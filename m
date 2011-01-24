Return-Path: <cyrus@holtmann.org>
Date: Mon, 24 Jan 2011 11:56:23 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Subject: Re: [PATCH] Fix initialization when adapter is already up
Message-ID: <20110124095623.GA13189@jh-x301>
References: <1295860387-10608-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1295860387-10608-1-git-send-email-luiz.dentz@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Mon, Jan 24, 2011, Luiz Augusto von Dentz wrote:
> When handling HCI_DEV_REG event it should not be necessary to generate a
> HCI_DEV_UP since init_known_adapters already does it in case the adapter
> is ulready up.
> ---
>  plugins/hciops.c |   26 ++------------------------
>  1 files changed, 2 insertions(+), 24 deletions(-)

Thanks for the patch. It has been pushed upstream with a minor typo fix
in the commit message.

Marcel, I think this would be reason enough to make another release.

Johan
