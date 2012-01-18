Return-Path: <cyrus@holtmann.org>
Date: Wed, 18 Jan 2012 14:29:40 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, kanak.gupta@stericsson.com
Subject: Re: [PATCH] Fix compilation error in mgmt/main.c
Message-ID: <20120118122940.GA11594@x220>
References: <1326889431-24546-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1326889431-24546-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Wed, Jan 18, 2012, Szymon Janc wrote:
> Use %u instead of %zu for printing len which is of type uint16_t.
> 
> CC     mgmt/main.o
> cc1: warnings being treated as errors
> mgmt/main.c: In function ‘mgmt_device_found’:
> mgmt/main.c:561: error: format ‘%zu’ expects type ‘size_t’, but argument 4 has type ‘int’
> ---
>  mgmt/main.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Thanks, but you were a bit too slow: I already pushed the same fix
myself (I didn't initially catch this error in my 32 bit qemu vm but
when compiling outside in a 64 bit env I saw it).

Johan
