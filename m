Return-Path: <cyrus@holtmann.org>
Date: Thu, 9 Feb 2012 12:50:54 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] device: Shutdown connection if ATTIO list is empty
Message-ID: <20120209105054.GD5330@x220.ger.corp.intel.com>
References: <1328727910-20179-1-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1328727910-20179-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

On Wed, Feb 08, 2012, Andre Guedes wrote:
> Shutdown the ongoing connection attempt if the last ATTIO callback
> is removed from the list.
> ---
>  src/device.c |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)

Applied. Thanks.

Johan
