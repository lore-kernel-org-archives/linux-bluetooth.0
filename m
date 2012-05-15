Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJdJm_MVPxMp9QG9_CBmGn0YeMc_Hbhiipy+brSXsqjMzFuRjA@mail.gmail.com>
References: <1337009699-19831-1-git-send-email-mikel.astiz.oss@gmail.com>
	<CAJdJm_MVPxMp9QG9_CBmGn0YeMc_Hbhiipy+brSXsqjMzFuRjA@mail.gmail.com>
Date: Tue, 15 May 2012 17:03:07 +0200
Message-ID: <CANT-zCVAD0H7akcDZSeNaPjJ3u9Vbw9BEKm-A08Rva9M7ACCSw@mail.gmail.com>
Subject: Re: [RFC v0] Bluetooth: mgmt: Add device disconnect reason
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Tue, May 15, 2012 at 4:15 PM, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
> Hi Mikel,
>
> On Mon, May 14, 2012 at 11:34 AM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
>> From: Mikel Astiz <mikel.astiz@bmw-carit.de>
>>
>> MGMT_EV_DEVICE_DISCONNECTED should expose the disconnection reason to
>> userland.
>
> There is "getsockopt(sock, SOL_SOCKET, SO_ERROR, &sk_err, &len)". Why
> is it not enough?

Could you please be more specific? Which socket type exposes this
disconnect reason?

That would be the second approach explained in the cover-letter
(userspace part), but AFAIK it's not been set by the Kernel right now.
We would probably have to set the option for all RFCOMM, L2CAP and SCO
sockets associated to the ACL link.

Cheers,
Mikel
