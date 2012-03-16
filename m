Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJdJm_N854Z05+jDhvS-xjgiJhZEpRBjqqfRe8Z-+o38=X56AA@mail.gmail.com>
References: <1331723767-21436-1-git-send-email-chen.ganir@ti.com>
	<CAJdJm_N854Z05+jDhvS-xjgiJhZEpRBjqqfRe8Z-+o38=X56AA@mail.gmail.com>
Date: Fri, 16 Mar 2012 16:43:51 -0300
Message-ID: <CAKT1EBfPNciHd3ykxzhb70-obG4Lqixcpj4-6-UOQEBt8reMiA@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] GATT: Change the way GATT Plugins are enabled/disabled
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: chen.ganir@ti.com
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>,
	Anderson Lizardo <anderson.lizardo@openbossa.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chen Ganir,

On Wed, Mar 14, 2012 at 8:31 AM, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
> Hi Chen,
>
> On Wed, Mar 14, 2012 at 7:16 AM,  <chen.ganir@ti.com> wrote:
>> From: Chen Ganir <chen.ganir@ti.com>
>>
>> This patch set is a result of the discussion on the #bluez channel.
>>
>> Consolidate the --enable_<profile> for gatt profiles into a single
>> switch, called --enable_gatt.
>>
>> In addition, modify the AttributeServer propery in the main.conf to
>> EnableGatt option (default=false) and make sure all GATT plugins query
>> this option before trying to load (in the _init function of the
>> plugin)
>>
>> This is v3 of the patch set - fixed as suggested on the mailing list.
>
> Looks good to me.
>
> Regards,
> --
> Anderson Lizardo
> Instituto Nokia de Tecnologia - INdT
> Manaus - Brazil

How are you planning to enable/disable HoG?
IMO, the input D-Bus API needs to be aligned, it should be the same
for HID over BR/EDR and HID over GATT.

The point is: should "--disable-input" disable HoG also?

BR,
Claudio.
