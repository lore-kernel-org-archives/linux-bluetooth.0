Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CANK1S=MG_kJ3DJmjV9nSbEW0E51ru_ukFsbHjx4fTMoYAMHv5A@mail.gmail.com>
References: <CANK1S=MG_kJ3DJmjV9nSbEW0E51ru_ukFsbHjx4fTMoYAMHv5A@mail.gmail.com>
Date: Tue, 9 Apr 2013 15:26:26 +0300
Message-ID: <CABBYNZKCM1u+aY39o3Qha1cOFM1ugq4VFg9OpBLghhWB_KYj1A@mail.gmail.com>
Subject: Re: Bluez 5.3: Failed to connect to speaker (Unable to select SEP)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Om Huang <dendrobium0093@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Apr 9, 2013 at 3:02 PM, Om Huang <dendrobium0093@gmail.com> wrote:
> Hi,
>
> I'm trying to use bluez-5.3 to connect to a Bluetooth speaker. My
> computer is ubuntu-12.10 x86_64 with Linux 3.5.0. The bluez source was
> downloaded from http://www.bluez.org/release-of-bluez-5-3/

Then you need BlueZ 5 patches to PulseAudio to make it work, there is
a experimental tree here (if you are brave enough to try):

github.com/mastiz/pulseaudio-bluez5.git

> I have read the previous thread "Bluez 5.2 A2DP: Unable to select SEP"
> and thus enable source, sink and control in profiles/audio/manager.c.
> I also enable gateway, socket and source in /etc/bluetooth/audio.conf.
> I disable systemd in configure. And then make and make install.
> Unfortunately, I still got an error "Unable to select SEP" when I try
> to connect to my speaker. Any suggestion or idea? Thanks for any help.

Socket is no longer supported and gateway support is now done via
external profile (e.g. telephony stacks such as oFono).

--
Luiz Augusto von Dentz
