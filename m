Return-Path: <cyrus@holtmann.org>
Date: Fri, 4 Feb 2011 06:55:27 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bruna Moreira <bruna.moreira@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix invalid read after list concatenation
Message-ID: <20110204045527.GB1551@jh-x301>
References: <1296758628-15202-1-git-send-email-bruna.moreira@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1296758628-15202-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bruna,

On Thu, Feb 03, 2011, Bruna Moreira wrote:
> g_slist_concat uses the items from second list directly so they should
> not be freed.
> ---
>  attrib/gatt.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)

Pushed upstream. Thanks.

Johan
