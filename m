Return-Path: <cyrus@holtmann.org>
Date: Mon, 17 Oct 2011 16:36:19 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: chanyeol.park@samsung.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix input pending connect handling
Message-ID: <20111017133619.GA22294@fusion.localdomain>
References: <1318853257-10667-1-git-send-email-chanyeol.park@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1318853257-10667-1-git-send-email-chanyeol.park@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chan-yeol,

On Mon, Oct 17, 2011, chanyeol.park@samsung.com wrote:
> iconn->pending_connect needs to be freed after sending the error reply
> ---
>  input/device.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)

Applied. Thanks, and congrats for getting your first patch upstream! :)

Johan
