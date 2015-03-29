Return-Path: <cyrus@holtmann.org>
Message-ID: <55185E7F.9040604@cchtml.com>
Date: Sun, 29 Mar 2015 15:20:15 -0500
From: Michael Cronenworth <mike@cchtml.com>
MIME-Version: 1.0
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: header change affects c++ projects
References: <5517B933.1080809@cchtml.com> <CABBYNZ+VdZkU9y2TyH_6rsM_=8tVdGNrXUp9yX5NTAjy5k06bQ@mail.gmail.com>
In-Reply-To: <CABBYNZ+VdZkU9y2TyH_6rsM_=8tVdGNrXUp9yX5NTAjy5k06bQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 03/29/2015 01:57 PM, Luiz Augusto von Dentz wrote:
> It will probably get applied, no reason to get neurotic on the weekend
> no one said we would not take it, so please be patience.

I'm not following you here. What are you trying to say?

> It is a fix to uuid: Add bt_uuid_to_le since the convention is to define 128 bit 
> UUIDs as big endian which then need to be swaped regardless of endianess.

The commit doesn't change anything though. Please revert it or fix it to not have a 
conversion or precision loss. If you need help I will make a patch.

Thanks,
Michael
