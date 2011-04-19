Return-Path: <cyrus@holtmann.org>
Date: Tue, 19 Apr 2011 15:30:30 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Fix not waiting for POLLERR when disconnecting SCO
Message-ID: <20110419123030.GA25424@jh-x301>
References: <1303209490-14760-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1303209490-14760-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Tue, Apr 19, 2011, Luiz Augusto von Dentz wrote:
> To make sure the SCO link is really disconnected we should wait for
> POLLERR since POLLHUP does not necessarily means the link is
> completely disconnected just that no further data can be sent/received.
> 
> Note that this depend on a fix of SCO socket shutdown in kernel to wait
> for disconnect confimation to then kill/destroy the socket indicating
> the err/reason using POLLERR.
> ---
>  audio/headset.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)

Pushed upstream. Thanks.

Johan
