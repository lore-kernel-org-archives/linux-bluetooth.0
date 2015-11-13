Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Fri, 13 Nov 2015 13:53:32 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix powering on with privacy and advertising
Message-ID: <20151113115332.GA10089@t440s.lan>
References: <1447360987-4129-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1447360987-4129-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

On Thu, Nov 12, 2015, Andrzej Kaczmarek wrote:
> In order to enable advertising with privacy enabled, SMP has to be
> registered in order to generate new RPA. During power on, it will be
> registered at the very end which is the reason why advertising is not
> enabled and it's not possible to enable it anymore due to mismatch
> between hci_dev settings and actual controller state.
> 
> This fixes this problem by postponing advertising enable after SMP is
> registered in case of power on.
> ---
>  net/bluetooth/mgmt.c | 70 ++++++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 54 insertions(+), 16 deletions(-)

Instead of postponing advertising, did you consider simply moving
smp_register() earlier? Wouldn't it be possible to move it to
mgmt_powered() before powered_update_hci() is called?

Johan
