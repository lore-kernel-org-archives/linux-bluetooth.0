Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZ+d6c1ohwkj4Bqoa_=fN+aCT34LwJR1eE53xix_woPYow@mail.gmail.com>
References: <1387199317-27438-1-git-send-email-luiz.dentz@gmail.com>
	<CAN_7+YaOQLno_kZoi7sAk2f8Ky_natHGa1Zi-J9vErfZ5WW8ug@mail.gmail.com>
	<CABBYNZ+d6c1ohwkj4Bqoa_=fN+aCT34LwJR1eE53xix_woPYow@mail.gmail.com>
Date: Mon, 16 Dec 2013 21:33:14 +0100
Message-ID: <CAN_7+Ya4eVC4YcSZ1xyvdTaX+WtiQH1UxUcJHKcZvxLyOUTPjQ@mail.gmail.com>
Subject: Re: [PATCH v2 BlueZ] android: Add initial Android Bluetooth Audio
 protocol API doc
From: Lukasz Rymanowski <lukasz.rymanowski@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-2
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Mon, Dec 16, 2013 at 7:31 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Lukasz,
>
> On Mon, Dec 16, 2013 at 6:27 PM, Lukasz Rymanowski
> <lukasz.rymanowski@gmail.com> wrote:
>> Hi Luiz,
>>
>>
>> On Mon, Dec 16, 2013 at 2:08 PM, Luiz Augusto von Dentz
>> <luiz.dentz@gmail.com> wrote:
>>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>>
>>> This IPC is used to communicate Android BlueZ daemon and AudioFlinger
>>> plugin.
>>> ---
>>> v2: Rework IPC commands to match Android Audio HAL
>>>
>>>  android/Makefile.am       |  3 +-
>>>  android/audio-ipc-api.txt | 85 +++++++++++++++++++++++++++++++++++++++++++++++
>>>  2 files changed, 87 insertions(+), 1 deletion(-)
>>>  create mode 100644 android/audio-ipc-api.txt
>>>
>>> diff --git a/android/Makefile.am b/android/Makefile.am
>>> index 79f30d7..ac00bb2 100644
>>> --- a/android/Makefile.am
>>> +++ b/android/Makefile.am
>>> @@ -111,4 +111,5 @@ EXTRA_DIST += android/Android.mk android/hal-ipc-api.txt android/README \
>>>                 android/pixit-gap.txt android/pixit-hid.txt \
>>>                 android/pixit-opp.txt android/pixit-pan.txt \
>>>                 android/pixit-pbap.txt android/pts-gap.txt android/pts-hid.txt \
>>> -               android/pts-opp.txt android/pts-pbap.txt
>>> +               android/pts-opp.txt android/pts-pbap.txt \
>>> +               android/audio-ipc-api.txt
>>> diff --git a/android/audio-ipc-api.txt b/android/audio-ipc-api.txt
>>> new file mode 100644
>>> index 0000000..e9a2136
>>> --- /dev/null
>>> +++ b/android/audio-ipc-api.txt
>>> @@ -0,0 +1,85 @@
>>> +Bluetooth Audio Plugin
>>> +======================
>>> +
>>> +The audio plugin happen to be in a different socket but all the rules for
>>> +HAL socket apply here as well, the abstract socket name is
>>> +"\0bluez_audio_socket" (tentative):
>>> +
>>> +       .--Android--.                             .---Audio---.
>>> +       |  daemon   |                             |   Plugin  |
>>> +       |           |          Command            |           |
>>> +       |           | <-------------------------- |           |
>>> +       |           |                             |           |
>>> +       |           | --------------------------> |           |
>>> +       |           |          Response           |           |
>>> +       |           |                             |           |
>>> +       |           |                             |           |
>>> +       |           |                             |           |
>>> +       '-----------'                             '-----------'
>>> +
>>> +
>>> +       Audio HAL                               Daemon
>>> +       ----------------------------------------------------
>>> +
>>> +       call dev->open()                    --> command 0x01
>>> +       return dev->open()                  <-- response 0x01
>>> +
>>> +       call dev->open_output_stream()      --> command 0x03
>>> +       return dev->open_output_stream()    <-- response 0x03
>>> +
>>> +       call stream_in->read()              --> command 0x05
>>> +       return stream_in->read()            <-- response 0x05
>>> +
>> I think it should be stream_out->write() here.
>>
>>> +       call stream_in->common.standby()    --> command 0x06
>>> +       return  stream_in->common.standby() <-- response 0x06
>>> +
>> Also here: stream_out->common.standby()
>
> I guess it should work both ways, but perhaps Android is never meant
> to sink role nevertheless I would not limit the IPC to just source as
> it could be useful and it doesn't need that much to work.
>

I agree that it should work for stream in as well, and actually I can
imagine product based on Android acting as SINK on A2DP.
Anyway, maybe it would be better to point it out directly and keep HAL
calls example for stream out.

/£ukasz

> --
> Luiz Augusto von Dentz
