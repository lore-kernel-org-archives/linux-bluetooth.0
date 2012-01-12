Return-Path: <cyrus@holtmann.org>
Date: Thu, 12 Jan 2012 23:14:32 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] Fix Alert Level characteristic for Proximity IAS
Message-ID: <20120112211432.GA9912@fusion.localdomain>
References: <1326401813-30140-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1326401813-30140-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Thu, Jan 12, 2012, Anderson Lizardo wrote:
> According to PXP IAS specification (Table 3.2), the Alert Level
> characteristic property has only "Write without response" as mandatory
> and the rest is excluded.
> ---
>  proximity/reporter.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Applied. Thanks.

Johan
