Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <44F45E3F.7050507@csr.com>
Date: Tue, 29 Aug 2006 16:33:19 +0100
From: Steven Singer <steven.singer@csr.com>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <44EC4CFC.4060400@arcor.de>
In-Reply-To: <44EC4CFC.4060400@arcor.de>
Subject: Re: [Bluez-users] Inquiry in Bluetooth 1.2
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

Simon Siemens wrote:
> So what is this enhanced inquiry scan? How is it compared to the old
> v1.1 inquiry scan? How can I activate it?

Here's an answer I wrote to someone else who asked me this question
today.

I've not checked all the details and I may have simplified in places, but
it should be close enough for you to understand the difference.

-------------------------------------------------------------------------
Enhanced inquiry scan is a mandatory feature in 1.2 and is not a feature
that can be turned on and off. All 1.2 devices do enhanced inquiry scan
all the time.

Enhanced inquiry scan is entirely backwards compatible with the inquiry
procedure in 1.1 and earlier (in fact, the inquiry procedure was not
changed between 1.1 and 1.2).

The enhancement is just a minor change to the inquiry scan timing. In
BT 1.1 the inquiry scan procedure is:

    1) Go into scan for the time specified by the inquiry scan window.
    2a) If you don't receive an ID packet before the end of the window:
       + wait until the next inquiry scan interval
       + go to stage 1
    2b) if you receive an ID packet before the end of the window:
       + back off for 0..1023 slots
       + go into inquiry scan again for 128 slots.
       + if you receive an ID packet before the end of the 128 slots:
         * send an FHS packet
         * go to stage 1
       + If you don't receive an ID packet before the end of the 128
         slots:
         * go to stage 1

In 1.2, the procedure is simplified to:

    1) Go into scan for the time specified by the inquiry scan window.
    2a) If you don't receive an ID packet before the end of the window:
       + wait until the next inquiry scan interval
       + go to stage 1
    2b) if you receive an ID packet before the end of the window:
       + send an FHS packet
       + back off for 0..1023 slots
       + go to stage 1

The big difference is that in 1.1 you a device backs off before it
responds and then must be hit in a window after the backoff, whereas,
in 1.2 a device responds in its normal window before it backs off.

This means that 1.2 devices respond sooner than 1.1 devices. This
means that responses can be collected faster.

Also, with the 1.1 procedure, there was a chance that even with perfect
radio conditions, it was possible to have a timing such that not all
devices could respond. In 1.2, that pathology has been removed so that
all devices should be detected (assuming there are no collisions).
-------------------------------------------------------------------------

The timing pathology I refer to is when a 1.1 device receives the initial
ID packet just before the inquirer changes trains (which someone's
already explained in this thread). In that case, after the backoff, the
scanner is listening while the inquirer is on the other train. By the
time the inquirer has returned to this train, the 128 slot timeout has
expired and the scanner needs to be hit twice to respond.

I hope this helps.

	- Steven
-- 


To access the latest news from CSR copy this link into a web browser:  http://www.csr.com/email_sig.php

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
