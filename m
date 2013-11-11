Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20131111083735.GA4541@x220.p-661hnu-f1>
References: <1383925711-26374-1-git-send-email-lukasz.rymanowski@tieto.com>
	<1383925711-26374-2-git-send-email-lukasz.rymanowski@tieto.com>
	<20131111083735.GA4541@x220.p-661hnu-f1>
Date: Mon, 11 Nov 2013 23:23:27 +0100
Message-ID: <CAN_7+Yb9smK8U+UeK8P-3YcBR0pC8spgsnVkw4f86jMO67A+FA@mail.gmail.com>
Subject: Re: [PATCH 1/3] android: Update bond state on incoming bonding
From: Lukasz Rymanowski <lukasz.rymanowski@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>,
	linux-bluetooth@vger.kernel.org,
	Szymon Janc <szymon.janc@tieto.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Mon, Nov 11, 2013 at 9:37 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Lukasz,
>
> On Fri, Nov 08, 2013, Lukasz Rymanowski wrote:
>> Before sending any ssp request or pin code request up to HAL library we
>> need to send bond state change with bonding state. Otherwise incoming
>> bonding is impossible.
>> ---
>>  android/adapter.c | 21 ++++++++++++++++++---
>>  1 file changed, 18 insertions(+), 3 deletions(-)
>
> Wont this cause HAL_BOND_STATE_BONDING to be sent twice if the pairing
> was locally initiated through create_bond()?

Well, of course we could try to keep track our local bond state and
send HAL_BOND_STATE_BONDING in smarter way, but we don't need to. It
is not a problem for Android to handle HAL_BOND_STATE_BONDING twice.
Actually It works like this even now with current BT stack.
And of course we need to send this event up as soon as we start
bonding procedure, so it should stay in create_bond().

>
> Johan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

\Łukasz
