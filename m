Return-Path: <cyrus@holtmann.org>
Date: Thu, 14 Apr 2011 20:15:38 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Iain Hibbert <plunky@rya-online.net>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] hcidump: use correct size to copy 'direction' value
Message-ID: <20110414171538.GB10623@jh-x301>
References: <20110414091124.D0AB826008F@galant.ukfsn.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110414091124.D0AB826008F@galant.ukfsn.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Iain,

On Thu, Apr 14, 2011, Iain Hibbert wrote:
> frm.in is stored as an uint8_t, so we cannot copy an int there
> directly.  use an intermediate variable so that it also works
> on big-endian systems.
> ---
>  src/hcidump.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)

Pushed upstream. Thanks.

Johan
