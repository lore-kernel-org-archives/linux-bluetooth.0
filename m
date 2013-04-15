Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CANK1S=PZqcKOupE9mbg3=hGpHQKz_s7W0wt4zvo0b=H5mVDwzA@mail.gmail.com>
References: <CANK1S=MG_kJ3DJmjV9nSbEW0E51ru_ukFsbHjx4fTMoYAMHv5A@mail.gmail.com>
	<CABBYNZKCM1u+aY39o3Qha1cOFM1ugq4VFg9OpBLghhWB_KYj1A@mail.gmail.com>
	<CANK1S=OFfmhR2-URNmSkMxeCf1tby5Uc4c1=FZrvcJ0TT=_gCg@mail.gmail.com>
	<CANK1S=Mn0esGHy7q5g8rCtA0paFw_EVAc=5XA83D+Ev=6cGhdw@mail.gmail.com>
	<CANK1S=PZqcKOupE9mbg3=hGpHQKz_s7W0wt4zvo0b=H5mVDwzA@mail.gmail.com>
Date: Mon, 15 Apr 2013 17:07:48 +0300
Message-ID: <CABBYNZ+6K5Q3YbD43_JZUfH=OLGkixkL__RL4F9z8s-F8sDXhQ@mail.gmail.com>
Subject: Re: Bluez 5.3: Failed to connect to speaker (Unable to select SEP)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Om Huang <dendrobium0093@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Om Huang,

On Mon, Apr 15, 2013 at 4:31 PM, Om Huang <dendrobium0093@gmail.com> wrote:
> Hi Luiz,
>
> I'm sorry to bother you. The order of building projects is bluez-5,
> sbc-1.0 and then pulseaudio-bluez5. The configure result of
> pulseaudio-bluez5 shows that D-Bus and BlueZ are enabled. I install
> these three projects to my development board. But I still encounter
> the same problem (i.e. unable to find sep). By code tracing, I find
> that server->sources is null in a2dp_select_sep(). That's maybe the
> reason that bluez can't select SEP. Could anyone provides some idea?

Do you happen to have the bluetoothd logs? Btw, make sure the correct
PulseAudio is running.

Luiz Augusto von Dentz
