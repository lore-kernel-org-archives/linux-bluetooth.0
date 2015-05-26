Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <556412A0.4030004@samsung.com>
References: <1430925036-20245-1-git-send-email-chanyeol.park@samsung.com>
	<CABBYNZ+tM==j0Af=X93jCCQAqenspFbtbLRs6KqFrMuA8-niOg@mail.gmail.com>
	<556412A0.4030004@samsung.com>
Date: Tue, 26 May 2015 17:30:53 +0300
Message-ID: <CABBYNZKUfRYy2pgmTAp3gaVHYE3Wf1WBzcRw-csxdtpoQrNWng@mail.gmail.com>
Subject: Re: [RFC BlueZ 1/3] audio/a2dp: connect A2DP vendor codec if possible
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Chan-yeol Park <chanyeol.park@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chanyeol,

On Tue, May 26, 2015 at 9:28 AM, Chan-yeol Park
<chanyeol.park@samsung.com> wrote:
> Hi Luiz,
> On 05/07/2015 05:20 PM, Luiz Augusto von Dentz wrote:
>>
>> Hi Chan-yeol,
>>
>> On Wed, May 6, 2015 at 6:10 PM,  <chanyeol.park@samsung.com> wrote:
>>>
>>> From: Chan-yeol Park <chanyeol.park@samsung.com>
>>>
>>> This patch gives the priority on vendor codec during A2DP codec
>>> negotiation.
>>
>>
>> There is already a prioritization based on the sender and in the order
>> the endpoints are registered, so by doing this you would be breaking
>> the prioritization instead register the codecs in order of preference
>> that should have the same results.
>>
>
> Yes you're right. but most of phone(Android/iOS) register their SBC in the
> first SEP to support compatibility because some of headset try to connect
> first SEP without codec comparison. As a result I could not register vendor
> codec in the first SEP. So without this patch vendor codec establishment
> would not be made.

Hmm, I did not know such devices exists, so they connect with first
set no matter what? Than perhaps we need a priority flag which we can
then check while selecting.

-- 
Luiz Augusto von Dentz
