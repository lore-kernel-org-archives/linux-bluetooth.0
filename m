Return-Path: <cyrus@holtmann.org>
Date: Mon, 29 Aug 2011 13:52:06 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Pavel Raiskup <praiskup@redhat.com>
Cc: linux-bluetooth@vger.kernel.org, ovasik@redhat.com
Subject: Re: [PATCH 3/8] Off-by-one error in uses_rfcomm
Message-ID: <20110829105020.GB11395@dell.ger.corp.intel.com>
References: <op.v0av36jth52hc0@dhcp-25-209.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <op.v0av36jth52hc0@dhcp-25-209.brq.redhat.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Pavel,

On Tue, Aug 16, 2011, Pavel Raiskup wrote:
> Variable len could be assigned to PATH_MAX + 1 length (returned
> from readlink) and this variable is used as index to array link
> of size only PATH_MAX + 1.
> ---
>  compat/dun.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

The first three patches have been applied. The rest still have
formatting errors so I have not been able to apply them.

Johan
