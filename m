Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <6F1ED394B577D71182ED0020ED3A22BD2E0BFF@NICONT2>
From: Willem Myburgh <wmyburgh@astratagroup.com>
To: "'Daniel Haensse'" <haensse@swissembedded.com>,
   "'uClinux development list'" <uclinux-dev@uclinux.org>
Cc: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: [Bluez-users] RE: [uClinux-dev] GSM Multiplexer Protocol
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
Date: Tue, 28 Sep 2004 09:37:07 +0200

Hi all

We also require a GSM Multiplexer.

I suppose one has to implement a special line discipline in the tty layer.
This line discipline then should provide the number of virtual serial
devices
as required by GSM 07.10 as a set of tty_driver.

A good way to start is to look at the PPP driver code. This code implements
a
line discipline that process frames, and pass data on to the PPP net device
driver.


Kind regards

Willem Myburgh
Design Engineer
--
//===========================
Astrata Systems (Pty) Limited
11 Termo Street
Technopark
STELLENBOSCH, 7600
South Africa
Tel : +27 21 880-2822
Fax : +27 21 880-1308
Cell: +27 83 415-0416
Web : www.astratagroup.com
//===========================


-----Original Message-----
From: Daniel Haensse [mailto:haensse@swissembedded.com]
Sent: Sunday, September 26, 2004 9:24 PM
To: uclinux-dev
Cc: bluez-users@lists.sourceforge.net
Subject: [uClinux-dev] GSM Multiplexer Protocol


Hi lists,

we need GPRS and SMS services at the same time. For this reason a
multiplexer 
protocol is supported in GSM 07.10 which creates several virtual serial
ports 
which can be controlled with normal AT commands. The AT commands are routed 
through a software multiplexer circuit which on the other end is connected
to 
the real GSM modem's tty.

Is there any GSM multiplexer protocol for linux available?

Unfortunately, I did not find any driver in the kernel or userland to
support 
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
_______________________________________________
uClinux-dev mailing list
uClinux-dev@uclinux.org
http://mailman.uclinux.org/mailman/listinfo/uclinux-dev
This message was resent by uclinux-dev@uclinux.org
This electronic mail message contains confidential information for the
addressee only. If you  are not the intended recipient, please notify us
immediately. You should not  use, disclose, distribute or copy this
communication if received in error.  NO BINDING CONTRACT WILL RESULT FROM
THIS E-MAIL UNTIL SUCH TIME AS A  WRITTEN DOCUMENT IS SIGNED ON BEHALF OF
THE COMPANY. Astrata Systems (PTY) Ltd cannot accept any responsibility for
the  completeness or accuracy of this message as it has been transmitted
over  public networks.


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
