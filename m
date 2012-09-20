Return-Path: <cyrus@holtmann.org>
Message-ID: <505AF82A.3060601@ti.com>
Date: Thu, 20 Sep 2012 14:04:10 +0300
From: Chen Ganir <chen.ganir@ti.com>
MIME-Version: 1.0
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
CC: <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v3 00/10] Implement Generic battery and LE Battery client
References: <1348129663-1701-1-git-send-email-chen.ganir@ti.com> <CAJdJm_MhZwRyD8JVsmm6QTWqhWh1x2FXkopTQqdmNy=td0aj8Q@mail.gmail.com>
In-Reply-To: <CAJdJm_MhZwRyD8JVsmm6QTWqhWh1x2FXkopTQqdmNy=td0aj8Q@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Anderson,

On 09/20/2012 01:56 PM, Anderson Lizardo wrote:
> Hi Chen,
>
> On Thu, Sep 20, 2012 at 4:27 AM,  <chen.ganir@ti.com> wrote:
>> From: Chen Ganir <chen.ganir@ti.com>
>>
>> This patch set replaces previous patch sets which implemented the LE battery
>> GATT Client. This patch set implements a generic device battery D-Bus interface
>> that can be used to get remote device battery status using D-Bus. In addition,
>> This patch set also implements the GATT Battery client, which uses the generic
>> device battery to expose LE device battery status.
>>
>> see doc/battery-api.txt and doc/device-api.txt for more information.
>>
>> This is version 2 of the patch set, including multiple style and other comments
>> reported on the ML. This version is rebased on the latest code.
>
> Besides some minor style comments (found on this last round of
> review), patch set looks good to me.
>
> Regards,
>
Thanks for the review !

I'll wait and see if there are any more comments before i send the next 
patch set with fixes.


-- 
BR,
Chen Ganir

