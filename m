Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CACUGKYNDR3XNRSt8EFWqOfAbkqY9vjRE2tw-8yZkv=qVf7tsrw@mail.gmail.com>
References: <CACUGKYMLZPpDTQ7Kxv90j8SCdy1goZT6Na-rZS5NEhu2kWp9mg@mail.gmail.com>
	<CABBYNZLWFNmsht7N_jb7Qz2K4L8Mf5Spbc9HvP79_cctz5hCKA@mail.gmail.com>
	<CACUGKYNDR3XNRSt8EFWqOfAbkqY9vjRE2tw-8yZkv=qVf7tsrw@mail.gmail.com>
Date: Tue, 23 Sep 2014 19:11:02 -0700
Message-ID: <CACUGKYMPXrCvCo+omEQgf6VGNzgLUWg21Bb7_DW9kNzJqEVFaw@mail.gmail.com>
Subject: Re: Action: Start playing a media item with at least 512 bytes
From: John Tobias <john.tobias.ph@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

I tried the test/simple-play (python ./simple-player), but it was
returning error:

dbus.exceptions.DBusException: org.bluez.Error.InvalidArguments:
Invalid arguments in method call

I ran gdbus introspect --recurse --system --dest org.bluez -o / and
the org.bluez.Media1 was there:

interface org.bluez.Media1 {
          methods:
            RegisterEndpoint(in  o endpoint,
                             in  a{sv} properties);
            UnregisterEndpoint(in  o endpoint);
            RegisterPlayer(in  o player,
                           in  a{sv} properties);
            UnregisterPlayer(in  o player);
          signals:
          properties:
        };

Any idea?.

Regards,

john

On Mon, Sep 22, 2014 at 6:36 PM, John Tobias <john.tobias.ph@gmail.com> wrote:
> Hi Luiz,
>
> Yes, that is correct. The test/simple-player will play an audio on my
> device(sink) and will provide the necessary information for PTS or the
> sink would be the PTS?
>
> Also, are you familiar with this info (see attached image1.png) "send
> L2CAP_Data over the assigned channel with correct DCID?.
>
> Regards,
>
> john
>
> On Mon, Sep 22, 2014 at 12:47 AM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> Hi John
>>
>> On Sat, Sep 20, 2014 at 12:12 AM, John Tobias <john.tobias.ph@gmail.com> wrote:
>>> Hello guys,
>>>
>>> I got these PTS dialog box (TC_TG_RCR_BV_02_C and TC_TG_RCR_BV_04_C)
>>> but, I am not sure how to respond from my bluetooth device.
>>>
>>>
>>> Any idea?.
>>
>> I suppose this one is AVRCP fragmentation test isn't it? You would
>> need to provide a metadata that is big enough, in Android case this
>> can be done with android/haltest and in D-Bus solution you can try
>> test/simple-player.
>>
>> --
>> Luiz Augusto von Dentz
