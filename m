Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <54D96429.8000304@freescale.com>
References: <54D96429.8000304@freescale.com>
Date: Wed, 11 Feb 2015 09:16:38 +0100
Message-ID: <CAN_7+Yai0m39=crfcqJdJZfoTOOuh4zxPi_46wn6EXbewHGf8g@mail.gmail.com>
Subject: Re: BlueZ for Android 4.4.3
From: Lukasz Rymanowski <lukasz.rymanowski@gmail.com>
To: Zheng Tao-B46827 <b46827@freescale.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tony,

On Tue, Feb 10, 2015 at 2:51 AM, Zheng Tao-B46827 <b46827@freescale.com> wrote:
> Hi, Peers
>
> Thanks for your hard work that let us can experience BlueZ for Android.  But
> I am faced with a audio/a2dp problems that stick me many weeks.
>
> I’m try to port Bluez to kitkat 4.4.3, and many common profiles, such as
> HIDP/FTP/GATT can function successfully. But the A2DP profile failed.
>
> So, I try to debug it using haltest tool as follows(with USB Bluetooth
> Dongle):
>
> 1.bluetooth init
>
> 2.bluetooth enable
>
> 3.bluetooth get_profile_interface a2dp
>
> 4.bluetooth start_discovery
>
> 5.bluetooth create_bond xxxxxxxx
>

Here you should setup A2DP using "av connect <bdaddr>." (don't forget
to do av init before.)  Once you are connected you can open stream.


> 6.audio init
>
> 7.audio open_output_stream
>
> Then it will prompts:
>
> D/BlueZ   ( 1106):
> external/bluetooth/bluez/android/hal-audio.c:audio_open_output_stream()
>
> D/BlueZ   ( 1106):
> external/bluetooth/bluez/android/hal-audio.c:ipc_open_stream_cmd()
>
> E/BlueZ   ( 1106): audio: Invalid cmd socket passed to audio_ipc_cmd
>
> E/BlueZ   ( 1106): audio: cannot open output stream
>
> when I debug it , I found that
>
> BlueZ   ( 1106): external/bluetooth/bluez/android/hal-audio.c:ipc_handler()
> Waiting for connection ...
>
> And it seems that there is no audio socket to connect it.
>
> I’m not familiar with Bluez stack details, can you give some advice? What
> should I do to enable audio/a2dp functionality and execute audio play
> command? Thanks.


\Lukasz

>
> ----------------------------------------------
>
> *Best Regards!*
>
> Tony Zheng
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
