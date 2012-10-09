Return-Path: <cyrus@holtmann.org>
Date: Tue, 9 Oct 2012 18:44:58 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/2] audio: Fix memory leak of AVDTP buffer
Message-ID: <20121009164458.GB11843@x220.c.hospitality.swisscom.com>
References: <1349798633-28071-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1349798633-28071-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Tue, Oct 09, 2012, Luiz Augusto von Dentz wrote:
> Upon disconnection all references to AVDTP session should be release
> otherwise the data associate with it cannot be freed and new connection
> may overwrite the buf pointer causing it to leak.
> ---
>  audio/sink.c   | 8 ++++++++
>  audio/source.c | 8 ++++++++
>  2 files changed, 16 insertions(+)

Both patches have been applied. Thanks.

Johan
