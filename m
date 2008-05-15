Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <482AE9AB.8060105@suse.de>
References: <482AE9AB.8060105@suse.de>
Date: Thu, 15 May 2008 11:39:09 +0200
Message-Id: <1210844349.7025.33.camel@violet.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Mouse not reconnecting after Timeout
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

Hi Stefan,

> My Logitech MX LASER does not reconnect after the idle timeout.
> If i either pull the dongle and replug it or switch off the mouse and switch
> it back on or do a
> 
>  dbus-send --system --type=method_call \
>            --dest=org.bluez /org/bluez/hci0 \
>            org.bluez.Adapter.DisconnectRemoteDevice \
>            string:"00:07:61:3F:1B:6D"
> 
> then it reconnects fine.
> This happens with all dongles (The internal one in my hp2510p, one of the CSR
> based HAMA mini-dongles, ...)
> 
> I'm running 2.6.25.3 and bluez-{libs,utils}-3.31 with btusb (but it also
> happened with hci_usb).
> My DELL BT Keyboard and other mice are working fine and reconnecting after
> timeout. I have reports of similar symptoms from apple bt-keyboard users.

so the first assumption is that we are causing this disconnect with the
idle timeout setting. I committed a patch to the CVS that disables the
timeout and provides a input.conf setting that would allow to change it
without re-compiling. So we can actually set this to 1 minute for
testing and see what happens.

If this actually fixes it, then it is only an interim fix since the real
problem is that we are disconnecting the remote device wrongly. Current
guess is that we still keep a reference count somewhere. Either inside
the kernel or in user-space.

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
