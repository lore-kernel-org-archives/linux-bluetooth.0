Return-Path: <cyrus@holtmann.org>
Date: Mon, 13 Aug 2012 13:27:24 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] btmgmt: Fix endianness conversion
Message-ID: <20120813102724.GB22250@x220.ger.corp.intel.com>
References: <1343743081-25474-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1343743081-25474-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Tue, Jul 31, 2012, Anderson Lizardo wrote:
> Flags field has 32-bit size. Same issue was fixed for mgmtops in
> 1801a4d45d74c29cebacaab79a07e9961300be41.
> ---
>  tools/btmgmt.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied. Thanks.

Johan
