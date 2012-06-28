Return-Path: <cyrus@holtmann.org>
Date: Thu, 28 Jun 2012 13:51:27 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Slawomir Bochenski <lkslawek@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] lib/sdp.c: Prevent passing unitialised argument
Message-ID: <20120628105127.GA14629@x220>
References: <1327411363-18773-1-git-send-email-lkslawek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1327411363-18773-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Slawek,

On Tue, Jan 24, 2012, Slawomir Bochenski wrote:
> In case of sdp_seq_alloc() failures in loop, unitialised seqDTDs would
> be passed to final sdp_seq_alloc.
> ---
>  lib/sdp.c |   12 ++++++++----
>  1 files changed, 8 insertions(+), 4 deletions(-)

Applied. Thanks.

Johan
