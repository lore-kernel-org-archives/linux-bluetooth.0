Return-Path: <cyrus@holtmann.org>
Date: Wed, 4 Mar 2015 10:50:23 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?utf-8?B?0JLQvtC70L7QtNC40LzQuNGAINCe0YHRgtCw0L8=?=
	<volodymyr.ostap@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Patch to bluez/src/shared/att.c
Message-ID: <20150304085023.GA17887@t440s.lan>
References: <CALMby5ZjoCqCirOcUPXN38mhAE5KEsVTdh8MMpjvKsL+w59k9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CALMby5ZjoCqCirOcUPXN38mhAE5KEsVTdh8MMpjvKsL+w59k9g@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Володимир,

On Tue, Mar 03, 2015, Володимир Остап wrote:
> Fix of thread racing in bt_att_send()
> 
> In case bt_att_send() is called from other thread, internal thread
> could complete
> just added operation before  bt_att_send() returns. So, the function
> return 0 as in error case.

I don't think any of our libraries have been designed to be used in a
multi-threaded context. We could try fixing individual issues like this
but it's a slippery slope which will lead you to find more and more
things to fix - ultimately leading to greatly increased code complexity
because the fundamental design doesn't take multi-threading into account.

Johan
