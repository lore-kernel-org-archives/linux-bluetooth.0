Return-Path: <cyrus@holtmann.org>
Message-ID: <49EBA01F.1040402@pook.es>
Date: Mon, 20 Apr 2009 00:05:19 +0200
From: Stuart Pook <linux-bluetooth4@pook.es>
MIME-Version: 1.0
To: Johan Hedberg <johan.hedberg@gmail.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: bluez git + Linksys USBBT100 + 2.6.30-rc2 -> Segmentation fault
References: <49D89DCD.7090808@pook.es> <49D8E48A.2060807@pook.es> <20090405172212.GB6612@jh-x301> <49EB7950.4000802@pook.es> <20090419200528.GA18068@jh-x301> <49EB93C2.3090702@pook.es> <20090419213837.GA6514@jh-x301>
In-Reply-To: <20090419213837.GA6514@jh-x301>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

hi Johan

On 19/04/09 23:38, Johan Hedberg wrote:
> On Sun, Apr 19, 2009, Stuart Pook wrote:
>> I did get one error that I had never seen before "Refusing headset":
> 
> That comes if a headset is trying to connect to you and there's already 
> max_connected_headsets headsets connected

I don't that that is the case. I only have 2 headsets and the other has never been
connected to the PC. Weird.

>> bluetoothd[32401]: Unix client disconnected (fd=13)
>> bluetoothd[32401]: Unable to get service record: Connection timed out 
>> (110)
>> Segmentation fault
> 
> Could you please run bluetoothd through valgrind to get a proper 
> backtrace.

bluetoothd doesn't seg fault very often now but I'll leave a loop running aplay 
and bluetoothd from git overnight.

:; ok=0;total=0; while sleep 15; do if aplay -vv -D JX10 /home/stuart/ws/music_test/Rebecca_Pidgeon-You_Got_Me-8000-mono.wav; then ok=$(($ok + 1)); fi; total=$(($total + 1)); echo ok=$ok total=$total; done

> Once we have the valgrind 
> trace I'd also be interested in seeing the output of hcidump for the 
> "Connection timed out" situation.

You mean when bluetoothd says "Unable to get service record: Connection timed out (110)"?

I get "aplay: pcm_write:1442: write error: Input/output error" a lot more often
but bluetoothd doesn't say anything special.

bluetoothd[1851]: State changed /org/bluez/1851/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECTED -> HEADSET_STATE_DISCONNECTED
bluetoothd[1851]: Accepted new client connection on unix socket (fd=13)
bluetoothd[1851]: Audio API: BT_REQUEST <- BT_GET_CAPABILITIES
bluetoothd[1851]: Audio API: BT_RESPONSE -> BT_GET_CAPABILITIES
bluetoothd[1851]: Audio API: BT_REQUEST <- BT_OPEN
bluetoothd[1851]: open sco - object=ANY source=ANY destination=00:1A:45:2F:49:98 lock=write
bluetoothd[1851]: Audio API: BT_RESPONSE -> BT_OPEN
bluetoothd[1851]: Audio API: BT_REQUEST <- BT_SET_CONFIGURATION
bluetoothd[1851]: State changed /org/bluez/1851/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECT_IN_PROGRESS
bluetoothd[1851]: adapter_get_device(00:1A:45:2F:49:98)
bluetoothd[1851]: Discovered Handsfree service on RFCOMM channel 1
bluetoothd[1851]: /org/bluez/1851/hci0/dev_00_1A_45_2F_49_98: Connecting to 00:1A:45:2F:49:98 channel 1
bluetoothd[1851]: link_key_request (sba=00:0C:41:E1:FF:30, dba=00:1A:45:2F:49:98)
bluetoothd[1851]: kernel auth requirements = 0x00
bluetoothd[1851]: stored link key type = 0x00
bluetoothd[1851]: /org/bluez/1851/hci0/dev_00_1A_45_2F_49_98: Connected to 00:1A:45:2F:49:98
bluetoothd[1851]: Received AT+BRSF=27
bluetoothd[1851]: HFP HF features: "EC and/or NR function" "Call waiting and 3-way calling" "Voice recognition activation" "Remote volume control" 
bluetoothd[1851]: Received AT+CIND=?
bluetoothd[1851]: Received AT+CIND?
bluetoothd[1851]: Received AT+CMER=3, 0, 0, 1
bluetoothd[1851]: Event reporting (CMER): mode=3, ind=1
bluetoothd[1851]: HFP Service Level Connection established
bluetoothd[1851]: telephony-dummy: device 0x4b90d40 connected
bluetoothd[1851]: State changed /org/bluez/1851/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_CONNECTED
bluetoothd[1851]: Audio API: BT_RESPONSE -> BT_SET_CONFIGURATION
bluetoothd[1851]: Audio API: BT_REQUEST <- BT_START_STREAM
bluetoothd[1851]: State changed /org/bluez/1851/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECTED -> HEADSET_STATE_PLAY_IN_PROGRESS
bluetoothd[1851]: Received AT+VGS=00
bluetoothd[1851]: SCO socket opened for headset /org/bluez/1851/hci0/dev_00_1A_45_2F_49_98
bluetoothd[1851]: SCO fd=20
bluetoothd[1851]: Audio API: BT_RESPONSE -> BT_START_STREAM
bluetoothd[1851]: Audio API: BT_INDICATION -> BT_NEW_STREAM
bluetoothd[1851]: State changed /org/bluez/1851/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_PLAY_IN_PROGRESS -> HEADSET_STATE_PLAYING
bluetoothd[1851]: Unix client disconnected (fd=13)
bluetoothd[1851]: State changed /org/bluez/1851/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_PLAYING -> HEADSET_STATE_CONNECTED
bluetoothd[1851]: No matching connection found for handle 41
bluetoothd[1851]: telephony-dummy: device 0x4b90d40 disconnected
bluetoothd[1851]: State changed /org/bluez/1851/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECTED -> HEADSET_STATE_DISCONNECTED


>> In fact I get the "Too short (1 bytes) IPC packet from bluetoothd" error
>> even from bluetoothd 4.36.
> If this isn't caused by a bug the only possible reason I can think of as 
> a cause for it is a mismatch between the alsa plugin and bluetoothd 
> versions.

I have installed bluetoothd and the alsa plugin together so that shouldn't happen.
When I switch from bluez 4.3x to bluez 4.19 (for example) I seem to switch both the plug
and the daemon together.

> Btw, you might want to consider trying out pulseaudio 0.9.15. It's 
> worked pretty flawlessly for me with bluez 4.34 and later versions 

I only use my headset to do VoIP and I use twinkle to do VoIP (SIP). Twinkle
only understands alsa and OSS. I don't have to use twinkle I suppose.

thanks
Stuart

-- 
If the From address bounces, please see http://www.pook.it/.
