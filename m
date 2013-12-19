Return-Path: <cyrus@holtmann.org>
Date: Thu, 19 Dec 2013 10:09:42 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/3] android/socket: Connect directly to RFCOMM chan is
 uuid is zero
Message-ID: <20131219080942.GA31549@x220.p-661hnu-f1>
References: <1387376336-17092-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1387376336-17092-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1387376336-17092-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Wed, Dec 18, 2013, Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Check uuid and connect to specified channel number directly.
> ---
>  android/socket.c | 32 +++++++++++++++++++++++---------
>  1 file changed, 23 insertions(+), 9 deletions(-)

Please fix the commit message: capital UUID, s/is/if/ and
s/chan/channel/ in the subject.

> +static bool is_empty(const uint8_t *uuid)
> +{
> +	static uint8_t zero_uuid[16];
> +
> +	return memcmp(uuid, zero_uuid, sizeof(zero_uuid)) == 0;
> +}
> +
>  static void handle_connect(const void *buf, uint16_t len)
>  {
>  	const struct hal_cmd_sock_connect *cmd = buf;
> -	struct rfcomm_sock *rfsock;
> +	struct rfcomm_sock *rfsock = NULL;

Firstly this rfsock = NULL seems completely unrelated to this patch, and
secondly it's not even needed. Please remove it.

>  	uuid_t uuid;
>  	int hal_fd = -1;
>  
> @@ -940,17 +947,21 @@ static void handle_connect(const void *buf, uint16_t len)
>  
>  	android2bdaddr(cmd->bdaddr, &rfsock->dst);
>  
> -	memset(&uuid, 0, sizeof(uuid));
> -	uuid.type = SDP_UUID128;
> -	memcpy(&uuid.value.uuid128, cmd->uuid, sizeof(uint128_t));
> +	if (is_empty(cmd->uuid)) {
> +		if (!do_connect(rfsock, cmd->channel))
> +			goto failed;

If this is_empty function was really needed it should at least be called
uuid_is_empty to make it clear what it's for. However, since it's a
one-line function and you've only got a single place needing it, I'd
just declare a static const uint8_t zero_uuuid[16] in handle_connect()
and do the memcmp directly there.

Johan
