Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CANK1S=Mn0esGHy7q5g8rCtA0paFw_EVAc=5XA83D+Ev=6cGhdw@mail.gmail.com>
References: <CANK1S=MG_kJ3DJmjV9nSbEW0E51ru_ukFsbHjx4fTMoYAMHv5A@mail.gmail.com>
	<CABBYNZKCM1u+aY39o3Qha1cOFM1ugq4VFg9OpBLghhWB_KYj1A@mail.gmail.com>
	<CANK1S=OFfmhR2-URNmSkMxeCf1tby5Uc4c1=FZrvcJ0TT=_gCg@mail.gmail.com>
	<CANK1S=Mn0esGHy7q5g8rCtA0paFw_EVAc=5XA83D+Ev=6cGhdw@mail.gmail.com>
Date: Mon, 15 Apr 2013 21:31:41 +0800
Message-ID: <CANK1S=PZqcKOupE9mbg3=hGpHQKz_s7W0wt4zvo0b=H5mVDwzA@mail.gmail.com>
Subject: Re: Bluez 5.3: Failed to connect to speaker (Unable to select SEP)
From: Om Huang <dendrobium0093@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

I'm sorry to bother you. The order of building projects is bluez-5,
sbc-1.0 and then pulseaudio-bluez5. The configure result of
pulseaudio-bluez5 shows that D-Bus and BlueZ are enabled. I install
these three projects to my development board. But I still encounter
the same problem (i.e. unable to find sep). By code tracing, I find
that server->sources is null in a2dp_select_sep(). That's maybe the
reason that bluez can't select SEP. Could anyone provides some idea?

2013/4/12 Om Huang <dendrobium0093@gmail.com>:
> Hi Luiz,
>
> 2013/4/12 Om Huang <dendrobium0093@gmail.com>:
>> Hi Luiz,
>>
>> 2013/4/9 Luiz Augusto von Dentz <luiz.dentz@gmail.com>:
>>> Hi,
>>>
>>> On Tue, Apr 9, 2013 at 3:02 PM, Om Huang <dendrobium0093@gmail.com> wrote:
>>>> Hi,
>>>>
>>>> I'm trying to use bluez-5.3 to connect to a Bluetooth speaker. My
>>>> computer is ubuntu-12.10 x86_64 with Linux 3.5.0. The bluez source was
>>>> downloaded from http://www.bluez.org/release-of-bluez-5-3/
>>>
>>> Then you need BlueZ 5 patches to PulseAudio to make it work, there is
>>> a experimental tree here (if you are brave enough to try):
>>>
>>> github.com/mastiz/pulseaudio-bluez5.git
>>>
>> Thanks for your help. But I still have a question. When I was using
>> bluez 4, I can connect to my speaker by using org.bluez.Device.Connect
>> without installing pulseaudio. Pulseaudio can be installed after bluez
>> 4 connects to my speaker. However, when I use
>> org.bluez.Device1.Connect or org.bluez.Device1.ConnectProfile in bluez
>> 5 without pulseaudio, "unable to select SEP" appears and connection
>> losts. Is it necessary to install pulseaudio-bluez5 for bluez 5 to
>> connect to a speaker?
>> Thank you.
>>
> Since I could not remove pulseaudio from my ubuntu desktop. I try it
> on my development board. It's linux 2.6.32 with compat driver 3.6. It
> works well with bluez 4.101 and pulseaudio-2.1. However, it failed to
> connect to my speaker and showed "unable to select SEP" after porting
> bluez 5.0 and pulseaudio-bluez5.
> Thank you.
>
>>>> I have read the previous thread "Bluez 5.2 A2DP: Unable to select SEP"
>>>> and thus enable source, sink and control in profiles/audio/manager.c.
>>>> I also enable gateway, socket and source in /etc/bluetooth/audio.conf.
>>>> I disable systemd in configure. And then make and make install.
>>>> Unfortunately, I still got an error "Unable to select SEP" when I try
>>>> to connect to my speaker. Any suggestion or idea? Thanks for any help.
>>>
>>> Socket is no longer supported and gateway support is now done via
>>> external profile (e.g. telephony stacks such as oFono).
>>>
>>> --
>>> Luiz Augusto von Dentz
>> --
>> Om Huang
> --
> Om Huang
--
Om Huang
