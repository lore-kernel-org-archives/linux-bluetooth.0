Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] GSM Multiplexer Protocol
From: Marcel Holtmann <marcel@holtmann.org>
To: Daniel Haensse <haensse@swissembedded.com>
Cc: uclinux-dev <uclinux-dev@uclinux.org>, bluez-users@lists.sourceforge.net
In-Reply-To: <200409262123.50707.haensse@swissembedded.com>
References: <200409262123.50707.haensse@swissembedded.com>
Content-Type: text/plain
Message-Id: <1096359052.4684.20.camel@notepaq>
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
Date: Tue, 28 Sep 2004 10:10:52 +0200

Hi Daniel,

> we need GPRS and SMS services at the same time. For this reason a multiplexer 
> protocol is supported in GSM 07.10 which creates several virtual serial ports 
> which can be controlled with normal AT commands. The AT commands are routed 
> through a software multiplexer circuit which on the other end is connected to 
> the real GSM modem's tty.
> 
> Is there any GSM multiplexer protocol for linux available?
> 
> Unfortunately, I did not find any driver in the kernel or userland to support 
> this. I did find out so far that RFCOMM might be a good point to start 
> writing virtual tty ports as bluetooth also supports GSM 07.10 in connection 
> with the RFCOMM protocol. The basic idea behind it is to interface the sock 
> to a the GSM modem TTY instead of L2CAP. Any hints?

the RFCOMM is not a good starting point, because it is only a subset of
GSM 07.10 specification and they already changed some parts of them to
met their requirements.

You should implement it as a serial line discipline like we have done
for the hci_uart driver, but as far as I know nobody started working on
such a kernel driver.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
