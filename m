Return-Path: <cyrus@holtmann.org>
Date: Fri, 28 Mar 2014 14:25:45 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] attrib: Use const source data pointer for write
Message-ID: <20140328122545.GB11823@t440s.ger.corp.intel.com>
References: <1395929009-23366-1-git-send-email-jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1395929009-23366-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Thu, Mar 27, 2014, Jakub Tyszkowski wrote:
> Source buffer for write operations should be immutable.
> ---
>  attrib/gatt.c | 6 +++---
>  attrib/gatt.h | 6 +++---
>  2 files changed, 6 insertions(+), 6 deletions(-)

Both patches have been applied. Thanks.

Johan
