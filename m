Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <1080.200.183.91.159.1095630933.squirrel@webmail.ic.unicamp.br>
From: ra002890@ic.unicamp.br
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Subject: [Bluez-users] HCI EMU ?
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
Date: Sun, 19 Sep 2004 18:55:33 -0300 (BRT)

Hello everybody from bluez-users...

  I'm trying to put hciemu to work on my notebook, but it does nothing.
  I have downloaded hciemu sources from bluez.org and compiled it with:
  ./configure
  make
  make install
  All this gone well but when I try to run hciemu nothing happens.
  I tried in this way:
  hciemu localhost:1234
  hciconfig hci0 up
  hciconfig   --> nothing appears...

  above all I have loaded hci_vhci module.
  Can iptables block this port, and for this reason my hciemu is not
working?!?

                            Thanks in advance, Daniel Moraes.


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
