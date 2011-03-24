Return-Path: <cyrus@holtmann.org>
Date: Thu, 24 Mar 2011 11:20:42 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Return an error if the attribute requires authorization
Message-ID: <20110324092042.GC30621@jh-x301>
References: <1300909212-15709-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1300909212-15709-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Wed, Mar 23, 2011, Claudio Takahasi wrote:
> If an attribute requires authorization, Insuficient Authorization
> will be returned by the attribute server until the Agent supports
> a method to authorize attribute access.
> ---
>  src/attrib-server.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/src/attrib-server.c b/src/attrib-server.c
> index 9543da6..dc05d7e 100644
> --- a/src/attrib-server.c
> +++ b/src/attrib-server.c
> @@ -173,6 +173,8 @@ static uint8_t att_check_reqs(struct gatt_channel *channel, uint8_t opcode,
>  		channel->encrypted = g_attrib_is_encrypted(channel->attrib);
>  	if (reqs == ATT_AUTHENTICATION && !channel->encrypted)
>  		return ATT_ECODE_INSUFF_AUTHEN;
> +	else if (reqs == ATT_AUTHORIZATION)
> +		return ATT_ECODE_INSUFF_AUTHO;
>  
>  	switch (opcode) {
>  	case ATT_OP_READ_BY_GROUP_REQ:

Pushed upstream. Thanks.

Btw, I'm not really a fan of those "authen" and "autho" short versions.
Since you're already spelling the words out in other defines (e.g.
ATT_AUTHENTICATION) I suppose it'd make sense to do the same for the
error codes as well.

Johan
