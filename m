Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] obexFTP ... does it works?
From: Marcel Holtmann <marcel@holtmann.org>
To: Massimiliano Cuccia <massimiliano_cuccia@yahoo.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040925213557.18900.qmail@web53207.mail.yahoo.com>
References: <20040925213557.18900.qmail@web53207.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1096149821.7719.7.camel@pegasus>
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
Date: Sun, 26 Sep 2004 00:03:42 +0200

Hi Massimiliano,

> I installed linux suse 9.1 and some rpm from suse and
> now I have a bt support.
> 
> I read in the suse help center a command line that can
> send files to my cell phones (Nokia 6600)
> here it is:
> obexftp -b xx:xx:xx:xx:xx:xx -B 10 -p pippo.jpg
> 
> (xx:xx:xx:xx:xx:xx is the addr I read using hcitool
> scan)
> (I don't know what is the -B 10 option)

have you tried to look this up with "man obexftp"? It is the Bluetooth
RFCOMM channel number of the FTP service.

> I already installed obexftp 1.0.1 but it doesn't works
> ... 
> it says failed
> anyone can help me to understand why?
> others operation works correctly, so I can send a file
> (note or image) to my linux (using opd) from my phone.
> 
> The same operation works if i use the KDEBluetooth
> framework ... but I need a command line tool

There is a tool call btobex in the BlueZ obex CVS repository that might
work.

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
