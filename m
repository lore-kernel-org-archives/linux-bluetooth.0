Return-Path: <cyrus@holtmann.org>
Date: Thu, 23 Aug 2012 15:15:40 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] gatt: GAP and GATT services are mandatory
Message-ID: <20120823121540.GA25044@x220.ger.corp.intel.com>
References: <1345664329-30577-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1345664329-30577-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Wed, Aug 22, 2012, Claudio Takahasi wrote:
> This patch fixes potential segmentation fault if the remote doesn't
> support GAP and GATT services.
> ---
>  profiles/gatt/manager.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

Applied. Thanks.

Johan
