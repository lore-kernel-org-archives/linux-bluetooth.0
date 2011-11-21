Return-Path: <cyrus@holtmann.org>
Date: Mon, 21 Nov 2011 20:42:05 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bartosz Szatkowski <bulislaw@linux.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd] client: Fix app params memory management
Message-ID: <20111121184205.GA18774@fusion.localdomain>
References: <1321886687-10662-1-git-send-email-bulislaw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1321886687-10662-1-git-send-email-bulislaw@linux.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bartosz,

On Mon, Nov 21, 2011, Bartosz Szatkowski wrote:
> ---
>  client/transfer.c |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)

Applied after a minor fix (you don't need to check for NULL before
calling g_free). Thanks.

Johan
