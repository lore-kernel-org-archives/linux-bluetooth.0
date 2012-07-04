Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAAngNMaLQUem5vmgjCOWyUUdW+iFuACXxtJ=4oBO1u0ZXcUCxQ@mail.gmail.com>
References: <1341403768-16709-1-git-send-email-luiz.dentz@gmail.com>
	<CAAngNMaLQUem5vmgjCOWyUUdW+iFuACXxtJ=4oBO1u0ZXcUCxQ@mail.gmail.com>
Date: Wed, 4 Jul 2012 17:35:20 +0300
Message-ID: <CABBYNZ+vNjKwrTz2Ck4x0hYRyeBzJsRiQLqZWX7YjOba-EYgQA@mail.gmail.com>
Subject: Re: [RFC BlueZ] core: Fix not waiting for discovery to stop before
 attempting to pair
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Joao Paulo Rechi Vita <jprvita@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org,
	Claudio Takahasi <claudio.takahasi@openbossa.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Joao,

On Wed, Jul 4, 2012 at 5:16 PM, Joao Paulo Rechi Vita
<jprvita@openbossa.org> wrote:
> Hello Luiz,
>
> On Wed, Jul 4, 2012 at 9:09 AM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>
>> In some cases, LE controllers, this can cause errors due to scan/inquiry
>> being active.
>>
>> To fix this instead of immediately attempting to pair wait until
>> discovery is properly stopped and only then proceed with bonding.
>> ---
>> Still RFC because I could only test against controllers that used to
>> work without this patch.
>>
>
> Claudio and I are currently working to support the General Connection
> Procedure for LE connections, which will serialize the discovery and
> LE connect commands. In other words, only one connect or discovery
> command will be sent to the kernel at a given time. We'll probably
> send an RFC on this code this week.

Sounds like a better idea.

-- 
Luiz Augusto von Dentz
