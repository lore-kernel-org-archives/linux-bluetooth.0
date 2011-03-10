Return-Path: <cyrus@holtmann.org>
Date: Thu, 10 Mar 2011 16:31:01 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Elvis Pf??tzenreuter <epx@signove.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v4] Implement ATT handle indications
Message-ID: <20110310143100.GA3245@jh-x301>
References: <1299765690-16322-1-git-send-email-epx@signove.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1299765690-16322-1-git-send-email-epx@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Elvis,

On Thu, Mar 10, 2011, Elvis Pf??tzenreuter wrote:
> This patch takes advantage of g_attrib_send() implicit guarantee of
> queueing i.e. indication is only sent if the previous one has been
> confirmed, so we don't need to maintain an explicit queue.
> ---
>  src/attrib-server.c |   16 ++++++++++++++++
>  1 files changed, 16 insertions(+), 0 deletions(-)

Pushed upstream. Thanks.

Johan
