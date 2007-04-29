Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Sun, 29 Apr 2007 09:08:15 +0400
From: John Frankish <frankish@dubai.oilfield.slb.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-id: <7.0.1.0.2.20070429085827.03de8030@dubai.oilfield.slb.com>
MIME-version: 1.0
Subject: [Bluez-devel] Fwd: Re: Unable to set number of SCO buffers : please
 upgrade your Kernel !
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

I tried a couple of things over the last few days:

1. Tried to find the archives to search for an earlier 
sco-flowcontrol patch that might have been submitted by Fabien - no 
luck, where are the archives?

2. I compiled bluez-libs/bluez-utils 3.9 to see if plugz would work 
better with this - I ran into the same pin problem as before in that 
I don't get a pin pop-up on my machine. If I set security to auto in 
hcid.conf then I can pair with my cell phone since I can enter a pin 
on the phone but this does not work with a bluetooth headset since I 
cannot enter a pin and hcid just sits there waiting...

# hcid -n
hcid[32062]: Bluetooth HCI daemon
hcid[32062]: HCI dev 0 registered
hcid[32062]: HCI dev 0 already up
hcid[32062]: Device hci0 has been added
hcid[32062]: Starting security manager 0
hcid[32062]: Device hci0 has been activated
hcid[32062]: link_key_request (sba=00:10:C6:56:F4:9F, dba=00:0A:D9:E8:4A:65)

btsco works fine with the same setup and bluez-libs/utils 2.15, but I 
would rather use plugz so any help would be welcome.

Regards
John


>Date: Wed, 25 Apr 2007 09:56:03 +0400
>From: John Frankish <frankish@dubai.oilfield.slb.com>
>Subject: Re: [Bluez-devel] Unable to set number of SCO buffers : 
>please upgrade
>  your Kernel !
>Sender: bluez-devel-bounces@lists.sourceforge.net
>To: BlueZ development <bluez-devel@lists.sourceforge.net>
>Reply-to: BlueZ development <bluez-devel@lists.sourceforge.net>
>Message-id: <7.0.1.0.2.20070425095009.03d963a8@dubai.oilfield.slb.com>
>Content-type: text/plain; charset=us-ascii
>Content-transfer-encoding: 7bit
>List-Post: <mailto:bluez-devel@lists.sourceforge.net>
>List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
>  <mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
>List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
>  <mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
>List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
>List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
>List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
>Original-recipient: rfc822;frankish@dubai.oilfield.slb.com
>
>Brad,
>
>Whilst it's reasonably difficult to move to a newer kernel in DSL-N,
>the main reason for making plugz work on this kernel is that I can
>then make it available as a DSL-N extension for many others to use.
>
>I tried the diff2 patch on my kernel - it ran with about 5 failures,
>4 of which I added manually. After reboot, I had the same SCO buffers
>error message. I wonder - does plugz need a certain version revision
>of bluez-utils or will it work with any version? I am using
>bluez-utils 2.15 as I cannot make the "pin" part of things work on
>DSL-N with later versions.
>
>Where would Fabien have put the earlier SCO patch?
>
>Thanks
>John
>
>At 17:45 24-04-07, you wrote:
> >John
> >
> > > The earliest patch in the cvs is v2.0 for 2.6.18-mh7 - given that I
> > > have 2.6.12 (DSL-N is like Knoppix, you cannot easily update the
> > > kernel), is there a patch archive somewhere with a patch closer to my
> > > kernel or do I need to try and apply the patch "manually"?
> >
> >Fabien may have submitted an early patch that is closer to your kernel
> >but rather than backport or dig in the archives I suggest you consider
> >trying a newer kernel.
> >
> >Brad
> >
> >-------------------------------------------------------------------------
> >This SF.net email is sponsored by DB2 Express
> >Download DB2 Express C - the FREE version of DB2 express and take
> >control of your XML. No limits. Just data. Click to get it now.
> >http://sourceforge.net/powerbar/db2/
> >_______________________________________________
> >Bluez-devel mailing list
> >Bluez-devel@lists.sourceforge.net
> >https://lists.sourceforge.net/lists/listinfo/bluez-devel
>
>
>-------------------------------------------------------------------------
>This SF.net email is sponsored by DB2 Express
>Download DB2 Express C - the FREE version of DB2 express and take
>control of your XML. No limits. Just data. Click to get it now.
>http://sourceforge.net/powerbar/db2/
>_______________________________________________
>Bluez-devel mailing list
>Bluez-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/bluez-devel


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
