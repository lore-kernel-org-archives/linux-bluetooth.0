Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582E22741D3
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 May 2025 11:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747222311; cv=none; b=P8QGHjcWTRSiGmkrXDSmdSNsgrwzbRLNBPLVna2PBcak4IDBlJSUit2nuvlARCkbPK5zXyF9KTr2jp82yTZmRLsTKwLdIn0U4W0BmjNSIBEz7t0S5WJgcrVcrpSwwaTKp6gkddpxlKmQN34Cw3gf181sjdQcFPOr+4L+lewEWSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747222311; c=relaxed/simple;
	bh=1mAyGT46vAMvbIfXfPX0Wgy80QzjkGiAqmPxIPDp220=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=FOc4j0riyPB/qPN9AHDAOdv63jkfOeE4rBqxJ/GsZv6BonzfZ3XVrjHx6SE0+MZJFPqLnQ2w9Ke6kiZhCzQaUwyy9ZeFR5CkUTPxVVXwnlCnKCPJYVcYfjwknQGkyN/rQdqWpcpq3yDswzEfeoi8EzsFxwgHffGr3ROPFcT6mBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.36] (g36.guest.molgen.mpg.de [141.14.220.36])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id DFDBF61E6479A;
	Wed, 14 May 2025 13:31:29 +0200 (CEST)
Message-ID: <601601d6-c2ab-4bd9-917c-1831651cfca6@molgen.mpg.de>
Date: Wed, 14 May 2025 13:31:29 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ] device: Reply br-connection-key-missing on
 connection bonding error
To: =?UTF-8?Q?Fr=C3=A9d=C3=A9ric_Danis?= <frederic.danis@collabora.com>
References: <20250514112050.17438-1-frederic.danis@collabora.com>
Content-Language: en-US
Cc: linux-bluetooth@vger.kernel.org
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250514112050.17438-1-frederic.danis@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Frédéric,


Am 14.05.25 um 13:20 schrieb Frédéric Danis:
> Currently when connection is removed while the client is waiting for
> Connect() the failed message is br-connection-canceled, even if this
> is due to bonding error.
> 
> This commit reply br-connection-key-missing when connection request
> fails due to bonding error, allowing the client to differentiate
> connection failure reasons.

This sentence is hard to parse for me. Maybe:

Implement to reply with br-connection-key-missing, when the connection 
request fails due to a bonding error, ….

Also, it’d be great if you added the steps, how to reproduce and test this.

> ---
>   src/device.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/src/device.c b/src/device.c
> index c364d72c3..816282eab 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -246,6 +246,7 @@ struct btd_device {
>   	struct browse_req *browse;		/* service discover request */
>   	struct bonding_req *bonding;
>   	struct authentication_req *authr;	/* authentication request */
> +	uint8_t		bonding_status;
>   	GSList		*disconnects;		/* disconnects message */

disconnects → disconnect

>   	DBusMessage	*connect;		/* connect message */
>   	DBusMessage	*disconnect;		/* disconnect message */
> @@ -3636,6 +3637,7 @@ void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type,
>   	DBusMessage *reply;
>   	bool remove_device = false;
>   	bool paired_status_updated = false;
> +	uint8_t bonding_status = device->bonding_status;
>   
>   	if (!state->connected)
>   		return;
> @@ -3643,6 +3645,7 @@ void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type,
>   	state->connected = false;
>   	state->initiator = false;
>   	device->general_connect = FALSE;
> +	device->bonding_status = 0;
>   
>   	device_set_svc_refreshed(device, false);
>   
> @@ -3658,6 +3661,7 @@ void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type,
>   	if (device->connect) {
>   		DBG("connection removed while Connect() is waiting reply");
>   		reply = btd_error_failed(device->connect,
> +				bonding_status ? ERR_BREDR_CONN_KEY_MISSING :
>   						ERR_BREDR_CONN_CANCELED);
>   		g_dbus_send_message(dbus_conn, reply);
>   		dbus_message_unref(device->connect);
> @@ -6763,6 +6767,8 @@ void device_bonding_complete(struct btd_device *device, uint8_t bdaddr_type,
>   
>   	DBG("bonding %p status 0x%02x", bonding, status);
>   
> +	device->bonding_status = status;
> +
>   	if (auth && auth->agent)
>   		agent_cancel(auth->agent);
>   


Kind regards,

Paul
