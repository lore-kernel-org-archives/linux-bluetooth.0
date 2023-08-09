Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A6D8C07E8A
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Aug 2023 18:31:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbjHISbr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Aug 2023 14:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232324AbjHISbo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Aug 2023 14:31:44 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0189A3
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Aug 2023 11:31:42 -0700 (PDT)
Received: from [192.168.1.195] (unknown [IPv6:2a0c:f040:0:2790::a03d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav@iki.fi)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4RLdth24Nwz49Q3M;
        Wed,  9 Aug 2023 21:31:40 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1691605900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nIkqQmxiQQqXvEiW00UBHsj50xrz9EPQpchFYcSxamE=;
        b=U8MZhxuqUyBZeb/Bxbk4pvUyWz63rSv9gnxDWCgQYz2IvCxR9rUTi5seRI2Ts7GqNzeSax
        JosVU1yvD/pRTiX3l4d2pJMuKicjE9pKBvMHSE8eluYCeSCUUZ/6BLcKRp0OlNBYfmDgZ8
        YFBtGW3BAWgoGBjQWJCz/OAPUWUxYNvgKTyJ4LuNmqoH7aWp3/dO6OGQxSzxgQTaTbBgmT
        ZyJ++Z9LYBaabtQVUJK2CnW1V+4TD3ptm3FViQtpL88ILEadUp6Fz222cWyUP2wn1H0UNY
        g6PrEVyBa/M4FE47NFu3MdCr8ktkHvG2GbspzgLaSrefPBJHJSw1cciPDLa0Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1691605900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nIkqQmxiQQqXvEiW00UBHsj50xrz9EPQpchFYcSxamE=;
        b=dMp6/TgVE4ZT+ZEHVVbUjHyMgHiHNm2XrEMnsFPGTimG50H5ADsl2Bk7EtHQ9EwF2XtXW1
        NiJ5GZLt+e859Mp8xcPN+K8O1CzdOxJ7tbL7r1QxaVLpPUN5OWg/6vr6KPkWER8IbpXI9y
        mvbhYEnFLZx4UZMYqVAzXoTomJGU0Mjpq7YZmk4Gcl91t2NUXvNEKn8Q5PcDHJ4oGA/a65
        tgOfxaYxQ4ny3+vQJ365W+Q4RPO15acIsmpOolVlZ41W+6ymQCmHUhxWANMWqA0Y18i3/T
        2sU5Ajg42mcIzDgwn+U6h8nNddvDAHiCrx5TIF/A5VmMUSA3uGgcepdDR2HoOA==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1691605900; a=rsa-sha256;
        cv=none;
        b=wg7bjD/nEOtGgu+yLdhdFXSSqzelGgK74b4bErs8EMcO19MW8T3KmwoSvnrxpWzNxqt9PY
        Xf4XIyNOaTEpyjb6OwWibmeo7N+K1wyKVmR+nU1eKvsiQiFA0MxEVevn/YRmWbZXz0Mpkc
        PW8JpScq8/JJS8BkSnVrDnHIObPxkJTJbHcG6I3Jod+8NjCRe/LOXrm4MKj10iwreDL94r
        nQ/J6l/taoRYoTPRHaE9YVphiHu5e0IKelGZ8/XjN725oJE3xB293vKN0K6f3N2H1Bk55a
        LbzagxC5P2PgwG3yV+VlQFgkBFDsbbuV7bavsmcCATXqixM/DeHT+RbShxpdiQ==
Message-ID: <4e26a59c2ba25be76f96aa1806ab2132f5f7e069.camel@iki.fi>
Subject: Re: [BlueZ RFC] profile: Add probe_on_discover flag
From:   Pauli Virtanen <pav@iki.fi>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Date:   Wed, 09 Aug 2023 21:31:37 +0300
In-Reply-To: <20230802201538.584029-1-luiz.dentz@gmail.com>
References: <20230802201538.584029-1-luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

ke, 2023-08-02 kello 13:15 -0700, Luiz Augusto von Dentz kirjoitti:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>=20
> This adds probe_on_discover flag which indicates if profile needs to be
> probed when the remote_uuid is discovered and changes device logic to
> attempt to probe driver when a new UUID is discovered and
> probe_on_discover is set.
> ---
>  src/device.c  | 22 +++++++++++++++++-----
>  src/profile.h |  5 +++++
>  2 files changed, 22 insertions(+), 5 deletions(-)

Note this seems to break (unicast) BAP for me, bap_probe does not seem
to be called any more on the devices.

Previously it is called immediately on bluetoothd start, not clear if
that is how it should be.

>=20
> diff --git a/src/device.c b/src/device.c
> index b43ced8b5c91..19ae03f7d98a 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -2156,7 +2156,7 @@ done:
>  void device_add_eir_uuids(struct btd_device *dev, GSList *uuids)
>  {
>  	GSList *l;
> -	bool added =3D false;
> +	GSList *added =3D NULL;
> =20
>  	if (dev->bredr_state.svc_resolved || dev->le_state.svc_resolved)
>  		return;
> @@ -2165,13 +2165,11 @@ void device_add_eir_uuids(struct btd_device *dev,=
 GSList *uuids)
>  		const char *str =3D l->data;
>  		if (g_slist_find_custom(dev->eir_uuids, str, bt_uuid_strcmp))
>  			continue;
> -		added =3D true;
> +		added =3D g_slist_append(added, (void *)str);
>  		dev->eir_uuids =3D g_slist_append(dev->eir_uuids, g_strdup(str));
>  	}
> =20
> -	if (added)
> -		g_dbus_emit_property_changed(dbus_conn, dev->path,
> -						DEVICE_INTERFACE, "UUIDs");
> +	device_probe_profiles(dev, added);
>  }
> =20
>  static void add_manufacturer_data(void *data, void *user_data)
> @@ -2201,6 +2199,7 @@ static void add_service_data(void *data, void *user=
_data)
>  	struct eir_sd *sd =3D data;
>  	struct btd_device *dev =3D user_data;
>  	bt_uuid_t uuid;
> +	GSList *l;
> =20
>  	if (bt_string_to_uuid(&uuid, sd->uuid) < 0)
>  		return;
> @@ -2208,6 +2207,10 @@ static void add_service_data(void *data, void *use=
r_data)
>  	if (!bt_ad_add_service_data(dev->ad, &uuid, sd->data, sd->data_len))
>  		return;
> =20
> +	l =3D g_slist_append(NULL, sd->uuid);
> +	device_add_eir_uuids(dev, l);
> +	g_slist_free(l);
> +
>  	g_dbus_emit_property_changed(dbus_conn, dev->path,
>  					DEVICE_INTERFACE, "ServiceData");
>  }
> @@ -3930,6 +3933,12 @@ static bool device_match_profile(struct btd_device=
 *device,
>  	if (profile->remote_uuid =3D=3D NULL)
>  		return false;
> =20
> +	/* Don't match if device was just discovered (not connected) and the
> +	 * profile don't have probe_on_discover flag set.
> +	 */
> +	if (!btd_device_is_connected(device) && !profile->probe_on_discover)
> +		return false;
> +
>  	if (g_slist_find_custom(uuids, profile->remote_uuid,
>  							bt_uuid_strcmp) =3D=3D NULL)
>  		return false;
> @@ -4884,6 +4893,9 @@ void device_probe_profiles(struct btd_device *devic=
e, GSList *uuids)
>  	struct probe_data d =3D { device, uuids };
>  	char addr[18];
> =20
> +	if (!uuids)
> +		return;
> +
>  	ba2str(&device->bdaddr, addr);
> =20
>  	if (device->blocked) {
> diff --git a/src/profile.h b/src/profile.h
> index 6871f2f0d7d8..cfc50058812d 100644
> --- a/src/profile.h
> +++ b/src/profile.h
> @@ -33,6 +33,11 @@ struct btd_profile {
>  	 */
>  	bool experimental;
> =20
> +	/* Indicates the profile needs to be probed when the remote_uuid is
> +	 * discovered.
> +	 */
> +	bool probe_on_discover;
> +
>  	int (*device_probe) (struct btd_service *service);
>  	void (*device_remove) (struct btd_service *service);
> =20

