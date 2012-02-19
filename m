Return-Path: <cyrus@holtmann.org>
Date: Mon, 20 Feb 2012 00:19:49 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd 1/8] core: Fix queueing packet containing error
 while suspended
Message-ID: <20120219221949.GA6928@x220.P-661HNU-F1>
References: <1329578343-31663-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1329578343-31663-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Sat, Feb 18, 2012, Luiz Augusto von Dentz wrote:
> Queueing the error won't remove the original packet created by transfer
> from the queue so upon resume gobex will attempt to send it again.
> 
> To fix this we no longer create a error packet instead the session is
> market as aborted and the error stored so when gobex finally resumes the
> error is forward properly.
> ---
>  src/obex-priv.h |    1 +
>  src/obex.c      |   10 ++++++----
>  2 files changed, 7 insertions(+), 4 deletions(-)

All patches in this set have been applied. Thanks.

Johan
