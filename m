Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562F43D4100
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Mar 2026 15:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773070844; cv=none; b=nIhKK6wugF0mvvcrnoqsBbpZrAJqSVVKrOlfmdS5JZjTk6OJ/6MLRDunu/+OFq8Q+zYRIHgkjeHJP5S6hWsHAUB50orNWqP0TuXv7wQV0e6UVJEQslqO7Z8M0dsZ5wKpWAwXb1sM4Ljp26t5/jmhVt6cQain0uuKgzZv4GpberI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773070844; c=relaxed/simple;
	bh=m7AI5+ftEf9xPy9nHicy9orP/GpjH7d8G+CJY3lmlUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nTEAFYopkaLmaJxpJBOaSM17Y/72VlO2Z+14RKyFxMuitelpORCWruenOn0t3GUh80SQP0JBRq3ssWtX0TNRZMqiugN18KvglZ5TgKrKFMCtj9gwV4oR28DiAn/b3W3iN2eKk9I37GxxqUG2OvoMUT2NCaZJHnpDcLjXEPby22c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=martinbts@gmx.net header.b=MdETHHlf; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=martinbts@gmx.net header.b="MdETHHlf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1773070837; x=1773675637; i=martinbts@gmx.net;
	bh=H7GBvnFToXGGP0qxx5tUSSBjY6hyMdqvA4Z1pUKDXas=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=MdETHHlfDccQKUtYIdKhE8SzESlTuZ17VH6AOBjY//AJTURaATu306JVIwvUhkuq
	 KNjARjeTvP/BJP0avgeT0m1K3ILmKCDfUFxxOruvUEVVP5SWv8/p3r7Uu4HPOrwLt
	 NtnrFX5GQUPkGXfkezlIXSjPDbPAVeJgnviW2OG3NKDTAH/XrAFNUaE5nOXddDBeE
	 aK0zHiTk5ci40GOct/WzIqDn9Portz7RKdQRhW9bjIeqGGFEL/9KqteP9WvaqElSx
	 UNiqY1QfB9QJ8eX1aGKRwkv6poqgyFahftPr8w8g5nR9D6a2MxXgbVVRQwzgliWOs
	 TUP2DMu0xzceHoQZ9g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MXXuH-1w99sQ3CUZ-00MMke; Mon, 09
 Mar 2026 16:40:37 +0100
Message-ID: <3c1516de-c89c-45a6-ad76-50d6360c1a74@gmx.net>
Date: Mon, 9 Mar 2026 16:40:37 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ v2 1/6] shared/gatt: make secondary discovery
 optional
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, hadess@hadess.net, vi@endrift.com,
 Martin BTS <martinbts@gmx.net>
References: <20260308124745.19248-1-martinbts@gmx.net>
 <20260308124745.19248-2-martinbts@gmx.net>
 <CABBYNZKbyTFDyogUi_5UGTKgR0syOgPCqgokMJa04vS4G-uUWA@mail.gmail.com>
Content-Language: en-US
From: Martin BTS <martinbts@gmx.net>
In-Reply-To: <CABBYNZKbyTFDyogUi_5UGTKgR0syOgPCqgokMJa04vS4G-uUWA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yGNHTGYVPG4Qtle1lGuGgCV2TpV8bQADA5rPa2QUfjmUWujVhTx
 SvhjKNt2G3/XActlaUjMPbtKcoiT5zeg3FZDYKZYfQ93qRm1MAoNKbNlNfZxpM++aeFWo4g
 zrFVB8ZPxPrtit3bju2bhUbMrW0UJxThP1jhd9xdWF9mlTv08HZ1WMWcLcJ0nuTb+Sk7kv1
 SZwyKeaefAitGr7u2TSsQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Pda1qND8suM=;NB2jM/TNL1EvKBmAN8EBdQ9hl/m
 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
 n27XW+CM99MoWQD369qA

Hi Luiz!

On 09.03.26 14:58, Luiz Augusto von Dentz wrote:
> Hi Martin,
>
> On Sun, Mar 8, 2026 at 8:48=E2=80=AFAM Martin BTS <martinbts@gmx.net> wr=
ote:
>> BREAKING CHANGE!
>>
>> * Remove gatt_client_init from bt_gatt_client_new. Consumers must now
>>    call gatt_client_init themselves!
>> * Remove mtu paramter from bt_gatt_client_new
> Why?

The only thing bt_gatt_client_new did with this parameter was to pass it=
=20
on to gatt_client_init. Since the latter is no longer part of=20
bt_gatt_client_init, the parameter is never used.

When implementing that, my approach was to squeeze in between _new()=20
populating the struct and the invocation of _init(). I did that by=20
splitting _init() from _new() which allows consumers to configure the=20
newly created client, before calling _init(), which implicitly does the=20
primary and secondary discovery.

With a few hours between me and me writing that ... I guess since I am=20
changing the interface anyways, I could just as well have added=20
skip_secondary as an additional parameter to bt_gatt_client_new(), which=
=20
would store it in its bt_gatt_client before calling _init(). Would still=
=20
break the interface, but would have resulted in a fewer lines of code.

>> * Rename gatt_client_init to bt_gatt_client_init and make it public
>> * Introduce a new bt_gatt_client field "skip_secondary", default false
>> * Introduce public skip_secondary setter
>> * If true, skip_secondary makes discover_primary_cb goto done
>>    (instead of discoverying secondary services)
> Overengineer, this could probably be handled gracefully internally.
> Maybe have a short timeout, e.g. 2 seconds, and if the device doesn't
> respond, continue as if it was ignored or something like that.

I have virtually no experience with bluetooth and rely on your=20
expertise. In=20
https://lore.kernel.org/all/CABBYNZLNJnnO+WUQCgzZ2BvgCqftvsSbX3qKDh=3DfZcf=
m-KQf5Q@mail.gmail.com/=20
you point out the importance of the current spec compliance and said we=20
"need a configuration setting, which should probably default to=20
compliance". Do you want me to introduce a 2 second timeout instead of=20
the configuration setting? Please advise.

>> ---
>>   src/shared/gatt-client.c | 22 ++++++++++++++--------
>>   src/shared/gatt-client.h |  4 +++-
>>   2 files changed, 17 insertions(+), 9 deletions(-)
>>
>> diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
>> index df1541b88..7896ed329 100644
>> --- a/src/shared/gatt-client.c
>> +++ b/src/shared/gatt-client.c
>> @@ -93,6 +93,7 @@ struct bt_gatt_client {
>>          struct queue *notify_chrcs;
>>          int next_reg_id;
>>          unsigned int disc_id, nfy_id, nfy_mult_id, ind_id;
>> +       bool skip_secondary;
>>
>>          /*
>>           * Handles of the GATT Service and the Service Changed charact=
eristic
>> @@ -1344,7 +1345,7 @@ secondary:
>>           * functionality of a device and is referenced from at least o=
ne
>>           * primary service on the device.
>>           */
>> -       if (queue_isempty(op->pending_svcs))
>> +       if (queue_isempty(op->pending_svcs) || client->skip_secondary)
>>                  goto done;
>>
>>          /* Discover secondary services */
>> @@ -2106,7 +2107,7 @@ done:
>>          notify_client_ready(client, success, att_ecode);
>>   }
>>
>> -static bool gatt_client_init(struct bt_gatt_client *client, uint16_t m=
tu)
>> +bool bt_gatt_client_init(struct bt_gatt_client *client, uint16_t mtu)
>>   {
>>          struct discovery_op *op;
>>
>> @@ -2549,7 +2550,6 @@ fail:
>>
>>   struct bt_gatt_client *bt_gatt_client_new(struct gatt_db *db,
>>                                                          struct bt_att =
*att,
>> -                                                       uint16_t mtu,
>>                                                          uint8_t featur=
es)
>>   {
>>          struct bt_gatt_client *client;
>> @@ -2561,11 +2561,6 @@ struct bt_gatt_client *bt_gatt_client_new(struct=
 gatt_db *db,
>>          if (!client)
>>                  return NULL;
>>
>> -       if (!gatt_client_init(client, mtu)) {
>> -               bt_gatt_client_free(client);
>> -               return NULL;
>> -       }
>> -
>>          return bt_gatt_client_ref(client);
>>   }
>>
>> @@ -2592,6 +2587,17 @@ struct bt_gatt_client *bt_gatt_client_clone(stru=
ct bt_gatt_client *client)
>>          return bt_gatt_client_ref(clone);
>>   }
>>
>> +bool bt_gatt_client_set_skip_secondary(struct bt_gatt_client *client,
>> +                                                               bool sk=
ip)
>> +{
>> +       if (!client)
>> +               return false;
>> +
>> +       client->skip_secondary =3D skip;
>> +
>> +       return true;
>> +}
>> +
>>   struct bt_gatt_client *bt_gatt_client_ref(struct bt_gatt_client *clie=
nt)
>>   {
>>          if (!client)
>> diff --git a/src/shared/gatt-client.h b/src/shared/gatt-client.h
>> index 63cf99500..e510ad455 100644
>> --- a/src/shared/gatt-client.h
>> +++ b/src/shared/gatt-client.h
>> @@ -18,9 +18,11 @@ struct bt_gatt_client;
>>
>>   struct bt_gatt_client *bt_gatt_client_new(struct gatt_db *db,
>>                                                          struct bt_att =
*att,
>> -                                                       uint16_t mtu,
>>                                                          uint8_t featur=
es);
>>   struct bt_gatt_client *bt_gatt_client_clone(struct bt_gatt_client *cl=
ient);
>> +bool bt_gatt_client_init(struct bt_gatt_client *client, uint16_t mtu);
>> +bool bt_gatt_client_set_skip_secondary(struct bt_gatt_client *client,
>> +                                                               bool sk=
ip);
>>
>>   struct bt_gatt_client *bt_gatt_client_ref(struct bt_gatt_client *clie=
nt);
>>   void bt_gatt_client_unref(struct bt_gatt_client *client);
>> --
>> 2.47.3
>>
>
