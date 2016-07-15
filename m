Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: Please review and upstream to bluetooth-next
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <DAC39EC0A5DE12469D14E5A0B14E6CF505473770@BGSMSX108.gar.corp.intel.com>
Date: Fri, 15 Jul 2016 07:48:05 +0100
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"An, Tedd" <tedd.an@intel.com>
Message-Id: <0331C8DC-83C0-4737-A063-5BE7B01845CB@holtmann.org>
References: <DAC39EC0A5DE12469D14E5A0B14E6CF505470BE4@BGSMSX108.gar.corp.intel.com> <DAC39EC0A5DE12469D14E5A0B14E6CF505473770@BGSMSX108.gar.corp.intel.com>
To: "G, Jaya P" <jaya.p.g@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaya,

please do not post HTML emails to this mailing list. The mailing list system will most likely reject them anyway.

> Patch is for creating a kobject file from btusb which creates a file under kobject
> Which exposes HW Variant, FW Variant and Patch number for Intel specific SKU’s
> Which is required to differentiate different chips from intel manufacturer.
>  
> Please review and upstream the Patch to bluetooth-next.

Please send patches according to the submitting patches guidelines. I can not apply patches randomly inserted into email bodies.

> From 01e904148f4de6d8d48d61b01b08da7a771fe998 Mon Sep 17 00:00:00 2001
> From: Jaya Praveen G <jaya.p.g@intel.com>
> Date: Fri, 15 Jul 2016 17:25:31 +0530
> Subject: [PATCH] btusb: Export the Intel HW/FW/Patch variants to /sysfs
>  
> Intel will have different SKU and version with the same
> VID/PID. Different SKU use different BT version this means
> different HW and FW. To check this, we have read version
> for the intel SKU which is unique, the same data is put in
> a file create with kobject in /sys/kernel/intel_hw_version_kobject/
> with the name /intel_hw_version where it shows the HW variant,
> FW variant and Patch number which will different for each SKU.

I am failing to understand what these informations are used for. The bluemoon utility can read out these information easily already.

It is also something that no other driver is doing. Why would Intel need such a thing in the first place. Also exposing random kobjects from a driver is the wrong approach to this. I mean no Bluetooth driver is exposing things in sysfs.

>  
> Signed-off-by: Jaya Praveen G <jaya.p.g@intel.com>
> ---
> drivers/bluetooth/btusb.c | 57 +++++++++++++++++++++++++++++++++++++++++++++--
> 1 file changed, 55 insertions(+), 2 deletions(-)
>  
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 811f9b9..720f14f 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -24,6 +24,10 @@
> #include <linux/module.h>
> #include <linux/usb.h>
> #include <linux/firmware.h>
> +#include <linux/kobject.h>
> +#include <linux/sysfs.h>
> +#include <linux/fs.h>
> +#include <linux/string.h>
> #include <asm/unaligned.h>
>  #include <net/bluetooth/bluetooth.h>
> @@ -42,6 +46,30 @@ static bool reset = true;
>  static struct usb_driver btusb_driver;
> +static struct kobject *intel_hw_version_kobject;
> +struct intel_version ver;
> +
> +/*
> + * This file which is under /sys/kernel/intel_hw_version_kobject kobject which has the file name as intel_hw_version
> + * contains the intel FW version in terms of HW variant, FW variant and Patch number which are different for
> + * different SKU's.
> + */
> +static ssize_t intel_hw_showrev(struct kobject *k, struct attribute *a, char *buf)
> +{
> +        return sprintf(buf, "HW_Variant: 0x%02x%02x%02x\nFW_variant: 0x%02x%02x%02x%02x%02x\nPatch Num: 0x%02x\n",ver.hw_platform, ver.hw_variant, ver.hw_revision,
> +                            ver.fw_variant,  ver.fw_revision, ver.fw_build_num,
> +                            ver.fw_build_ww, ver.fw_build_yy, ver.fw_patch_num);
> +}

We have a line size limit of 78 characters that should be considered whenever possible to break things into multiple lines. Only a few exceptions are breaking this coding style rules.

> +
> +/* Sysfs attributes made as user readable and writable*/
> +static const struct {
> +             struct attribute attr;
> +             ssize_t (*show)(struct kobject *k, struct attribute *a, char *buf);
> +} intel_hw_version_attr = {
> +             .attr = { .name = "intel_hw_version", .mode = S_IWUSR | S_IRUSR},
> +             .show = intel_hw_showrev,
> +};
> +
> #define BTUSB_IGNORE                              0x01
> #define BTUSB_DIGIANSWER      0x02
> #define BTUSB_CSR                       0x04
> @@ -1655,7 +1683,7 @@ static int btusb_setup_intel(struct hci_dev *hdev)
>               const struct firmware *fw;
>               const u8 *fw_ptr;
>               int disable_patch, err;
> -              struct intel_version ver;
> +        int error = 0;
>                BT_DBG("%s", hdev->name);
> @@ -1690,6 +1718,19 @@ static int btusb_setup_intel(struct hci_dev *hdev)
>                              ver.fw_variant,  ver.fw_revision, ver.fw_build_num,
>                              ver.fw_build_ww, ver.fw_build_yy, ver.fw_patch_num);
> +        /* Create a kobject with the name "intel_hw_version_kobject", located
> +         * under /sys/kernel/.
> +         */
> +        intel_hw_version_kobject = kobject_create_and_add("intel_hw_version_kobject", kernel_kobj);

This is broken by design. Linux supports multiple controllers. So what happens if you attach a second Intel controller to the same system.

> +        if(!intel_hw_version_kobject)
> +                  return -ENOMEM;
> +
> +        /* Create a file associated with the kobject */
> +        error = sysfs_create_file(intel_hw_version_kobject, &intel_hw_version_attr.attr);
> +        if(error) {
> +              BT_DBG("failed to create the version file in /sys/kernel/intel_hw_version_kobject \n");
> +        }
> +

The whole section is wrongly intended and is not following the network subsystem coding style.

Regards

Marcel

