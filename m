Return-Path: <cyrus@holtmann.org>
Date: Tue, 22 Feb 2011 14:20:55 -0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix not setting global mode when SetProperty is used
Message-ID: <20110222172055.GA2737@jh-x301>
References: <1298366773-5781-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1298366773-5781-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Tue, Feb 22, 2011, Luiz Augusto von Dentz wrote:
> Global mode should be overwrite if user application change the adapter
> mode by using SetProperty while there are sessions active, otherwise
> when this sessions are released the mode restored will be the global
> mode from before the sessions were created and not the mode set with
> SetProperty.
> ---
>  src/adapter.c |   14 +++++++++++---
>  1 files changed, 11 insertions(+), 3 deletions(-)

Pushed upstream. Thanks.

Johan
