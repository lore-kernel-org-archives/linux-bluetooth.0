Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4412ECD1.4070007@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Connecting to a headset
References: <fe0a97c20603090959r28afb671n79c0a432f4f6c0c2@mail.gmail.com>
In-Reply-To: <fe0a97c20603090959r28afb671n79c0a432f4f6c0c2@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
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
Date: Sat, 11 Mar 2006 08:29:21 -0700

Sowmya

> Iam a novice in linux and bluetooth....
> I have a very specific question regarding the headset and audio profile....
> Why is it that ALSA and Bluetooth can connect to a headset???
> I mean what ALSA can do which others can't do?
> 
> Can't it be on a lil lower kernel of 2.4.20 or something... or with
> downloaded ALSA libraries ... why only with an "integrated"  kernel with
> ALSA???? ( i,e a newer kernel.... )

Get the bluez cvs project and have a look at utils/test/scotest.c

You can write your app to do all the audio transfers itself and you
won't have to patch or upgrade the kernel.

Of course you're mostly on your own :) so good luck.

Brad


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
