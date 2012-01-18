Return-Path: <cyrus@holtmann.org>
Date: Thu, 19 Jan 2012 00:34:26 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 08/11] Add support for sending the Load Long Term
 Keys commands
Message-ID: <20120118223426.GA14634@x220.P-661HNU-F1>
References: <1326842930-31623-1-git-send-email-vinicius.gomes@openbossa.org>
 <1326842930-31623-8-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1326842930-31623-8-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Tue, Jan 17, 2012, Vinicius Costa Gomes wrote:
> Also this adds another method to the adapter_ops method table,
> this method allows LTKs to be loaded to the kernel.
> ---
>  plugins/hciops.c  |    6 +++++
>  plugins/mgmtops.c |   55 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  src/adapter.h     |   12 +++++++++++
>  3 files changed, 73 insertions(+), 0 deletions(-)

All patches up until this one have been applied. I'm waiting for an
update for the rest based on our discussion in IRC.

Johan
