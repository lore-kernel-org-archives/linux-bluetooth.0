Return-Path: <cyrus@holtmann.org>
Date: Thu, 23 Dec 2010 00:42:55 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bruna Moreira <bruna.moreira@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Change LE scan interval and window to recommended
 values
Message-ID: <20101222224255.GB10702@jh-x301>
References: <1293045108-14011-1-git-send-email-bruna.moreira@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1293045108-14011-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bruna,

On Wed, Dec 22, 2010, Bruna Moreira wrote:
> Replace default scan interval and scan window values with recommended
> ones for general discovery procedure, according to the Core
> specification.
> ---
>  plugins/hciops.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)

Pushed upstream. Thanks.

Johan
