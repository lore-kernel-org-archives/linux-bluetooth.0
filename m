Return-Path: <cyrus@holtmann.org>
Date: Sun, 29 May 2011 22:05:59 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix possible buffer overflow when sending avdtp commands
Message-ID: <20110529190559.GE32088@dell.ger.corp.intel.com>
References: <1306485444-2110-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1306485444-2110-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Fri, May 27, 2011, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Buffer size should be as big as the maximum of imtu and omtu, otherwise
> it may overflow when sending messages which are bigger then imtu.
> ---
>  audio/avdtp.c |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)

Applied. Thanks.

Johan
