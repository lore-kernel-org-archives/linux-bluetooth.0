Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B423128CA
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 May 2026 21:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778102883; cv=none; b=LQBYU0fjcnj+o8ATgx4zW9G1OxQzh1TvPo+0OZ171EkRLnzy+a6JPb4+4ZFM6SY001SFTOK+pvebLqNrpEqqPW8qx/1+0N0Yd0RW617yKxNugzKx9eGxaG76Bq+VOYYFpo0GKXaYTStYUySOmN4cpF2E7NkhoMluVhXBV5mQz/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778102883; c=relaxed/simple;
	bh=ANB1+Bw1zQ77dhnr3cFWTX07FHEdrH96DUWtx2MTaVo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=gT+CQFo3rWrrpQBD44LCIN6ddqozCFGgq074Lu1TcGjCzYZ/MhtvXyiCnOkSGZ415RE2NPyZOpxT3NI1TL0E87WWMEpytVOWLT/Sv+X2Hylw/1xnE1Ls1p2qN7hnLezfcAsJOivWSq3hiJMxL42cQqQiAPiSV2UMq3UACG+mzpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QX64tR01; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QX64tR01"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2ef2a1cc06dso553420eec.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 May 2026 14:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778102881; x=1778707681; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WUxKDzZlEwF4tfLkvHZW1vCn4Gio/DyuDlLiix4sr40=;
        b=QX64tR01WOmOMlYQy/QEpSqJjqyHbrGJWU0OD1RW3m5jXMB4hd07texkKy9d9Lp4X9
         m2a7GEFW/qZW3zeCrTOdQ2WJJr65pHfYlr32nQT3suB2NhUCGtj8OUp9y0axwtiKYjWi
         6Il5+/Mhw37tab1gmM6GEedNaPpd5+ABpwlR9VKU1fqMl6WtL96NUpU55b9SlZ4Q4HRA
         5AqSTt+qb4jblek1bc3Pz6Syu/8gvIYfKUlAcyXw+rl9a6AmWxRcandA1Nuo62JEdrgk
         zc+1cnBua1sZHFjMqIgbkqZxToKqC1RBFrQvoBZiaII6xU0nuB3mBZJNL7+ITs/WTw8Y
         Xq4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778102881; x=1778707681;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WUxKDzZlEwF4tfLkvHZW1vCn4Gio/DyuDlLiix4sr40=;
        b=CR3pLmwC9pyuqKyWj35Bp9luygp3Dp7rBs1fG9Cl3TPoS01DU1vaWjq8qHBO36ndS7
         o5/So1pb+qtLngzdMOuWqwma5zgRY6YUdk7l/Z1XzfptOV9N0vUxW/vtJ1pEE4GDDoeQ
         MpP1EvnY331mECimT/bV8HbfLaA8ZzzLhEa3PyjuZodoxy/P/P2bGKoUSuJg+E4N7DNL
         PObY8T6/+y9kQ32R9N9FspO7JvHRS5RRkXeq/4kNk5k6smj/i5G+le0UFr0PslkCG5n7
         m23qm6XvzANTEFP4iBrmJJjki6DZOkBuhL48M4vOukoFlnPZBFEhBmweb5x5LqCu0f98
         PA2Q==
X-Gm-Message-State: AOJu0YzEDKaanuDljL0mSsMnvDL3k42WCnSpGqynMJRS3B2XDQtJMwBu
	QbQdZ/lFVFrlm3uNUWBEuRUVsJbkd06NHInp4rVxylVttBOeVEHtNlxtSLx1Hw==
X-Gm-Gg: AeBDies3cukXglmmqeSKRP/FUrtdlWVfQL2/EEY+I/6uKnBs/MucWK1yQpU/dEbscWA
	Ecsnh5z8UI65WlnEvspAWxdWKkKa8nXjttI2ZnV7b6oNXFsUgT8p4xIIeaKEz67no3V3KhflSPd
	wVz99VKXjIzgRdabv0wVv/E1/BpqhU2IF6kLYdVcAhTVbbMg7fgZAlv20HkmeFUjmB122YIK7H3
	l8uOgYG5InrU1Eg/1Sy3g6rNOUdYI2J/fG8tkbcTO3GKQrf2Cekjcx1H1GqtzJm9YQl0IzwOEP7
	ONClX4FVmTnj3rL5hxyD+AZspQkN/8cVCgfDzOcD+AD82OJWbu0Tp61ZKVjPCUCJhC7JD2U/WQ1
	GOrGUAPuTwXJz/Uuz9YSJvaS8Pzc8vJnbjtCbZXkjbQZVSBbMfo0DkytqLqKP3pr7+0K3zLLnvI
	8D4BIoYzoILE0erWdG3VLxLQtA3Vq3UhwlH+gwl/9rTQ==
X-Received: by 2002:a05:693c:2c14:b0:2e2:a64b:63b5 with SMTP id 5a478bee46e88-2f549e6b38dmr2682982eec.18.1778102880564;
        Wed, 06 May 2026 14:28:00 -0700 (PDT)
Received: from [172.17.0.2] ([172.208.153.11])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f56d3d8d83sm5861858eec.7.2026.05.06.14.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 14:28:00 -0700 (PDT)
Message-ID: <69fbb260.050a0220.817c9.8220@mx.google.com>
Date: Wed, 06 May 2026 14:28:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8944203435147653933=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: Add helper for "cleanup" variable attribute
In-Reply-To: <20260506143220.3076135-2-hadess@hadess.net>
References: <20260506143220.3076135-2-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8944203435147653933==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1090532

---Test result---

Test Summary:
CheckPatch                    PASS      2.00 seconds
GitLint                       PASS      1.32 seconds
BuildEll                      PASS      21.42 seconds
BluezMake                     PASS      638.21 seconds
MakeCheck                     PASS      18.99 seconds
MakeDistcheck                 PASS      232.55 seconds
CheckValgrind                 PASS      272.18 seconds
CheckSmatch                   WARNING   331.14 seconds
bluezmakeextell               PASS      163.78 seconds
IncrementalBuild              PASS      1203.38 seconds
ScanBuild                     PASS      924.01 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/main.c: note: in included file (through src/device.h):src/shared/gatt-server.c:271:25: warning: Variable length array is used.src/shared/gatt-server.c:614:25: warning: Variable length array is used.src/shared/gatt-server.c:712:25: warning: Variable length array is used.src/shared/gatt-server.c:271:25: warning: Variable length array is used.src/shared/gatt-server.c:614:25: warning: Variable length array is used.src/shared/gatt-server.c:712:25: warning: Variable length array is used.src/shared/gatt-server.c:271:25: warning: Variable length array is used.src/shared/gatt-server.c:614:25: warning: Variable length array is used.src/shared/gatt-server.c:712:25: warning: Variable length array is used.src/main.c: note: in included file (through src/device.h):src/main.c: note: in included file (through src/device.h):


https://github.com/bluez/bluez/pull/2102

---
Regards,
Linux Bluetooth


--===============8944203435147653933==--
