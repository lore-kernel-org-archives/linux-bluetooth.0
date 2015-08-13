Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZJCZL+PFrpS79qSeDhBYJKfsdegkR=tp3uzx_4NEpg8pQ@mail.gmail.com>
References: <CACjvawmBmmMfaQZSZLOxWz1dJt2_B-QkF=oTZ8-VLYqKsCi6Qg@mail.gmail.com>
	<CACjvawkPj2uZz+pWUJaofumq8CBadVs5WM5ig3Jy+o4+DGX2eA@mail.gmail.com>
	<CACjvawmEeUSjJNSmvZE=tFFUtOUPBAdweLLf+R9KeUgN1PB_rA@mail.gmail.com>
	<CACjvawmWdvVtj2q4Gn69bBT=8C+ZY4EqY2PC_RJwmc3xZNNszw@mail.gmail.com>
	<CABBYNZJCZL+PFrpS79qSeDhBYJKfsdegkR=tp3uzx_4NEpg8pQ@mail.gmail.com>
Date: Thu, 13 Aug 2015 11:55:33 +0600
Message-ID: <CACjvawkmqNk_+MZtQ_4AU3wSXS6e2xFHqGrNffuXjXrxA+zsAg@mail.gmail.com>
Subject: Re: Inconsistent behavior while getting manufacture data through dbus-api
From: Nazmul Alam <fadedreamz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Thanks Augusto for your reply.

I have verified this behavior with 5.33, it is still the same.

Any pointer to look into?

Thanks again.

On Wed, Aug 12, 2015 at 9:10 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi,
>
> On Wed, Aug 12, 2015 at 3:14 PM, Nazmul Alam <fadedreamz@gmail.com> wrote:
>> Hello everybody.
>> I am seeing inconsistent behavior while fetching manufacture data
>> through dbus-api.
>>
>> I have a mobile device reporting adv data and scan response. Both
>> having manufacture data. which I am trying to get from another device
>> running bluez-5.31.
>>
>> The api is working as expected when I am using ubuntu. I can see
>> manufacture data from adv data and scan response in an interleaved
>> manner.
>>
>> But when I change to raspberry pi I can only see scan response. And
>> seldom get adv data. After checking the issue with btmgmt, I see that
>> "find -l" command is reporting eir length of 62 (probably they are
>> aggregated). But dbus-api is reporting only one manufacture data.
>>
>> What might be the cause of this inconsistency? Also is there any way
>> to make bluez to not aggregate those two into a single eir?
>>
>> My kernel version for ubuntu is 3.13.0 and 4.1.4 for raspberry pi
>> (running raspbian).
>
> There have been some fixes recently to AD and manufacturer data,
> please first check if 5.33 had fix the issue.
>
>
> --
> Luiz Augusto von Dentz
