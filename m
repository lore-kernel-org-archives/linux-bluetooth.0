Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Content-Type: text/plain
Message-Id: <1078411850.5347.43.camel@pegasus>
Mime-Version: 1.0
Subject: [Bluez-devel] First HCI command sent to a device
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 04 Mar 2004 15:50:50 +0100

Hi Folks,

while debugging the i-Tec dongle with Broadcom HID proxy support I saw
that this dongle expects that the first command is a HCI_Reset. I can't
remember any time where BlueZ has used this command. Our command
sequence on initialization can be found in hci_core.c:hci_init_req() and
it looks like this:

/* Mandatory initialization */

        /* Read Local Supported Features */
        hci_send_cmd(hdev, OGF_INFO_PARAM, OCF_READ_LOCAL_FEATURES, 0, NULL);

        /* Read Buffer Size (ACL mtu, max pkt, etc.) */
        hci_send_cmd(hdev, OGF_INFO_PARAM, OCF_READ_BUFFER_SIZE, 0, NULL);

        /* Read BD Address */
        hci_send_cmd(hdev, OGF_INFO_PARAM, OCF_READ_BD_ADDR, 0, NULL);

        /* Read Voice Setting */
        hci_send_cmd(hdev, OGF_HOST_CTL, OCF_READ_VOICE_SETTING, 0, NULL);

/* Optional initialization */

        /* Clear Event Filters */
        cp.flt_type  = HCI_FLT_CLEAR_ALL;
        hci_send_cmd(hdev, OGF_HOST_CTL, OCF_SET_EVENT_FLT, sizeof(cp), &cp);

        /* Page timeout ~20 secs */
        param = __cpu_to_le16(0x8000);
        hci_send_cmd(hdev, OGF_HOST_CTL, OCF_WRITE_PG_TIMEOUT, 2, &param);

        /* Connection accept timeout ~20 secs */
        param = __cpu_to_le16(0x7d00);
        hci_send_cmd(hdev, OGF_HOST_CTL, OCF_WRITE_CA_TIMEOUT, 2, &param);

Until the i-Tec dongle this worked perfect, but now my question is what
is the prefered init sequence? How do other stacks do it? Acutally how
do Microsoft or Widcomm init a device? Will adding a HCI_Reset break any
other Bluetooth adapter? Feedback from everyone is welcome before I am
going to make a decission on adding HCI_Reset or not.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
