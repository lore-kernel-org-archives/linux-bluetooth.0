Return-Path: <cyrus@holtmann.org>
Message-Id: <8C64B784-7758-40B0-AE1B-C15F475693D4@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20080826163544.GA5068@lapse.rw.madduck.net>
Mime-Version: 1.0 (Apple Message framework v928.1)
Date: Tue, 26 Aug 2008 19:19:45 +0200
References: <20080822073628.GA5989@piper.oerlikon.madduck.net>
	<1219394015.7591.441.camel@violet.holtmann.net>
	<20080826163544.GA5068@lapse.rw.madduck.net>
Subject: Re: [Bluez-devel] btusb+sco failing to play sound through Jabra
	BT500v headset (was:	 SCO flowcontrol patch v4.4 on 2.6.25/6
	causes)	hardlocks when connecting to BT device
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

Hi Martin,

>> what about not using that patch at all? I am using the new audio
>> interface without that patch. And you wanna use the btusb driver
>> and since 2.6.27-rc4 that one actually has SCO support.
>
> If I had known... :)
>
> Unfortunately, I have not yet succeeded. I modprobed 'sco' and then
> ran headsetd as before, but that just prints
>
>  headsetd[9417]: Bluetooth headset daemon version 0.5
>  headsetd[9417]: Configuration phase ended: target bdaddr is 00:1A: 
> 45:14:EE:D7, timeout is 90000 ms
>  headsetd[9417]: Changing state: Idle-->Paging
>  headsetd[9417]: Changing state: Paging-->Connecting
>  headsetd[9417]: Changing state: Connecting-->Ready
>  headsetd[9417]: Changing state: Ready-->Opening

don't use headsetd. Use the audio stuff that comes with bluez-utils.

Regards

Marcel


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
