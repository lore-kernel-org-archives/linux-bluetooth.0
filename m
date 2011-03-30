Return-Path: <cyrus@holtmann.org>
Date: Wed, 30 Mar 2011 19:44:01 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix crash when acquiring a2dp stream
Message-ID: <20110330164401.GG30984@jh-x301>
References: <1301488324-16975-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1301488324-16975-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Wed, Mar 30, 2011, Luiz Augusto von Dentz wrote:
> Disconnecting l2cap before getting a response for avdtp start cause a
> crash while we try to abort it:
> 
> avdtp_sep_set_state (session=0x9c210, sep=0x9ada0, state=AVDTP_STATE_IDLE)
> 0x000256dc in connection_lost (session=0x9c210, err=-5)
> 0x00025d44 in cancel_request (session=0x9c210, err=-5)
> 0x00026a98 in avdtp_abort (session=0x9c210, stream=0x9bee8)
> 0x00020e74 in a2dp_cancel (dev=<value optimized out>, id=<value optimized out>)
> 0x0002d5b4 in acquire_request_free (req=0x9b1a0)
> 0x0002d638 in media_owner_remove (owner=0x9a4a0)
> 0x0002da94 in media_transport_free (data=<value optimized out>)
> 0x000115a0 in remove_interface (data=0xa1f88, name=<value optimized out>)
> 0x0002e2a0 in media_transport_remove (transport=0x8fad8)
> 0x0002c624 in media_endpoint_clear_configuration (endpoint=0x9b098)
> 0x000260c8 in avdtp_sep_set_state (session=0x9c210, sep=0x9ada0, state=AVDTP_STATE_IDLE)
> 
> To fix this callbacks are called after handling the state change, so
> any pending request are properly removed before state is set to idle.
> ---
>  audio/avdtp.c     |   14 ++++++++------
>  audio/transport.c |   12 +-----------
>  2 files changed, 9 insertions(+), 17 deletions(-)

Pushed upstream. Thanks.

Johan
