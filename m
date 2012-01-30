Return-Path: <cyrus@holtmann.org>
Date: Mon, 30 Jan 2012 14:27:20 -0800
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Ulisses Furquim <ulisses@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi
Subject: Re: [PATCH v4 1/2] Bluetooth: Remove usage of __cancel_delayed_work()
Message-ID: <20120130222720.GA4971@x220.globalsuite.net>
References: <1327955189-4604-1-git-send-email-ulisses@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1327955189-4604-1-git-send-email-ulisses@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ulisses,

On Mon, Jan 30, 2012, Ulisses Furquim wrote:
> __cancel_delayed_work() is being used in some paths where we cannot
> sleep waiting for the delayed work to finish. However, that function
> might return while the timer is running and the work will be queued
> again. Replace the calls with safer cancel_delayed_work() version
> which spins until the timer handler finishes on other CPUs and
> cancels the delayed work.
> 
> Signed-off-by: Ulisses Furquim <ulisses@profusion.mobi>
> ---
>  include/net/bluetooth/l2cap.h |    4 ++--
>  net/bluetooth/l2cap_core.c    |    6 +++---
>  2 files changed, 5 insertions(+), 5 deletions(-)

Both patches have bee applied to my bluetooth-next tree. Thanks.

Johan
