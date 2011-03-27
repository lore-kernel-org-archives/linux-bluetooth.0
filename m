Return-Path: <cyrus@holtmann.org>
Date: Sun, 27 Mar 2011 22:51:39 +0300
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] Make MediaTransport.Release asynchronous
Message-ID: <20110327195139.GB6994@jh-x301>
References: <1301072395-16787-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1301072395-16787-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Fri, Mar 25, 2011, Luiz Augusto von Dentz wrote:
> This make it possible for the owners to synchronize its state if the
> transport is going to be suspended.
> 
> Note that client which don't want to wait for Release can just ignore/
> not wait for its reply.
> ---
>  audio/transport.c |  168 +++++++++++++++++++++++++++++++++++++++++-----------
>  1 files changed, 132 insertions(+), 36 deletions(-)

All three patches have been pushed upstream. Thanks.

Johan
