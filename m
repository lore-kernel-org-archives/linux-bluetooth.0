Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Help needed (Fedora Core 2)
From: Marcel Holtmann <marcel@holtmann.org>
To: Ricky Soh <rickysoh@gmail.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <db972f43040912183766fef4f9@mail.gmail.com>
References: <db972f43040909203314e6825d@mail.gmail.com>
	 <20040910034429.37672.qmail@web11605.mail.yahoo.com>
	 <db972f43040909223675a4a082@mail.gmail.com>
	 <1094997279.5695.2.camel@pegasus>
	 <db972f43040912183766fef4f9@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1095072018.5695.35.camel@pegasus>
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
Date: Mon, 13 Sep 2004 12:40:18 +0200

Hi Ricky,

> If bluez is installed properly, i should be able to see bluez under
> lsmod right? And l2test and scotest command are bluez command too, why
> are they missing? Please help.

with a 2.6 kernel the core module is named bluetooth.ko and not bluez.o
and the l2test and scotest commands are never installed by default.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
