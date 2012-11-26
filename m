Return-Path: <cyrus@holtmann.org>
Date: Mon, 26 Nov 2012 16:43:53 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 01/11] audio: Remove AudioSink interface
Message-ID: <20121126144353.GA7319@x220>
References: <1353935362-8666-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1353935362-8666-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Mon, Nov 26, 2012, Luiz Augusto von Dentz wrote:
> This interface is no longer needed as Device interface can now connect
> the profiles and the state can be tracked using MediaTransport interface.
> ---
>  doc/audio-api.txt     |  53 -------------------
>  profiles/audio/sink.c | 141 ++------------------------------------------------
>  2 files changed, 3 insertions(+), 191 deletions(-)

All patches in this set have been applied. Thanks.

Johan
