Return-Path: <cyrus@holtmann.org>
Message-ID: <54D96429.8000304@freescale.com>
Date: Tue, 10 Feb 2015 09:51:37 +0800
From: Zheng Tao-B46827 <b46827@freescale.com>
MIME-Version: 1.0
To: <linux-bluetooth@vger.kernel.org>
Subject: BlueZ for Android 4.4.3
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi, Peers

Thanks for your hard work that let us can experience BlueZ for Android. 
  But I am faced with a audio/a2dp problems that stick me many weeks.

I’m try to port Bluez to kitkat 4.4.3, and many common profiles, such as 
HIDP/FTP/GATT can function successfully. But the A2DP profile failed.

So, I try to debug it using haltest tool as follows(with USB Bluetooth 
Dongle):

1.bluetooth init

2.bluetooth enable

3.bluetooth get_profile_interface a2dp

4.bluetooth start_discovery

5.bluetooth create_bond xxxxxxxx

6.audio init

7.audio open_output_stream

Then it will prompts:

D/BlueZ   ( 1106): 
external/bluetooth/bluez/android/hal-audio.c:audio_open_output_stream()

D/BlueZ   ( 1106): 
external/bluetooth/bluez/android/hal-audio.c:ipc_open_stream_cmd()

E/BlueZ   ( 1106): audio: Invalid cmd socket passed to audio_ipc_cmd

E/BlueZ   ( 1106): audio: cannot open output stream

when I debug it , I found that

BlueZ   ( 1106): 
external/bluetooth/bluez/android/hal-audio.c:ipc_handler() Waiting for 
connection ...

And it seems that there is no audio socket to connect it.

I’m not familiar with Bluez stack details, can you give some advice? 
What should I do to enable audio/a2dp functionality and execute audio 
play command? Thanks.

----------------------------------------------

*Best Regards!*

Tony Zheng

