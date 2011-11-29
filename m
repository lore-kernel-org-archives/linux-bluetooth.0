Return-Path: <cyrus@holtmann.org>
Date: Tue, 29 Nov 2011 11:00:35 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd 5/6 v2] Port core daemon to gobex
Message-ID: <20111129090035.GA17393@x220>
References: <1322428331-28204-1-git-send-email-luiz.dentz@gmail.com>
 <1322428331-28204-5-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1322428331-28204-5-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Sun, Nov 27, 2011, Luiz Augusto von Dentz wrote:
> +	char *path = g_strdup_printf("/transfer%u", GPOINTER_TO_UINT(os));

The first four patches have been applied and (like we discussed offline)
I'm waiting for an update to this one that doesn't expose our internal
memory addresses to external processes like this.

Johan
