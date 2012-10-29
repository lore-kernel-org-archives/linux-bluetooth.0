Return-Path: <cyrus@holtmann.org>
Date: Mon, 29 Oct 2012 13:07:12 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ v4] AVDTP: Do not keep a internal reference
Message-ID: <20121029110712.GA10204@x220>
References: <1351259069-21516-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1351259069-21516-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Fri, Oct 26, 2012, Luiz Augusto von Dentz wrote:
> Don't initialize reference with 1, instead always start disconnect timer
> when reference drops to 0, so in case nobody reclaims the session it
> automatically disconnect after 1 second and frees the memory.
> ---
> v2: Fix with stream_setup flag being ignored in disconnect_timeout
> v3: Do avrcp_free on connection_lost to avoid having dangling sessions in
> disconnected state waiting the timeout to be freed.
> v4: Remove unnecessary reference when authorizing, disconnect timer is only
> started when the session is really connected.
> 
>  audio/avdtp.c | 204 +++++++++++++++++++++++-----------------------------------
>  1 file changed, 82 insertions(+), 122 deletions(-)

Applied. Thanks.

Johan
