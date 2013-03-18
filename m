Return-Path: <cyrus@holtmann.org>
Date: Mon, 18 Mar 2013 12:17:40 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Alexandru Gheorghiu <gheorghiuandru@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: bluetooth: Replaced kzalloc and memcpy with kmemdup
Message-ID: <20130318151740.GC16337@joana>
References: <1363497410-24983-1-git-send-email-gheorghiuandru@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1363497410-24983-1-git-send-email-gheorghiuandru@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alexandru,

* Alexandru Gheorghiu <gheorghiuandru@gmail.com> [2013-03-17 07:16:50 +0200]:

> Replaced calls to kzalloc followed by memcpy with a single call to kmemdup.
> 
> Signed-off-by: Alexandru Gheorghiu <gheorghiuandru@gmail.com>
> ---
>  net/bluetooth/a2mp.c |    6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Patch has been applied to bluetooth-next. Thanks.

	Gustavo
