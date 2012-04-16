Return-Path: <cyrus@holtmann.org>
Date: Mon, 16 Apr 2012 23:41:14 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd] client: Fix regression when calling
 obc_session_shutdown within callback
Message-ID: <20120416204114.GA17024@x220.ger.corp.intel.com>
References: <1334572807-2578-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1334572807-2578-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Mon, Apr 16, 2012, Luiz Augusto von Dentz wrote:
> Commit c07ddfbd019d3545cce2d7ec694143cdc55a2167 introduced the freeing of
> the active pending request on obc_session_shutdown without checking if
> the request was already processed/terminated.
> ---
>  client/session.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)

Applied. Thanks.

Johan
