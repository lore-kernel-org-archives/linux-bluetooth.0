Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAHZ1yC=FkUt=ESbZ+OnfSXKrN0+XHVgcMxqOjQq-EaJU+TPf-w@mail.gmail.com>
References: <CAHZ1yC=FkUt=ESbZ+OnfSXKrN0+XHVgcMxqOjQq-EaJU+TPf-w@mail.gmail.com>
Date: Thu, 28 Feb 2013 13:25:10 -0800
Message-ID: <CAHZ1yCmmPvo-XCrNB5N3KpefQC67CSNZkc_DZNSP0-HRhG1Tfw@mail.gmail.com>
Subject: Re: Bluez 5.2 A2DP: "Unable to select SEP"
From: Scott James Remnant <keybuk@google.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

I guess I spoke too soon, I can get the endpoint connected with this
config change, but it just fails a little later now with
"avdtp_set_configuration: Transport endpoint is not connected"

Here's the log of the connect call; note that I see the
SelectConfiguration and reply to it on the endpoint side - but never
receive a SetConfiguration call:

bluetoothd[24139]: src/device.c:connect_profiles()
/org/bluez/hci0/dev_10_B7_F6_01_31_ED (all), client :1.389
bluetoothd[24139]: profiles/audio/manager.c:a2dp_sink_connect() path
/org/bluez/hci0/dev_10_B7_F6_01_31_ED
bluetoothd[24139]: profiles/audio/avdtp.c:avdtp_ref() 0x7f68d07c8790: ref=2
bluetoothd[24139]: profiles/audio/sink.c:sink_connect() stream
creation in progress
bluetoothd[24139]: profiles/audio/sink.c:discovery_complete() Discovery complete
bluetoothd[24139]: profiles/audio/a2dp.c:setup_ref() 0x7f68d079aff0: ref=2
bluetoothd[24139]: profiles/audio/media.c:media_endpoint_async_call()
Calling SelectConfiguration: name = :1.398 path
 = /org/chromium/Cras/Bluetooth/A2DPSource
bluetoothd[24139]: profiles/audio/a2dp.c:a2dp_config() a2dp_config:
selected SEP 0x7f68d07d9640
bluetoothd[24139]: profiles/audio/a2dp.c:setup_ref() 0x7f68d079aff0: ref=3
bluetoothd[24139]: avdtp_set_configuration: Transport endpoint is not connected
bluetoothd[24139]: profiles/audio/a2dp.c:setup_unref() 0x7f68d079aff0: ref=2
bluetoothd[24139]: src/device.c:device_profile_connected() audio-sink
Input/output error (5)
bluetoothd[24139]: profiles/audio/manager.c:avrcp_control_connect()
path /org/bluez/hci0/dev_10_B7_F6_01_31_ED
bluetoothd[24139]: Failed to connect audio-avrcp: Operation not supported
bluetoothd[24139]: src/device.c:device_profile_connected() returning
response to :1.389
bluetoothd[24139]: profiles/audio/avdtp.c:avdtp_unref() 0x7f68d07c8790: ref=1
bluetoothd[24139]: profiles/audio/a2dp.c:setup_unref() 0x7f68d079aff0: ref=1

Scott

On Thu, Feb 28, 2013 at 11:51 AM, Scott James Remnant <keybuk@google.com> wrote:
> Hey,
>
> I'm having some difficulties connecting up A2DP in BlueZ 5.2, and I'm
> sure I'm just missing something obvious so would appreciate a second
> set of eyes.
>
> I had thought that to send to an A2DP Sink on a device, I needed an
> A2DP Source endpoint at my end, but when I try and register that
> endpoint I just get org.bluez.Error.NotSupported
>
> I can register an A2DP Sink endpoint no problem, but then when I call
> org.bluez.Device1.Connect the connection fails with "Unable to select
> SEP" in the logs.
>
> Any ideas?
>
> Scott
> --
> Scott James Remnant | Chrome OS Systems | keybuk@google.com | Google



--
Scott James Remnant | Chrome OS Systems | keybuk@google.com | Google
