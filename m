Return-Path: <cyrus@holtmann.org>
Date: Fri, 20 Dec 2013 09:42:13 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2 1/6] emulator: Add new method for adding l2cap server
Message-ID: <20131220074213.GB18981@x220.p-661hnu-f1>
References: <1387463345-26406-1-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1387463345-26406-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Thu, Dec 19, 2013, Marcin Kraglak wrote:
> This method allow user to add l2cap server and register
> connect callback. If no callback is specified, it will behave
> like bthost_set_server_psm() method.
> ---
>  emulator/bthost.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++----
>  emulator/bthost.h |  5 +++++
>  2 files changed, 63 insertions(+), 4 deletions(-)

All patches in this set have been applied. Thanks.

I also applied two cleanup patches to bthost to remove some redundant
function calls.

Johan
