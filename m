Return-Path: <cyrus@holtmann.org>
Date: Sun, 11 Jul 2010 12:22:13 -0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Santiago Carot-Nemesio <sancane@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Set mode options for l2cap sockets in BTIO API
Message-ID: <20100711152213.GA11951@jh-x301>
References: <1278713330-11140-1-git-send-email-sancane@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1278713330-11140-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Sat, Jul 10, 2010, Santiago Carot-Nemesio wrote:
> Some profiles like MCAP or HDP need set an specific l2cap configuraton
> such as Streming, ERTM or another else. This patch enables BTIO API to
> set the mode for l2cap socket options.
> ---
>  src/btio.c |   19 +++++++++++++------
>  src/btio.h |    1 +
>  2 files changed, 14 insertions(+), 6 deletions(-)

Thanks for the patch! It has now been pushed upstream.

johan
