Return-Path: <cyrus@holtmann.org>
Message-ID: <5051C434.9030009@ti.com>
Date: Thu, 13 Sep 2012 14:32:04 +0300
From: Chen Ganir <chen.ganir@ti.com>
MIME-Version: 1.0
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
CC: Joao Paulo Rechi Vita <jprvita@openbossa.org>,
	<linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 02/10] battery: Implement Generic device battery
References: <1347349100-24228-1-git-send-email-chen.ganir@ti.com> <1347349100-24228-3-git-send-email-chen.ganir@ti.com> <CAAngNMbUQzxAdwo2JUjzrqkLGXFhpyRVqtz03u+3t3nfXcyxpg@mail.gmail.com> <50501416.90408@ti.com> <20120912084537.GA31700@x220.P-661HNU-F1> <5050644F.5040902@ti.com> <CAJdJm_NNR86qNnxm-CPFqfuu0sPkoQhqAZY6nGUKB6GYeJ2HAw@mail.gmail.com>
In-Reply-To: <CAJdJm_NNR86qNnxm-CPFqfuu0sPkoQhqAZY6nGUKB6GYeJ2HAw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Anderson,

On 09/12/2012 01:57 PM, Anderson Lizardo wrote:
> Hi Chen,
>
> On Wed, Sep 12, 2012 at 6:30 AM, Chen Ganir <chen.ganir@ti.com> wrote:
>>> Both BtIO and GAttrib intend to mimic GLib-like libraries where this is
>>> the convention. The plan is not to let this spread to the entire code
>>> base (particularly with the likely move to libell in the long run), so
>>> please don't use CamelCase.
>>>
>> Ok. So for the battery options i'll simply change it to battery_option. What
>> about the convention for defining a function pointer ?
>
> See the result of:
>
> grep -r 'typedef.*(' *
>
> on your bluez tree. As Johan mentioned, you should ignore the (few)
> occurrences of camel case typedef declarations.
>
> Regards,
>
Thanks.

-- 
BR,
Chen Ganir

