Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAHZ1yCmmPvo-XCrNB5N3KpefQC67CSNZkc_DZNSP0-HRhG1Tfw@mail.gmail.com>
References: <CAHZ1yC=FkUt=ESbZ+OnfSXKrN0+XHVgcMxqOjQq-EaJU+TPf-w@mail.gmail.com>
	<CAHZ1yCmmPvo-XCrNB5N3KpefQC67CSNZkc_DZNSP0-HRhG1Tfw@mail.gmail.com>
Date: Fri, 1 Mar 2013 11:17:08 +0200
Message-ID: <CACumGO+hGP6arHfGh++ycCBjfojyAi8bHLAW4m7W0qsPnihYNA@mail.gmail.com>
Subject: Re: Bluez 5.2 A2DP: "Unable to select SEP"
From: "Von Dentz, Luiz" <luiz.von.dentz@intel.com>
To: Scott James Remnant <keybuk@google.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Scott,

On Thu, Feb 28, 2013 at 11:25 PM, Scott James Remnant <keybuk@google.com> wrote:
> I guess I spoke too soon, I can get the endpoint connected with this
> config change, but it just fails a little later now with
> "avdtp_set_configuration: Transport endpoint is not connected"
>
> Here's the log of the connect call; note that I see the
> SelectConfiguration and reply to it on the endpoint side - but never
> receive a SetConfiguration call:
>
> bluetoothd[24139]: src/device.c:connect_profiles()
> /org/bluez/hci0/dev_10_B7_F6_01_31_ED (all), client :1.389
> bluetoothd[24139]: profiles/audio/manager.c:a2dp_sink_connect() path
> /org/bluez/hci0/dev_10_B7_F6_01_31_ED
> bluetoothd[24139]: profiles/audio/avdtp.c:avdtp_ref() 0x7f68d07c8790: ref=2
> bluetoothd[24139]: profiles/audio/sink.c:sink_connect() stream
> creation in progress
> bluetoothd[24139]: profiles/audio/sink.c:discovery_complete() Discovery complete

There is something off in this log, you should be getting at least the
following:

bluetoothd[27965]: profiles/audio/avdtp.c:avdtp_connect_cb() AVDTP:
connected signaling channel to 58:17:0C:EB:F1:D6
bluetoothd[27965]: profiles/audio/avdtp.c:avdtp_connect_cb() AVDTP
imtu=672, omtu=339

Otherwise there is no chance that discovery would complete without an
error, anyway I wasn't able to reproduce with current upstream code
which btw have some regression fixes when using PulseAudio BlueZ 5
testing tree but apparently that is not the case here.
