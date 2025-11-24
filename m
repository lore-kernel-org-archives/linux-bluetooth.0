Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7067A31619D
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Nov 2025 16:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764003528; cv=pass; b=qNjuZM3BHTM+MXLC4nFjWMKwZISDt9dOeDvh2soFO7PangZscp+W8pGlIahbljNFAKBueXzOZyFmM9Iyr70tRXeUf7b33xFe4fc/TVe1ib5v2QnfVE1XmvophWAoJBWjQxmfNp0/qjM98xu1YQyBfSrET0/9QoAWjp61DCpsRQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764003528; c=relaxed/simple;
	bh=N/6Egd5p9q9R0+9S+OnaZAAitFGJz28ISpmWOEXHxec=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=E7uW6eVXKgzLBnLeWcD/EEldNvq1RA/yRhwxtFoIf4TS37hN6NV8DOZS+qOYUGGeVuVjapRWskl77YiKay5Ookb432gnfqk6mt8kN6HjJ8I5GFvgqk+pWwmmaIb9zMWhIu9Duen/OQ5lX0QUs6h3gWEzM4T/Cmre7Dsj+6ahw3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=okx1f5Ix; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="okx1f5Ix"
Received: from ehlo.thunderbird.net (unknown [193.138.7.214])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dFX8h1JYKzyS9;
	Mon, 24 Nov 2025 18:58:44 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1764003524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MnRgdJ0XVbWKSvI6ef9b4cgnzrwoZe7yV7fNQecyKJM=;
	b=okx1f5IxUDpJ+I8rJkZ0wBHo96OBon3yRwejMXG+BqyZQEWX80i0VkJJYLAF2M2+SsSWFC
	GuiUVr7O6KQvIK87RV2DJq1qykGWLpHiq3sNXmemSK0hDCVfoDYCS/QBaPhoTEnVfIKxQc
	Uk2aBTlvzDAFZFNgW96VOLgtJyh7WWw=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1764003524;
	b=dCzAyGpv1ZnvNRrjaJVmMUUWRyF+JxJsBD3MlWZN3d3lb84CG+3gMhYCHfX2UpQYALZ+ds
	t62u92bWbhE0pdKj/+R5JNfMf0OURviQKkbDK70wp8A+xjF46xY6p+kFCz1A2wYUpsrHEw
	i1B0tXCCcyxZL+UDBGkQOtgTpYvLDPM=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1764003524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MnRgdJ0XVbWKSvI6ef9b4cgnzrwoZe7yV7fNQecyKJM=;
	b=XxAm3memyyizkcmVlCRI51TP/iTlOrYWmiS6Rk6Hgq3AxgqE/j7Uo2CP7gV2xd9jk9fF9L
	YtxR7EJ0RtFQoV1vJg18RFDsfekanbIu2zXd9pZpyjVkjKV4OILCKxM+5AzCDLLwxg3i6A
	ezoAaR1HMCe0wyEtu5CFj7mJcm4uTp4=
Date: Mon, 24 Nov 2025 16:58:44 +0000
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 04/10] bap: have unicast client wait for VCS & TMAS
In-Reply-To: <CABBYNZJdLZwX0t+0h3R71bvfqapj8zrc=_t=ZnVJ6SyuTj=_pA@mail.gmail.com>
References: <cover.1763914558.git.pav@iki.fi> <3761b0c09f02442470d64de9225d3308df2d509f.1763914558.git.pav@iki.fi> <CABBYNZJdLZwX0t+0h3R71bvfqapj8zrc=_t=ZnVJ6SyuTj=_pA@mail.gmail.com>
Message-ID: <CE94A896-F5D2-4446-8692-3BE4B5881709@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

24=2E marraskuuta 2025 16=2E25=2E49 UTC Luiz Augusto von Dentz <luiz=2Eden=
tz@gmail=2Ecom> kirjoitti:
>Hi Pauli,
>
>On Sun, Nov 23, 2025 at 11:17=E2=80=AFAM Pauli Virtanen <pav@iki=2Efi> wr=
ote:
>>
>> Have unicast client to wait for VCS and TMAS before creating endpoints
>> and transports, so that their information is available at that point=2E
>> ---
>>  profiles/audio/bap=2Ec | 69 ++++++++++++++++++++++++++++++++++++++++++=
--
>>  1 file changed, 66 insertions(+), 3 deletions(-)
>>
>> diff --git a/profiles/audio/bap=2Ec b/profiles/audio/bap=2Ec
>> index b07d65e68=2E=2E73c5cfc74 100644
>> --- a/profiles/audio/bap=2Ec
>> +++ b/profiles/audio/bap=2Ec
>> @@ -127,6 +127,7 @@ struct bap_data {
>>         struct btd_device *device;
>>         struct btd_adapter *adapter;
>>         struct btd_service *service;
>> +       struct queue *wait_services;
>>         struct bt_bap *bap;
>>         unsigned int ready_id;
>>         unsigned int state_id;
>> @@ -139,6 +140,7 @@ struct bap_data {
>>         GIOChannel *listen_io;
>>         unsigned int io_id;
>>         unsigned int cig_update_id;
>> +       unsigned int service_state_id;
>>  };
>>
>>  static struct queue *sessions;
>> @@ -186,11 +188,15 @@ static void bap_data_free(struct bap_data *data)
>>         queue_destroy(data->bcast, ep_unregister);
>>         queue_destroy(data->server_streams, NULL);
>>         queue_destroy(data->bcast_snks, setup_free);
>> +       queue_destroy(data->wait_services, NULL);
>>         bt_bap_ready_unregister(data->bap, data->ready_id);
>>         bt_bap_state_unregister(data->bap, data->state_id);
>>         bt_bap_pac_unregister(data->bap, data->pac_id);
>>         bt_bap_unref(data->bap);
>>
>> +       if (data->service_state_id)
>> +               btd_service_remove_state_cb(data->service_state_id);
>> +
>>         if (data->cig_update_id)
>>                 g_source_remove(data->cig_update_id);
>>
>> @@ -2015,13 +2021,16 @@ static bool pac_found_bcast(struct bt_bap_pac *=
lpac, struct bt_bap_pac *rpac,
>>         return true;
>>  }
>>
>> -static void bap_ready(struct bt_bap *bap, void *user_data)
>> +static void bap_service_ready(struct bap_data *data)
>>  {
>> -       struct btd_service *service =3D user_data;
>> -       struct bap_data *data =3D btd_service_get_user_data(service);
>> +       struct bt_bap *bap =3D data->bap;
>> +       struct btd_service *service =3D data->service;
>>
>>         DBG("bap %p", bap);
>>
>> +       if (!queue_isempty(data->wait_services))
>> +               return;
>> +
>>         /* Register all ep before selecting, so that sound server
>>          * knows all=2E
>>          */
>> @@ -2031,6 +2040,15 @@ static void bap_ready(struct bt_bap *bap, void *=
user_data)
>>         bap_select_all(data, false, NULL, NULL);
>>  }
>>
>> +static void bap_ready(struct bt_bap *bap, void *user_data)
>> +{
>> +       struct btd_service *service =3D user_data;
>> +       struct bap_data *data =3D btd_service_get_user_data(service);
>> +
>> +       queue_remove(data->wait_services, NULL);
>> +       bap_service_ready(data);
>> +}
>> +
>>  static bool match_setup_stream(const void *data, const void *user_data=
)
>>  {
>>         const struct bap_setup *setup =3D data;
>> @@ -3740,6 +3758,44 @@ static int bap_probe(struct btd_service *service=
)
>>         return 0;
>>  }
>>
>> +static void wait_service_cb(struct btd_service *service,
>> +                                               btd_service_state_t old=
_state,
>> +                                               btd_service_state_t new=
_state,
>> +                                               void *user_data)
>> +{
>> +       struct bap_data *data =3D user_data;
>> +
>> +       if (new_state =3D=3D BTD_SERVICE_STATE_CONNECTING)
>> +               return;
>> +       if (!queue_remove(data->wait_services, service))
>> +               return;
>> +
>> +       DBG("%s", btd_service_get_profile(service)->name);
>> +       bap_service_ready(data);
>> +}
>> +
>> +static void wait_service_add(struct bap_data *data, uint16_t remote_uu=
id)
>> +{
>> +       struct btd_service *service;
>> +       bt_uuid_t uuid;
>> +       char uuid_str[64];
>> +
>> +       bt_uuid16_create(&uuid, remote_uuid);
>> +       bt_uuid_to_string(&uuid, uuid_str, sizeof(uuid_str));
>> +
>> +       service =3D btd_device_get_service(data->device, uuid_str);
>> +       if (!service)
>> +               return;
>> +       if (btd_service_get_state(service) !=3D BTD_SERVICE_STATE_CONNE=
CTING)
>> +               return;
>> +
>> +       queue_push_tail(data->wait_services, service);
>> +
>> +       if (!data->service_state_id)
>> +               data->service_state_id =3D btd_service_add_state_cb(
>> +                                               wait_service_cb, data);
>> +}
>> +
>>  static int bap_accept(struct btd_service *service)
>>  {
>>         struct btd_device *device =3D btd_service_get_device(service);
>> @@ -3760,6 +3816,13 @@ static int bap_accept(struct btd_service *servic=
e)
>>                 return -EINVAL;
>>         }
>>
>> +       queue_destroy(data->wait_services, NULL);
>> +       data->wait_services =3D queue_new();
>> +
>> +       queue_push_tail(data->wait_services, NULL);
>
>Why are you pushing NULL above?

It's for waiting for bap_ready

>
>> +       wait_service_add(data, TMAS_UUID);
>> +       wait_service_add(data, VCS_UUID);
>
>I wonder if we couldn't add this sort of logic directly in service=2Ec
>so in case other plugins need to do some dependency handling like
>above we don't need to code it  internally in the plugin itself
>creating duplicate handling=2E

Could be changed to be generic yes=2E We also might want to also do confli=
cts, eg BAP and AVRPC/AVDTP at the same time sometimes happens in practice =
and devices usually don't like that=2E


>
>>         btd_service_connecting_complete(service, 0);
>>
>>         return 0;
>> --
>> 2=2E51=2E1
>>
>>
>
>
