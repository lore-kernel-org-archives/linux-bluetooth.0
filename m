Return-Path: <jaya.p.g@intel.com>
From: "G, Jaya P" <jaya.p.g@intel.com>
To: "'linux-bluetooth@vger.kernel.org'" <linux-bluetooth@vger.kernel.org>,
	"Marcel@holtmann.org" <Marcel@holtmann.org>
CC: "An, Tedd" <tedd.an@intel.com>
Subject: Please review and upstream to bluetooth-next
Date: Fri, 15 Jul 2016 06:33:50 +0000
Message-ID: <DAC39EC0A5DE12469D14E5A0B14E6CF505473770@BGSMSX108.gar.corp.intel.com>
References: <DAC39EC0A5DE12469D14E5A0B14E6CF505470BE4@BGSMSX108.gar.corp.intel.com> 
Content-Type: multipart/alternative;
	boundary="_000_DAC39EC0A5DE12469D14E5A0B14E6CF505473770BGSMSX108garcor_"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

--_000_DAC39EC0A5DE12469D14E5A0B14E6CF505473770BGSMSX108garcor_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

Patch is for creating a kobject file from btusb which creates a file under =
kobject
Which exposes HW Variant, FW Variant and Patch number for Intel specific SK=
U's
Which is required to differentiate different chips from intel manufacturer.

Please review and upstream the Patch to bluetooth-next.

>From 01e904148f4de6d8d48d61b01b08da7a771fe998 Mon Sep 17 00:00:00 2001
From: Jaya Praveen G <jaya.p.g@intel.com>
Date: Fri, 15 Jul 2016 17:25:31 +0530
Subject: [PATCH] btusb: Export the Intel HW/FW/Patch variants to /sysfs

Intel will have different SKU and version with the same
VID/PID. Different SKU use different BT version this means
different HW and FW. To check this, we have read version
for the intel SKU which is unique, the same data is put in
a file create with kobject in /sys/kernel/intel_hw_version_kobject/
with the name /intel_hw_version where it shows the HW variant,
FW variant and Patch number which will different for each SKU.

Signed-off-by: Jaya Praveen G <jaya.p.g@intel.com>
---
drivers/bluetooth/btusb.c | 57 ++++++++++++++++++++++++++++++++++++++++++++=
+--
1 file changed, 55 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 811f9b9..720f14f 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -24,6 +24,10 @@
#include <linux/module.h>
#include <linux/usb.h>
#include <linux/firmware.h>
+#include <linux/kobject.h>
+#include <linux/sysfs.h>
+#include <linux/fs.h>
+#include <linux/string.h>
#include <asm/unaligned.h>
 #include <net/bluetooth/bluetooth.h>
@@ -42,6 +46,30 @@ static bool reset =3D true;
 static struct usb_driver btusb_driver;
+static struct kobject *intel_hw_version_kobject;
+struct intel_version ver;
+
+/*
+ * This file which is under /sys/kernel/intel_hw_version_kobject kobject w=
hich has the file name as intel_hw_version
+ * contains the intel FW version in terms of HW variant, FW variant and Pa=
tch number which are different for
+ * different SKU's.
+ */
+static ssize_t intel_hw_showrev(struct kobject *k, struct attribute *a, ch=
ar *buf)
+{
+        return sprintf(buf, "HW_Variant: 0x%02x%02x%02x\nFW_variant: 0x%02=
x%02x%02x%02x%02x\nPatch Num: 0x%02x\n",ver.hw_platform, ver.hw_variant, ve=
r.hw_revision,
+                            ver.fw_variant,  ver.fw_revision, ver.fw_build=
_num,
+                            ver.fw_build_ww, ver.fw_build_yy, ver.fw_patch=
_num);
+}
+
+/* Sysfs attributes made as user readable and writable*/
+static const struct {
+             struct attribute attr;
+             ssize_t (*show)(struct kobject *k, struct attribute *a, char =
*buf);
+} intel_hw_version_attr =3D {
+             .attr =3D { .name =3D "intel_hw_version", .mode =3D S_IWUSR |=
 S_IRUSR},
+             .show =3D intel_hw_showrev,
+};
+
#define BTUSB_IGNORE                              0x01
#define BTUSB_DIGIANSWER      0x02
#define BTUSB_CSR                       0x04
@@ -1655,7 +1683,7 @@ static int btusb_setup_intel(struct hci_dev *hdev)
              const struct firmware *fw;
              const u8 *fw_ptr;
              int disable_patch, err;
-              struct intel_version ver;
+        int error =3D 0;
               BT_DBG("%s", hdev->name);
@@ -1690,6 +1718,19 @@ static int btusb_setup_intel(struct hci_dev *hdev)
                             ver.fw_variant,  ver.fw_revision, ver.fw_build=
_num,
                             ver.fw_build_ww, ver.fw_build_yy, ver.fw_patch=
_num);
+        /* Create a kobject with the name "intel_hw_version_kobject", loca=
ted
+         * under /sys/kernel/.
+         */
+        intel_hw_version_kobject =3D kobject_create_and_add("intel_hw_vers=
ion_kobject", kernel_kobj);
+        if(!intel_hw_version_kobject)
+                  return -ENOMEM;
+
+        /* Create a file associated with the kobject */
+        error =3D sysfs_create_file(intel_hw_version_kobject, &intel_hw_ve=
rsion_attr.attr);
+        if(error) {
+              BT_DBG("failed to create the version file in /sys/kernel/int=
el_hw_version_kobject \n");
+        }
+
              /* fw_patch_num indicates the version of patch the device cur=
rently
               * have. If there is no patch data in the device, it is alway=
s 0x00.
               * So, if it is other than 0x00, no need to patch the device =
again.
@@ -1974,7 +2015,6 @@ static int btusb_setup_intel_new(struct hci_dev *hdev=
)
                                                                           =
 0x00, 0x08, 0x04, 0x00 };
              struct btusb_data *data =3D hci_get_drvdata(hdev);
              struct sk_buff *skb;
-              struct intel_version ver;
              struct intel_boot_params *params;
              const struct firmware *fw;
              const u8 *fw_ptr;
@@ -1983,6 +2023,7 @@ static int btusb_setup_intel_new(struct hci_dev *hdev=
)
              ktime_t calltime, delta, rettime;
              unsigned long long duration;
              int err;
+        int error =3D 0;
               BT_DBG("%s", hdev->name);
@@ -1996,6 +2037,18 @@ static int btusb_setup_intel_new(struct hci_dev *hde=
v)
              if (err)
                             return err;
+        /* Create a kobject with the name "intel_hw_version_kobject", loca=
ted
+         * under /sys/kernel/.
+         */
+        intel_hw_version_kobject =3D kobject_create_and_add("intel_hw_vers=
ion_kobject", kernel_kobj);
+        if(!intel_hw_version_kobject)
+                  return -ENOMEM;
+
+        /* Create a file associated with the kobject */
+        error =3D sysfs_create_file(intel_hw_version_kobject, &intel_hw_ve=
rsion_attr.attr);
+        if(error) {
+              BT_DBG("failed to create the version file in /sys/kernel/int=
el_hw_version_kobject \n");
+        }
              /* The hardware platform number has a fixed value of 0x37 and
               * for now only accept this single value.
               */
--
1.9.1

Regards,
Jaya Praveen G

--_000_DAC39EC0A5DE12469D14E5A0B14E6CF505473770BGSMSX108garcor_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle18
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:#1F497D;}
span.EmailStyle19
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:#1F497D;}
span.EmailStyle20
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:#1F497D;}
span.EmailStyle21
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:#1F497D;}
span.EmailStyle22
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:#1F497D;}
span.EmailStyle23
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:#1F497D;}
span.EmailStyle24
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:#1F497D;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">Hi,<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D"><o:p>&nbsp;</o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">Patch is for creating =
a kobject file from btusb which creates a file under kobject
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">Which exposes HW Varia=
nt, FW Variant and Patch number for Intel specific SKU&#8217;s
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">Which is required to d=
ifferentiate different chips from intel manufacturer.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D"><o:p>&nbsp;</o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">Please review and upst=
ream the Patch to bluetooth-next.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D"><o:p>&nbsp;</o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">From 01e904148f4de6d8d=
48d61b01b08da7a771fe998 Mon Sep 17 00:00:00 2001<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">From: Jaya Praveen G &=
lt;jaya.p.g@intel.com&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">Date: Fri, 15 Jul 2016=
 17:25:31 &#43;0530<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">Subject: [PATCH] btusb=
: Export the Intel HW/FW/Patch variants to /sysfs<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D"><o:p>&nbsp;</o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">Intel will have differ=
ent SKU and version with the same<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">VID/PID. Different SKU=
 use different BT version this means<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">different HW and FW. T=
o check this, we have read version<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">for the intel SKU whic=
h is unique, the same data is put in<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">a file create with kob=
ject in /sys/kernel/intel_hw_version_kobject/<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">with the name /intel_h=
w_version where it shows the HW variant,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">FW variant and Patch n=
umber which will different for each SKU.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D"><o:p>&nbsp;</o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">Signed-off-by: Jaya Pr=
aveen G &lt;jaya.p.g@intel.com&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">---<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">drivers/bluetooth/btus=
b.c | 57 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&=
#43;&#43;--<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">1 file changed, 55 ins=
ertions(&#43;), 2 deletions(-)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D"><o:p>&nbsp;</o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">diff --git a/drivers/b=
luetooth/btusb.c b/drivers/bluetooth/btusb.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">index 811f9b9..720f14f=
 100644<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">--- a/drivers/bluetoot=
h/btusb.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&#43;&#43;&#43; b/driv=
ers/bluetooth/btusb.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">@@ -24,6 &#43;24,10 @@=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">#include &lt;linux/mod=
ule.h&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">#include &lt;linux/usb=
.h&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">#include &lt;linux/fir=
mware.h&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&#43;#include &lt;linu=
x/kobject.h&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&#43;#include &lt;linu=
x/sysfs.h&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&#43;#include &lt;linu=
x/fs.h&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&#43;#include &lt;linu=
x/string.h&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">#include &lt;asm/unali=
gned.h&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&nbsp;#include &lt;net=
/bluetooth/bluetooth.h&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">@@ -42,6 &#43;46,30 @@=
 static bool reset =3D true;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&nbsp;static struct us=
b_driver btusb_driver;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&#43;static struct kob=
ject *intel_hw_version_kobject;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&#43;struct intel_vers=
ion ver;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&#43;<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&#43;/*<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&#43; * This file whic=
h is under /sys/kernel/intel_hw_version_kobject kobject which has the file =
name as intel_hw_version<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&#43; * contains the i=
ntel FW version in terms of HW variant, FW variant and Patch number which a=
re different for<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&#43; * different SKU'=
s.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&#43; */<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&#43;static ssize_t in=
tel_hw_showrev(struct kobject *k, struct attribute *a, char *buf)<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&#43;{<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&#43;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; return sprintf(buf, &quot;HW_Variant: 0x%02x%02x%=
02x\nFW_variant: 0x%02x%02x%02x%02x%02x\nPatch Num: 0x%02x\n&quot;,ver.hw_p=
latform, ver.hw_variant, ver.hw_revision,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&#43;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ver.=
fw_variant,&nbsp; ver.fw_revision, ver.fw_build_num,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&#43;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ver.=
fw_build_ww, ver.fw_build_yy, ver.fw_patch_num);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&#43;}<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&#43;<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&#43;/* Sysfs attribut=
es made as user readable and writable*/<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&#43;static const stru=
ct {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&#43;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct attribute at=
tr;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&#43;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ssize_t (*show)(str=
uct kobject *k, struct attribute *a, char *buf);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&#43;} intel_hw_versio=
n_attr =3D {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&#43;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .attr =3D { .name =
=3D &quot;intel_hw_version&quot;, .mode =3D S_IWUSR | S_IRUSR},<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&#43;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .show =3D intel_hw_=
showrev,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&#43;};<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&#43;<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">#define BTUSB_IGNORE&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; 0x01<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">#define BTUSB_DIGIANSW=
ER&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x02<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">#define BTUSB_CSR&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x04<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">@@ -1655,7 &#43;1683,7=
 @@ static int btusb_setup_intel(struct hci_dev *hdev)<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct firmw=
are *fw;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const u8 *fw_ptr;<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int disable_patch,=
 err;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">-&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct intel_vers=
ion ver;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&#43;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; int error =3D 0;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BT_DBG(&quot=
;%s&quot;, hdev-&gt;name);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">@@ -1690,6 &#43;1718,1=
9 @@ static int btusb_setup_intel(struct hci_dev *hdev)<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ver=
.fw_variant,&nbsp; ver.fw_revision, ver.fw_build_num,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ver=
.fw_build_ww, ver.fw_build_yy, ver.fw_patch_num);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&#43;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; /* Create a kobject with the name &quot;intel_hw_=
version_kobject&quot;, located<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&#43;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * under /sys/kernel/.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&#43;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&#43;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; intel_hw_version_kobject =3D kobject_create_and_a=
dd(&quot;intel_hw_version_kobject&quot;, kernel_kobj);<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&#43;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; if(!intel_hw_version_kobject)<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&#43;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -ENOMEM;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&#43;<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&#43;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; /* Create a file associated with the kobject */<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&#43;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; error =3D sysfs_create_file(intel_hw_version_kobj=
ect, &amp;intel_hw_version_attr.attr);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&#43;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; if(error) {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&#43;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BT_DBG(&quot;=
failed to create the version file in /sys/kernel/intel_hw_version_kobject \=
n&quot;);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&#43;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&#43;<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* fw_patch_num in=
dicates the version of patch the device currently<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;* have. If t=
here is no patch data in the device, it is always 0x00.<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;* So, if it =
is other than 0x00, no need to patch the device again.<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">@@ -1974,7 &#43;2015,6=
 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;0x00, 0x08, 0x04, 0x0=
0 };<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct btusb_data =
*data =3D hci_get_drvdata(hdev);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct sk_buff *sk=
b;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">-&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct intel_vers=
ion ver;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct intel_boot_=
params *params;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct firmw=
are *fw;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const u8 *fw_ptr;<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">@@ -1983,6 &#43;2023,7=
 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ktime_t calltime, =
delta, rettime;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long long=
 duration;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int err;<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&#43;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; int error =3D 0;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BT_DBG(&quot=
;%s&quot;, hdev-&gt;name);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">@@ -1996,6 &#43;2037,1=
8 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (err)<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret=
urn err;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&#43;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; /* Create a kobject with the name &quot;intel_hw_=
version_kobject&quot;, located<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&#43;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * under /sys/kernel/.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&#43;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&#43;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; intel_hw_version_kobject =3D kobject_create_and_a=
dd(&quot;intel_hw_version_kobject&quot;, kernel_kobj);<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&#43;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; if(!intel_hw_version_kobject)<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&#43;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -ENOMEM;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&#43;<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&#43;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; /* Create a file associated with the kobject */<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&#43;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; error =3D sysfs_create_file(intel_hw_version_kobj=
ect, &amp;intel_hw_version_attr.attr);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&#43;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; if(error) {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&#43;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BT_DBG(&quot;=
failed to create the version file in /sys/kernel/intel_hw_version_kobject \=
n&quot;);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&#43;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* The hardware pl=
atform number has a fixed value of 0x37 and<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;* for now on=
ly accept this single value.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;*/<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">-- <o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">1.9.1<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D"><o:p>&nbsp;</o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">Regards,<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">Jaya Praveen G<o:p></o=
:p></span></p>
</div>
</body>
</html>

--_000_DAC39EC0A5DE12469D14E5A0B14E6CF505473770BGSMSX108garcor_--
