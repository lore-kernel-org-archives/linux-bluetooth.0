Return-Path: <cyrus@holtmann.org>
Date: Mon, 30 Jul 2012 16:00:26 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2 hcidump] hci: Fix EIR data parsing
Message-ID: <20120730130026.GC16470@x220.ger.corp.intel.com>
References: <1343554225-3644-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1343554225-3644-1-git-send-email-andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

On Sun, Jul 29, 2012, Andrzej Kaczmarek wrote:
> Data passed to ext_inquiry_data_dump are expected to start with length
> octet which was consumed by get_u8.
> ---
>  parser/hci.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Applied. Thanks.

Johan
