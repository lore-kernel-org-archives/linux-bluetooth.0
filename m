Return-Path: <cyrus@holtmann.org>
Date: Thu, 6 Oct 2011 11:59:35 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd] Fix possible crash when using syncevolution plugin
Message-ID: <20111006085935.GA26908@fusion.localdomain>
References: <1317890818-15669-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1317890818-15669-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Thu, Oct 06, 2011, Luiz Augusto von Dentz wrote:
> Context os need to be set since synce_write uses it, in addiction
> check if context is valid in synce_open.
> ---
>  plugins/syncevolution.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)

Applied. Thanks.

Johan
