Return-Path: <cyrus@holtmann.org>
Message-ID: <015401c8bbb3$4de51ce0$6701a8c0@freqonedev>
From: "David Stockwell" <dstockwell@frequency-one.com>
To: "Marcel Holtmann" <marcel@holtmann.org>
Cc: "Johan Hedberg" <johan.hedberg@gmail.com>,
	"BlueZ development" <bluez-devel@lists.sourceforge.net>
References: <013e01c8bb99$b4ba5580$6701a8c0@freqonedev> <E0A89313-87C7-4C2B-B91E-5D4326DD27DD@holtmann.org>
Subject: Re: Issues with BlueZ v3.31 Object Path Naming
Date: Wed, 21 May 2008 21:26:50 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel,

Thanks for the quick response; I do appreciate it and the effort all of you have expended in marshaling this migration to DBus. I 
fully appreciate the benefits!

I also appreciate that prepending every path with "/org/bluez" was more than a little redundant...
So, under 4.X: the Manager's path is "/";
the Adapter's path is "/hci<n>";
the device's path is "/hci<n>/dev_<remote address>"

Still, the audio device paths will be /org/bluez/device<n>, correct?  Or will it just be /device<n>, or perhaps /hci<n>/device<n>?

Also, the old paths are documented in doc/xxx-api.txt.  I will be happy to provide updates.

I will also proceed to dig through the code to straighten out the naming per the new names (assuming "experimental" is set).

One more issue: in manager.c and adapter.c, the _init functions enable the new Methods and Signals if experimental is set, then 
enables the old Methods and Signals (even if they have the same names) after that.

If experimental is set, should we not turn off the old methods and signals?  If you refer to my previous posts, you will find that 
when Discovery is completed, signals are returned against the old and new paths/signals simultaneously; very confusing, but now that 
I see how things work, I understand why it has been happening.

DS
----- Original Message ----- 
From: "Marcel Holtmann" <marcel@holtmann.org>
To: "David Stockwell" <dstockwell@frequency-one.com>
Cc: "Johan Hedberg" <johan.hedberg@gmail.com>; "BlueZ development" <bluez-devel@lists.sourceforge.net>
Sent: Wednesday, May 21, 2008 6:41 PM
Subject: Re: Issues with BlueZ v3.31 Object Path Naming


Hi David,

> I have not been chiming in for several weeks, because I have been
> busy hacking through code to figure out how bluez is supposed to
> work, how it actually works, and issues and incompatibilitites I am
> struggling with between bluez (DBus, v3.31) and the CSR BlueLab
> libraries (v4.0, compatible with BT2.1).; What fun.
>
> In working with my test application, talking with bluez, I have run
> into the following and need clarification before proceeding:
> • What is the path name for the top level Manager interface?  Is it
> going to be "/org/bluez"? Or is it supposed to be "/"?
> If you call the DefaultAdapter method with the "/org/bluez" path, it
> is resolved to call old_default_adapter in hcid/manager.c, returning
> a String representing the old Default Adapter path, or "/org/bluez/
> hci0"?
>
> On the other hand, call the DefaultAdapter method with the "/" path,
> it is resolved to call default_adapter in hcid/manager.c, returning
> an Object (actually a string representing an object path),
> representing the NEW Default Adapter path: "/hci0".  However, when
> returning the Object, it also throws an error because, somehow, /
> hci0 was never registered.  (Unregistered object at path '/hci0').
> Very bad result.
>
> So, what should it be?  /org/bluez and /org/bluez/hci0?  Or / and /
> hci0?
>
> And, while we are at it, should we clean up the documentation in
> docs/manager-api.txt and docs/adapter-api.txt?  Both refer to the
> "old" paths.  Let me know and I will be happy to "dive in".
>
> • For what it is worth, the "new" and experimental Adapter methods
> ARE registered with path "/hci0", despite the apparent fact that no
> object '/hci0' is registered...
> • I had been confused about opening an audio.Control device as
> opposed to (or in addition to, or in sequence with) a device under
> org.bluez.Adapter, using CreateDevice and CreatePairedDevice.  When
> I did get things to "work", sort of, CreateDevice would return a
> device path name like "/hci0/dev_xx_xx_xx_xx_xx_xx", but on return
> would fail with the same "Unregistered object at path" error as above.
> • Along the lines of the last item, it does appear that one must
> pair, then one must create an audio "device" using the
> org.bluez.audio.Manager CreateDevice method (with path /org/bluez/
> audio).  Am I correct in this understanding?
> • Yet another question: is the "/org/bluez/audio" path correct, or
> will it be changed in the future?  When I have used this method, it
> returns a device path of "/org/bluez/audio/device0".  It is
> interesting (and perhaps a bit strange) to use the device address,
> as opposed to the device path, to create this pseudo-device to
> provide the audio services (Device, Headset, Gateway, Sink, Source,
> Control).
> I can quickly submit patches to unify the naming, etc., if you will
> tell me your current thinking and roadmap in this area.  However, I
> do not want to waste my time hacking if you are going in some other
> direction.

the new object paths are all intentional. We currently support the 3.x
and 4.x API. Once we created 4.0, the old API will go away..

And dbus-api.txt is the 3.x API while doc/*-api.txt is the 4.x API.

Regards

Marcel
