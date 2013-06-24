Return-Path: <cyrus@holtmann.org>
Date: Mon, 24 Jun 2013 11:09:41 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] lib: Cleanup SDP logs to not include double new lines
Message-ID: <20130624080941.GA16051@x220>
References: <1371847700-21192-1-git-send-email-szymon.janc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1371847700-21192-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Fri, Jun 21, 2013, Szymon Janc wrote:
> SDPERR and SDPDBG already add new line to prints.
> ---
>  lib/sdp.c | 183 +++++++++++++++++++++++++++++++-------------------------------
>  1 file changed, 90 insertions(+), 93 deletions(-)

Applied. Thanks.

Johan
