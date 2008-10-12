Return-Path: <cyrus@holtmann.org>
Message-ID: <48F23B66.7030605@powercraft.nl>
Date: Sun, 12 Oct 2008 20:01:10 +0200
From: Jelle de Jong <jelledejong@powercraft.nl>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <48F1F7C0.4040705@powercraft.nl>
	<1223819361.31961.1763.camel@cookie.hadess.net>
In-Reply-To: <1223819361.31961.1763.camel@cookie.hadess.net>
Subject: Re: [Bluez-devel] Sony Bluetooth BD Remote Control
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
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Bastien Nocera wrote:
> On Sun, 2008-10-12 at 15:12 +0200, Jelle de Jong wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
> <snip>
>> Hello everybody,
>>
>> I bought a bluetooth remote for a bluetooth mobile system that I am
>> trying to built. (bluetooth remote, speakers, mouse, keyboard, headset, gps)
>>
>> However I can't get the device to work out of the box... I have found
>> some script and some tools on the internet but this is not very
>> maintainable (and I could not get it to work)
>>
>> I am wondering what is needed to create a good healthy maintainable
>> system to get the remote working out of the box after connecting to it
>> with bluez...? So how do we create out of the box support for bluetooth
>> devices?
>>
>> hidd[3688]: New HID device 00:1E:3D:15:0A:4F (Sony Computer
> 
> There's no hidd support for the PS3 BD remote. Use bluez-{utils,libs}
> 3.36, or use the latest versions of bluez and bluez-gnome (and make sure
> your version has that patch[1]).
> 
> And don't use that "Linux driver" horror that requires networking...
> 
> [1]:
> http://git.kernel.org/?p=bluetooth/bluez-gnome.git;a=commit;h=c99b105989a216dd4565228ba7dc3b2702f4a6ad
> 

Thank you for the information,

I currently use bluez-utils_3.36-2_i386.deb and bluetooth_3.36-2_all.deb
on my debian sid system this is version 3.36 as suggested. I don't know
if the patch is applied on the package. Should the device have worked on
my system?

But I am kind of curious what is needed to get such device working in
the source code and how keys are mapped.

Kind regards,

Jelle



-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
