Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZKfisRUPncZFU4Xa5cns8TvEFLTaYhu1S5mdUPi=ovJng@mail.gmail.com>
References: <1435320003-14720-1-git-send-email-luiz.dentz@gmail.com>
	<CAPyD+=CichTsAGNKRO14L2pXhGxdVnk27+qZZc1B-tAr2M7c1w@mail.gmail.com>
	<CABBYNZKfisRUPncZFU4Xa5cns8TvEFLTaYhu1S5mdUPi=ovJng@mail.gmail.com>
Date: Mon, 29 Jun 2015 10:59:59 +0300
Message-ID: <CABBYNZKR32GzjvzPnHfCcbm=LVAoLo2srbyJF0f1AQrmyxF1oQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] core/advertising: Fix using wrong instance id
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "Othman, Ossama" <ossama.othman@intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Jun 26, 2015 at 10:33 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Ossama,
>
> On Fri, Jun 26, 2015 at 9:08 PM, Othman, Ossama <ossama.othman@intel.com> wrote:
>> Hi Luiz,
>>
>> On Fri, Jun 26, 2015 at 5:00 AM, Luiz Augusto von Dentz
>> <luiz.dentz@gmail.com> wrote:
>>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>>
>>> The instance id shall be limited to the number of instance the kernel
>>> support, and since this will probably be quite small the ids should be
>>> reused once the client unregistered.
>>> ---
>>>  src/advertising.c | 12 +++++++-----
>>>  1 file changed, 7 insertions(+), 5 deletions(-)
>>> ...
>>
>> This patch appears to address the problem I was seeing with the failed
>> advertisement registration.  With it in place I'm able to repeatedly
>> register/unregister my advertisement without problem.
>
> I will probably apply it tomorrow to give people some time to try it,
> but Im quite sure this will be the final version.
>
>
> --
> Luiz Augusto von Dentz

Applied.

-- 
Luiz Augusto von Dentz
