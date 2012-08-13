Return-Path: <cyrus@holtmann.org>
Date: Mon, 13 Aug 2012 13:24:29 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 BlueZ] monitor: Fix endianness conversion
Message-ID: <20120813102429.GA22250@x220.ger.corp.intel.com>
References: <1343672142-18834-1-git-send-email-anderson.lizardo@openbossa.org>
 <1343740877-16611-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1343740877-16611-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Tue, Jul 31, 2012, Anderson Lizardo wrote:
> Flags field has 32-bit size. Same issue was fixed for mgmtops in
> 1801a4d45d74c29cebacaab79a07e9961300be41.
> ---
> 
> v2 -> v3: Fix another occurrence of same bug.
> 
>  monitor/control.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied. Thanks.

Johan
