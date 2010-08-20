Return-Path: <cyrus@holtmann.org>
Date: Fri, 20 Aug 2010 13:55:39 +0300
From: Ville Tervo <ville.tervo@nokia.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] bluetooth: fix not setting security level when
 creating a rfcomm session
Message-ID: <20100820105539.GB1835@null.mobile.lnx.nokia.com>
References: <1282215970-32758-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1282215970-32758-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Aug 19, 2010 at 01:06:10PM +0200, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>
> 
> This cause 'No Bonding' to be used if userspace has not yet been paired
> with remote device since the l2cap socket used to create the rfcomm
> session does not have any security level set.

Looks good.

> Signed-off-by: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

Acked-by: Ville Tervo <ville.tervo@nokia.com>

-- 
Ville
