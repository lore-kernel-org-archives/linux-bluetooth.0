Return-Path: <cyrus@holtmann.org>
Message-ID: <99409C1CA8BB44AA991976C2B7B4BA6C@freqoneremote>
From: "David Stockwell" <dstockwell@frequency-one.com>
To: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>,
	"Dave Zielinski" <DZielinski@righthandtech.com>
Cc: <linux-bluetooth@vger.kernel.org>
References: <69FA8BA3444DD443841AF768F2F6C65A01611E9B3C9D@SERVER2.righthandtech.local> <CABBYNZJ2wAebT-J7x_i72t3p2iQG5VgmrD_+tVEHYh2O2FN+Uw@mail.gmail.com>
In-Reply-To: <CABBYNZJ2wAebT-J7x_i72t3p2iQG5VgmrD_+tVEHYh2O2FN+Uw@mail.gmail.com>
Subject: Re: AVRCP Use Question
Date: Thu, 26 Jan 2012 07:29:27 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello "other Dave" and Luiz,

+++++

Hi Dave,

On Wed, Jan 25, 2012 at 7:59 PM, Dave Zielinski
<DZielinski@righthandtech.com> wrote:
> Hi all,
>   I'm trying to set up a system running bluez that will essentially be a 
> "headset" for a device playing audio (cellphone).   So far I've been 
> successful able to get the audio stream aspect (A2DP) of it working and 
> now I'm trying to add some AVRCP 1.0 control (play, pause, fwd, rev). 
> Looking through some of the git logs, I'm seeing that some of this control 
> was added a long before the version I'm using, which is 4.96, but I'm 
> having a rough time figure out where/what the interface is.
>
> My best guess at this point is that it can be accessed via the "uinput" 
> driver however the only example that I'm seeing is where evtest is used to 
> listen for events coming from headset for example.  This is actually 
> opposite of what I'm doing.  The device running bluez is the "headset" and 
> I want to sent the commands to the device playing audio.
>
> Can anyone confirm this AVRCP 1.0 "uinput" interface from 4.96 is 
> "uni-directional" and will not do what I need?
>
> In digging around I see that there was dbus controls added after the 4.96 
> tag that implements org.bluez.Control.ChangePlayback.  I would just try 
> this but upgrading is not going to be trivial on my system it seems.
>
> Can anyone tell me if I'm on the right track or provide any hints?

Currently there is no API to send those AVRCP commands, and yes uinput
does not support sending events, perhaps we can add such API to
org.bluez.Control, create another interface e.g. RemoteControl, or
somehow capture events from a input device. Iirc one of the problem of
doing this over D-Bus is the emulation of press/release events.

+++++

Months ago I submitted code that implemented a signal for remote device 
commands and passthroughs, but that was rejected in favor of continuing with 
uinput.

Should we revisit this?

David Stockwell

+++++
-- 
Luiz Augusto von Dentz
--
To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" 
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html 

