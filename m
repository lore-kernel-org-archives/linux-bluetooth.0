Return-Path: <cyrus@holtmann.org>
Date: Tue, 14 Feb 2012 14:46:09 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] adapter: Fix possible invalid memory access
Message-ID: <20120214124609.GA19427@x220.ger.corp.intel.com>
References: <1328910472-26550-1-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1328910472-26550-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Fri, Feb 10, 2012, Vinicius Costa Gomes wrote:
> ---
> 
> This possible crash was detected by the clang static analysis tool.
> 
>  src/adapter.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)

Applied. Thanks.

Johan
