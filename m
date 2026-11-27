Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795787732;
	b=Jm9I7lRnR+B+boH1IRYMH0bWf7l0ukI+U5WCPgHN7RyHJlptVKCx4TX5oFiGEePVErYe
	 ud6JQVYEe6BoP9ttt7+t0T3lsvLzcXG7Dwm/lXdoOHxu7FNZbIKy4/wE6dDbOw7Oxbr5n
	 8XSoH/hcUAtLX2SXUv3mMMDT5+h9EG6+nmFQr2IGEQM8a4kzM4oM8vhjP8HQcCNIJsdPi
	 cWPyVmrbIISqZX2N5OdAbkthEzjwa/537OBFT1Pi4re0yPcBpr9JviWKx31j0rxRL/jk4
	 eiaUMlNpF5qezhPWAGR0tYEAa3pYGBh+N99v8rSME55bv4Dzt6dNilmH7/XfRIpqlBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795787732;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=LBv4K0w+i16EPmHgBZxph5k9v/h/04NxnvbVy2aL2n4=;
	b=o9TTd7tFgMKsx5a3jgToArNtQZoiFe3nsoM/Y0x5KVj5ntoAIEnimYaKbuR/3bcBbP1W
	 wFgMBzJZaBC6KsfwhSGT8FQp8VrzNY9eIm4MynjOUMwwcraNcZMsXS5TFX7Stfz4NCi4P
	 f0QJWs97LPUpKVjrgWcJ2x3cwdhJkuTiJljqW+kdqAPbt3nrhZiJX5KfZVjI6wS4vxR+9
	 f/rnu7zgUwlKEHCPMlrEFfz2epYDpY55mrIpcVn4lorOY2RsgDBTJmUsvJXZ452IGxp43
	 Ge0cHsbtVKR78eu2UPZtiNlNOVS9f+FX4j0e+sOLqEaHxUq8Cer2lqD9RZz5IjpD92g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IyOYevOT;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9344A606A326
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 13:55:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9344A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IyOYevOT
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-38431138772so10586084eec.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 05:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795787731; x=1796392531; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LBv4K0w+i16EPmHgBZxph5k9v/h/04NxnvbVy2aL2n4=;
        b=IyOYevOTFwItHM2PJYz9CZWmEKmqRBCYImpR0H2awiKH521JPV5v7azeqxYP4ZyiLr
         PK0/AWIqk82K0F9q/8ZhI3Skp3eIkRTNStY3MlS38yR+pTuJMQAFOX2PviP9P4DsJqMP
         toq2qvtrF0QGcSwe3qOo83lQ75v+hUzXyxT1Qk7Msn0JUp+wmvjaxRZiHjpbP0h9LRYd
         Dmru5HaXvYDFyKVqGlnofS+metWVztycLlqZXkw3OCjgaa8Z1RwaZwZW0d9rWV5Jy0rU
         RFJ9B3lHxvJP6VEwsLi4Icz5aG+64NJlOftg3bF3RJhEz44QbvOSt8cthdKJpEzFl+3v
         Okpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795787731; x=1796392531;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LBv4K0w+i16EPmHgBZxph5k9v/h/04NxnvbVy2aL2n4=;
        b=MueYVHb0I1bzWaffVtJBJI1eX0K1njxxgYTuZ2E/7p3hPKP5zB3905pUQ2E8hxOeOp
         itP7DvqlrpNeJTqXQaWz951pUKsowy+Khu0ADjtDqYZo6yEG/7gyrOwRMajlKo8FO+kI
         CggWWWTQdHt2KZxec5pPVyaxbHmQCkEqU7HQ/FsX3Lf/39rOcHh5K52w2Y2A93twzm4v
         T2UN15oHJ4lEx18L8rtUeq7LMF4ASfXHRv+wA3MHboCx30Dx1lTInhZIQT5Lk60Ueehm
         nUkh62O/JgXWlueXlUXEdSYN6BE0g/TLqx4bVy8rNUcOvJtzaIHE9B88YtBt30GjoK9r
         yOsw==
X-Gm-Message-State: APuU4Z9NeiPUa1PX6v2ouEMmMPNBtdctgR9bG3Ka2Kj3qHmtBRPpNBmL
	93WW0LCTXi6+WVkEXmhNIT7Fl2ECT63cCDUvpiFiAQ2vqupuSzR9KS2RjaqrgA==
X-Gm-Gg: AZFdTZdmG+WvKb+hrrSfyfmbqrduSsQvJD5nPdo4u8Hzd2a2Xb5AfnsutjzHZc6ohTi
	ACY0qyTUiITKomXBfdeUtXDxrfmlwE3+JynpoFCcZ/aEkzhE8d6fshevnR5MI9fze4KNRr6aD0r
	vikbDcef2dq88wkJX5BuwBiYhQPEnQhC0qcSu6U2yxNxcdxDWajTHPAIWQUuLxEgOtyyJN5Tu5u
	gVDTZYMzoT5wtnyg6RrhNwRtTJkEoS9fvN33MfUHUvgcQnXzeoKWhM48itcuCqKZyLYk06v64ho
	F+GMG8Pqf6pZRomQfUCY7AfRK2ZEtNMFymsBGoHAxd2kPE8ajrFEVj9fT9shgPr9fKgNMd9HWWr
	Rce4/DRSJUk0Jt+xlPjrPsLxPkqojjdRWiToifKXjRegi2+3tuXv071kUMFt3eywFFhWtjCnxtx
	5Bi0Ex1EXjUrP857fofOYPb3c0b8kj8qEp85IpJQGkbk7tKtO/KkXc0P/4LjBaP853pjRPA6/ut
	sJTGi/nfDuazEHESxHJpaiCRvCSGEp+DdvVtxMh/ykMjpshbVja3y+JS2vON//LzNPsLGfynDu0
	NtJMqGO2
X-Received: by 2002:a05:7300:8816:b0:385:5b47:8aad with SMTP id 5a478bee46e88-38570451daemr25805105eec.19.1795787730445;
        Fri, 27 Nov 2026 05:55:30 -0800 (PST)
Received: from [172.17.0.2] ([20.169.114.161])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566cd4efesm76093882eec.12.2026.11.27.05.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 05:55:30 -0800 (PST)
Message-ID: <6b098bd2.7bf231e0.18dcf9.12b2@mx.google.com>
Date: Fri, 27 Nov 2026 05:55:30 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2275132799070522811=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, 17868388227@163.com
Subject: RE: Bluetooth: virtio_bt: fix skb double-free when send fails
In-Reply-To: <20261127070813.662250-1-17868388227@163.com>
References: <20261127070813.662250-1-17868388227@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2275132799070522811==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1224050/

---Test result---

Test Summary:
CheckPatch                    PASS      0.54 seconds
VerifyFixes                   PASS      0.08 seconds
VerifySignedoff               PASS      0.08 seconds
GitLint                       PASS      0.23 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      25.28 seconds
CheckAllWarning               PASS      28.82 seconds
CheckSparse                   WARNING   30.72 seconds
BuildKernel32                 PASS      25.22 seconds
CheckKernelLLVM               PASS      25.62 seconds
TestRunnerSetup               PASS      567.39 seconds
IncrementalBuild              PASS      22.46 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
drivers/bluetooth/virtio_bt.c:340:25: error: no generic selection for 'unsigned short virtio_cread_v'drivers/bluetooth/virtio_bt.c:340:25: error: incompatible types in comparison expression (different base types):drivers/bluetooth/virtio_bt.c:340:25:    bad type *drivers/bluetooth/virtio_bt.c:340:25:    unsigned short *drivers/bluetooth/virtio_bt.c:340:25: error: no generic selection for 'unsigned short [addressable] virtio_cread_v'drivers/bluetooth/virtio_bt.c:343:25: error: no generic selection for 'unsigned short virtio_cread_v'drivers/bluetooth/virtio_bt.c:343:25: error: incompatible types in comparison expression (different base types):drivers/bluetooth/virtio_bt.c:343:25:    bad type *drivers/bluetooth/virtio_bt.c:343:25:    unsigned short *drivers/bluetooth/virtio_bt.c:343:25: error: no generic selection for 'unsigned short [addressable] virtio_cread_v'drivers/bluetooth/virtio_bt.c:378:25: error: no generic selection for 'unsigned short virtio_cread_v'drivers/bluetooth/virtio_bt.c:378:25: error: incompatible types in comparison expression (different base types):drivers/bluetooth/virtio_bt.c:378:25:    bad type *drivers/bluetooth/virtio_bt.c:378:25:    unsigned short *drivers/bluetooth/virtio_bt.c:378:25: error: no generic selection for 'unsigned short [addressable] virtio_cread_v'drivers/bluetooth/virtio_bt.c:381:25: error: no generic selection for 'unsigned short virtio_cread_v'drivers/bluetooth/virtio_bt.c:381:25: error: incompatible types in comparison expression (different base types):drivers/bluetooth/virtio_bt.c:381:25:    bad type *drivers/bluetooth/virtio_bt.c:381:25:    unsigned short *drivers/bluetooth/virtio_bt.c:381:25: error: no generic selection for 'unsigned short [addressable] virtio_cread_v'


https://github.com/bluez/bluetooth-next/pull/1240

---
Regards,
Linux Bluetooth


--===============2275132799070522811==--
