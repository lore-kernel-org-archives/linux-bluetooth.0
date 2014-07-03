Return-Path: <cyrus@holtmann.org>
Date: Thu, 3 Jul 2014 10:34:30 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Add support for Read Unconfigured Index List
 command
Message-ID: <20140703073430.GA3275@t440s.lan>
References: <1404331852-40619-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1404331852-40619-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Jul 02, 2014, Marcel Holtmann wrote:
> This command allows to get the list of currently known controller that
> are in unconfigured state.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/mgmt.h |  7 ++++
>  net/bluetooth/mgmt.c         | 91 +++++++++++++++++++++++++++++++++++++++-----
>  2 files changed, 88 insertions(+), 10 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
