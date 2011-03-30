Return-Path: <cyrus@holtmann.org>
Date: Wed, 30 Mar 2011 19:38:38 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/3] Remove hard-coded handles from example GATT plugin
Message-ID: <20110330163838.GC30984@jh-x301>
References: <1301415328-14257-1-git-send-email-anderson.lizardo@openbossa.org>
 <1301415328-14257-4-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1301415328-14257-4-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Tue, Mar 29, 2011, Anderson Lizardo wrote:
> Instead of having static handles, use attrib_db_find_avail() to find
> available handle ranges.
> 
> Also split the big register_attributes() into one function per service.
> ---
>  plugins/gatt-example.c |  350 ++++++++++++++++++++++++++++++++++--------------
>  1 files changed, 250 insertions(+), 100 deletions(-)

Patches 2/3 & 3/3 have also been pushed upstream. Thanks.

Johan
