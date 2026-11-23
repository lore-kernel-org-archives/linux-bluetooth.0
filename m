Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795446875;
	b=KFb/ZWeBjASBBp3UOsCCNlz6ISR/fWSxwDg1VyQO1zkbfvyp8HuDGBKcStqwDW09zXtq
	 09pP92+2hXRGkZqxE94lQffUI8xPM1Jyoin7GGtNDuQ+vGVKBL9DaHgLAAZ5h/pdPMzKb
	 3x9tl6tlHrv7ZWpAFiCN1Petu0mpTl/6bAwdMZs1bbyHAPIheLL2pYWlGoeZXGtBBYzwh
	 tb3FDYqMaEC6AhgtqUqyoHgAwZJBjh/0u7qRqIFrBymUhua0pQM5wJE2dMt26IyLoSUBG
	 cJG1p4m2qd7IdOBanEn46gJXh/p4HNkWdy5P3vE6DWJVEDG0XLsiLhJtEuS1c9hKWGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795446875;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=GO05yt5rk+WYlek4MPUa95QDqn4B7yTt1qZfcKMFYcc=;
	b=h52YRwFTbLnfGgJO/No0IGwt6W0CkarHSHMyJtOfLORNTBzkBkSbCcyfKsERjtGtSxrx
	 wRh3iA/+CQgfoLmD3NoGY1durHrr7fzRDFXp4ja1NHqfMpzWuwyldO1aXEcNoi5L9frej
	 F4k4ngpeCGlF/a+ak/2m6mkL65ij/RSwqrPKxkz27BJ4SUgRW8/4GFMiYxraDa5aFBH+6
	 toAnQo2PwQQANXvuYTHstz/FA+R15cnwQ7PJiHl9NRCMhwODe8wEmfDGSgVzk8+PhU738
	 vA42e5oM7u1exeWlpNd+h9sYzEaxmMNz7tqc2Z0nqh3EPUb6RembQLo20mvIpqWAJSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=bFu7S9Kt;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF6F606A31A
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 15:14:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCF6F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=bFu7S9Kt
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-49412eb1474so2177558f8f.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 07:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795446873; x=1796051673; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GO05yt5rk+WYlek4MPUa95QDqn4B7yTt1qZfcKMFYcc=;
        b=bFu7S9Kt6AoadKSFbmcFYpodnjVxU+GcUVySK+t8rGFMPqDKREQgV38R6SHQAffEYU
         VFbffSjp+DDCh2p1H7PMNn4SZ1vYQI1VUIuQOSxd1mB0LCmrL6lIhx8goT7pi8TAgFsq
         Jp9p+yso5hX9FaGaFKQg2IWvSOAUC79t7EYzk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795446873; x=1796051673;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GO05yt5rk+WYlek4MPUa95QDqn4B7yTt1qZfcKMFYcc=;
        b=epNA8oTgirvmpaSM56UUQNS0UNik6+PyI8wNLQpnhulYvM1AV1dKiO2icILBlmlfUC
         ze8TgkRPABydDB9l15gcCm0UEzytlEoCn8yvKT8fy4klhouii9tTlga5zLHCLF0JSpWN
         zs4iJ1U6MOOIR08HkAJpFKsjDohfMqLSA/clYQ25Yw9CROPjaiLSLs4OVXIM7pEbOwq/
         +u58oO43kKd7kPYollYYMvqfHqmciUuBkr/ksyYosRhlg6clX+3WACOqrdOImbsULilL
         kLZ14jEuv7Xsb3GG2lXQFW/Dk1lc4ju1jdz5a2XtSELOOqnEq1KspKELYd8GbrRr9+Lr
         ktIw==
X-Gm-Message-State: APuU4Z/l7iJMW9fo1twILDbyI2/OLV2Z34QfFtT10ju+WsXw1xy5O41K
	kUvPnQcGTJAlL8LGn6CXgPm98L+jFzl3DnbjOygdv1m/iIw1rv61+N/43Y4IEB2Z8tI3CNpqizt
	KynTx
X-Gm-Gg: AZFdTZfihIMp9tlN5cXJsLAcZM0V7nHRVgGoGUzAAbBSGeMyM1mAPpxmlRjbI9QaXBO
	JQoLUSwLxGDfY/zaHvU9ssmYDCN+09OA19UumMpWsuwifrb+GFDD+U1J+4WrUmtGM3BImnDoHnd
	R19X3Ubrtaeh4gsby4EILVxNA6/bpLtvbOqTPSbIS+rlfTOhAxGA168oStdqqmycq2Qbnt/cPbJ
	XwWvcwwskm6mDaB1CgltlZbbQWDaK9UbVJHT3fLYr+QRA6A2D9iuvzyYcRrIhiZwQCBusFS2r8q
	RQ2TUdGuYFi9L+MTUy8btf9u0idW0ejMBFIIRGXI5SRTxhV2W72NhYIJgbIbnExkSBfNpX+JO03
	nO69VK7ZKHx8L5Ke4kxFNPBRZUJAC2XtXtPyyKM3t7uI6w5jsK1Gkc8NTDMu59noTehW4nX6c8s
	GQL5Wa+3NO1QFcAY+BA8nTsWlZRurflLJGBSaczFyrdZQ+M5APSSb3HMbPdkyDtN7ZV70vvappJ
	6kAVv4s31nT4LYdIWadqVx3zPoiTYrJzaKMoATxpf9yYsoy/sheN4MZ9mSuax3+Qm5AdW5IoxIw
	Rv30PTNQf3czmlTemklMxTW85LDbWvEK+r5uXi3imqayaXReD0hl+r4VMco7zugkD368o7K6rfG
	5wjaxhw==
X-Received: by 2002:a05:6000:2283:b0:4af:e519:cccc with SMTP id ffacd0b85a97d-4b546663d5bmr3560810f8f.12.1795446873104;
        Mon, 23 Nov 2026 07:14:33 -0800 (PST)
Received: from ?IPV6:2a01:390:0:101:4fbf:a0ba:28e9:473? ([2a01:390:0:101:4fbf:a0ba:28e9:473])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a67fec7sm21391704f8f.26.2026.11.23.07.14.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 07:14:32 -0800 (PST)
Message-ID: <d698f0f7-2dac-4587-a2bb-483b1c659052@streamunlimited.com>
Date: Mon, 23 Nov 2026 16:14:32 +0100
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: hci_sync: Don't filter duplicates while a PA
 sync is pending
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>
References: <20261122201328.2852883-1-simon.mikuda@streamunlimited.com>
 <CABBYNZ+UG_2o-RjzUDyzYv5m9G2N4x43TQKdPqNgrBepa8gd1w@mail.gmail.com>
Content-Language: en-US
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
In-Reply-To: <CABBYNZ+UG_2o-RjzUDyzYv5m9G2N4x43TQKdPqNgrBepa8gd1w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Luiz.

You are right this is controller bug. We will try to report it to chip 
vendors and
see what they will reply. From now we will keep this as a HACK for 
broken chips.

We do not set HCI_QUIRK_STRICT_DUPLICATE_FILTER on our hw that we use.

Thanks for your support and pointers!

BR,
Simon

On 11/23/26 15:18, Luiz Augusto von Dentz wrote:
> Hi Simon,
>
> On Sun, Nov 22, 2026 at 3:13 PM Simon Mikuda
> <simon.mikuda@streamunlimited.com> wrote:
>> To sync to a broadcast, the controller needs an extended advertisement of
>> the source after LE Periodic Advertising Create Sync, because that carries
>> the SyncInfo. Some controllers, for example an NXP one and an Intel
>> BE200, only use the SyncInfo of an advertisement they report to
>> the host. With the duplicates filter on, they report a source once per
>> scan. Passive scanning starts right before Create Sync, so when the source
>> is reported in between, its later advertisements are filtered out and the
>> sync waits until the host cancels it after 20 seconds:
>>
>>      21:59:14.147 > LE Extended Advertising Report  50:1E:2D:9F:95:23
>>      21:59:14.149 < LE Periodic Advertising Create Sync
>>      21:59:35.131 < LE Periodic Advertising Create Sync Cancel
>>      21:59:35.132 > LE Periodic Advertising Sync Established
>>                       Status: Operation Cancelled by Host (0x44)
>>
>> Turn the filter off while a PA sync is pending. The accept list limits the
>> reports to the source being synced.
>>
>> Steps to reproduce:
>> 1. Start a broadcast on another device.
>> 2. Join it, leave and join again, repeatedly. Rarely the sync takes more
>>     than 10 seconds, and until then there is no sound.
>>
>> Fixes: eca0ae4aea66 ("Bluetooth: Add initial implementation of BIS connections")
>> Signed-off-by: Simon Mikuda <simon.mikuda@streamunlimited.com>
>> ---
>>   net/bluetooth/hci_sync.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
>> index 638589f77081..88ce0ceef394 100644
>> --- a/net/bluetooth/hci_sync.c
>> +++ b/net/bluetooth/hci_sync.c
>> @@ -3645,6 +3645,12 @@ static int hci_passive_scan_sync(struct hci_dev *hdev)
>>                  filter_dups = LE_SCAN_FILTER_DUP_DISABLE;
>>          }
>>
>> +       /* The controller only syncs on a report it doesn't filter as a duplicate,
>> +        * and that report can come before the sync is created.
>> +        */
>> +       if (hci_dev_test_flag(hdev, HCI_PA_SYNC))
>> +               filter_dups = LE_SCAN_FILTER_DUP_DISABLE;
> We should probably check if the HCI_QUIRK_STRICT_DUPLICATE_FILTER is
> set though, that said hci_le_past_params_sync may have a similar
> problem wrt to mode but I wonder if we should really work around this
> or inform the hardware/firmware does have a bug, because filtering
> duplicates shouldn't mean treat as they never happened just don't send
> them to host otherwise while attempting to synchronize a BIG we maybe
> flooded with PA reports that have no use for the host.
>
>>          bt_dev_dbg(hdev, "LE passive scan with acceptlist = %d", filter_policy);
>>
>>          return hci_start_scan_sync(hdev, LE_SCAN_PASSIVE, interval, window,
>>
>> base-commit: 4fe38719e6738feaa90486e36b0790dd5d960a96
>> --
>> 2.43.0
>>
>
