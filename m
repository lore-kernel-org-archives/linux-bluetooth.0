Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: Patch to bluez/src/shared/att.c
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20150304085023.GA17887@t440s.lan>
Date: Wed, 4 Mar 2015 07:18:39 -0800
Cc: =?utf-8?B?0JLQvtC70L7QtNC40LzQuNGAINCe0YHRgtCw0L8=?=
	<volodymyr.ostap@gmail.com>, linux-bluetooth@vger.kernel.org
Message-Id: <260CDA8B-2CB3-4AC0-83E5-30710A56CEB3@holtmann.org>
References: <CALMby5ZjoCqCirOcUPXN38mhAE5KEsVTdh8MMpjvKsL+w59k9g@mail.gmail.com> <20150304085023.GA17887@t440s.lan>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

>> Fix of thread racing in bt_att_send()
>> 
>> In case bt_att_send() is called from other thread, internal thread
>> could complete
>> just added operation before  bt_att_send() returns. So, the function
>> return 0 as in error case.
> 
> I don't think any of our libraries have been designed to be used in a
> multi-threaded context. We could try fixing individual issues like this
> but it's a slippery slope which will lead you to find more and more
> things to fix - ultimately leading to greatly increased code complexity
> because the fundamental design doesn't take multi-threading into account.

the whole BlueZ internal code is not thread safe. And that is on purpose. We want to keep the tools and daemons single threaded.

Regards

Marcel

