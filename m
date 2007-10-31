Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <1In7ly-1gisng0@fwd33.aul.t-online.de>
References: <1In7ly-1gisng0@fwd33.aul.t-online.de>
Date: Wed, 31 Oct 2007 17:17:48 +0100
Message-Id: <1193847468.32459.40.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] VOIP bluetooth headset
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Frank,
> 
> i have successfully compiled bluez-libs and bluez-utils 3.22 with
> audio enabled. I can use my Logitech voice headset with 'mplayer -ao
> alsa:device=bluetooth' to play audio and arecord to record audio. But
> with skype 1.4.0 118 and twinkle it doesn't work. When i want to start
> a call in skype the headset makes a beep noise every second and after
> 30 seconds the call failes. when i go to the options dialog the
> headset beep again and i must wait In twinkle there is no alsa device
> "bluetooth". VOIP was the reason why i have installed bluez. I have
> googled many hours to find a solution but without success. Last i have
> tried the OSS-Version of Skype because alsa seems to be buggy in Skype
> but to emulate the headset as dsp-device in .asoundrc to use with aoss
> was too difficult for me. I hope you have an idea how i can solve the
> problem, because i can't belive that it's not possible to use skype
> with a bluetooth headset.

first of all Skype is not VoIP. Skype is using a proprietary protocol
that allows you do make calls over the Internet. That is no VoIP,
because it would mean an open and well document protocol.

Second, you have to blame Skype for not working. Their usage of the ALSA
API is totally strange and it gets worse with every version. That this
works with real hardware sound cards, it from my point of view, pure
luck. With virtual sound cards, like a Bluetooth headset it is not that
simple and so far I couldn't find a sane way to make Skype happy.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
