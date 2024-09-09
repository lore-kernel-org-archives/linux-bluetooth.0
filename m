Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDB8139CF6
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Sep 2024 15:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725895033; cv=none; b=ia80+C8f9sSIYSNLuSCmuTXNL4eQYjKxcNFUwd860fR26DibmJI2CdoeEfmslwGOoQwavKqoHYCFdL+owTqCqD8/iDUIj5xi0BJ2HT8+rJR+fQRATk6QvveN18Z6HCM0gW3wNo+4/uChz0ZWfjBZPLgKLaJ9w9e2r05pbYi9lzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725895033; c=relaxed/simple;
	bh=PfUbmvl8pnC38nNG+85kwfU7OQq+MlTh3LFpyXNxJqQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fplQM4b4hhLfReTNM4gVXt3lf+bm6aBlLKzchSNfGxGLp9xEN4Y6vbtrNcN0GOwcM06l1AG2wwtb333qcRDYcUAlegYxHKVEE9wVuSK3l5fxa0Ow6T9JisBqyYz8VfRo/YCJXK8X/+XmXcBo5AE6qOJepYkzJhVVfk2gsXemTaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fhdBRvb8; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhdBRvb8"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2f75c6ed397so22528801fa.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Sep 2024 08:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725895030; x=1726499830; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CLA0mDVxoimThfZPYgeYBnLDpXJg/tS2MYQqK1x7b1Y=;
        b=fhdBRvb8y5ojuRPLVAtVBisVGoVGq0utkMP6m/CR2tEkNRL+EulFe+zcDdRCyqKCke
         4TZL+vsG/yaof6Qr6c+74d0R4C61bMUDsKmPi8sLRg6gtOQ5ySiAV7/vMgqNZEn3Zi7T
         hXnX1f2lSFbIIDL365MSLzyevbWKErTcxisgGkL0JNoIXlZLJIsyO1bSLtecWDyz6hOW
         c5ao9yRybS0r+HzJkZbxq6k6cYk+E+dPDzJxO2syL+qw++cgakezS13RyXqKAb/7KkLW
         hnbtDa6fIS5LXOyv6egyXdfPKwZL7fR6fgA4ZXVZl0rt9uolD681iKxvedceTudcfaOd
         i0ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725895030; x=1726499830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CLA0mDVxoimThfZPYgeYBnLDpXJg/tS2MYQqK1x7b1Y=;
        b=cq8X1qj+xYBulJpHeVZUS035i2EAhQY/5d9hpigUGnJ+bkjbUPqPegLNODNUXg5RaQ
         FohkcXyqUpwvj0F7mJSwtX7mH9cjaMgbU+0CiUPfz1OhbgO4ejt7RsC37ZkQKo+D2uoD
         kpgjrFltgAiSoralSecwkuwqJ4Xhq3ZrOoMdIjSdqBupaIkvhIMRpK0Z4yTELDqritLf
         WEofmiMYw31c+7bUrse1KSWd3pwPA+vjAMdEeB7W1fuHAMoEO+8sm/f5Fs6oovEU0Deq
         +f4mLXwiIzirLSK8ielMuB20sFFCdRPUDNLLUDSfM8ouRmGlg5x0rUnlkIol7PPOdRSv
         lEoA==
X-Gm-Message-State: AOJu0YyM6xsh6yfwGlQsoJ5aKH85SCjX/asQxp5G3EiEPhJ62N/oi8HT
	4UJLiDAbAbqdx52gBqKiIUhkyp4k2XmgRFkd6QOMTNM41aZsOUUt0XmT9vClqtZY0ywavFLWjtz
	5mU8b27jCcMpY3vWj5wW6D3d/yPc=
X-Google-Smtp-Source: AGHT+IE/NqnmUcc4p3cn7ocnRNXA9Syjd595VawgRybk7HfwQd0mwAXmjspGAB/QB7Vd/n8iVTU2GXuYD27OLP4i9O4=
X-Received: by 2002:a05:651c:502:b0:2f6:5f7b:e5e0 with SMTP id
 38308e7fff4ca-2f751efa3bcmr61745961fa.21.1725895029122; Mon, 09 Sep 2024
 08:17:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240907213301.14000-1-vibhavp@gmail.com> <20240907213301.14000-2-vibhavp@gmail.com>
In-Reply-To: <20240907213301.14000-2-vibhavp@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 9 Sep 2024 11:16:56 -0400
Message-ID: <CABBYNZ+sskbvtEb2CMyGU3_yYJAe4e4Cmh+vrvKj4U9+7872mA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] device: Add method GetServiceRecords
To: Vibhav Pant <vibhavp@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Vibhav,

On Sat, Sep 7, 2024 at 5:33=E2=80=AFPM Vibhav Pant <vibhavp@gmail.com> wrot=
e:
>
> GetServiceRecords returns all currently known BR/EDR service records
> for the device, as an array of array of bytes. Each individual byte
> array represents a raw SDP record, as defined by the Bluetooth Service
> Discovery Protocol spec.
> This method is intended to be only used by compatibility layers like
> Wine, that need to provide access to raw SDP records to implement the
> Win32 Bluetooth API. Applications should instead use the Profile API
> for services-related functionality.

Is this the best format though? I'm afraid this would require an upper
level to implement SDP record parsing as well or is that what Windows
exposes as well?

> ---
>  src/device.c | 83 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 83 insertions(+)
>
> diff --git a/src/device.c b/src/device.c
> index 0f18c8c7f..6aa809c80 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -3215,6 +3215,86 @@ static DBusMessage *cancel_pairing(DBusConnection =
*conn, DBusMessage *msg,
>         return dbus_message_new_method_return(msg);
>  }
>
> +static sdp_list_t *read_device_records(struct btd_device *device);
> +
> +static DBusMessage *get_service_records(DBusConnection *conn, DBusMessag=
e *msg,
> +                                       void *data)
> +{
> +       DBusMessage *reply;
> +       DBusMessageIter records_arr, record;
> +       struct btd_device *device =3D data;
> +       sdp_list_t *cur;
> +
> +       if (!btd_adapter_get_powered(device->adapter))
> +               return btd_error_not_ready(msg);
> +
> +       if (!btd_device_is_connected(device))
> +               return btd_error_not_connected(msg);
> +
> +       if (!device->bredr_state.svc_resolved)
> +               return btd_error_not_ready(msg);
> +
> +       if (!device->tmp_records) {
> +               device->tmp_records =3D read_device_records(device);
> +               if (!device->tmp_records)
> +                       return btd_error_does_not_exist(msg);
> +       }
> +
> +       reply =3D dbus_message_new_method_return(msg);
> +       if (!reply)
> +               return btd_error_failed(msg, "Could not create method rep=
ly");
> +
> +       dbus_message_iter_init_append(reply, &records_arr);
> +       if (!dbus_message_iter_open_container(&records_arr, DBUS_TYPE_ARR=
AY,
> +                                             "ay", &record)) {
> +               dbus_message_unref(reply);
> +               return btd_error_failed(msg, "Could not initialize iterat=
or");
> +       }
> +
> +       for (cur =3D device->tmp_records; cur; cur =3D cur->next) {
> +               DBusMessageIter record_bytes;
> +               sdp_record_t *rec =3D cur->data;
> +               sdp_buf_t buf;
> +               int result;
> +
> +               result =3D sdp_gen_record_pdu(rec, &buf);
> +               if (result) {
> +                       dbus_message_iter_abandon_container(&records_arr,
> +                                                           &record);
> +                       dbus_message_unref(reply);
> +                       return btd_error_failed(
> +                               msg, "Could not marshal service record");
> +               }
> +               if (!dbus_message_iter_open_container(&record, DBUS_TYPE_=
ARRAY,
> +                                                     "y", &record_bytes)=
) {
> +                       bt_free(buf.data);
> +                       dbus_message_iter_abandon_container(&records_arr,
> +                                                           &record);
> +                       dbus_message_unref(reply);
> +                       return btd_error_failed(
> +                               msg, "Could not initialize iterator");
> +               }
> +               if (!dbus_message_iter_append_fixed_array(
> +                           &record_bytes, DBUS_TYPE_BYTE, &buf.data,
> +                           buf.data_size)) {
> +                       bt_free(buf.data);
> +                       dbus_message_iter_abandon_container(&record,
> +                                                           &record_bytes=
);
> +                       dbus_message_iter_abandon_container(&records_arr,
> +                                                           &record);
> +                       dbus_message_unref(reply);
> +                       return btd_error_failed(
> +                               msg, "Could not append record data to rep=
ly");
> +               }
> +               dbus_message_iter_close_container(&record, &record_bytes)=
;
> +               bt_free(buf.data);
> +       }
> +
> +       dbus_message_iter_close_container(&records_arr, &record);
> +
> +       return reply;
> +}
> +
>  static const GDBusMethodTable device_methods[] =3D {
>         { GDBUS_ASYNC_METHOD("Disconnect", NULL, NULL, dev_disconnect) },
>         { GDBUS_ASYNC_METHOD("Connect", NULL, NULL, dev_connect) },
> @@ -3224,6 +3304,9 @@ static const GDBusMethodTable device_methods[] =3D =
{
>                                                 NULL, disconnect_profile)=
 },
>         { GDBUS_ASYNC_METHOD("Pair", NULL, NULL, pair_device) },
>         { GDBUS_METHOD("CancelPairing", NULL, NULL, cancel_pairing) },
> +       { GDBUS_EXPERIMENTAL_METHOD("GetServiceRecords", NULL,
> +                                   GDBUS_ARGS({ "Records", "aay" }),
> +                                   get_service_records) },
>         { }
>  };
>
> --
> 2.46.0
>
>


--=20
Luiz Augusto von Dentz
