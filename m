Return-Path: <cyrus@holtmann.org>
Date: Thu, 19 Aug 2010 14:08:04 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix crash when there is no enough space to fragment
 avdtp packet
Message-ID: <20100819110804.GA13364@jh-x301>
References: <1282215669-24429-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1282215669-24429-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Thu, Aug 19, 2010, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>
> 
> This was catch when running codenomicon tests when the output mtu is not
> big enough to stuff fragmented packets.
> ---
>  audio/avdtp.c |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)

Thanks. The patch has been pushed upstream.

Johan
