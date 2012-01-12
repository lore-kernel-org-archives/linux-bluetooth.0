Return-Path: <cyrus@holtmann.org>
Date: Thu, 12 Jan 2012 21:41:38 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bruna Moreira <bruna.moreira@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix EIR name parsing
Message-ID: <20120112194138.GB7453@fusion.localdomain>
References: <1326393217-13111-1-git-send-email-bruna.moreira@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1326393217-13111-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bruna,

On Thu, Jan 12, 2012, Bruna Moreira wrote:
> Some vendors put a NUL byte terminator on EIR name field. If that is the
> case, use -1 as string length so g_utf8_validade() can parse it
> properly.
> ---
>  src/eir.c |   11 ++++++++++-
>  1 files changed, 10 insertions(+), 1 deletions(-)

Applied. Thanks.

Johan
