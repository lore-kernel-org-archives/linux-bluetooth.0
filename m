Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Chris Sterling <chris.sterling@oXians.com>
Reply-To: csterling@oXians.com
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain
Message-Id: <1063773826.2320.9.camel@dev.blackbear.com>
Mime-Version: 1.0
Subject: [Bluez-users] bcsp w/ csr chip Mavin CF card
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
Date: 16 Sep 2003 21:43:46 -0700

I had sent a message to the list a week or so ago with the following
errors repeating in my dmesg log on the Sharp Zaurus SL5000D:

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

If I allow this to continue, the Zaurus eventually freezes up and I have
to take the battery out to get it back to normal again.  From the
output, Steven Singer explained to me that the btuart_cs module uses the
csr chip set and is in bcsp mode.  The bluez module is still talk using
H4 to the module.

I am using the base installed modules and scripts with slight
configuration modifications on theKompanyROM for the Zaurus.  It is
currently on the 2.4.18 kernel.  The Zaurus recognizes the card as the
Mavin Compact Flash card when it is put in.

Does anybody know how I can modify the scripts or configurations to
attach using bcsp and maybe give some specifics on files to be modified?
Thank you in advance.

Chris Sterling
chris.sterling@oXians.com
http://www.oXians.com/



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
