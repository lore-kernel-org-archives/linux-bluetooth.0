Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9B1137932
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Oct 2024 03:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729134314; cv=none; b=uInucAlMyv6Zot78TJd9i+YkfbxHuKfpJKlYfnjjeWVTKLhwcP1qsoNuQfwfeD8gekE1ZHLlZN6gsAnoEuF3Mur/Dnab9DEo3tyCcxjM2VEhA7MrHPe7S4Fpyhs+SNO0SxX0sqIhKwvPQ+qNA1udFbjewu/PCXmdTPi0ZcMtfpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729134314; c=relaxed/simple;
	bh=KNplimBP1NDosfi8hpIVMADmMp2TXquikdKnV+6pfwk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=NAd92vBRGH0obOPAShXMLGgjN/rhemmG1d6Wgo7yYUr8OlJSwsVodT5TNwRa4UNADz88wLaWiVHrX5NJbkv/FF713KOyeQCeuJ+qP+PgdjM8nWqUiYUzfWqU430ZMt2BoaRrpc3+Fs8AxTqj4zCmXz58bgOydCvX7x4zfnDM4j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g7VaU9XK; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g7VaU9XK"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4609d75e2f8so3195451cf.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Oct 2024 20:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729134311; x=1729739111; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KNplimBP1NDosfi8hpIVMADmMp2TXquikdKnV+6pfwk=;
        b=g7VaU9XKvu0KdMaLjL6s8TLX+tcpxXOLE3d0xYpvrjgWfUFmfWyDpB6LaY4ggJ134R
         YI/ijnvk/mM6aD+5qEpme54x+j086XFL7nB7+L4K6fQ/w9A5GOx0rhkAO/sBqlLeHbi6
         oXww6me682ny9XPzDySu/+Xwp9m6/i9jMQPsjwELCNZuE4wCOrQqT+yFc/mfiZXAJR7Q
         3fvkhCLABfxsgVe7XoIzQgDBKJHittmvp2CKekUXwJ28CAQRyRCLMkMITN//Aq3t23Ly
         MGEIyaQtiYSHwwNwOrYIBCcJdaQXO1ye5vxUWKPMmABflVTEnV7uneTX399RpBL/uR3H
         yNIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729134311; x=1729739111;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KNplimBP1NDosfi8hpIVMADmMp2TXquikdKnV+6pfwk=;
        b=lIhKLSLHdMtEveVgX/kxN1vNG6BR9Gq1wTvD/AjY1qCdRpdgr0g/zHk83mVRtlIrdN
         fyVkJWbNqEbqQuVJzxdbfSh4dw+eHTl0jAn0Ijuuan2UvZWdspKMd1wl+iybQ0pbjbJz
         tb2J+MkW9kN1bJEB9oPYyxn7HujNSS5ZCSzLmdbEcCNBR8MvtTeEP+M613Ihy5hAyNPx
         Ve6AhDUqQ2zoHisTot7qaMOCc6DIdd4GMeKXvlhuAdOflxMeSv/KKPLmjy+5uNdZF4Y+
         W9x/LSFlBBDUrj4TtLwB0ZW+TL58Eih75RGesNVd6kzmDQAdyKNKAF7glNPRMzncG7RQ
         2tOw==
X-Gm-Message-State: AOJu0YxSMxCuNkIoD1yY8c2+VzkD9GluzLzmBwx5JLe3OiKbJcSFtsO9
	eBntQdm4WTG6ufLFyz0vv0IIXVb7xwDfTS3lWEj5GkFULRW3F+F62JvR3Q==
X-Google-Smtp-Source: AGHT+IF32gOkCIKXnhWB7UzlgFOLfKxdcPFZNH+Bxrm6hk5kcutcGi5PV7l9u+kR5lEWKwAqaHA0Tg==
X-Received: by 2002:a05:622a:506:b0:460:8e30:75fa with SMTP id d75a77b69052e-4609b4eda43mr31570911cf.28.1729134311127;
        Wed, 16 Oct 2024 20:05:11 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.46.117])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4607b123e13sm23799171cf.44.2024.10.16.20.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 20:05:10 -0700 (PDT)
Message-ID: <67107ee6.050a0220.1fd6a4.ad22@mx.google.com>
Date: Wed, 16 Oct 2024 20:05:10 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1015084380257431279=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, wangyuli@uniontech.com
Subject: RE: [RESEND.,v2] Bluetooth: btusb: Add MT7925 support for ID 0x13d3:0x3608
In-Reply-To: <3DBBE09166DE4374+20241017022433.50800-1-wangyuli@uniontech.com>
References: <3DBBE09166DE4374+20241017022433.50800-1-wangyuli@uniontech.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1015084380257431279==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btusb.c:512
error: drivers/bluetooth/btusb.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============1015084380257431279==--
