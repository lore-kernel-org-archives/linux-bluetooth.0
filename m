Return-Path: <cyrus@holtmann.org>
Message-ID: <1327958996.1955.162.camel@aeonflux>
Subject: Re: [PATCH v4 1/2] Bluetooth: Remove usage of
 __cancel_delayed_work()
From: Marcel Holtmann <marcel@holtmann.org>
To: Ulisses Furquim <ulisses@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi
Date: Mon, 30 Jan 2012 13:29:56 -0800
In-Reply-To: <1327955189-4604-1-git-send-email-ulisses@profusion.mobi>
References: <1327955189-4604-1-git-send-email-ulisses@profusion.mobi>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ulisses,

> __cancel_delayed_work() is being used in some paths where we cannot
> sleep waiting for the delayed work to finish. However, that function
> might return while the timer is running and the work will be queued
> again. Replace the calls with safer cancel_delayed_work() version
> which spins until the timer handler finishes on other CPUs and
> cancels the delayed work.
> 
> Signed-off-by: Ulisses Furquim <ulisses@profusion.mobi>
> ---

I have the feeling that I already looked at this patch before. And given
that it is v4, that might be true actually ;)

Use the space between --- and diffstat to have some small changelog so I
know what was different to the previous version.

>  include/net/bluetooth/l2cap.h |    4 ++--
>  net/bluetooth/l2cap_core.c    |    6 +++---
>  2 files changed, 5 insertions(+), 5 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


