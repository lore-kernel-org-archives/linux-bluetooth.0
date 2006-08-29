Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <20060829212436.50217.qmail@web25713.mail.ukl.yahoo.com>
Date: Tue, 29 Aug 2006 22:24:36 +0100 (BST)
From: Ray <whatdoineed2do@yahoo.co.uk>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: Re: [Bluez-users] hci0 only comes up with PSCAN (no ISCAN)
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

hi Marcel

> > i am currently using bluez 3.4 (hcid has dynamic
dep
> > on libbluetooth-2.2.1) so the disable iscan bug
still
> > exists.
> 
> I have no idea what you mean. This bug has nothing
to do with the
> library version you use. However if you use
bluez-utils-3.4 the you
> should also use bluez-libs-3.4 as stated in the
ChangeLog file. A
> previous library version might work, but it can also
have side effects.

what i meant to say was that i was using both the 3.4
versions of the bluez-libs and bluez-utils;  i was
saying that the hcid binary (from the utils pkg) has a
dynamic dep (ldd) against the libbluetooth.so.2.2.1
just to prove that everything i have used is from the
3.4 bluez libs/utils

given this situation, would you say that there is
still a bug?

thanks
ray


	
	
		
___________________________________________________________ 
All new Yahoo! Mail "The new Interface is stunning in its simplicity and ease of use." - PC Magazine 
http://uk.docs.yahoo.com/nowyoucan.html

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
