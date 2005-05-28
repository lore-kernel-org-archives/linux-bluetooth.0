Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <c43104b305052801374253576b@mail.gmail.com>
From: peng zhihuai <pengzhihuai@gmail.com>
To: Bluez-users@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-users] strange error--/drivers/bluetooth/hci_uart.c
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sat, 28 May 2005 16:37:20 +0800

hi all:
      h4_recv: Unknown HCI packet type 00
      h4_recv: Unknown HCI packet type 34
      these message offen appear
      I find then in "/drivers/bluetooth/hci_uart.c",function n_hci_rx:
/* WAIT_PACKET_TYPE */
=09=09switch (*ptr) {
=09=09=09case HCI_EVENT_PKT:
=09=09=09=09DBG("Event packet");
=09=09=09=09n_hci->rx_state =3D WAIT_EVENT_HDR;
=09=09=09=09n_hci->rx_count =3D HCI_EVENT_HDR_SIZE;
=09=09=09=09type =3D HCI_EVENT_PKT;
=09=09=09=09break;

=09=09=09case HCI_ACLDATA_PKT:
=09=09=09=09DBG("ACL packet");
=09=09=09=09n_hci->rx_state =3D WAIT_ACL_HDR;
=09=09=09=09n_hci->rx_count =3D HCI_ACL_HDR_SIZE;
=09=09=09=09type =3D HCI_ACLDATA_PKT;
=09=09=09=09break;

=09=09=09case HCI_SCODATA_PKT:
=09=09=09=09DBG("SCO packet");
=09=09=09=09n_hci->rx_state =3D WAIT_SCO_HDR;
=09=09=09=09n_hci->rx_count =3D HCI_SCO_HDR_SIZE;
=09=09=09=09type =3D HCI_SCODATA_PKT;
=09=09=09=09break;

=09=09=09default:
=09=09=09=09ERR("Unknown HCI packet type %2.2x", (__u8)*ptr);
=09=09=09=09n_hci->hdev.stat.err_rx++;
=09=09=09=09ptr++; count--;
=09=09=09=09continue;
=09=09};
=09=09ptr++; count--;

     why these message apper? how to treat it?


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
