Return-Path: <cyrus@holtmann.org>
Date: Tue, 15 May 2012 10:58:10 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: chen.ganir@ti.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] eir: Keep parsed eir_data on error
Message-ID: <20120515075810.GA20177@x220>
References: <1336555275-32638-1-git-send-email-chen.ganir@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1336555275-32638-1-git-send-email-chen.ganir@ti.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chen,

On Wed, May 09, 2012, chen.ganir@ti.com wrote:
> Do not discard already parsed eir_data on eir data length error.
> Data corruption may occur, but this does not mean that we need
> to ignore already parsed valid eir data
> ---
>  src/eir.c |    5 ++---
>  1 files changed, 2 insertions(+), 3 deletions(-)

Applied, though I did clean it up a little bit (e.g. removing {} and
doing a break instead of a return).

Johan
