Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: David Stockwell <dstockwell@frequency-one.com>
In-Reply-To: <013e01c8bb99$b4ba5580$6701a8c0@freqonedev>
References: <013e01c8bb99$b4ba5580$6701a8c0@freqonedev>
Message-Id: <E0A89313-87C7-4C2B-B91E-5D4326DD27DD@holtmann.org>
Mime-Version: 1.0 (Apple Message framework v919.2)
Date: Thu, 22 May 2008 01:41:45 +0200
Cc: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Issues with BlueZ v3.31 Object Path Naming
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi David,

> I have not been chiming in for several weeks, because I have been  =

> busy hacking through code to figure out how bluez is supposed to  =

> work, how it actually works, and issues and incompatibilitites I am  =

> struggling with between bluez (DBus, v3.31) and the CSR BlueLab  =

> libraries (v4.0, compatible with BT2.1).; What fun.
>
> In working with my test application, talking with bluez, I have run  =

> into the following and need clarification before proceeding:
> 	=95 What is the path name for the top level Manager interface?  Is it  =

> going to be "/org/bluez"? Or is it supposed to be "/"?
> If you call the DefaultAdapter method with the "/org/bluez" path, it  =

> is resolved to call old_default_adapter in hcid/manager.c, returning  =

> a String representing the old Default Adapter path, or "/org/bluez/ =

> hci0"?
>
> On the other hand, call the DefaultAdapter method with the "/" path,  =

> it is resolved to call default_adapter in hcid/manager.c, returning  =

> an Object (actually a string representing an object path),  =

> representing the NEW Default Adapter path: "/hci0".  However, when  =

> returning the Object, it also throws an error because, somehow, / =

> hci0 was never registered.  (Unregistered object at path '/hci0').  =

> Very bad result.
>
> So, what should it be?  /org/bluez and /org/bluez/hci0?  Or / and / =

> hci0?
>
> And, while we are at it, should we clean up the documentation in  =

> docs/manager-api.txt and docs/adapter-api.txt?  Both refer to the  =

> "old" paths.  Let me know and I will be happy to "dive in".
>
> 	=95 For what it is worth, the "new" and experimental Adapter methods  =

> ARE registered with path "/hci0", despite the apparent fact that no  =

> object '/hci0' is registered...
> 	=95 I had been confused about opening an audio.Control device as  =

> opposed to (or in addition to, or in sequence with) a device under  =

> org.bluez.Adapter, using CreateDevice and CreatePairedDevice.  When  =

> I did get things to "work", sort of, CreateDevice would return a  =

> device path name like "/hci0/dev_xx_xx_xx_xx_xx_xx", but on return  =

> would fail with the same "Unregistered object at path" error as above.
> 	=95 Along the lines of the last item, it does appear that one must  =

> pair, then one must create an audio "device" using the  =

> org.bluez.audio.Manager CreateDevice method (with path /org/bluez/ =

> audio).  Am I correct in this understanding?
> 	=95 Yet another question: is the "/org/bluez/audio" path correct, or  =

> will it be changed in the future?  When I have used this method, it  =

> returns a device path of "/org/bluez/audio/device0".  It is  =

> interesting (and perhaps a bit strange) to use the device address,  =

> as opposed to the device path, to create this pseudo-device to  =

> provide the audio services (Device, Headset, Gateway, Sink, Source,  =

> Control).
> I can quickly submit patches to unify the naming, etc., if you will  =

> tell me your current thinking and roadmap in this area.  However, I  =

> do not want to waste my time hacking if you are going in some other  =

> direction.

the new object paths are all intentional. We currently support the 3.x  =

and 4.x API. Once we created 4.0, the old API will go away..

And dbus-api.txt is the 3.x API while doc/*-api.txt is the 4.x API.

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
