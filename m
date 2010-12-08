Return-Path: <cyrus@holtmann.org>
Date: Wed, 8 Dec 2010 09:03:07 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Revert use of new error function for Blocked
Message-ID: <20101208070307.GA6934@jh-x301>
References: <1291770126-2726-1-git-send-email-padovan@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1291770126-2726-1-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Tue, Dec 07, 2010, Gustavo F. Padovan wrote:
> The error message says a lot about what the user need to do, I'm reverting
> this change and will fix in the next patch series about the DBus error
> handling.
> ---
>  src/device.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)

Applied, thanks.

Johan
