Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Chris Sterling <chris.sterling@blackbearconsulting.com>
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain
Message-Id: <1063600741.9649.7.camel@dev.blackbear.com>
Mime-Version: 1.0
Subject: [Bluez-users] btuart_cs module freezes Zaurus SL5000D after 30 seconds
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: 14 Sep 2003 21:39:02 -0700

I am currently having an issue where I get the following error dmesg:

btuart_cs: Unknown HCI packet with type 0xc0 received.
btuart_cs: Unknown HCI packet with type 0x00 received.
btuart_cs: Unknown HCI packet with type 0x41 received.
btuart_cs: Unknown HCI packet with type 0x00 received.
btuart_cs: Unknown HCI packet with type 0xbe received.
btuart_cs: Unknown HCI packet with type 0xa9 received.
btuart_cs: Unknown HCI packet with type 0xdc received.
btuart_cs: Unknown HCI packet with type 0xed received.
btuart_cs: Unknown HCI packet with type 0xed received.
btuart_cs: Unknown HCI packet with type 0x01 received.
btuart_cs: Unknown HCI packet with type 0xff received.
btuart_cs: RLSI

After this has filled up the dmesg with these messages, the zaurus I
have freezes. I am using the theKompanyROM which has the 2.4.18 kernel.
I get the same thing on the YetAnotherROM, as well. So, I believe that
it must be the module itself and how it works with the Mavin BT CF card.

Does anyone have any ideas on how I might be able to fix this?

Thanks.

-- 
Chris Sterling <chris.sterling@blackbearconsulting.com>
Black Bear Consulting


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
