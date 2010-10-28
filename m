Return-Path: <cyrus@holtmann.org>
Date: Thu, 28 Oct 2010 14:07:08 +0100
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, ville.tervo@nokia.com
Subject: Re: [PATCH] bluetooth: fix not setting security level when
 creating a rfcomm session
Message-ID: <20101028130708.GC17930@vigoh>
References: <1282215970-32758-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1282215970-32758-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

* Luiz Augusto von Dentz <luiz.dentz@gmail.com> [2010-08-19 14:06:10 +0300]:

> From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>
> 
> This cause 'No Bonding' to be used if userspace has not yet been paired
> with remote device since the l2cap socket used to create the rfcomm
> session does not have any security level set.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>
> ---
>  net/bluetooth/rfcomm/core.c |   13 ++++++++++---
>  1 files changed, 10 insertions(+), 3 deletions(-)

Patch has been applied to the bluetooth-2.6 tree. Thanks.

-- 
Gustavo F. Padovan
ProFUSION embedded systems - http://profusion.mobi
