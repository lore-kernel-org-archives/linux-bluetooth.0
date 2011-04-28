Return-Path: <cyrus@holtmann.org>
Date: Thu, 28 Apr 2011 14:04:15 -0700
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Add secure param to Mgmt PIN Code Request Event
Message-ID: <20110428210415.GA25225@jh-x301>
References: <1303987847-6878-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1303987847-6878-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Waldek,

On Thu, Apr 28, 2011, Waldemar Rymarkiewicz wrote:
> Update mgmt interface with secure param in pin code request event
> which is part of secure pin requirement implementation.
> ---
>  doc/mgmt-api.txt |    1 +
>  lib/mgmt.h       |    1 +
>  2 files changed, 2 insertions(+), 0 deletions(-)

I've applied this patch so the latest bluetooth-next tree can be used,
however I'd like to discuss the details of the second patch a bit more.

Johan
