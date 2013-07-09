Return-Path: <cyrus@holtmann.org>
Date: Tue, 9 Jul 2013 16:25:46 +0100
From: Gustavo Padovan <gustavo@padovan.org>
To: Stanislaw Gruszka <sgruszka@redhat.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] ath3k: don't use stack memory for DMA
Message-ID: <20130709152546.GB1772@joana>
References: <20130627094837.GA2288@redhat.com>
 <20130707194009.GB3966@joana>
 <20130708082722.GB1569@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130708082722.GB1569@redhat.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Stanislaw,

* Stanislaw Gruszka <sgruszka@redhat.com> [2013-07-08 10:27:23 +0200]:

> Memory allocated by vmalloc (including stack) can not be used for DMA,
> i.e. data pointer on usb_control_msg() should not point to stack memory.
> 
> Resolves:
> https://bugzilla.redhat.com/show_bug.cgi?id=977558
> 
> Reported-and-tested-by: Andy Lawrence <dr.diesel@gmail.com>
> Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>
> ---
>  drivers/bluetooth/ath3k.c | 38 +++++++++++++++++++++++++++++---------
>  1 file changed, 29 insertions(+), 9 deletions(-)

Patch has been applied to bluetooth-next. Thanks.

	Gustavo
