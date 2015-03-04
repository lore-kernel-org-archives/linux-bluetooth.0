Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: Patch to bluez/src/shared/att.c
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CALMby5ZX29VY3bkX+EYyUw_uE68mB6r6myJK4KcZKn9EHdEumw@mail.gmail.com>
Date: Wed, 4 Mar 2015 09:23:26 -0800
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Message-Id: <AB5F448F-1706-45A3-8D45-9D65773FAB54@holtmann.org>
References: <CALMby5ZjoCqCirOcUPXN38mhAE5KEsVTdh8MMpjvKsL+w59k9g@mail.gmail.com> <20150304085023.GA17887@t440s.lan> <260CDA8B-2CB3-4AC0-83E5-30710A56CEB3@holtmann.org> <CALMby5ZX29VY3bkX+EYyUw_uE68mB6r6myJK4KcZKn9EHdEumw@mail.gmail.com>
To: =?utf-8?B?0JLQvtC70L7QtNC40LzQuNGAINCe0YHRgtCw0L8=?=
	<volodymyr.ostap@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Volodymyr,

please do not top post on this mailing list.

> Thank you for response.
> I am ok with single thread implementation but I fixed API, a
> particular function which is used to send notification.
> It definitely cannot be called from internal thread.
> Other thread is updating characteristic and pushes notification into
> internal queue. Next, internal thread gets the notification from queue
> and transfers it.
> As you can see two thread is involved. I have no idea how to send
> notification using internal thread.
> 
> Anyway this fix for sure doesn't break logic.

all applications in BlueZ are single threaded and we are using signalfd and thus this fix is not needed.

Regards

Marcel

