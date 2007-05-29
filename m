Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <2d5a2c100705290618n2b74dbcfmfa997c87f344a6a0@mail.gmail.com>
References: <1179933855.3629.75.camel@cookie.hadess.net>
	<59278C28-851A-44FF-AE01-25D8F074CE1E@nokia.com>
	<1180013992.3151.6.camel@cookie.hadess.net>
	<089F41B2-DBC5-483E-A6C9-F413E18DF38B@nokia.com>
	<1180032597.14752.13.camel@cookie.hadess.net>
	<1180096233.14752.27.camel@cookie.hadess.net>
	<1180097928.14752.33.camel@cookie.hadess.net>
	<1180105720.14752.49.camel@cookie.hadess.net>
	<2d5a2c100705282058o22ace961y93308be3340bb2d4@mail.gmail.com>
	<1180434383.3030.70.camel@cookie.hadess.net>
	<2d5a2c100705290618n2b74dbcfmfa997c87f344a6a0@mail.gmail.com>
Date: Tue, 29 May 2007 15:37:55 +0200
Message-Id: <1180445875.21432.137.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] CUPS plugin discovery bits
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Luiz,

>         > Btw, The printer wizard as it is now wont work with periodic
>         > discovery, signals DiscoveryStarted and 
>         > DiscoveryCompleted are not emitted while in
>         periodic  discovery.
>         
>         The cups backend isn't supposed to run forever, so it can't do
>         periodic
>         discovery.
> 
> Well that is not the case of being running forever but you could
> probably 
> test if the periodic scan is active before you start a blocking
> discovery.
> My main concern is about multiple process doing this, the probability
> of
> having collisions while doing sdp searches could be very high as it is
> very 
> common to have more than one functionality in a device, this leaves
> wizard
> processes very complicated and may force them to reschedule on each
> collision .

it is fine to start an inquiry while you are in periodic inquiry. With
the exception that some chips don't allow that.

It is also fine to create an ACL link while in periodic inquiry since
the device then will stop its inquiry train automatically and switch to
page for the ACL link. After it it will continue with the periodic
inquiry as before.

The kernel now takes care of serializing the ACL link creation. This
works perfectly fine. There is one small glitch with remote name resolve
that doesn't trigger the ACL queue. However real name request have been
always a problem. However over D-Bus you only get cached names or an
error anyway. The only exception is if you in inquiry or periodic
inquiry. While the inquiry is no problem, we have to check with the
periodic inquiry if we create a deadlock.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
