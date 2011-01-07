Return-Path: <cyrus@holtmann.org>
Date: Fri, 7 Jan 2011 22:29:13 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] Refactor example server to use att_put_u16()
Message-ID: <20110107202913.GA6870@jh-x301>
References: <1294431133-8847-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1294431133-8847-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Fri, Jan 07, 2011, Anderson Lizardo wrote:
> The original code was written before att_put_u16() was implemented.
> ---
>  attrib/example.c |  162 +++++++++++++++---------------------------------------
>  1 files changed, 45 insertions(+), 117 deletions(-)

All three patches have been pushed upstream. Thanks.

Johan
