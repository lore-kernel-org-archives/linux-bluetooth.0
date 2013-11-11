Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1822\))
Subject: Re: [PATCH 1/3] android: Update bond state on incoming bonding
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAN_7+Yb9smK8U+UeK8P-3YcBR0pC8spgsnVkw4f86jMO67A+FA@mail.gmail.com>
Date: Tue, 12 Nov 2013 08:19:03 +0900
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>,
	"linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>,
	Szymon Janc <szymon.janc@tieto.com>
Message-Id: <8B291258-C1EE-457D-808F-FF642AAB1688@holtmann.org>
References: <1383925711-26374-1-git-send-email-lukasz.rymanowski@tieto.com> <1383925711-26374-2-git-send-email-lukasz.rymanowski@tieto.com> <20131111083735.GA4541@x220.p-661hnu-f1> <CAN_7+Yb9smK8U+UeK8P-3YcBR0pC8spgsnVkw4f86jMO67A+FA@mail.gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

>>> Before sending any ssp request or pin code request up to HAL library we
>>> need to send bond state change with bonding state. Otherwise incoming
>>> bonding is impossible.
>>> ---
>>> android/adapter.c | 21 ++++++++++++++++++---
>>> 1 file changed, 18 insertions(+), 3 deletions(-)
>> 
>> Wont this cause HAL_BOND_STATE_BONDING to be sent twice if the pairing
>> was locally initiated through create_bond()?
> 
> Well, of course we could try to keep track our local bond state and
> send HAL_BOND_STATE_BONDING in smarter way, but we don't need to. It
> is not a problem for Android to handle HAL_BOND_STATE_BONDING twice.
> Actually It works like this even now with current BT stack.
> And of course we need to send this event up as soon as we start
> bonding procedure, so it should stay in create_bond().

I think we should keep track of our bond state internally. I get the feeling we will need that eventually anyway. For example we already know that we need to keep a mapping of BD_ADDR to address types to make LE work.

Regards

Marcel

