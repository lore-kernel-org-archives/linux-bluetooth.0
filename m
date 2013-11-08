Return-Path: <cyrus@holtmann.org>
Date: Fri, 8 Nov 2013 11:04:49 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/ipc: Fix crash when sending file descriptor
Message-ID: <20131108090449.GA23960@x220.p-661hnu-f1>
References: <1383837935-31110-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1383837935-31110-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Thu, Nov 07, 2013, Andrei Emeltchenko wrote:
> Since CMSG_FIRSTHDR is defined as shown below:
> 
>   ((size_t) (mhdr)->msg_controllen >= sizeof (struct cmsghdr) \
>    ? (struct cmsghdr *) (mhdr)->msg_control : (struct cmsghdr *) 0)
> 
> it return NULL if msg_controllen is not defined. Accessing
> that pointer result in daemon crash.
> ---
>  android/ipc.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied. Thanks.

Johan
