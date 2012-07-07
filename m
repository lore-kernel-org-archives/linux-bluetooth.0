Return-Path: <cyrus@holtmann.org>
Date: Sat, 7 Jul 2012 10:16:24 +0100
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ v2] mgmtops: Fix calling btd_adapter_start() for an
 off adapter
Message-ID: <20120707091624.GA23372@x220.vexbr.com.br>
References: <1341606418-12257-1-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1341606418-12257-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Fri, Jul 06, 2012, Vinicius Costa Gomes wrote:
> When the adapter mode is off and the controller is down, we should
> not consider that the adapter is powered up.
> ---
>  plugins/mgmtops.c |   11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)

Applied. Thanks.

Johan
