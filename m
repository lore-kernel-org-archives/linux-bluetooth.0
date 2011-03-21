Return-Path: <cyrus@holtmann.org>
Date: Mon, 21 Mar 2011 11:09:02 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix compilation against latest BlueZ
Message-ID: <20110321090902.GA1302@jh-x301>
References: <1300475419-7009-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1300475419-7009-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Fri, Mar 18, 2011, Anderson Lizardo wrote:
> BlueZ now has ntoh64()/hton64() functions in bluetooth.h, therefore the
> hcidump local copy is not necessary.
> ---
>  src/hcidump.c |   16 ----------------
>  1 files changed, 0 insertions(+), 16 deletions(-)

Pushed upstream. Thanks.

Johan
