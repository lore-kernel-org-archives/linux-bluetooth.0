Return-Path: <cyrus@holtmann.org>
Date: Wed, 17 Nov 2010 09:05:34 +0000
From: Johan Hedberg <johan.hedberg@gmail.com>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: =?iso-8859-1?Q?Andr=E9_K=FChne?= <andre.kuehne@gmx.net>,
	linux-bluetooth@vger.kernel.org
Subject: Re: Apple Wireless Keyboard connection issue
Message-ID: <20101117090534.GA11494@jh-x301>
References: <20101116212701.50060@gmx.net>
 <20101117013009.GA15855@vigoh>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="huq684BweRXVnRxX"
In-Reply-To: <20101117013009.GA15855@vigoh>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--huq684BweRXVnRxX
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Gustavo,

On Tue, Nov 16, 2010, Gustavo F. Padovan wrote:
> * "André Kühne" <andre.kuehne@gmx.net> [2010-11-16 22:27:01 +0100]:
> > I noticed the following on my system: After upgrading to bluez-4.79
> > connecting my Apple Wireless Keyboard does not work anymore. With
> > bluez-4.77 the connection works just fine.
> 
> My Microsoft keyboard is not working too. That is probably due to commit
> abe7cd44124a from Johan. It should be fixed soon.

The only real difference that patch makes is the reuse of the HCI socket
inside hciops.c. Maybe that screws up the event filters somehow or
something similar. I don't have a keyboard to verify a fix, but could
you try the attached patch and see if it helps?

Johan

--huq684BweRXVnRxX
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="hciops_encrypt.patch"

diff --git a/plugins/hciops.c b/plugins/hciops.c
index 9d25558..4492983 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -338,31 +338,37 @@ static int hciops_encrypt_link(int index, bdaddr_t *dst, bt_hci_result_t cb,
 	uint32_t link_mode;
 	uint16_t handle;
 
+	dd = hci_open_dev(index);
+	if (dd < 0)
+		return -errno;
+
 	cr = g_malloc0(sizeof(*cr) + sizeof(struct hci_conn_info));
 	cr->type = ACL_LINK;
 	bacpy(&cr->bdaddr, dst);
 
-	err = ioctl(SK(index), HCIGETCONNINFO, cr);
+	err = ioctl(dd, HCIGETCONNINFO, cr);
 	link_mode = cr->conn_info->link_mode;
 	handle = cr->conn_info->handle;
 	g_free(cr);
 
-	if (err < 0)
-		return -errno;
+	if (err < 0) {
+		err = -errno;
+		goto fail;
+	}
 
-	if (link_mode & HCI_LM_ENCRYPT)
-		return -EALREADY;
+	if (link_mode & HCI_LM_ENCRYPT) {
+		err = -EALREADY;
+		goto fail;
+	}
 
 	memset(&cp, 0, sizeof(cp));
 	cp.handle = htobs(handle);
 
-	if (hci_send_cmd(SK(index), OGF_LINK_CTL, OCF_AUTH_REQUESTED,
-				AUTH_REQUESTED_CP_SIZE, &cp) < 0)
-		return -errno;
-
-	dd = dup(SK(index));
-	if (dd < 0)
-		return -errno;
+	if (hci_send_cmd(dd, OGF_LINK_CTL, OCF_AUTH_REQUESTED,
+				AUTH_REQUESTED_CP_SIZE, &cp) < 0) {
+		err = -errno;
+		goto fail;
+	}
 
 	cmd = g_new0(struct hci_cmd_data, 1);
 	cmd->handle = handle;
@@ -379,8 +385,7 @@ static int hciops_encrypt_link(int index, bdaddr_t *dst, bt_hci_result_t cb,
 	if (setsockopt(dd, SOL_HCI, HCI_FILTER, &nf, sizeof(nf)) < 0) {
 		err = -errno;
 		g_free(cmd);
-		close(dd);
-		return -err;
+		goto fail;
 	}
 
 	io = g_io_channel_unix_new(dup(SK(index)));
@@ -391,6 +396,10 @@ static int hciops_encrypt_link(int index, bdaddr_t *dst, bt_hci_result_t cb,
 	g_io_channel_unref(io);
 
 	return 0;
+
+fail:
+	close(dd);
+	return err;
 }
 
 /* End async HCI command handling */

--huq684BweRXVnRxX--
