Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <878u19lmqj.fsf@gmail.com>
References: <878u19lmqj.fsf@gmail.com>
Date: Wed, 23 Mar 2016 15:35:54 +0200
Message-ID: <CABBYNZLRf4fMhhGQR_6TSpJGS1EuuBpY=tu5QDMb0Y+mgiwa3g@mail.gmail.com>
Subject: Re: BlueZ 5.38 continuously disconnects bluetooth headset
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mo Reina <urban.yoga.journeys@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Mar 23, 2016 at 8:42 AM, Mo Reina <urban.yoga.journeys@gmail.com> wrote:
> Hi,
>
> I just wanted to report that after upgrading to BlueZ 5.38 yesterday my
> bluetooth headset (Beats Wireless) disconnects after connecting for 1
> second.
>
> Downgrading back to BlueZ 5.37 resolves this issue.
>
>  My system: Linux x1 4.4.5-1-ARCH #1 SMP PREEMPT Thu Mar 10 07:38:19 CET
> 2016 x86_64 GNU/Linux
>
> I'd like to be cc'ed the replies to this email please.

I just pushed a patch that should fix connecting to A2DP/AVRCP
headsets, we will probably have another release coming out with this
fix if there is nothing else that has regressed.

-- 
Luiz Augusto von Dentz
