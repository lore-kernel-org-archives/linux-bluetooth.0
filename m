Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <fb2ac3c90803041440l75dead88y8cd8dc9d23cf66a8@mail.gmail.com>
References: <fb2ac3c90803041411k3ea1426cib1e729b19053adce@mail.gmail.com>
	<F5766422-47CD-4AD6-8C71-AD7D21BDB4BD@holtmann.org>
	<fb2ac3c90803041440l75dead88y8cd8dc9d23cf66a8@mail.gmail.com>
Date: Thu, 06 Mar 2008 11:56:31 +0100
Message-Id: <1204800991.13254.8.camel@californication>
Mime-Version: 1.0
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

> Aren't you maintaining bluez-gnome?  Could you add this fallback to
> properties/input.c?

feel free to send a patch :)

> I'm curious what you mean by "would have broken the API."  Do you mean
> if we were to remove the method now after it has been released?  If so
> then I agree, it's too late.

We can't add any parameters to an already established method call. And
there are cases were we wanna use a device in an unpaired way.

> But I'm curious why a new method was added rather than new
> functionality to the existing method.  Are there new callbacks that
> would have broken existing clients?  I guess it's a moot point now
> though.

See my point above. It is not that simple.

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
