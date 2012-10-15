Return-Path: <cyrus@holtmann.org>
Date: Mon, 15 Oct 2012 13:13:39 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] media: Fix leaking endpoint in case of failure to
 register SEP
Message-ID: <20121015101339.GA32745@x220>
References: <1350294687-20718-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1350294687-20718-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Mon, Oct 15, 2012, Luiz Augusto von Dentz wrote:
> This can happen in case of AudioSink and/or AudioSource are disabled in
> audio.conf.
> ---
>  audio/media.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied. Thanks.

This finally fixed the leak I've been seeing for a long time. Btw, this
happens also with no audio.conf at all as the default is to disable
AudioSource, so it's a bit misleading to imply (as you do in your commit
message) that this would happen only because of something in audio.conf.

Johan
