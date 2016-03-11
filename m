Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZ+RUsTRfEdH-TByrmphna+DhvSZw8bi6_KunVXKfrsW_A@mail.gmail.com>
References: <1457094267-5925-1-git-send-email-luiz.dentz@gmail.com>
	<CAExxLLD+Z4rVRhXqU0MYFKTvOeq09_=-C55fWF9oXdY=mUowTA@mail.gmail.com>
	<CABBYNZKNkEFO7uAsH55Un47esqezPV-acTiqE1NFMfNXFWKj2Q@mail.gmail.com>
	<4446282.74ti4cqF2s@leonov>
	<CABBYNZ+RUsTRfEdH-TByrmphna+DhvSZw8bi6_KunVXKfrsW_A@mail.gmail.com>
Date: Fri, 11 Mar 2016 16:46:04 +0200
Message-ID: <CABBYNZKFa=_RhyQh0LXGm9Ofm1eN61KwHtmMu-dvidHSEh858g@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/2] core/device: Don't set MTU when acting as a peripheral
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Szymon Janc <ext.szymon.janc@tieto.com>
Cc: =?UTF-8?Q?=C5=81ukasz_Rymanowski?= <lukasz.rymanowski@codecoup.pl>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon, Lukasz,

On Thu, Mar 10, 2016 at 12:26 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Szymon,
>
> On Thu, Mar 10, 2016 at 11:42 AM, Szymon Janc <ext.szymon.janc@tieto.com> wrote:
>> Hi Luiz,
>>
>> On Thursday 10 of March 2016 11:35:23 Luiz Augusto von Dentz wrote:
>>> Hi Lukasz,
>>>
>>> On Thu, Mar 10, 2016 at 11:17 AM, Łukasz Rymanowski
>>>
>>> <lukasz.rymanowski@codecoup.pl> wrote:
>>> >> Not only we cannot be configured as server, but even if we do the
>>> >> roles are only relevant for PTS because otherwise there is no way to
>>> >> tell the roles of the remote device.
>>> >
>>> > If device sends request that means it is a Client. If not that means
>>> > it is a Server.
>>>
>>> Well if it send it can be a Client/Server as well, btw some systems
>>> including Android appear to have support to send Exchange MTU at any
>>> point so detecting a server only pretty hard, besides our current
>>> design split Server and Client functionality so waiting to see if
>>> anything has been received before starting sending anything is not so
>>> trivial and we had still to choose an arbitrary timeout to wait for
>>> detecting the role but if both are based on BlueZ this would just
>>> delay each other.
>>
>> Maybe we could simply delay MTU exchange until we are done with discovery?
>> For discovery we shouldn't need larger MTU. And if in the meantime remote
>> initiates MTU exchange we can skip MTU exchange from our side.
>
> Actually discovery is where it makes most of the difference for
> devices with big databases which delays quite a lot the first
> connection (sometimes more than 10 seconds to discover everything). We
> do have a cache to mitigate that in the subsequent connections, but I
> wouldn't like to receive complains again that discovery takes too long
> because the MTU was not changed.

Im actually abandoning this one as it seems Androind 5.1 and later
seems to have this fixed.

-- 
Luiz Augusto von Dentz
