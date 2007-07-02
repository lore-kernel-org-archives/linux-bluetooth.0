Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <18a15270707021204o3ffc0021pc3f0d4b0ec278c39@mail.gmail.com>
Date: Mon, 2 Jul 2007 20:04:35 +0100
From: "Ranulf Doswell" <cbe@ranulf.net>
To: cbe-oss-dev@ozlabs.org, bluez-devel@lists.sf.net
MIME-Version: 1.0
Subject: [Bluez-devel] [PATCH] bluetooth: reset unexpected connections
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1633505838=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1633505838==
Content-Type: multipart/alternative;
	boundary="----=_Part_88086_15425107.1183403075189"

------=_Part_88086_15425107.1183403075189
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

From: Ranulf Doswell <ralf@ranulf.net>

Send a reset command to any device that sends us data when there is no
active
connection to that device. This hopefully discourages the device from
sending
any more data which causes the syslog to fill up rapidly otherwise.

Signed-off-by: Ranulf Doswell <ralf@ranulf.net>

---

An example device which causes this problem is the Sony Playstation six-axis
controller which continues sending data even after the host is rebooted as
the linux kernel stack returns before the controller's stack times out.

This patch is against 2.6.22-rc5

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 8943c93..fb99b95 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1340,6 +1340,12 @@ static inline void hci_acldata_packet(struct hci_dev
*hdev, struct sk_buff *skb)
        } else {
                BT_ERR("%s ACL packet for unknown connection handle %d",
                        hdev->name, handle);
+
+               /* Force the device to reset in the hope that it will then
+                * leave us alone. In some devices, a reboot doesn't provide
+                * enough time for the device's stack to time out, so it
keeps
+                * sending data until forcibly terminated. */
+               hci_reset_req(hdev, 0);
        }

        kfree_skb(skb);

------=_Part_88086_15425107.1183403075189
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

From: Ranulf Doswell &lt;<a href="mailto:ralf@ranulf.net">ralf@ranulf.net</a>&gt;<br><br>Send a reset command to any device that sends us data when there is no active<br>connection to that device. This hopefully discourages the device from sending
<br>any more data which causes the syslog to fill up rapidly otherwise.<br><br>Signed-off-by: Ranulf Doswell &lt;<a href="mailto:ralf@ranulf.net">ralf@ranulf.net</a>&gt;<br><br>---<br><br>An example device which causes this problem is the Sony Playstation six-axis
<br>controller which continues sending data even after the host is rebooted as<br>the linux kernel stack returns before the controller&#39;s stack times out.<br><br>This patch is against 2.6.22-rc5<br><br>diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
<br>index 8943c93..fb99b95 100644<br>--- a/net/bluetooth/hci_core.c<br>+++ b/net/bluetooth/hci_core.c<br>@@ -1340,6 +1340,12 @@ static inline void hci_acldata_packet(struct hci_dev *hdev, struct sk_buff *skb)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BT_ERR(&quot;%s ACL packet for unknown connection handle %d&quot;,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hdev-&gt;name, handle);<br>+<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Force the device to reset in the hope that it will then<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * leave us alone. In some devices, a reboot doesn&#39;t provide<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * enough time for the device&#39;s stack to time out, so it keeps<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * sending data until forcibly terminated. */
<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hci_reset_req(hdev, 0);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>&nbsp;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree_skb(skb);<br><br>

------=_Part_88086_15425107.1183403075189--


--===============1633505838==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============1633505838==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1633505838==--
