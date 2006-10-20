Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <4537DB32.7080903@flcd.net>
References: <4504301E.4060402@flcd.net> <1158313871.5233.11.camel@localhost>
	<450AD1DF.2010401@flcd.net> <1158337144.5233.34.camel@localhost>
	<451D96BD.6010201@flcd.net> <1159567413.29673.6.camel@localhost>
	<4537DB32.7080903@flcd.net>
Date: Fri, 20 Oct 2006 04:36:39 +0200
Message-Id: <1161311799.27585.8.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] enable auth and BNEP question?
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

Hi Denis,

> But I've got another a bit off topic and lame question, I've never send 
> patches before but would like to help when I can. So if I would find a 
> bug and solution for it in future, should I just generate patch in a way 
> like this:
>  "|diff -up original modified > patch"
> and send it to mail-list or there are some other commonly used procedure?

only make sure it is a unified diff (-u), because I am unable to read
context diffs. I personally to most patches with "cvs diff -u" directly
from the CVS repository.

Regards

Marcel



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
