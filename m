Return-Path: <cyrus@holtmann.org>
Date: Sun, 29 May 2011 22:10:01 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Rafal Michalski <michalski.raf@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix invalid read of memory in avdtp module
Message-ID: <20110529191001.GF32088@dell.ger.corp.intel.com>
References: <1306501157-13073-1-git-send-email-michalski.raf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1306501157-13073-1-git-send-email-michalski.raf@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Rafal,

On Fri, May 27, 2011, Rafal Michalski wrote:
> Fixed incorrect update of server->sessions GSlist in avdtp_exit.
> Previosly it was leading to invalid read of memory (l = l->next)
> (and possible memory leaks) since after invoking avdtp_unref in
> connection_lost, l pointer was not valid anymore (previously assignment
> l = l->next was used after invoking connection_lost in for loop).
> ---
>  audio/avdtp.c |    8 +++++++-
>  1 files changed, 7 insertions(+), 1 deletions(-)

Applied. Thanks.

Johan
