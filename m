Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Daniel Haensse <haensse@swissembedded.com>
Reply-To: Daniel Haensse <haensse@swissembedded.com>
To: uclinux-dev <uclinux-dev@uclinux.org>
Cc: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200409262123.50707.haensse@swissembedded.com>
Subject: [Bluez-users] GSM Multiplexer Protocol
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
Date: Sun, 26 Sep 2004 21:23:50 +0200

Hi lists,

we need GPRS and SMS services at the same time. For this reason a multiplexer 
protocol is supported in GSM 07.10 which creates several virtual serial ports 
which can be controlled with normal AT commands. The AT commands are routed 
through a software multiplexer circuit which on the other end is connected to 
the real GSM modem's tty.

Is there any GSM multiplexer protocol for linux available?

Unfortunately, I did not find any driver in the kernel or userland to support 
this. I did find out so far that RFCOMM might be a good point to start 
writing virtual tty ports as bluetooth also supports GSM 07.10 in connection 
with the RFCOMM protocol. The basic idea behind it is to interface the sock 
to a the GSM modem TTY instead of L2CAP. Any hints?

Thanks

regards

Dani

-- 
swissEmbedded GmbH
Daniel Haensse, Dipl. El. Ing. ETH
Zuercherstrasse 12, 5400 Baden, Switzerland
Phone ++41562100158
Fax: ++41562100157
Mobile: ++41763207732
Email: haensse@swissembedded.com


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
