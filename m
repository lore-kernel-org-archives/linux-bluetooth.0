Return-Path: <cyrus@holtmann.org>
Message-id: <556412A0.4030004@samsung.com>
Date: Tue, 26 May 2015 15:28:48 +0900
From: Chan-yeol Park <chanyeol.park@samsung.com>
MIME-version: 1.0
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [RFC BlueZ 1/3] audio/a2dp: connect A2DP vendor codec if possible
References: <1430925036-20245-1-git-send-email-chanyeol.park@samsung.com>
 <CABBYNZ+tM==j0Af=X93jCCQAqenspFbtbLRs6KqFrMuA8-niOg@mail.gmail.com>
In-reply-to: <CABBYNZ+tM==j0Af=X93jCCQAqenspFbtbLRs6KqFrMuA8-niOg@mail.gmail.com>
Content-type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,
On 05/07/2015 05:20 PM, Luiz Augusto von Dentz wrote:
> Hi Chan-yeol,
>
> On Wed, May 6, 2015 at 6:10 PM,  <chanyeol.park@samsung.com> wrote:
>> From: Chan-yeol Park <chanyeol.park@samsung.com>
>>
>> This patch gives the priority on vendor codec during A2DP codec
>> negotiation.
>
> There is already a prioritization based on the sender and in the order
> the endpoints are registered, so by doing this you would be breaking
> the prioritization instead register the codecs in order of preference
> that should have the same results.
>

Yes you're right. but most of phone(Android/iOS) register their SBC in 
the first SEP to support compatibility because some of headset try to 
connect first SEP without codec comparison. As a result I could not 
register vendor codec in the first SEP. So without this patch vendor 
codec establishment would not be made.

I am not clear how to give the priority on vendor codec in this case.

Thanks
Chanyeol
