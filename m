Return-Path: <cyrus@holtmann.org>
Message-Id: <7523DBFE-12FA-48A2-9DF1-FA30ACEDB92C@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <fb2ac3c90803060754i5c7910as8ed1f92b26f70dc7@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Date: Fri, 7 Mar 2008 19:39:55 +0100
References: <fb2ac3c90803041411k3ea1426cib1e729b19053adce@mail.gmail.com>
	<F5766422-47CD-4AD6-8C71-AD7D21BDB4BD@holtmann.org>
	<fb2ac3c90803041440l75dead88y8cd8dc9d23cf66a8@mail.gmail.com>
	<1204800991.13254.8.camel@californication>
	<fb2ac3c90803060754i5c7910as8ed1f92b26f70dc7@mail.gmail.com>
Subject: Re: [Bluez-devel] CreateSecureDevice
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

Hi Andrew,

>>> Aren't you maintaining bluez-gnome?  Could you add this fallback to
>>> properties/input.c?
>>
>> feel free to send a patch :)
>
> Trouble is that it doesn't return anything, it just segfaults.
> Probably it's being called in some wrong way.  I might look at it
> someday but given that I can just remove 'Secure' if bluez-utils is
> too old I think I'll just leave the package patched.

if it segfaults then it is a bug in bluez-gnome. It should never  
segfault only because a method is not available.

>>> I'm curious what you mean by "would have broken the API."  Do you  
>>> mean
>>> if we were to remove the method now after it has been released?   
>>> If so
>>> then I agree, it's too late.
>>
>> We can't add any parameters to an already established method call.  
>> And
>> there are cases were we wanna use a device in an unpaired way.
>
> There can be an input device that can be used in either paired or
> unpaired mode as desired?  I wouldn't have thought any such thing
> existed, but if that's so then I agree and am sorry to have troubled
> you about it.

The HID specification and its implementation are broken in some cases :(

Regards

Marcel


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
