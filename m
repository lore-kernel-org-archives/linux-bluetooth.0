Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <768ccca40606041514m77eea4cer437d3ea227d3eec8@mail.gmail.com>
Date: Mon, 5 Jun 2006 00:14:34 +0200
From: "Eduardo Margallo" <eduardo.margallo@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Subject: [Bluez-devel] Broadcom adapter
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi there,

I just bought a sweex USB BT adapter featuring a BCM2035. Everything
works fine (pand/dund), except for the SCO links to my Jabra BT205.
The symptoms are the same ones that have already been reported in this
list a couple of times: volume control works fine, but no audio comes
from/to the headset. Some white noise is audible while the channel is
open, but no bytes are transfered over SCO. I applied the patch for
the Broadcom MTU problem, but it made no difference.

I have been investigating a bit around the code. I am not familiar
with bluez and my knowledge of BT is limited. However, I found that
I'm getting -ERESTARTSYS (-512) errors in snd_card_bt_sco_thread
coming from bt_sock_recvmsg. It looks like quite an exotic error code
to me. Further I have difficulty tracking where it comes from. Is this
code normal?

I have attached a typical log with extended debug info for one of
these failed SCO connection attempts. Do you have any ideas what might
be wrong? Perhaps some pointers or suggestions to track the problem
down?

Regards,

Eduardo

sco_connect_cfm: hcon c1bb0120 bdaddr D3:73:7C:17:13:00 status 0
sco_conn_ready: conn c07985c0
sco_sock_clear_timer: sock c124ea00 state 5
sco_sock_getsockopt: sk c124ea00
sco_sock_getsockopt: sk c124ea00
sco_sock_getsockopt: mtu 64
bt_sock_poll: sock c1ce80c0, sk c1d6ca00
** Waiting for read
bt_sock_recvmsg: sock c1ce8540 sk c124ea00 len 256
** bt_sock_recvmsg: sk->sk_err = 0 before calling skb
** bt_sock_recvmsg: Error fffffe00 reading datagram from socket c124ea00
** read len -512 bytes from socket c1ce8540
** read negative length from socket c1ce8540!!!
hci_usb_rx_complete: hci0 urb c1a3a354 type 4 status 0 count 7 flags 0
__recv_frame: hci0 type 4 data c178bcc0 count 7
__recv_frame: new packet len 7
hci_usb_rx_complete: hci0 urb c1a3a354 type 4 resubmit status 0
** Waiting for read
bt_sock_recvmsg: sock c1ce8540 sk c124ea00 len 256
** bt_sock_recvmsg: sk->sk_err = 0 before calling skb
hci_usb_rx_complete: hci0 urb c1a3af54 type 2 status 0 count 21 flags 0
__recv_frame: hci0 type 2 data c1b9f800 count 21
__recv_frame: new packet len 21
hci_usb_rx_complete: hci0 urb c1a3af54 type 2 resubmit status 0
hci_usb_rx_complete: hci0 urb c1a3af54 type 2 status 0 count 6 flags 0
__recv_frame: hci0 type 2 data c1b9f800 count 6
__recv_frame: new packet len 6
hci_usb_rx_complete: hci0 urb c1a3af54 type 2 resubmit status 0
bt_sock_poll: sock c1ce80c0, sk c1d6ca00
hci_usb_send_frame: hci0 type 2 len 18
hci_usb_tx_process: hci0
hci_usb_send_bulk: hci0 skb c1d0a460 len 18
__tx_submit: hci0 urb c1a3a554 type 2
hci_usb_tx_complete: hci0 urb c1a3a554 status 0 flags 0
hci_usb_tx_process: hci0
bt_sock_poll: sock c1ce80c0, sk c1d6ca00
hci_usb_rx_complete: hci0 urb c1a3a354 type 4 status 0 count 7 flags 0
__recv_frame: hci0 type 4 data c178bcc0 count 7
__recv_frame: new packet len 7
hci_usb_rx_complete: hci0 urb c1a3a354 type 4 resubmit status 0
snd-bt-sco: playback_trigger 0
snd-bt-sco: setting playback to NULL
bt_sock_poll: sock c1ce80c0, sk c1d6ca00
snd-bt-sco: Disposing of previous socket count 3
** bt_sock_recvmsg: Error fffffe00 reading datagram from socket c124ea00
** read len -512 bytes from socket c1ce8540


_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
