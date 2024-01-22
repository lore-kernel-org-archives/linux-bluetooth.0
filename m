Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2493620DF0
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jan 2024 14:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705934754; cv=none; b=YSADQzioXyVzIEQxI8O9zb7Z6NMjLLCao7hAYRHzMtMPLTQ/ci9eflfqNeSlVK/uOAj0div6c/Jjb170vBYprD69Wj5phNxxn31Ssg1ChfH1dJk4QmhvYB4UwOr7WS1wzhbAFXgEHfhhL4GcSkgCrkNRVvK4dp/3os4T9ABS2mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705934754; c=relaxed/simple;
	bh=GogtZwYgHxZ/f05d4Wz2aHemGMxZcczpVrQmPLbn3gQ=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=H/ltGY/6/gQc+fU0jmvUdQBxDXruTNLPwbIgw0+TlMeTuZ1VHpN7G1DhaM3ukH4sReX31qSQd9Q8GIw0KkpaXizlk1jt/AThLOKcknXHWOKNnwYENzFv6MdXjgoQ5iEsegBPDOGvq9tHshgj3k1m5IcqwYRpLZq6VbsRI8acdAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mobile-devices.fr; spf=pass smtp.mailfrom=mobile-devices.fr; dkim=pass (1024-bit key) header.d=mobile-devices.fr header.i=@mobile-devices.fr header.b=gcbuAl/v; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mobile-devices.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobile-devices.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mobile-devices.fr header.i=@mobile-devices.fr header.b="gcbuAl/v"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40e490c2115so25911385e9.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jan 2024 06:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mobile-devices.fr; s=google; t=1705934749; x=1706539549; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=EqXCKGHnXT0KXUzsFLxHmOxEpLgsFzriqXWJ5Er7ri4=;
        b=gcbuAl/vI3XVLcKWWdhC/nuxDYZEe4MIeCS/Gt8gcnIh4+ETR/oS4Yi25UCqElh4yu
         qZq1scN2Zj6bBIm2xCgWf4LW/VzsavcPHzvH3Hp9QjcHRixl1k8ZnPRRB5irGMVDibDk
         Ota1sO1jNC5LV9c0MFoxmfuQT+l9sWbo0ZXXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705934749; x=1706539549;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EqXCKGHnXT0KXUzsFLxHmOxEpLgsFzriqXWJ5Er7ri4=;
        b=M9I6AZiE6npSh7I0Ca8PDvEQG2BIU2oGmm8mzRWcxc+zGVQ4MCsnI4T8fxas/XdolI
         pZco1+3QEs99cWlo0PdQx5e/+8dTSKxr2FkJ/K4USrY3y9JrWX4IVorcig537nnuigC+
         Z3O2sJH2GW/SY495CiA59BlHL8DcwdsUAXYTPlEsgXZ0Zea/NLVFAB/H+kioBZ9nqlnG
         MqYLRX9+w10SUHYkyMYmhxiMOAi1+uJxMUW6nY6ey9k4EFAhdCy01HFR1ddEZBkWo7Ls
         th3WWJvzl70PqP7tnCWFDT9IgZkKmAbuoMIn5aEtHtf8Abas+ns77unIGe3ocaB1xNlP
         hFyQ==
X-Gm-Message-State: AOJu0YwP/oRuowZc6eOobubt5Y13nCygzQnWD8EubOXmaRyP0W+qGO+u
	nz0aRL/ajqFbEu1A24pzTmmAe13f2nQn543iW37btw2tyuDpjNtFuuZvi4RYT9jE99ZPXHjgZo+
	m
X-Google-Smtp-Source: AGHT+IHXtIeJxm9mMTn6wd31jUzltopX5xVfNhoayNXfAsWRMfgYHgpSnk2xOW8nlicwJfNS/W7boQ==
X-Received: by 2002:a05:600c:3109:b0:40e:8655:d48f with SMTP id g9-20020a05600c310900b0040e8655d48fmr2881890wmo.11.1705934749151;
        Mon, 22 Jan 2024 06:45:49 -0800 (PST)
Received: from [10.42.100.11] (static-qvn-qvs-183113.business.bouyguestelecom.com. [89.87.183.113])
        by smtp.gmail.com with ESMTPSA id jd21-20020a05622a719500b0042a41b27d3fsm740877qtb.90.2024.01.22.06.45.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 06:45:48 -0800 (PST)
From: Andrei Volkov <andrey.volkov@mobile-devices.fr>
X-Google-Original-From: Andrei Volkov <andrey.volkov@munic.io>
Message-ID: <747030d8-a06f-4d7d-bf93-0e95f54b9bbf@munic.io>
Date: Mon, 22 Jan 2024 15:45:46 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: regression in c7f59461f5a78: Bluetooth: Fix a refcnt underflow
 problem for hci_conn
Content-Language: en-US, fr
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
References: <a3a31b2d-6039-4b50-af81-47f7ea1a0461@munic.io>
 <CABBYNZ+9UdG1cMZVmdtN3U2aS16AKMCyTARZZyFX7xTEDWcMOw@mail.gmail.com>
Organization: MUNIC
In-Reply-To: <CABBYNZ+9UdG1cMZVmdtN3U2aS16AKMCyTARZZyFX7xTEDWcMOw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Luiz,

Wouldn't it be better to add a 'yet-another' flag as an addition to 
HCI_CONN_SSP_ENABLED, and clear it unconditionally at the top of 
'hci_remote_ext_features_evt', before

"        conn = hci_conn_hash_lookup_handle "

check?

In this case broken ext_features response (with ev->status != 0 or conn 
== NULL) will not indirectly enable the SSP feature.

Regards
Andrei VOLKOV

Le 22/01/2024 à 15:02, Luiz Augusto von Dentz a écrit :

> Hi Andrei,
>
> On Mon, Jan 22, 2024 at 7:18 AM Andrei Volkov
> <andrey.volkov@mobile-devices.fr> wrote:
>> Hello,
>>
>> Lately we've bumped with regression introduced by commit:
>>
>>    c7f59461f5a78 ("Bluetooth: Fix a refcnt underflow problem for
>> hci_conn", 2023-10-04)
>>
>> The regression related with adding "hci_conn_ssp_enabled()" check in
>> "hci_io_capa_request_evt()" handler, and broke pairing process initiated
>> by the external device.
>>
>> Precisely, some ext. devices, like any phone equipped with Android ver <
>> 14 (we have not latest one, so we didn't check), always send "IO
>> Capability Request" before "Read Remote Extended Features" command, as
>> consequence the flag "HCI_CONN_SSP_ENABLED" not yet activated at the
>> time of "hci_io_capa_request_evt()" execution  and
>> "hci_conn_ssp_enabled()" always returns false in time of the pairing.
>>
>> As a result, pairing always fails. The quick and dirty fix is revert the
>> ssp check introduced in the subj. commit, like below:
>>
>> --- a/net/bluetooth/hci_event.c
>> +++ b/net/bluetooth/hci_event.c
>> @@ -5329,7 +5329,7 @@ static void hci_io_capa_request_evt(struct hci_dev
>> *hdev, void *data,
>>           hci_dev_lock(hdev);
>>
>>           conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &ev->bdaddr);
>> -       if (!conn || !hci_conn_ssp_enabled(conn))
>> +       if (!conn)
>>                   goto unlock;
>>
>>           hci_conn_hold(conn);
>>
>>
>> However, a more thorough and correct fix requires discussion and
>> testing. Therefore, I would like to get any comments/suggestion from the
>> community before doing this.
> I think we need to do something like this, so we consider only the
> local SSP flag when evaluating if we should proceed to respond or just
> drop:
>
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 6130c969f361..a15924db83d9 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -5327,9 +5327,12 @@ static void hci_io_capa_request_evt(struct
> hci_dev *hdev, void *data,
>          hci_dev_lock(hdev);
>
>          conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &ev->bdaddr);
> -       if (!conn || !hci_conn_ssp_enabled(conn))
> +       if (!conn || !hci_dev_test_flag(hdev, HCI_SSP_ENABLED))
>                  goto unlock;
>
> +       /* Assume remote supports SSP since it has triggered this event */
> +       set_bit(HCI_CONN_SSP_ENABLED, &conn->flags);
> +
>          hci_conn_hold(conn);
>
>          if (!hci_dev_test_flag(hdev, HCI_MGMT))
>
>
>> Regards
>> Andrey VOLKOV
>>
>>
>
