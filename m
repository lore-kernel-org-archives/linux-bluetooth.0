Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878163B290
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jan 2024 12:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705925893; cv=none; b=n4IVc1krV6oWJxFWMl0F2s0nPI9Ut97FqGBuckodpeTx6SNRP7HQSWO6/NtTTM6XThQelmfVS6ri5cRAJK1D78GedzmHDAyCu0yZ1yor+Smm5P37blHx5cotmQXzbt7VMwDwuUf+PI1DmMuMmy6VHxn5Orno/SCkeMo/5kKHtiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705925893; c=relaxed/simple;
	bh=QTVIrXa/wNjcS5+ppP3vBMuA/0WXUE7/yQd0xY3ae8E=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Content-Type; b=aMHYOpfHXPrLo3jdx7j2AYB+PuoDfKzc7DHEg6COIpwAboRxWDmHXvM0g6lvdX+yIQjX8SAVQBCzvFRVPSfUfL5yRXe+oaUQN5WUjp3mhClaB3t8FwXYWdWj55dqBT3Vmj6gMHBmer6t53sTP8rHxudXVtQipKdBmYtFx38tFck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mobile-devices.fr; spf=pass smtp.mailfrom=mobile-devices.fr; dkim=pass (1024-bit key) header.d=mobile-devices.fr header.i=@mobile-devices.fr header.b=jtaBdC5+; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mobile-devices.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobile-devices.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mobile-devices.fr header.i=@mobile-devices.fr header.b="jtaBdC5+"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40e880121efso34472365e9.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jan 2024 04:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mobile-devices.fr; s=google; t=1705925887; x=1706530687; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:content-language:to:subject
         :user-agent:mime-version:date:message-id:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IPXkskolG/PayeuRoN9pTvBCCUGNL6vsW3GPZSp74VQ=;
        b=jtaBdC5+Q2bVbxhRdVFNz6aLa8qLXPdeIot2f7mSpHKGmhq+FHmqi4P4E7YjJDQALu
         b+w+CZEq8UBPI/TDqDJWpzxLb3FkZ+fN9KgD3U+hCN9bLriw6nKcD80Tnr0niwGTzEOY
         fdd8AMFEqcm73X3xAc938xPNviet7aVbFMgXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705925887; x=1706530687;
        h=content-transfer-encoding:organization:content-language:to:subject
         :user-agent:mime-version:date:message-id:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IPXkskolG/PayeuRoN9pTvBCCUGNL6vsW3GPZSp74VQ=;
        b=r9r8JMdflI01JGBdaOUJF6f76k+7Jq5Jvrtl85hM/HlLQ9PoyTPPNqBM7NYM9TSh3D
         LJE0NH5KU/Vv/xbuYtrYZ3tzAlnZSYAUfxSPFKDft9/2LEwAbXzDlgV1/KdpIGA13VQn
         cLpSrqCVswefn22oLJuUz8iz2iwtU2awjP2ubi8vGHMALFb55yh1/dVsSmVoUKcvqVny
         nZyl/A/Fqbzgtam2gQALECoNIzWzgHr+kumhPePTtDB854+1FrOuScFhoDu6AkvZdtCW
         jIi6zBPrTmrUWmnLhstoHGDcbOGhfqu78M8uisvyQbOIgtQCmLndh3Iu6tMYmOZSLySa
         +Myw==
X-Gm-Message-State: AOJu0YyiPNHsuVXON17zBSiFx4YX7zxN12jjOx4B8blqONbpjSNsZV1+
	zkQOmSEpREIoMpbGrsmObyJDrp9nwEIZuADgPcUWW5E2dQH9+XqFemh/fOh4MU5fV0/kkScxzK8
	Y6hKY/3nlBMPGmN78na1WUfyNIDCPSIdOY0xYGphjYJL8J9CAxkHwYd8CGTWdeWFt8KaIOvKWA2
	OJisxyWfnQwm0VnleM8wohQGs67f/Txq+2QEUuc8ZDUOZWWdCGFmls0UpzvDjk0RQ=
X-Google-Smtp-Source: AGHT+IHok74q6vkvpS94zRJ/j8SQ4E4n+OQuZLFq2hWz4sr8JTjOmSnsjR+bSoAIALYukZWgq07mug==
X-Received: by 2002:a05:600c:2349:b0:40e:5f64:934a with SMTP id 9-20020a05600c234900b0040e5f64934amr2365052wmq.165.1705925887054;
        Mon, 22 Jan 2024 04:18:07 -0800 (PST)
Received: from [10.42.100.11] (static-qvn-qvs-183113.business.bouyguestelecom.com. [89.87.183.113])
        by smtp.gmail.com with ESMTPSA id j14-20020a5d604e000000b003392cdeb3a2sm4675756wrt.103.2024.01.22.04.18.06
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 04:18:06 -0800 (PST)
From: Andrei Volkov <andrey.volkov@mobile-devices.fr>
X-Google-Original-From: Andrei Volkov <andrey.volkov@munic.io>
Message-ID: <a3a31b2d-6039-4b50-af81-47f7ea1a0461@munic.io>
Date: Mon, 22 Jan 2024 13:18:06 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: regression in c7f59461f5a78: Bluetooth: Fix a refcnt underflow
 problem for hci_conn
To: linux-bluetooth@vger.kernel.org
Content-Language: en-US, fr
Organization: MUNIC
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

Lately we've bumped with regression introduced by commit:

  c7f59461f5a78 ("Bluetooth: Fix a refcnt underflow problem for 
hci_conn", 2023-10-04)

The regression related with adding "hci_conn_ssp_enabled()" check in 
"hci_io_capa_request_evt()" handler, and broke pairing process initiated 
by the external device.

Precisely, some ext. devices, like any phone equipped with Android ver < 
14 (we have not latest one, so we didn't check), always send "IO 
Capability Request" before "Read Remote Extended Features" command, as 
consequence the flag "HCI_CONN_SSP_ENABLED" not yet activated at the 
time of "hci_io_capa_request_evt()" execution  and 
"hci_conn_ssp_enabled()" always returns false in time of the pairing.

As a result, pairing always fails. The quick and dirty fix is revert the 
ssp check introduced in the subj. commit, like below:

--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5329,7 +5329,7 @@ static void hci_io_capa_request_evt(struct hci_dev 
*hdev, void *data,
         hci_dev_lock(hdev);

         conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &ev->bdaddr);
-       if (!conn || !hci_conn_ssp_enabled(conn))
+       if (!conn)
                 goto unlock;

         hci_conn_hold(conn);


However, a more thorough and correct fix requires discussion and 
testing. Therefore, I would like to get any comments/suggestion from the 
community before doing this.

Regards
Andrey VOLKOV

