Return-Path: <cyrus@holtmann.org>
Date: Tue, 24 Mar 2015 18:39:20 -0700
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Filter list of supported commands/events for
 untrusted users
Message-ID: <20150325013920.GA25324@t440s>
References: <1427243463-13987-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1427243463-13987-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Mar 24, 2015, Marcel Holtmann wrote:
> When the user of the management interface is not trusted, then it only
> has access to a limited set of commands and events. When providing the
> list of supported commands and events take the trusted vs untrusted
> status of the user into account and return different lists.
> 
> This way the untrusted user knows exactly which commands it can
> execute and which events it can receive. So no guesswork needed.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/mgmt.c | 53 +++++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 46 insertions(+), 7 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
