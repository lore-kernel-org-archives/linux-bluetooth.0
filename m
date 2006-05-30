Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <e85851c20605300332p163f0e51x84ab59c5cb24cbe3@mail.gmail.com>
References: <e85851c20605300332p163f0e51x84ab59c5cb24cbe3@mail.gmail.com>
Date: Tue, 30 May 2006 12:45:55 +0200
Message-Id: <1148985955.17015.9.camel@localhost>
Mime-Version: 1.0
Cc: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] [Bluez-devel] There is comfirmation but ....
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Gloria,

> i get some problem when i attempt to send a file  (i try any
> file that have differ extension) to a nokia phone (Nokia e60) from a
> computer using bluetooth.
> However, i getting confuse because i can send that file to Nokia 6680
> without any change to the source code.
> 
> Are there any differences between them?

maybe or maybe not. Run "hcidump -X -V --obex=<channel>" as root in
another terminal and see what it actually tells you.

> And also, i want to get some advices about how to get progression info
> while we sending a file?

This is actually OpenOBEX specific and I think the OpenOBEX mailing list
will be a little more suitable for this question. However if anyone else
wants to answer it, be my quest.

Regards

Marcel




_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
