Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Unknown HCI packet type / 3CRWB6096B
From: Marcel Holtmann <marcel@holtmann.org>
To: Jan Sykora <Jan.Sykora@fel.cvut.cz>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <40F3BD15.30908@fel.cvut.cz>
References: <40F3BD15.30908@fel.cvut.cz>
Content-Type: text/plain
Message-Id: <1089826519.4517.7.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 14 Jul 2004 19:35:19 +0200

Hi Jan,

> I am able to establish kppp session to siemens s55 mobile and the 
> connection works OK, however after a while I get messages in 
> /var/log/messages
> 
> Jul 12 23:59:26 merlin kernel: h4_check_data_len: Data length is too large
> Jul 12 23:59:26 merlin kernel: h4_recv: Unknown HCI packet type 00
> Jul 12 23:59:26 merlin kernel: h4_recv: Unknown HCI packet type 6e
> Jul 12 23:59:26 merlin kernel: h4_recv: Unknown HCI packet type 20
> Jul 12 23:59:26 merlin kernel: h4_recv: Unknown HCI packet type 63
> Jul 12 23:59:26 merlin kernel: h4_recv: Unknown HCI packet type 6c
> Jul 12 23:59:26 merlin kernel: h4_recv: Unknown HCI packet type 61
> Jul 12 23:59:26 merlin kernel: h4_recv: Unknown HCI packet type 73
> Jul 12 23:59:26 merlin kernel: h4_recv: Unknown HCI packet type 73
> Jul 12 23:59:26 merlin kernel: h4_recv: Unknown HCI packet type 3d
> Jul 12 23:59:26 merlin kernel: h4_recv: Unknown HCI packet type 22
> Jul 12 23:59:26 merlin kernel: h4_recv: Unknown HCI packet type 63
> Jul 12 23:59:26 merlin kernel: h4_recv: Unknown HCI packet type 61
> Jul 12 23:59:26 merlin kernel: h4_recv: Unknown HCI packet type 73
> Jul 12 23:59:26 merlin kernel: h4_recv: Unknown HCI packet type 22
> Jul 12 23:59:26 merlin kernel: h4_recv: Unknown HCI packet type 3e
> Jul 12 23:59:26 merlin kernel: h4_recv: Unknown HCI packet type 31
> Jul 12 23:59:26 merlin kernel: h4_recv: Unknown HCI packet type 32
> Jul 12 23:59:26 merlin kernel: h4_recv: Unknown HCI packet type 2e
> Jul 12 23:59:26 merlin kernel: l2cap_recv_acldata: Unexpected start 
> frame (len 9)
> Jul 12 23:59:26 merlin kernel: h4_recv: Unknown HCI packet type 45
> Jul 12 23:59:26 merlin kernel: h4_recv: Unknown HCI packet type 00
> Jul 12 23:59:26 merlin kernel: h4_recv: Unknown HCI packet type 05
> Jul 12 23:59:26 merlin kernel: h4_recv: Unknown HCI packet type dc
> Jul 12 23:59:26 merlin kernel: h4_check_data_len: Data length is too large
> Jul 12 23:59:26 merlin kernel: h4_recv: Unknown HCI packet type 11
> Jul 12 23:59:26 merlin kernel: h4_recv: Unknown HCI packet type 00
> Jul 12 23:59:26 merlin kernel: h4_recv: Unknown HCI packet type 5d
> Jul 12 23:59:26 merlin kernel: h4_recv: Unknown HCI packet type 40
> Jul 12 23:59:26 merlin kernel: h4_recv: Unknown HCI packet type 00
> Jul 12 23:59:26 merlin kernel: h4_recv: Unknown HCI packet type 74
> Jul 12 23:59:26 merlin kernel: h4_recv: Unknown HCI packet type 06
> Jul 12 23:59:26 merlin kernel: h4_recv: Unknown HCI packet type 37
> Jul 12 23:59:26 merlin kernel: h4_recv: Unknown HCI packet type 7d
> Jul 12 23:59:26 merlin kernel: h4_recv: Unknown HCI packet type 33
> Jul 12 23:59:26 merlin kernel: h4_recv: Unknown HCI packet type 50
> Jul 12 23:59:26 merlin kernel: h4_recv: Unknown HCI packet type bc
> Jul 12 23:59:26 merlin kernel: h4_recv: Unknown HCI packet type a2
> Jul 12 23:59:26 merlin kernel: h4_recv: Unknown HCI packet type c3
> Jul 12 23:59:26 merlin kernel: h4_recv: Unknown HCI packet type ac
> Jul 12 23:59:26 merlin kernel: h4_recv: Unknown HCI packet type 18
> Jul 12 23:59:26 merlin kernel: h4_recv: Unknown HCI packet type 27
> Jul 12 23:59:26 merlin kernel: h4_recv: Unknown HCI packet type f4
> Jul 12 23:59:26 merlin kernel: h4_recv: Unknown HCI packet type 00
> Jul 12 23:59:26 merlin kernel: l2cap_recv_acldata: Fragment is too large 
> (len 17, expect 16)
> Jul 12 23:59:26 merlin kernel: l2cap_recv_acldata: Unexpected 
> continuation frame (len 17)
> Jul 12 23:59:26 merlin last message repeated 8 times
> Jul 12 23:59:26 merlin kernel: l2cap_recv_acldata: Unexpected 
> continuation frame (len 15)
> Jul 12 23:59:31 merlin kernel: h4_check_data_len: Data length is too large
> .......

this is an out of sync H4 stream. This happens sometimes. Try to enable
flow control on your serial port.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
