Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB1040D570
	for <linux-bluetooth@vger.kernel.org>; Sun, 14 Jun 2026 10:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781433290; cv=none; b=JzHx6fYFZdU+GIg4QT5/HVuOI1ciUocejZ2BfxcYpFStgPORIqNh4ur/0ZNv+O/F7DHpYyPa6xUBvxcGrv0D2N3Q3DpRTS58yUnaixStoftsk2Zdp0yULlZPQ+uIeiUxnA7fbVHVDepAwNR5Kdo6mmALtqmh+xy7+6205nFxFQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781433290; c=relaxed/simple;
	bh=PoaWsVMduk+y/ACLhBcCnofmbfMXCUQg+17W0zS4UjM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hmNCoF2uhbSs5lQgDCvZXXqL6xeIOm9JwnY9t18/B46uodEd4tVvOW13Fc/u8ExsYxe1hXAolctlzGNea6I9irOdkl73M/wcrSAhUHZgtZkBoS+nyUhXwY3xF6h2cyFkLCHY7B3owy//Y6zX4w6tYyZPV8ED8zBIKwwpQ9GAVQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com; spf=pass smtp.mailfrom=streamunlimited.com; dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b=SzMEx74m; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b="SzMEx74m"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so15579665e9.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 14 Jun 2026 03:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1781433287; x=1782038087; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3SH6pz90JYEEg2jBVgYQykOz2XJ46C04zXUGimnWLk4=;
        b=SzMEx74mSsITGJT6lVvGrFZ0TL/UcwkIyw0JxF/2BNB27v5r7U8GEHxIPK+eQjH9R/
         df7UCffNJnEOBqx77HUJjnlrYipLK87nUwFTySlBFmeMxUn5zIHDZMdgRyvQ978ajBKy
         5MUOx9DA7eKqHRj1lT1KbqwTmuHKiW2ewKQJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781433287; x=1782038087;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3SH6pz90JYEEg2jBVgYQykOz2XJ46C04zXUGimnWLk4=;
        b=dS2bxuDTEtZiEKUgqnc3vL+ZB9kBBnSPQ9qGqok1i/nRk7FI3kH5nBDbkYbrMSbiy7
         b+REW4cHdF2e1h5BVPCIFkdw22dIJ0NNbhZa1i0Z0laE7U5AD8MhPf7rwSgpF49zUa1/
         4EHwxdcpt30QN0efEP2m6FEjT4oH2m17RnwDwYYGo3uE3gByta0BfHL/h93x77LVCFoE
         n8pqm+tyAIVK1FtqfHp6wcIPrHfzWAtpTPNRFIjwwLF2PV9dkCPwaa2RFE0iYsP/2ZeE
         8+MRVXC270cetatmvLCdhcauytHidy1jvWTuAbXF5XKZ54z8SobsU+zQvW21YvvmItSI
         NGPg==
X-Gm-Message-State: AOJu0Yzipc/Mk8fyBuPhBCqmw03PcTXRjOTXShHxEBCps/cq+dHNdBE0
	PNJOXgvmDrbl8HhAvWZsjpSJNluN5k/y7R+ImtonbkKWAQQ7UyxerJ23RcpfYPUqNcRhicr0c24
	NfG3j
X-Gm-Gg: Acq92OFF10dSJc777MWqLsYzOY0x6Qk2YT746oWF56PYWNqfQ4PRJ/4jmYAdTP3jdzE
	vEwQVFWXuuJYF/n/Sy8805kqB1kVugjpPfuS9yBoEtFnceLKH1KZ4EJhnbMLFDR46dJHfpGP2pv
	l8x5tMTcfjkPmiBfIu1juVkvJYpgCXfGkSoFowyiGRPlQ9J+FlUfGQV+OgI+xeSlTpKqcqu1tC5
	UMp0/5hzGydmkB5X3v8DxQ2IVWHWytne3JYHdkpqYmxGbk0/I2pml4nLs0PVm0imxjrubcplUeh
	pO21nuUfkh7QfQoF4BNPNQohIM0YHZ0q7i0q3OXI5rTKLTPJW2chwn4WHNhNpDxhV90Uml/gpqG
	ecBW/I5CcAUddHgg59aiQ2KyfKiq/ajcUdNAqeTDd2vKvHA+TltBVT6/Uqx0XkuJxtxVqPQ7nys
	sIApiJIrTfZ1ukxcTMkFev6jgnQBxGue9riR54VB1zBA176rwINfQ=
X-Received: by 2002:a05:600c:848a:b0:492:203f:a373 with SMTP id 5b1f17b1804b1-492203fa692mr65622485e9.29.1781433287075;
        Sun, 14 Jun 2026 03:34:47 -0700 (PDT)
Received: from [192.168.1.8] ([77.247.227.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2b0d4fsm24941093f8f.24.2026.06.14.03.34.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jun 2026 03:34:46 -0700 (PDT)
Message-ID: <661379f2-ccea-4021-8c31-958d490a00d8@streamunlimited.com>
Date: Sun, 14 Jun 2026 12:34:46 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ] gatt-client: Add PreferredNotifyType property
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
References: <20260608142050.3742000-1-simon.mikuda@streamunlimited.com>
 <CABBYNZL-A=NpnfiO9GO66TNX5QaEuvpSZ9fuBk0Jo+aNtr7huA@mail.gmail.com>
Content-Language: en-US
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
In-Reply-To: <CABBYNZL-A=NpnfiO9GO66TNX5QaEuvpSZ9fuBk0Jo+aNtr7huA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

I send a patch that will use notifications by default, when both 
indications+notifications are enabled.

I am not sure what is meant by this:

 > when an acknowledgment is not required by a higher-layer specification

in that case we should send indication, which was previous behavior...

On 6/8/26 17:21, Luiz Augusto von Dentz wrote:
> Hi Simon,
>
> On Mon, Jun 8, 2026 at 10:31 AM Simon Mikuda
> <simon.mikuda@streamunlimited.com> wrote:
>> When a characteristic supports both notifications and indications the
>> CCC we always register for notifications, leaving no way to choose
>> indications from D-Bus.
>>
>> Add PreferredNotifyType (string, "notification"/"indication") to
>> org.bluez.GattCharacteristic1, only present when both flags are set.
>> StartNotify() and AcquireNotify() honor it on the next CCC write.
>> ---
>>   doc/org.bluez.GattCharacteristic.rst | 21 +++++++
>>   src/gatt-client.c                    | 85 ++++++++++++++++++++++++++++
>>   src/shared/gatt-client.c             | 31 +++++++++-
>>   src/shared/gatt-client.h             |  3 +
>>   4 files changed, 138 insertions(+), 2 deletions(-)
>>
>> diff --git a/doc/org.bluez.GattCharacteristic.rst b/doc/org.bluez.GattCharacteristic.rst
>> index 805f39593..f7e541590 100644
>> --- a/doc/org.bluez.GattCharacteristic.rst
>> +++ b/doc/org.bluez.GattCharacteristic.rst
>> @@ -401,3 +401,24 @@ uint16 MTU [read-only]
>>
>>   Characteristic MTU, this is valid both for **ReadValue()** and **WriteValue()**
>>   but either method can use long procedures when supported.
>> +
>> +string PreferredNotifyType [readwrite, optional, experimental]
>> +``````````````````````````````````````````````````````````````
>> +
>> +Selects whether **StartNotify()** and **AcquireNotify()** enable notifications
>> +or indications when the characteristic supports both. Only present when both
>> +"notify" and "indicate" flags are set.
>> +
>> +Possible values:
>> +
>> +:"notification":
>> +
>> +       Enable notifications (CCC = 0x0001). Default.
>> +
>> +:"indication":
>> +
>> +       Enable indications (CCC = 0x0002).
>> +
>> +Note: the preference applies on the next CCC write. If another client has
>> +already enabled the CCC on this characteristic, the existing setting is kept
>> +and the new preference takes effect only after the last subscriber stops.
> Well the spec seems to have changed to allow setting both notify and
> indicate simultaneously as well:
>
> If both the Notification and Indication bits are set, then the server
> shall use the notification procedure (see Section 4.10) when an
> acknowledgment is not required by a higher-layer specification or
> shall use the indication procedure (see Section 4.11) when an
> acknowledgment is required. The server should not use both procedures
> to send the same characteristic value.
>
> So perhaps we need to handle that as well, that said I don't know if
> it wouldn't be more efficient to add another method which would enable
> passing the value directly rather modifying the
> StartNotify/AcquireNotify behavior, but then we would need to create a
> different interface name in order to break the existing methods, so
> maybe going wit this is better and we just need to handle 0x0003 as
> being both enabled and the server decides what to do with it.
>
>> diff --git a/src/gatt-client.c b/src/gatt-client.c
>> index 3baf95c4f..29564a87d 100644
>> --- a/src/gatt-client.c
>> +++ b/src/gatt-client.c
>> @@ -115,6 +115,7 @@ struct characteristic {
>>          struct queue *descs;
>>
>>          bool notifying;
>> +       bool prefer_indicate;
>>          struct queue *notify_clients;
>>   };
>>
>> @@ -1595,6 +1596,9 @@ static DBusMessage *characteristic_acquire_notify(DBusConnection *conn,
>>          if (!client)
>>                  return btd_error_failed(msg, "Failed allocate notify session");
>>
>> +       bt_gatt_client_set_notify_prefer_indicate(gatt, chrc->value_handle,
>> +                                                       chrc->prefer_indicate);
>> +
>>          client->notify_id = bt_gatt_client_register_notify(gatt,
>>                                                  chrc->value_handle,
>>                                                  register_notify_io_cb,
>> @@ -1673,6 +1677,9 @@ static DBusMessage *characteristic_start_notify(DBusConnection *conn,
>>
>>          op = async_dbus_op_new(msg, client);
>>
>> +       bt_gatt_client_set_notify_prefer_indicate(gatt, chrc->value_handle,
>> +                                                       chrc->prefer_indicate);
>> +
>>          client->notify_id = bt_gatt_client_register_notify(gatt,
>>                                                  chrc->value_handle,
>>                                                  register_notify_cb, notify_cb,
>> @@ -1719,6 +1726,76 @@ static DBusMessage *characteristic_stop_notify(DBusConnection *conn,
>>          return dbus_message_new_method_return(msg);
>>   }
>>
>> +static gboolean
>> +characteristic_get_prefer_notify_type(const GDBusPropertyTable *property,
>> +                                       DBusMessageIter *iter, void *data)
>> +{
>> +       struct characteristic *chrc = data;
>> +       const char *str = chrc->prefer_indicate ? "indication" : "notification";
>> +
>> +       dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &str);
>> +
>> +       return TRUE;
>> +}
>> +
>> +static void
>> +characteristic_set_prefer_notify_type(const GDBusPropertyTable *property,
>> +                                       DBusMessageIter *iter,
>> +                                       GDBusPendingPropertySet id, void *data)
>> +{
>> +       struct characteristic *chrc = data;
>> +       struct bt_gatt_client *gatt = chrc->service->client->gatt;
>> +       const char *str;
>> +       bool prefer;
>> +
>> +       if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_STRING) {
>> +               g_dbus_pending_property_error(id,
>> +                                       ERROR_INTERFACE ".InvalidArguments",
>> +                                       "Invalid arguments in method call");
>> +               return;
>> +       }
>> +
>> +       dbus_message_iter_get_basic(iter, &str);
>> +
>> +       if (!strcmp(str, "notification"))
>> +               prefer = false;
>> +       else if (!strcmp(str, "indication"))
>> +               prefer = true;
>> +       else {
>> +               g_dbus_pending_property_error(id,
>> +                                       ERROR_INTERFACE ".InvalidArguments",
>> +                                       "Invalid arguments in method call");
>> +               return;
>> +       }
>> +
>> +       if (chrc->prefer_indicate == prefer) {
>> +               g_dbus_pending_property_success(id);
>> +               return;
>> +       }
>> +
>> +       chrc->prefer_indicate = prefer;
>> +
>> +       if (gatt)
>> +               bt_gatt_client_set_notify_prefer_indicate(gatt,
>> +                                               chrc->value_handle, prefer);
>> +
>> +       g_dbus_emit_property_changed(btd_get_dbus_connection(), chrc->path,
>> +                                       GATT_CHARACTERISTIC_IFACE,
>> +                                       "PreferredNotifyType");
>> +
>> +       g_dbus_pending_property_success(id);
>> +}
>> +
>> +static gboolean
>> +characteristic_prefer_notify_type_exists(const GDBusPropertyTable *property,
>> +                                       void *data)
>> +{
>> +       struct characteristic *chrc = data;
>> +
>> +       return (chrc->props & BT_GATT_CHRC_PROP_NOTIFY) &&
>> +                               (chrc->props & BT_GATT_CHRC_PROP_INDICATE);
>> +}
>> +
>>   static const GDBusPropertyTable characteristic_properties[] = {
>>          { "Handle", "q", characteristic_get_handle },
>>          { "UUID", "s", characteristic_get_uuid, NULL, NULL },
>> @@ -1733,6 +1810,10 @@ static const GDBusPropertyTable characteristic_properties[] = {
>>          { "NotifyAcquired", "b", characteristic_get_notify_acquired, NULL,
>>                                  characteristic_notify_acquired_exists },
>>          { "MTU", "q", characteristic_get_mtu, NULL, characteristic_mtu_exists },
>> +       { "PreferredNotifyType", "s", characteristic_get_prefer_notify_type,
>> +                               characteristic_set_prefer_notify_type,
>> +                               characteristic_prefer_notify_type_exists,
>> +                               G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
>>          { }
>>   };
>>
>> @@ -2282,6 +2363,10 @@ static void register_notify(void *data, void *user_data)
>>          op = new0(struct async_dbus_op, 1);
>>          op->data = notify_client;
>>
>> +       bt_gatt_client_set_notify_prefer_indicate(client->gatt,
>> +                                       notify_client->chrc->value_handle,
>> +                                       notify_client->chrc->prefer_indicate);
>> +
>>          notify_client->notify_id = bt_gatt_client_register_notify(client->gatt,
>>                                          notify_client->chrc->value_handle,
>>                                          register_notify_cb, notify_cb,
>> diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
>> index a6abe8ac2..403d22758 100644
>> --- a/src/shared/gatt-client.c
>> +++ b/src/shared/gatt-client.c
>> @@ -217,6 +217,7 @@ struct notify_chrc {
>>          uint16_t properties;
>>          unsigned int notify_id;
>>          int notify_count;  /* Reference count of registered notify callbacks */
>> +       bool prefer_indicate;
>>
>>          /* Pending calls to register_notify are queued here so that they can be
>>           * processed after a write that modifies the CCC descriptor.
>> @@ -1671,9 +1672,13 @@ static bool notify_data_write_ccc(struct notify_data *notify_data, bool enable,
>>
>>          if (enable) {
>>                  /* Try to enable notifications or indications based on
>> -                * whatever the characteristic supports.
>> +                * whatever the characteristic supports. If both are
>> +                * available honor the per-chrc prefer_indicate flag.
>>                   */
>> -               if (properties & BT_GATT_CHRC_PROP_NOTIFY)
>> +               if (notify_data->chrc->prefer_indicate &&
>> +                               (properties & BT_GATT_CHRC_PROP_INDICATE))
>> +                       value = cpu_to_le16(0x0002);
>> +               else if (properties & BT_GATT_CHRC_PROP_NOTIFY)
>>                          value = cpu_to_le16(0x0001);
>>                  else if (properties & BT_GATT_CHRC_PROP_INDICATE)
>>                          value = cpu_to_le16(0x0002);
>> @@ -3838,6 +3843,28 @@ unsigned int bt_gatt_client_register_notify(struct bt_gatt_client *client,
>>                                                          user_data, destroy);
>>   }
>>
>> +bool bt_gatt_client_set_notify_prefer_indicate(struct bt_gatt_client *client,
>> +                                               uint16_t value_handle,
>> +                                               bool prefer)
>> +{
>> +       struct notify_chrc *chrc;
>> +
>> +       if (!client || !client->db || !value_handle)
>> +               return false;
>> +
>> +       chrc = queue_find(client->notify_chrcs, match_notify_chrc_value_handle,
>> +                                               UINT_TO_PTR(value_handle));
>> +       if (!chrc) {
>> +               chrc = notify_chrc_create(client, value_handle);
>> +               if (!chrc)
>> +                       return false;
>> +       }
>> +
>> +       chrc->prefer_indicate = prefer;
>> +
>> +       return true;
>> +}
>> +
>>   bool bt_gatt_client_unregister_notify(struct bt_gatt_client *client,
>>                                                          unsigned int id)
>>   {
>> diff --git a/src/shared/gatt-client.h b/src/shared/gatt-client.h
>> index 63cf99500..0d08f8014 100644
>> --- a/src/shared/gatt-client.h
>> +++ b/src/shared/gatt-client.h
>> @@ -124,6 +124,9 @@ unsigned int bt_gatt_client_register_notify(struct bt_gatt_client *client,
>>                                  bt_gatt_client_destroy_func_t destroy);
>>   bool bt_gatt_client_unregister_notify(struct bt_gatt_client *client,
>>                                                          unsigned int id);
>> +bool bt_gatt_client_set_notify_prefer_indicate(struct bt_gatt_client *client,
>> +                                               uint16_t value_handle,
>> +                                               bool prefer);
>>
>>   bool bt_gatt_client_set_security(struct bt_gatt_client *client, int level);
>>   int bt_gatt_client_get_security(struct bt_gatt_client *client);
>> --
>> 2.43.0
>>
>>
>
