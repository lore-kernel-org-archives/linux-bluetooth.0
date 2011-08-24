Return-Path: <cyrus@holtmann.org>
Date: Wed, 24 Aug 2011 14:24:52 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric?= Dalleau
	<frederic.dalleau@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 0/9] Add support for HandsfreeGateway to Media
Message-ID: <20110824112452.GA23872@dell>
References: <1314027047-5476-1-git-send-email-frederic.dalleau@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1314027047-5476-1-git-send-email-frederic.dalleau@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frédéric,

On Mon, Aug 22, 2011, Frédéric Dalleau wrote:
> This patch will enable HandsfreeGateway interface to work with PulseAudio.
> This is similar to what is done for Headset interface.
> 
> Also there is some minor fixes in the pulse audio part required.
> I've updated the patch on the PA list to v3
> 
> Best regards,
> Frédéric
> 
> Frédéric Dalleau (9):
>   Fix double free in error case in endpoint_reply
>   Add state change callback to HandsfreeGateway
>   Use state change callback from media interface
>   Update g_strcmp0 to strcasecmp
>   Fix RFCOMM disconnect on suspend request
>   Set state to "connecting" when AG connects.
>   Fix invalid state at SCO disconnect in gateway
>   Introduce gateway locking mechanism
>   Implement media_transport for HFP_HS_UUID
> 
>  audio/gateway.c   |  107 ++++++++++++++++++++++++++++++++++++++++++-
>  audio/gateway.h   |   15 ++++++
>  audio/media.c     |   61 ++++++++++++++++++++++++-
>  audio/transport.c |  130 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 309 insertions(+), 4 deletions(-)

All patches applied except 7/9 (for which I'm waiting for a response to
Luiz's feedback). Thanks.

Johan
