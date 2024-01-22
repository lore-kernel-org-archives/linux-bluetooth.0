Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A1D3D99D
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jan 2024 15:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705938639; cv=none; b=AaO89RSm67rAayZlAgc+0Jr8LhnLREFdO194dw1jJ3bEOtvTrIKfJivTK5F8hUBUnZlCPD8ospLHuQ6aLd1oNZkIkdN0+pJu4C8LuNjg/fOKkTvQQZewhtcEc/8T1T0HSS/sgO7bnbFlnNjUwqv1xAwM2kKrtNVX14q59O9BMLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705938639; c=relaxed/simple;
	bh=TE+LRlGonhbK58aDKvIydqV+YdH3ggL1RBjYn30QFf8=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=E5ciAGEW+rxATcaA5Mu6jzGnUAzI0pbLwI9OlLMgk9gOxb8iZnUwo1BVeFyQssM3Sik5SBOIgwRfxsEPyVjONm5OeMccX6j13+tohinpW5Oips8yoZmWUNDBnNEYb3TSZ9HOA7TdJhmtcu+hhiHbaI3IAOBekU8r038TWpQa0CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mobile-devices.fr; spf=pass smtp.mailfrom=mobile-devices.fr; dkim=pass (1024-bit key) header.d=mobile-devices.fr header.i=@mobile-devices.fr header.b=XOXBV+8X; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mobile-devices.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobile-devices.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mobile-devices.fr header.i=@mobile-devices.fr header.b="XOXBV+8X"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40eaf973eb4so8362825e9.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jan 2024 07:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mobile-devices.fr; s=google; t=1705938634; x=1706543434; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ETEwehMrlhMkIWkqbaE15na/+a2CO5zZeL8Rq9KL9C0=;
        b=XOXBV+8XF1DtYPou7XGNDRX70yOvgxcsRS1gYDa4LeTGfs2J4vzoJRoyGuDraos4jq
         d9X4gdkMGkP41Zh6k1vMXmL+u35kUYOCCj/sOZeGR0r/d1tu3el14btEFfHQRncUy2kF
         Kq5qwBtP0+6fk0DkrdnMs1onu87iZ3jJusPVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705938634; x=1706543434;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ETEwehMrlhMkIWkqbaE15na/+a2CO5zZeL8Rq9KL9C0=;
        b=CSNIS6K88dkq0U7WB1xGLXBIqLA4gIv6OsHvuNGicvQIohMdofjAq8a4WYmTy46y+l
         X+Z+ce6KxipOI98HKY/UBpdLKFR/wzdSiRr0dRASUpXAodqLv0RY3c9sJH5OOH04HKyX
         yzDyrWqeqUvCVrANzf1pnPQPwXMkt+4JEHYWfM/NEPvImWhUvQi3Eu7nh7lP/kiLSHlB
         BYMvn3zpmadiTTNnpZG+b5KXJF/79Q5qFE1Bu4gQdNK1Yxp0vbtjweCFQrJ3wcEvDcR2
         8hIB+48wmelY1dvtlgXEGUKZSDh5YdglrgpDrmgSxaFOeethyE5EcyuFsBr6QFXCZHlR
         7ETA==
X-Gm-Message-State: AOJu0YzSHTTBFSv64Ms6muKWUZJ16hCwaTq9eMawylkF40rVnfVKmIWx
	aXCdnOkBag7ZRbY7LInbI+Qk+jc7XoUw56j493zlkf+o1c4KGW9sfa6TAXmWAK8=
X-Google-Smtp-Source: AGHT+IGHG9K/hA6sCBkoirPSCq5vCvUij3RHCV1UR3vAMyinMx1hp55Muh6cy4IIQOHDi9qUOR3XTw==
X-Received: by 2002:a05:600c:468b:b0:40e:85e9:7404 with SMTP id p11-20020a05600c468b00b0040e85e97404mr2429829wmo.125.1705938633930;
        Mon, 22 Jan 2024 07:50:33 -0800 (PST)
Received: from [10.42.100.11] (static-qvn-qvs-183113.business.bouyguestelecom.com. [89.87.183.113])
        by smtp.gmail.com with ESMTPSA id f6-20020a05600c4e8600b0040d6ffae526sm43743168wmq.39.2024.01.22.07.50.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 07:50:33 -0800 (PST)
From: Andrei Volkov <andrey.volkov@mobile-devices.fr>
X-Google-Original-From: Andrei Volkov <andrey.volkov@munic.io>
Message-ID: <810c8fcc-95a5-4117-afbc-91d201398004@munic.io>
Date: Mon, 22 Jan 2024 16:50:33 +0100
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
 <747030d8-a06f-4d7d-bf93-0e95f54b9bbf@munic.io>
 <CABBYNZ+4fb3FbEPe41gQuRBNG3jNARakfSqvqB2j8wKZ3J92fQ@mail.gmail.com>
Organization: MUNIC
In-Reply-To: <CABBYNZ+4fb3FbEPe41gQuRBNG3jNARakfSqvqB2j8wKZ3J92fQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Luiz,

Le 22/01/2024 à 16:10, Luiz Augusto von Dentz a écrit :

> Hi Andrei,
>
> On Mon, Jan 22, 2024 at 9:45 AM Andrei Volkov
> <andrey.volkov@mobile-devices.fr> wrote:
>> Hi Luiz,
>>
>> Wouldn't it be better to add a 'yet-another' flag as an addition to
>> HCI_CONN_SSP_ENABLED, and clear it unconditionally at the top of
>> 'hci_remote_ext_features_evt', before
>>
>> "        conn = hci_conn_hash_lookup_handle"
>>
>> check?
>>
>> In this case broken ext_features response (with ev->status != 0 or conn
>> == NULL) will not indirectly enable the SSP feature.
> HCI_CONN_SSP_ENABLED is already at conn level, besides that it is too
> late to clear it if the SSP procedure has already taken place and on
> top of it I don't want to change the code too much and risk having
> more regressions like this.
>
> Btw, something tells me that Android is not actually doing the
> HCI_OP_READ_REMOTE_EXT_FEATURES since we do have CI testing SSP and
> this change hasn't cause us any problems, do you know what command it
> uses? Perhaps it tries SSP right-away or does it cache the previous
> response?
>
The real problem is that since the ext. device does not receive a 
response to the IO request (cmd 0x31) from BlueZ, it refuses to continue 
the pairing. But with proposed reverting the ssp check, we are probably 
coming back to the initial href problem.

Btw, for me it's unclear how the additional check in 
"hci_io_capa_request_evt" helps with href undderrun. It looks like the 
original FSM implementation is missing something, and the fix actually 
is masking the problem.

Regards
Andrei VOLKOV

>> Regards
>> Andrei VOLKOV
>>
>> Le 22/01/2024 à 15:02, Luiz Augusto von Dentz a écrit :
>>
>>> Hi Andrei,
>>>
>>> On Mon, Jan 22, 2024 at 7:18 AM Andrei Volkov
>>> <andrey.volkov@mobile-devices.fr> wrote:
>>>> Hello,
>>>>
>>>> Lately we've bumped with regression introduced by commit:
>>>>
>>>>     c7f59461f5a78 ("Bluetooth: Fix a refcnt underflow problem for
>>>> hci_conn", 2023-10-04)
>>>>
>>>> The regression related with adding "hci_conn_ssp_enabled()" check in
>>>> "hci_io_capa_request_evt()" handler, and broke pairing process initiated
>>>> by the external device.
>>>>
>>>> Precisely, some ext. devices, like any phone equipped with Android ver <
>>>> 14 (we have not latest one, so we didn't check), always send "IO
>>>> Capability Request" before "Read Remote Extended Features" command, as
>>>> consequence the flag "HCI_CONN_SSP_ENABLED" not yet activated at the
>>>> time of "hci_io_capa_request_evt()" execution  and
>>>> "hci_conn_ssp_enabled()" always returns false in time of the pairing.
>>>>
>>>> As a result, pairing always fails. The quick and dirty fix is revert the
>>>> ssp check introduced in the subj. commit, like below:
>>>>
>>>> --- a/net/bluetooth/hci_event.c
>>>> +++ b/net/bluetooth/hci_event.c
>>>> @@ -5329,7 +5329,7 @@ static void hci_io_capa_request_evt(struct hci_dev
>>>> *hdev, void *data,
>>>>            hci_dev_lock(hdev);
>>>>
>>>>            conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &ev->bdaddr);
>>>> -       if (!conn || !hci_conn_ssp_enabled(conn))
>>>> +       if (!conn)
>>>>                    goto unlock;
>>>>
>>>>            hci_conn_hold(conn);
>>>>
>>>>
>>>> However, a more thorough and correct fix requires discussion and
>>>> testing. Therefore, I would like to get any comments/suggestion from the
>>>> community before doing this.
>>> I think we need to do something like this, so we consider only the
>>> local SSP flag when evaluating if we should proceed to respond or just
>>> drop:
>>>
>>> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
>>> index 6130c969f361..a15924db83d9 100644
>>> --- a/net/bluetooth/hci_event.c
>>> +++ b/net/bluetooth/hci_event.c
>>> @@ -5327,9 +5327,12 @@ static void hci_io_capa_request_evt(struct
>>> hci_dev *hdev, void *data,
>>>           hci_dev_lock(hdev);
>>>
>>>           conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &ev->bdaddr);
>>> -       if (!conn || !hci_conn_ssp_enabled(conn))
>>> +       if (!conn || !hci_dev_test_flag(hdev, HCI_SSP_ENABLED))
>>>                   goto unlock;
>>>
>>> +       /* Assume remote supports SSP since it has triggered this event */
>>> +       set_bit(HCI_CONN_SSP_ENABLED, &conn->flags);
>>> +
>>>           hci_conn_hold(conn);
>>>
>>>           if (!hci_dev_test_flag(hdev, HCI_MGMT))
>>>
>>>
>>>> Regards
>>>> Andrey VOLKOV
>>>>
>>>>
>
>
