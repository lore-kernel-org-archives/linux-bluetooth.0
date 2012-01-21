Return-Path: <cyrus@holtmann.org>
Message-ID: <1327164406.1955.54.camel@aeonflux>
Subject: Re: [PATCH v2] Bluetooth: Remove usage of __cancel_delayed_work()
From: Marcel Holtmann <marcel@holtmann.org>
To: Ulisses Furquim <ulisses@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi
Date: Sat, 21 Jan 2012 17:46:46 +0100
In-Reply-To: <1326975033-2668-1-git-send-email-ulisses@profusion.mobi>
References: <1326975033-2668-1-git-send-email-ulisses@profusion.mobi>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ulisses,

> __cancel_delayed_work() is being used in some paths where we cannot
> sleep waiting for the delayed work to finish. However, that function
> might return while the timer is running and the work will be queued
> again. Replace the calls with safer cancel_delayed_work() version
> which spins until the timer handler finishes in other CPUs and
> cancels the delayed work.
> 
> Signed-off-by: Ulisses Furquim <ulisses@profusion.mobi>
> ---
> 
> v2 - rebased against newer bluetooth-next
> 
>  include/net/bluetooth/l2cap.h |    4 ++--
>  net/bluetooth/l2cap_core.c    |   10 +++++-----
>  2 files changed, 7 insertions(+), 7 deletions(-)

looks fine to me.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


