Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <v04020a19be02f88660fa@[192.168.49.19]>
In-Reply-To: <1105014278.4299.19.camel@pegasus>
References: <5256d0b05010520461ad68ff3@mail.gmail.com>
 <5256d0b05010520461ad68ff3@mail.gmail.com>
To: bluez-devel@lists.sourceforge.net
From: Bob Gustafson <bobgus@rcn.com>
Subject: Re: [Bluez-devel] btsco under FC3
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 6 Jan 2005 08:23:44 -0600

Yes, I did that too.

something like 'up2date libao-devel', but the @AO. symbols were still in
the Makefile. I did lots of things, so need to do a clean install and
update to make certain what needs to be done to what.

It seemed as though all of the libao files installed in /usr/lib were of
the shared variety - thus I experimented with the libtool insertions in
sbc/Makefile as mentioned in my last email.

BobG

On Thu, 06 Jan 2005 13:24:38 +0100, Marcel Holtmann wrote:
>Hi Pete,
>
>> Just trying to compile btsco under FC3 and have run into a little
>> trouble compiling the latest CVS version. I can't actually get it to
>> compile as yet but will include the HW details FYI.
>>
>> D-Link DBT-120 rev B2
>> Headset Motorola HS-810
>> I also have a Motorola HS-850 on the way (the 810 is actually a friends).
>>
>> The actual problem is that it can't locate the @AO_CFLAGS@ directory
>> during compile. I'm following the directions on the website.
>
>what about installing the AO library development package.
>
>Regards
>
>Marcel
>
>
>
>
>-------------------------------------------------------
>The SF.Net email is sponsored by: Beat the post-holiday blues
>Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
>It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
>_______________________________________________
>Bluez-devel mailing list
>Bluez-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/bluez-devel



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
