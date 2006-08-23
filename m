Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Mayank BATRA <mayank.batra@st.com>
To: "'BlueZ development'" <bluez-devel@lists.sourceforge.net>
Date: Wed, 23 Aug 2006 13:33:40 +0530
Message-ID: <001f01c6c68a$a5af6680$9d0cc70a@dlh.st.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0020_01C6C6B8.BF67A280"
In-Reply-To: <d23110170608221347p37bc87a5mbdd1271eaf7631c3@mail.gmail.com>
Subject: Re: [Bluez-devel] Host Controller to Host Flow Control
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.

------=_NextPart_000_0020_01C6C6B8.BF67A280
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Hi Ulisses, Marcel,

> how about something like the attached patch? I've used some of
> Mayank's code and added some other parts. It's not complete and it's
> only compile-tested yet.

I think we will require the attached patch for setting the various
parameters of hci_dev structure from hciconfig (through ioctls).

Regards,
Mayank

------=_NextPart_000_0020_01C6C6B8.BF67A280
Content-Type: application/octet-stream;
	name="hci.h.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="hci.h.diff"

--- C:\Diffs\Copy of hci.h	2003-03-14 03:53:14.000000000 +-0530
+++ C:\Diffs\hci.h	2006-08-23 12:46:24.000000000 +-0530
@@ -82,12 +82,16 @@
 #define HCISETENCRYPT   _IOW('H', 223, int)
 #define HCISETPTYPE     _IOW('H', 224, int)
 #define HCISETLINKPOL   _IOW('H', 225, int)
 #define HCISETLINKMODE  _IOW('H', 226, int)
 #define HCISETACLMTU    _IOW('H', 227, int)
 #define HCISETSCOMTU    _IOW('H', 228, int)
+#define HCISETHOSTFC    _IOW('H', 229, int)
+#define HCISETHOSTACLMTU    _IOW('H', 230, int)
+#define HCISETHOSTSCOMTU    _IOW('H', 231, int)
+
 
 #define HCIINQUIRY      _IOR('H', 240, int)
 
 /* HCI timeouts */
 #define HCI_CONN_TIMEOUT 	(HZ * 40)
 #define HCI_DISCONN_TIMEOUT 	(HZ * 2)

------=_NextPart_000_0020_01C6C6B8.BF67A280
Content-Type: application/octet-stream;
	name="hci_core.c.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="hci_core.c.diff"

--- C:\Diffs\Copy of hci_core.c	2003-03-14 03:53:16.000000000 +-0530
+++ C:\Diffs\hci_core.c	2006-08-23 12:40:20.000000000 +-0530
@@ -691,12 +691,26 @@
 		break;
 
 	case HCISETSCOMTU:
 		hdev->sco_mtu  = *((__u16 *)&dr.dev_opt + 1);
 		hdev->sco_pkts = *((__u16 *)&dr.dev_opt + 0);
 		break;
+		
+	case HCISETHOSTFC:
+		hdev->host_flow_ctl = (__u8) dr.dev_opt;
+		break;
+		
+	case HCISETHOSTACLMTU:
+		hdev->host_acl_mtu  = *((__u16 *)&dr.dev_opt + 1);
+		hdev->acl_max_pkts = *((__u16 *)&dr.dev_opt + 0);
+		break;
+
+	case HCISETHOSTSCOMTU:
+		hdev->host_sco_mtu  = *((__u16 *)&dr.dev_opt + 1);
+		hdev->sco_max_pkts = *((__u16 *)&dr.dev_opt + 0);
+		break;
 
 	default:
 		err = -EINVAL;
 		break;
 	}	
 	hci_dev_put(hdev);

------=_NextPart_000_0020_01C6C6B8.BF67A280
Content-Type: application/octet-stream;
	name="hci_sock.c.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="hci_sock.c.diff"

--- C:\Diffs\Copy of hci_sock.c	2006-08-23 12:32:33.000000000 +-0530
+++ C:\Diffs\hci_sock.c	2006-08-23 12:34:30.000000000 +-0530
@@ -233,12 +233,15 @@
 	case HCISETENCRYPT:
 	case HCISETPTYPE:
 	case HCISETLINKPOL:
 	case HCISETLINKMODE:
 	case HCISETACLMTU:
 	case HCISETSCOMTU:
+	case HCISETHOSTFC:
+	case HCISETHOSTACLMTU:
+	case HCISETHOSTSCOMTU:
 		if (!capable(CAP_NET_ADMIN))
 			return -EACCES;
 		return hci_dev_cmd(cmd, arg);
 
 	case HCIINQUIRY:
 		return hci_inquiry(arg);

------=_NextPart_000_0020_01C6C6B8.BF67A280
Content-Type: application/octet-stream;
	name="hciconfig.c.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="hciconfig.c.diff"

--- C:\Diffs\Copy of hciconfig.c	2006-08-23 12:46:46.000000000 +-0530
+++ C:\Diffs\hciconfig.c	2006-08-23 13:28:57.000000000 +-0530
@@ -1298,12 +1298,81 @@
=20
 		print_dev_hdr(&di);
 		printf("\tAFH mode: %s\n", mode =3D=3D 1 ? "Enabled" : "Disabled");
 	}
 }
=20
+static void cmd_hostfc(int ctl, int hdev, char *opt)
+{
+	struct hci_dev_req dr;
+
+	dr.dev_id =3D hdev;
+	if (!strcmp(opt, "hostfcoff")) {
+		dr.dev_opt =3D HCI_HFC_NONE;
+	}
+	else if(!strcmp(opt, "hostfcacl")) {
+		dr.dev_opt =3D HCI_HFC_ACL;
+	}
+	else if(!strcmp(opt, "hostfcsco")) {
+		dr.dev_opt =3D HCI_HFC_SCO;
+	}
+	else if(!strcmp(opt, "hostfcboth")) {
+		dr.dev_opt =3D HCI_HFC_BOTH;
+	}
+	else {
+		printf("Invalid option for setting host flow control\n");
+		exit(1);
+	}
+
+	if (ioctl(ctl, HCISETHOSTFC, (unsigned long) &dr) < 0) {
+		fprintf(stderr, "Can't set host flow control on hci%d: %s (%d)\n",
+						hdev, strerror(errno), errno);
+		exit(1);
+	}
+}
+
+static void cmd_hostaclmtu(int ctl, int hdev, char *opt)
+{
+	struct hci_dev_req dr =3D { dev_id: hdev };
+	uint16_t mtu, mpkt;
+
+	if (!opt)
+		return;
+
+	if (sscanf(opt, "%4hu:%4hu", &mtu, &mpkt) !=3D 2)
+		return;
+
+	dr.dev_opt =3D htobl(htobs(mpkt) | (htobs(mtu) << 16));
+
+	if (ioctl(ctl, HCISETHOSTACLMTU, (unsigned long) &dr) < 0) {
+		fprintf(stderr, "Can't set HOST ACL mtu on hci%d: %s(%d)\n",
+						hdev, strerror(errno), errno);
+		exit(1);
+	}
+}
+
+static void cmd_hostscomtu(int ctl, int hdev, char *opt)
+{
+	struct hci_dev_req dr =3D { dev_id: hdev };
+	uint16_t mtu, mpkt;
+
+	if (!opt)
+		return;
+
+	if (sscanf(opt, "%4hu:%4hu", &mtu, &mpkt) !=3D 2)
+		return;
+
+	dr.dev_opt =3D htobl(htobs(mpkt) | (htobs(mtu) << 16));
+
+	if (ioctl(ctl, HCISETHOSTSCOMTU, (unsigned long) &dr) < 0) {
+		fprintf(stderr, "Can't set HOST SCO mtu on hci%d: %s (%d)\n",
+						hdev, strerror(errno), errno);
+		exit(1);
+	}
+}
+
 static void print_rev_ericsson(int dd)
 {
 	struct hci_request rq;
 	unsigned char buf[102];
=20
 	memset(&rq, 0, sizeof(rq));
@@ -1511,12 +1580,18 @@
 	{ "putkey",	cmd_putkey,	"<bdaddr>",	"Store link key on the device" },
 	{ "delkey",	cmd_delkey,	"<bdaddr>",	"Delete link key from the device" =
},
 	{ "commands",	cmd_commands,	0,		"Display supported commands" },
 	{ "features",	cmd_features,	0,		"Display device features" },
 	{ "version",	cmd_version,	0,		"Display version information" },
 	{ "revision",	cmd_revision,	0,		"Display revision information" },
+	{ "hostfcacl",	cmd_hostfc,	0,		"Enable host flow control for ACL data =
packets only"},
+	{ "hostfcsco",	cmd_hostfc,	0,		"Enable host flow control for SCO data =
packets only"},
+	{ "hostfcboth",	cmd_hostfc,	0,		"Enable host flow control for both ACL =
and SCOdata packets"},
+	{ "hostfcoff",	cmd_hostfc,	0,		"Disable Host Flow Control"},
+	{ "hostaclmtu",	cmd_hostaclmtu,	"<mtu:pkt>",	"Set host ACL MTU and =
host number of packets" },
+	{ "hostscomtu",	cmd_hostscomtu,	"<mtu:pkt>",	"Set host SCO MTU and =
host number of packets" },
 	{ NULL, NULL, 0 }
 };
=20
 static void usage(void)
 {
 	int i;

------=_NextPart_000_0020_01C6C6B8.BF67A280
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
------=_NextPart_000_0020_01C6C6B8.BF67A280
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

------=_NextPart_000_0020_01C6C6B8.BF67A280--
