Return-Path: <cyrus@holtmann.org>
Date: Thu, 10 May 2012 16:42:04 -0700
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Johan Hovold <jhovold@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH BlueZ] csr_bcsp: fix link establishment
Message-ID: <20120510234204.GA7917@x220.colubris.lan>
References: <1335531838-10627-1-git-send-email-jhovold@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1335531838-10627-1-git-send-email-jhovold@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Fri, Apr 27, 2012, Johan Hovold wrote:
> The current link-establishment implementation times out if a packet is
> not received after the link is active (i.e. reception of CONF_RESP).
> 
> Fix by making sure that the link establishment loop in open is
> terminated when ubcsp sets the UBCSP_PACKET_SENT flag (on reception of
> CONF_RESP) rather than UBCSP_PACKET_RECEIVED (on reception of any later
> packages).
> 
> ---
> 
> Hi,
> 
> This patch is required in order to be able to use devices with link managers
> that do not send any packets after the link has been established (i.e. after
> sending CONF_RESP).
> 
> I have two devices here; one which sends an HCI_EVENT_PKT after link
> establishment and one which doesn't. Both work with hciattach, but bccmd times
> out during link establishment with the latter one. Both work with bccmd with
> the patch applied.
> 
> It appears to me that this is a bug which has perhaps simply not been
> discovered as most devices do send something after LE. The ubcsp
> implementation, however, clearly sets the UBCSP_PACKET_SENT flag when reaching
> the link-active state and not the received flag which csr_open_bcsp checks for.
> 
> Thanks,
> Johan
> 
>  tools/csr_bcsp.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Applied. Thanks.

Johan
