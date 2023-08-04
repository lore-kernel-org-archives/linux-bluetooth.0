Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5453C001DB
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Aug 2023 06:40:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233610AbjHDGka (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 4 Aug 2023 02:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbjHDGkE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 4 Aug 2023 02:40:04 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA2F46BD
        for <linux-bluetooth@vger.kernel.org>; Thu,  3 Aug 2023 23:39:43 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-5230ac6dbc5so2065603a12.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Aug 2023 23:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1691131182; x=1691735982;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AN91KFs9Ps1X5VZqldmBIs4TMtfIa8G2VVO79N3rlS8=;
        b=u/F0HvUCT7P3x2cRDGUSoPSV5FUGs0WXwpUeqRyuuXyo1NUcBsMed3LdOd74/VToAs
         DxvCZp8/XbgNJWNd5hVtJOlNpMGP6T9i0jUhjdiBIqGa/NhVJcF9Pp/hTHW6FA2IZafD
         RozUUL4IEBTlw2NPB/HoTvMsWCCUrdN5P9rW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691131182; x=1691735982;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AN91KFs9Ps1X5VZqldmBIs4TMtfIa8G2VVO79N3rlS8=;
        b=KWv8pDkOIG9u1iGq+C2QdgXDJP5Ux8AH5WJ4rQ6XPZ7wjr74GObonNZTOzAYK/8/Ao
         24TsIZAgEJTrUpR5U2ezGmbm7R0uJPcD6awGr3UOVLrc7CcCi3P+I4GXLCAPNe75wXnY
         4oIUBh0CL/HPmKAR80IHkBWwiPvoHaukbXrwoOlc3BXgDAFlhOUc92Z3cOsSCrxjPf7n
         vhsKe5lylvH8roJTbom1ZdKI+xUWNxII2ZLMARkZhaI39WGSH1z67uw0judXfrGfljTr
         G4WO0whXcX1+SCVud3CQxogofj6+EcUjHJBzs5MQNaRDn4cY5CayNjkEc1lRduSZzeG/
         e8HA==
X-Gm-Message-State: AOJu0YyEidzSEzeCW5SRD81iEhIqhtuSTfrBnVcv1ipSpcOd5ZpIi9z4
        cEaYjp3mBZjILiZBbg5bG4HFLpbmpuvxyVNwk6o=
X-Google-Smtp-Source: AGHT+IFTDKeiGF31o2x9KqCWvEoJPO8c9rNbdZJrwwfy8fyKpg/sWPW/1xk88XQbPMyHvzayi4wKoA==
X-Received: by 2002:aa7:df90:0:b0:523:78c:166c with SMTP id b16-20020aa7df90000000b00523078c166cmr826038edy.16.1691131182295;
        Thu, 03 Aug 2023 23:39:42 -0700 (PDT)
Received: from ?IPV6:2a01:c846:10c0:200:46fe:8c34:c680:5cb9? ([2a01:c846:10c0:200:46fe:8c34:c680:5cb9])
        by smtp.gmail.com with ESMTPSA id m13-20020aa7c2cd000000b0051df54c6a27sm818543edp.56.2023.08.03.23.39.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Aug 2023 23:39:41 -0700 (PDT)
Message-ID: <d0d84f73-19e1-b1e4-ed81-0f3f92c73c89@streamunlimited.com>
Date:   Fri, 4 Aug 2023 08:39:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH BlueZ 5/5] device: Fix reverse service discovery handling
 for dual mode devices
Content-Language: en-US
To:     luiz.dentz@gmail.com
References: <20230728053153.584222-1-simon.mikuda@streamunlimited.com>
 <20230728053153.584222-6-simon.mikuda@streamunlimited.com>
Cc:     linux-bluetooth@vger.kernel.org
From:   Simon Mikuda <simon.mikuda@streamunlimited.com>
In-Reply-To: <20230728053153.584222-6-simon.mikuda@streamunlimited.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz.

Do you plan to review and merge also this commit series?

I already updated it according to your message:

Perhaps in case of discovery we could do both in parallel, although if
the remote side supports GATT services as part of SDP we may end up
with redundant discovery but bt_gatt_client/gatt_db shall be able to
handle that.

Thank you.

BR,
Simon

On 28. 7. 2023 7:31, Simon Mikuda wrote:
> There can be situation that after connection to LE bearer we will try
> to start reverse discovery on BR/EDR bearer even when it is not connected.
>
> This change separates SDP and GATT reverse services discoveries to their
> respective bearers. SDP to BR/EDR and GATT to LE.
> ---
>   src/device.c | 129 +++++++++++++++++++++++++++++++++------------------
>   1 file changed, 83 insertions(+), 46 deletions(-)
>
> diff --git a/src/device.c b/src/device.c
> index 367e2f046..90d6a7615 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -158,6 +158,10 @@ struct bearer_state {
>   	bool initiator;
>   	bool connectable;
>   	time_t last_seen;
> +	/* reverse service discovery timer */
> +	unsigned int discov_timer;
> +	/* service discover request (SDP, GATT) */
> +	struct browse_req *browse;
>   };
>   
>   struct ltk_info {
> @@ -236,9 +240,7 @@ struct btd_device {
>   	bool		temporary;
>   	bool		connectable;
>   	unsigned int	disconn_timer;
> -	unsigned int	discov_timer;
>   	unsigned int	temporary_timer;	/* Temporary/disappear timer */
> -	struct browse_req *browse;		/* service discover request */
>   	struct bonding_req *bonding;
>   	struct authentication_req *authr;	/* authentication request */
>   	GSList		*disconnects;		/* disconnects message */
> @@ -684,8 +686,10 @@ static void browse_request_free(struct browse_req *req)
>   {
>   	struct btd_device *device = req->device;
>   
> -	if (device->browse == req)
> -		device->browse = NULL;
> +	if (device->bredr_state.browse == req)
> +		device->bredr_state.browse = NULL;
> +	if (device->le_state.browse == req)
> +		device->le_state.browse = NULL;
>   
>   	if (req->listener_id)
>   		g_dbus_remove_watch(dbus_conn, req->listener_id);
> @@ -833,8 +837,10 @@ static void device_free(gpointer user_data)
>   	if (device->disconn_timer)
>   		timeout_remove(device->disconn_timer);
>   
> -	if (device->discov_timer)
> -		timeout_remove(device->discov_timer);
> +	if (device->bredr_state.discov_timer)
> +		timeout_remove(device->bredr_state.discov_timer);
> +	if (device->le_state.discov_timer)
> +		timeout_remove(device->le_state.discov_timer);
>   
>   	if (device->temporary_timer)
>   		timeout_remove(device->temporary_timer);
> @@ -1848,8 +1854,10 @@ void device_request_disconnect(struct btd_device *device, DBusMessage *msg)
>   	if (device->bonding)
>   		bonding_request_cancel(device->bonding);
>   
> -	if (device->browse)
> -		browse_request_cancel(device->browse);
> +	if (device->bredr_state.browse)
> +		browse_request_cancel(device->bredr_state.browse);
> +	if (device->le_state.browse)
> +		browse_request_cancel(device->le_state.browse);
>   
>   	if (device->att_io) {
>   		g_io_channel_shutdown(device->att_io, FALSE, NULL);
> @@ -2304,7 +2312,7 @@ void btd_device_update_allowed_services(struct btd_device *dev)
>   	/* If service discovery is ongoing, let the service discovery complete
>   	 * callback call this function.
>   	 */
> -	if (dev->browse) {
> +	if (dev->bredr_state.browse) {
>   		ba2str(&dev->bdaddr, addr);
>   		DBG("service discovery of %s is ongoing. Skip updating allowed "
>   							"services", addr);
> @@ -2370,7 +2378,7 @@ int btd_device_connect_services(struct btd_device *dev, GSList *services)
>   {
>   	GSList *l;
>   
> -	if (dev->pending || dev->connect || dev->browse)
> +	if (dev->pending || dev->connect || dev->bredr_state.browse)
>   		return -EBUSY;
>   
>   	if (!btd_adapter_get_powered(dev->adapter))
> @@ -2401,7 +2409,7 @@ static DBusMessage *connect_profiles(struct btd_device *dev, uint8_t bdaddr_type
>   	DBG("%s %s, client %s", dev->path, uuid ? uuid : "(all)",
>   						dbus_message_get_sender(msg));
>   
> -	if (dev->pending || dev->connect || dev->browse)
> +	if (dev->pending || dev->connect || dev->bredr_state.browse)
>   		return btd_error_in_progress_str(msg, ERR_BREDR_CONN_BUSY);
>   
>   	if (!btd_adapter_get_powered(dev->adapter)) {
> @@ -2784,7 +2792,7 @@ static void browse_request_complete(struct browse_req *req, uint8_t type,
>   
>   	/* if successfully resolved services we need to free browsing request
>   	 * before passing message back to connect functions, otherwise
> -	 * device->browse is set and "InProgress" error is returned instead
> +	 * device->state.browse is set and "InProgress" error is returned instead
>   	 * of actually connecting services
>   	 */
>   	msg = dbus_message_ref(req->msg);
> @@ -2829,7 +2837,7 @@ static void device_svc_resolved(struct btd_device *dev, uint8_t browse_type,
>   						uint8_t bdaddr_type, int err)
>   {
>   	struct bearer_state *state = get_state(dev, bdaddr_type);
> -	struct browse_req *req = dev->browse;
> +	struct browse_req *req = state->browse;
>   
>   	DBG("%s err %d", dev->path, err);
>   
> @@ -3060,7 +3068,7 @@ static DBusMessage *pair_device(DBusConnection *conn, DBusMessage *msg,
>   			err = device_connect_le(device);
>   		else
>   			err = adapter_create_bonding(adapter, &device->bdaddr,
> -							device->bdaddr_type,
> +							bdaddr_type,
>   							io_cap);
>   	} else {
>   		err = adapter_create_bonding(adapter, &device->bdaddr,
> @@ -4657,8 +4665,10 @@ void device_remove(struct btd_device *device, gboolean remove_stored)
>   		device_cancel_bonding(device, status);
>   	}
>   
> -	if (device->browse)
> -		browse_request_cancel(device->browse);
> +	if (device->bredr_state.browse)
> +		browse_request_cancel(device->bredr_state.browse);
> +	if (device->le_state.browse)
> +		browse_request_cancel(device->le_state.browse);
>   
>   	while (device->services != NULL) {
>   		struct btd_service *service = device->services->data;
> @@ -5317,7 +5327,7 @@ static void att_disconnected_cb(int err, void *user_data)
>   
>   	DBG("");
>   
> -	if (device->browse)
> +	if (device->le_state.browse)
>   		goto done;
>   
>   	DBG("%s (%d)", strerror(err), err);
> @@ -5345,7 +5355,7 @@ done:
>   
>   static void register_gatt_services(struct btd_device *device)
>   {
> -	struct browse_req *req = device->browse;
> +	struct browse_req *req = device->le_state.browse;
>   	GSList *services = NULL;
>   
>   	if (!bt_gatt_client_is_ready(device->client))
> @@ -5636,8 +5646,8 @@ static void att_connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
>   			adapter_connect_list_add(device->adapter, device);
>   		}
>   
> -		if (device->browse)
> -			browse_request_complete(device->browse,
> +		if (device->le_state.browse)
> +			browse_request_complete(device->le_state.browse,
>   						BROWSE_GATT,
>   						device->bdaddr_type,
>   						-ECONNABORTED);
> @@ -5751,15 +5761,24 @@ static struct browse_req *browse_request_new(struct btd_device *device,
>   							DBusMessage *msg)
>   {
>   	struct browse_req *req;
> +	struct bearer_state *state;
>   
> -	if (device->browse)
> +	switch (type) {
> +	case BROWSE_SDP:
> +		state = get_state(device, BDADDR_BREDR);
> +		break;
> +	case BROWSE_GATT:
> +		state = get_state(device, BDADDR_LE_PUBLIC);
> +		break;
> +	}
> +	if (state->browse)
>   		return NULL;
>   
>   	req = g_new0(struct browse_req, 1);
>   	req->device = device;
>   	req->type = type;
>   
> -	device->browse = req;
> +	state->browse = req;
>   
>   	if (!msg)
>   		return req;
> @@ -5879,15 +5898,17 @@ int device_discover_services(struct btd_device *device,
>   						uint8_t bdaddr_type, DBusMessage *msg)
>   {
>   	int err;
> +	struct bearer_state *state;
>   
>   	if (bdaddr_type == BDADDR_BREDR)
>   		err = device_browse_sdp(device, msg);
>   	else
>   		err = device_browse_gatt(device, msg);
>   
> -	if (err == 0 && device->discov_timer) {
> -		timeout_remove(device->discov_timer);
> -		device->discov_timer = 0;
> +	state = get_state(device, bdaddr_type);
> +	if (err == 0 && state->discov_timer) {
> +		timeout_remove(state->discov_timer);
> +		state->discov_timer = 0;
>   	}
>   
>   	return err;
> @@ -6208,16 +6229,22 @@ bool device_is_connectable(struct btd_device *device)
>   	return state->connectable;
>   }
>   
> -static bool start_discovery_cb(gpointer user_data)
> +static bool start_sdp_discovery_cb(gpointer user_data)
>   {
>   	struct btd_device *device = user_data;
>   
> -	if (device->bredr)
> -		device_browse_sdp(device, NULL);
> -	else
> -		device_browse_gatt(device, NULL);
> +	device->bredr_state.discov_timer = 0;
> +	device_browse_sdp(device, NULL);
>   
> -	device->discov_timer = 0;
> +	return FALSE;
> +}
> +
> +static bool start_gatt_discovery_cb(gpointer user_data)
> +{
> +	struct btd_device *device = user_data;
> +
> +	device->le_state.discov_timer = 0;
> +	device_browse_gatt(device, NULL);
>   
>   	return FALSE;
>   }
> @@ -6368,17 +6395,27 @@ void device_bonding_complete(struct btd_device *device, uint8_t bdaddr_type,
>   			g_dbus_send_reply(dbus_conn, bonding->msg, DBUS_TYPE_INVALID);
>   		}
>   		bonding_request_free(bonding);
> -	} else if (!state->svc_resolved) {
> -		if (!device->browse && !device->discov_timer &&
> -				btd_opts.reverse_discovery) {
> -			/* If we are not initiators and there is no currently
> -			 * active discovery or discovery timer, set discovery
> -			 * timer */
> -			DBG("setting timer for reverse service discovery");
> -			device->discov_timer = timeout_add_seconds(
> -							DISCOVERY_TIMER,
> -							start_discovery_cb,
> -							device, NULL);
> +
> +	} else if (!state->svc_resolved
> +			&& !state->browse
> +			&& !state->discov_timer
> +			&& btd_opts.reverse_discovery) {
> +
> +		/* If we are not initiators and there is no currently
> +		 * active discovery or discovery timer, set discovery
> +		 * timer */
> +		if (bdaddr_type == BDADDR_BREDR) {
> +			DBG("setting timer for reverse SDP service discovery");
> +			state->discov_timer = timeout_add_seconds(
> +					DISCOVERY_TIMER,
> +					start_sdp_discovery_cb,
> +					device, NULL);
> +		} else {
> +			DBG("setting timer for reverse GATT service discovery");
> +			state->discov_timer = timeout_add_seconds(
> +					DISCOVERY_TIMER,
> +					start_gatt_discovery_cb,
> +					device, NULL);
>   		}
>   	}
>   }
> @@ -6416,11 +6453,11 @@ unsigned int device_wait_for_svc_complete(struct btd_device *dev,
>   
>   	if (state->svc_resolved || !btd_opts.reverse_discovery)
>   		cb->idle_id = g_idle_add(svc_idle_cb, cb);
> -	else if (dev->discov_timer > 0) {
> -		timeout_remove(dev->discov_timer);
> -		dev->discov_timer = timeout_add_seconds(
> +	else if (dev->bredr_state.discov_timer > 0) {
> +		timeout_remove(dev->bredr_state.discov_timer);
> +		dev->bredr_state.discov_timer = timeout_add_seconds(
>   						0,
> -						start_discovery_cb,
> +						start_sdp_discovery_cb,
>   						dev, NULL);
>   	}
>   
