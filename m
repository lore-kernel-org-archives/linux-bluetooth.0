Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <545015.6254.qm@web37701.mail.mud.yahoo.com>
References: <545015.6254.qm@web37701.mail.mud.yahoo.com>
Date: Sun, 28 Jan 2007 22:47:29 +0100
Message-Id: <1170020849.4630.18.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] poll() problem ...
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
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

Hi Imran,

>    I am making a assignment 'file transfer using Bluetooth on hci
> layer'. I take code from hci.c. The problem is sometime my program
> works perfectly and transfer file successful. But most of the time it
> failed. 
> Sender sends the Handshake packet and on Receiving side it receives.
> Receiver sends HACK to Sender but didn't receive anything. Means
> 
> n = poll(&p, 1, timeout)
> 
> n goes to 0. and the error is ETIMEDOUT. 
> But the same program works fine sometime.
> I am getting sick from this problem. 
> I also try with different and same timeout values. but it doesn't
> effect in anyway.

actually it is a bad idea trying to use ACL links directly to transfer
files. The ACL packets are only meant to be used by L2CAP.

However you have to show us your complete code. Otherwise we can't tell
you anything.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
