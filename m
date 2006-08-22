Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Mayank BATRA <mayank.batra@st.com>
To: "'BlueZ development'" <bluez-devel@lists.sourceforge.net>
Date: Tue, 22 Aug 2006 09:00:31 +0530
Message-ID: <000201c6c59b$5735bc60$9d0cc70a@dlh.st.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0003_01C6C5C9.70EDF860"
In-Reply-To: <d23110170608211410l1c4cae0aufa41d8f589bda68d@mail.gmail.com>
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

------=_NextPart_000_0003_01C6C5C9.70EDF860
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Ulisses,
 
> I've noticed you sent a diff against hci.h from bluez-libs and not the
> one in the kernel, so please check that.

Oops. My mistake. Here is the diff for the one in the kernel.

> One other thing is that you
> have to be careful with endianess issues (please check your patch
> against hci_core.c).

Which one do you mean in particular? 0x0008 or connection handle?

> And I really think we should have a hci_send_cmd_raw() or something
> like that instead of messing with hci_send_cmd(). Or maybe a new
> function that creates a skb from scratch just to send the host number
> of completed packets command? Marcel, what do you think?

Right.

Regards,
Mayank

------=_NextPart_000_0003_01C6C5C9.70EDF860
Content-Type: application/octet-stream;
	name="hci.h.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="hci.h.diff"

--- C:\Copy of hci.h	2006-08-22 08:54:31.000000000 +-0530
+++ C:\hci.h	2006-08-22 08:52:07.000000000 +-0530
@@ -266,20 +266,38 @@
 #define OCF_WRITE_CLASS_OF_DEV	0x0024
 typedef struct {
 	__u8 	dev_class[3];
 } __attribute__ ((packed)) write_class_of_dev_cp;
 #define WRITE_CLASS_OF_DEV_CP_SIZE 3
 
+#define OCF_SET_CONTROLLER_TO_HOST_FC   0x0031
+typedef struct {
+        uint8_t         flow_control_enable;
+} __attribute__ ((packed)) set_controller_to_host_fc_cp;
+#define SET_CONTROLLER_TO_HOST_FC_CP_SIZE       1
+typedef struct {
+        uint8_t         status;
+} __attribute__ ((packed)) set_controller_to_host_fc_rp;
+#define SET_CONTROLLER_TO_HOST_FC_RP_SIZE       1
+
 #define OCF_HOST_BUFFER_SIZE	0x0033
 typedef struct {
 	__u16 	acl_mtu;
 	__u8 	sco_mtu;
 	__u16 	acl_max_pkt;
 	__u16	sco_max_pkt;
 } __attribute__ ((packed)) host_buffer_size_cp;
 #define HOST_BUFFER_SIZE_CP_SIZE 7
+
+#define OCF_HOST_NUM_OF_COMPLETED_PACKETS       0x0035
+typedef struct {
+        uint8_t         num_of_handles;
+        uint16_t        handle;
+        uint16_t        host_num_of_completed_packets;
+} __attribute__ ((packed)) host_num_of_completed_packets_cp;
+#define OCF_HOST_NUM_OF_COMPLETED_PACKETS_CP_SIZE 5
 
 /* Link Control */
 #define OGF_LINK_CTL	0x01 
 #define OCF_CREATE_CONN		0x0005
 typedef struct {
 	bdaddr_t bdaddr;

------=_NextPart_000_0003_01C6C5C9.70EDF860
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
------=_NextPart_000_0003_01C6C5C9.70EDF860
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

------=_NextPart_000_0003_01C6C5C9.70EDF860--
