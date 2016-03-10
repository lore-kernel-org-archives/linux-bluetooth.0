Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZJkLuSo4hAuNMJN3yKXQtx77BnTsEWvPfOQsXR9puCcqw@mail.gmail.com>
References: <CAEZxfGPBv4YJwMEMVSeJQmy5fwzgd6ANpwBUXeZeiv2Pox865Q@mail.gmail.com>
 <CABBYNZ+uYqOi7uYNGL6tJkJ5D2Cz=cOxCN5QbpLx1+Z7gC2Jxg@mail.gmail.com> <CABBYNZJkLuSo4hAuNMJN3yKXQtx77BnTsEWvPfOQsXR9puCcqw@mail.gmail.com>
From: =?UTF-8?Q?Fran=C3=A7ois_Beaufort?= <beaufort.francois@gmail.com>
Date: Thu, 10 Mar 2016 11:15:18 +0100
Message-ID: <CAEZxfGM-bzd07TOGG-v27SdDiZTPduDzQw-k6tFxtg5EnR7VLg@mail.gmail.com>
Subject: Re: Feature Request: Clean the cache upon device disconnection
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>,
	=?UTF-8?Q?Giovanni_Ortu=C3=B1o?= <ortuno@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Here are failing bluetoothd and hcidump logs with BlueZ at commit
c8a81f43921cf417e270f3b6e0b0118cbc27a58d

http://pastebin.com/raw/i416k6aw
http://pastebin.com/raw/5dC9dFiP

On Thu, Mar 10, 2016 at 10:11 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi François,
>
> On Wed, Mar 9, 2016 at 10:47 PM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> Hi François,
>>
>> On Wed, Mar 9, 2016 at 6:42 PM, François Beaufort
>> <beaufort.francois@gmail.com> wrote:
>>> As we've discovered recently
>>> (https://github.com/thegecko/web-bluetooth-dfu/issues/12#issuecomment-194348474),
>>> it looks like BlueZ trunk doesn't clean/update its cache upon device
>>> disconnection.
>>>
>>> Is this on purpose?
>>> If not, can it be fixed?
>>
>> I actually need more info, we do check if the cache is valid on every
>> reconnection, can someone provide the HCI trace of the issue perhaps
>> it is not using the fixes for the cache that have been merged
>> upstream.
>
> There at least 2 important fixes to the cache that where applied upstream:
>
> Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> Date:   Mon Feb 15 14:14:31 2016 +0200
>
>     core/device: Fix not clearing Attributes before storing
>
>     This can leave the storage in a bad state if device start changing its
>     attributes the old one are never removed as the code reloads them with
>     g_key_file_load_from_file.
>
> commit e3c14b2627ed8fd6277a72761539cb54111fc205
> Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> Date:   Mon Feb 15 13:44:27 2016 +0200
>
>     core/device: Fix not reseting database if attributes cannot be loaded
>
>     If one or more attributes cannot be loaded it means the database is
>     probably in a bad state so just clear it so the attributes can be
>     discovered again.
>
> If you don't have them it is probably not going to work since the
> device appears to be changing its database while win DFU mode.
>
>
> --
> Luiz Augusto von Dentz
