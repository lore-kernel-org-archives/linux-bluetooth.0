Return-Path: <cyrus@holtmann.org>
Date: Tue, 27 Sep 2011 11:30:23 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/5 v2] AVRCP: use a vtable to simplify PDU
 parsing/handling
Message-ID: <20110927083023.GI3952@dell>
References: <1315845241-17077-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1315845241-17077-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Mon, Sep 12, 2011, Luiz Augusto von Dentz wrote:
> This simplify a bit the handling by introducing common checks before
> calling the handler callback, it is also much easier to add/remove
> new PDUs in this way.
> ---
>  audio/control.c |  321 +++++++++++++++++++++----------------------------------
>  1 files changed, 124 insertions(+), 197 deletions(-)

All five patches applied. Thanks.

Johan
