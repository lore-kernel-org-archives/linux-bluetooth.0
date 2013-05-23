Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAGd9gwhAfcc_DVdJxZ7rqyKPji6xy51TGtPuCvEPET_JK4NJjg@mail.gmail.com>
References: <1369301309-25189-1-git-send-email-mikel.astiz.oss@gmail.com>
	<CABBYNZ+1baqBJRNgY9a_4soZ5o3oWK_jfSv=7RqMAkJtz=BP7w@mail.gmail.com>
	<CABBYNZJA0C2r-4Y=fd6V_g115ZHyDxmN=9vUCE=HYepMncWKVQ@mail.gmail.com>
	<CAGd9gwhAfcc_DVdJxZ7rqyKPji6xy51TGtPuCvEPET_JK4NJjg@mail.gmail.com>
Date: Thu, 23 May 2013 13:27:07 -0700
Message-ID: <CABBYNZKxTjvbL5Oww3Xni6WzUK3RqBzK7pcMLFSrF919FCBg=g@mail.gmail.com>
Subject: Re: [PATCH BlueZ v0 0/4] AVRCP connection-tracking issues
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Alex Deymo <deymo@chromium.org>
Cc: Mikel Astiz <mikel.astiz.oss@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

On Thu, May 23, 2013 at 12:45 PM, Alex Deymo <deymo@chromium.org> wrote:
> Hi all,
>
> On Thu, May 23, 2013 at 9:45 AM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> On Thu, May 23, 2013 at 9:21 AM, Luiz Augusto von Dentz
>> > @Alex: Can you test the last patch from Mikel for the second issue
>> > with the remote device connecting to us while we are connecting to it?
>> > The host down I think Johan has been working on that and we should
>> > have a patch soon.
>>
>> Actually let me take it back, the heuristic fix actually doesn't do
>> anything since we already have the same check four line above this
>> should never happen. A potential fix is to remove auto_connect from
>> avrcp_target_profile so if sink fails to connect it won't connect
>> automatically, anyway when the sink connects device.c will make sure
>> to connect avrcp as well.
>
> I tried the patchset with the latest master and it fixes the first
> scenario on my dev machine (attempt a connect when device is off).
> For the second issue (attempt a connection while the device is also
> attempting it), there is some timing involved and I couldn't run into
> the same problematic state on my dev machine with this patchset (which
> doesn't mean that I'm confirming this fixes the second issue). So, to
> be more confident about the second scenario I also tried the same
> patchset in a more controlled environment (a chromebook laptop), but
> on top of bluez-5.5 instead of master (is almost the same). The repro
> case is as follows:
> * Our audio server is playing music all the time, when the bluetooth
> profile is connected it switches the music from the laptop speakers to
> the bluetooth speakers. When the profile is disconnected, the music is
> switched back to the laptop speakers.
> * The Bose SoundLink pairing memory is cleared before the test (hold
> the bluetooth logo button 10s on the device until you hear a tone).
> This makes the bluetooth logo button connect back to the only known
> host in the memory (it may attempt to connect to previously paired
> hosts if not).
> Steps:
> 1. Put the device in discovery mode (should be anyway after the memory erase).
> 2. on bluetoothctl: power, agent on, scan on, wait for the [NEW]
> signal, scan off, pair BD_ADDR, trust BD_ADDR, connect BD_ADDR
> 3. Verify music plays out from the speakers.
> - At this point pressing once the bluetooth logo will disconnect the
> device. pressing it again will connect it again.
> - Also, running "disconnect BD_ADDR" will disconnect it, and running
> "connect BD_ADDR" will connect it back. Great. It works.
> 4. Disconnect the device with "disconnect BD_ADDR".
> 5. Wait a few seconds until the device is disconnected.
> 6. press once the bluetooth logo button on the device.
> 7. Wait 0.5 sec.
> 8. "connect BD_ADDR" on bluetoothctl (you may want to type the command
> before step 6 and just hit enter here).
>
> Logs as follows:
> without the patch --> http://ix.io/5LE
> snippet:
> bluetoothd[16286]: profiles/audio/manager.c:avrcp_target_connect()
> path /org/bluez/hci0/dev_00_0C_8A_XX_XX_XX
> bluetoothd[16286]: profiles/audio/avctp.c:avctp_set_state() AVCTP Connecting
> bluetoothd[16286]: profiles/audio/sink.c:sink_set_state() State
> changed /org/bluez/hci0/dev_00_0C_8A_XX_XX_XX: SINK_STATE_CONNECTING
> -> SINK_STATE_DISCONNECTED
> bluetoothd[16286]: profiles/audio/avrcp.c:session_tg_destroy() 0x779a0e60
> bluetoothd[16286]: profiles/audio/avctp.c:avctp_set_state() AVCTP Disconnected
> bluetoothd[16286]: profiles/audio/avdtp.c:avdtp_free() 0x779a1e18
>
> with the patch --> http://ix.io/5LF
> snippet:
> bluetoothd[17037]: profiles/audio/manager.c:avrcp_target_connect()
> path /org/bluez/hci0/dev_00_0C_8A_XX_XX_XX
> bluetoothd[17037]: profiles/audio/avctp.c:avctp_set_state() AVCTP Connecting
> bluetoothd[17037]: profiles/audio/sink.c:sink_set_state() State
> changed /org/bluez/hci0/dev_00_0C_8A_XX_XX_XX: SINK_STATE_CONNECTING
> -> SINK_STATE_DISCONNECTED
> bluetoothd[17037]: profiles/audio/avrcp.c:session_tg_destroy() 0x7843b580
> bluetoothd[17037]: src/service.c:change_state() 0x784647d8: device
> 00:0C:8A:XX:XX:XX profile audio-avrcp-target state changed: connecting
> -> disconnected (-5)
> bluetoothd[17037]: src/device.c:device_profile_connected()
> audio-avrcp-target Input/output error (5)
> bluetoothd[17037]: src/device.c:device_profile_connected() returning
> response to :1.75
> bluetoothd[17037]: profiles/audio/avctp.c:avctp_set_state() AVCTP Disconnected
> bluetoothd[17037]: profiles/audio/avdtp.c:avdtp_free() 0x7845c790
>
> So, from my side, it looks good. Let me know if you need more debug.
> Do you think it's possible to port this fix to bluez-5.4? I see you
> are using btd_service on one of those patches.

So with what patch-set have you tested, mine that Ive send a few hours
ago or Mikel's?


--
Luiz Augusto von Dentz
