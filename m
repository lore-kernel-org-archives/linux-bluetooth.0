Return-Path: <cyrus@holtmann.org>
Date: Thu, 6 Oct 2011 11:23:25 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Slawomir Bochenski <lkslawek@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd 4/4] Simplify code for calling mime driver flush()
Message-ID: <20111006082325.GA24058@fusion.localdomain>
References: <1317825160-21429-1-git-send-email-lkslawek@gmail.com>
 <1317825160-21429-4-git-send-email-lkslawek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1317825160-21429-4-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Slawek,

On Wed, Oct 05, 2011, Slawomir Bochenski wrote:
> OBEX_EV_REQ is the last thing that we are going to receive on PUT and
> this is always going to be delivered. As the service driver will start
> receiving data at or before its .put(), we can simply call flush() after
> that. This also makes flush() usable in PUTs without length header.
> ---
>  src/obex.c |   28 ++++++++++------------------
>  1 files changed, 10 insertions(+), 18 deletions(-)

This fourth patch has now also been applied. Thanks.

Johan
