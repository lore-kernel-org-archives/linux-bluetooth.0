Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA6835AC2F
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 May 2026 08:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779439036; cv=none; b=ov6SyDHD8YVZr/e5hnUfZnEX3SB+hfJSC/qSPY8uAuDqh4cU26rsSXM7kDlnAYHHqRz1o0vWUAGKrn9gkU+jNKaIAZwFI7hy//5r0rkzXsFGer7iQ4aKXNEV2S7RySWJZedzSxCgRHiGRUK9Ipqk3e7AquAD3oqnyFYCOqApTw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779439036; c=relaxed/simple;
	bh=ULv208iuGplee3VqZkwGKuoqNn8XQxdSj7Icfsy9q8c=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=cA7JZEbcYz/LmrQc3jfd+8vYbCthiPACYNaWKtY60kcj0aZ0AGQibz13kO78AC5usnNZETH91DHm0lqqiZelXzItLzaCOgUlj9SM7TMfOM68pVfK+4TxjvANaG8z6Dr1V8fvB4NqnBbR8yTyOvk89u5pV1vMQ/oZrbYWf8H7VZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RMAGHhnh; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RMAGHhnh"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-50faeb8317bso64269601cf.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 May 2026 01:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779439034; x=1780043834; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KZeUvhhBSYOIgZaV9dNrX7Tg9IMUflrZ6EsyEhsI9cs=;
        b=RMAGHhnh4SrhYENp//nqsNYEG6R7R/yu/Ddgzwurc/TbVtDkBf+JdYBQPH7tKH0RKk
         9uCAwWUhnd0KjyxPoPhc2VtmAgHxf7OTE7Zzni1kVZ6XA88DqP+g8O4PD0sEQP9s8Ja9
         /cOtpzY8g7R545FJjQOI73xeG0yvqfDwn2PHZ4NG77ZIS1gJmx1334EPNskMuGXomCQm
         xhgoN2SoAYe9547/PGkQM6EfXkIlp6PT8RzkE3Dv6UgkHK1gM5ejSSoxnUsJWduzQumF
         G/5RjyDq+IoczlsiSs/IIfrrR3fiW7pQ8rxhQVd7nFiXXdshbtLQWmeoZT44zjexmqSy
         259w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779439034; x=1780043834;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KZeUvhhBSYOIgZaV9dNrX7Tg9IMUflrZ6EsyEhsI9cs=;
        b=IOkJoRqsi/pGCQlUhmka0aEsT5BWtMp9kmo0oM+YDhtTZTvM8x1NSFMOlYJbFIyP2r
         UrTGKt8YEbAqscrbp1tSWiMdfPInxC/NMuEJtzWegyYSjc6E8IuzJY83ovRLecZANZUc
         hwAz4q9d4eGuTNqGNDntzfjxm5R32QaHKzQNScKaFxe+EjbSTgpHVf1ANSjXh2L82rL9
         P6SWNuTlO4hHdy8a1/9atd5mmzbk1zWYaLvRq8Y+jzAlV683yEn6XxFbnQUprX2isJfT
         gQJbYM7ATBZkq3hSESu1Dm51kcHAyjnnl7QWMekKophN7nZaum+t28w5lQYKrRtzD2NK
         l0Ww==
X-Gm-Message-State: AOJu0YxNO4AjDBlb5LfaHlvdqNlrz3qof47KGoiBVsLYPwO2zcsMNezH
	dy5ukQcVtyr8NXZYkDdCfnKgJtjUhtdl0JHI1bhHFWo6pbw57xa+wnaYQitAdm75
X-Gm-Gg: Acq92OGkyFPMO95zbiXzs+bA6J5GZZ24C04+mDLRkiXF9kchsz8JPp87D5q9zQndVpR
	uzgcVvrdpwc2kp2GxGH53E5Ki3Ob6ejkvCSshIfS13YzvLYg18/MVcXFyMZeE56XLN5H6K/SZfd
	pwaeRQy6r3/dSMWKXM6iMGA8OUU3INZpy18fSLlL0ykRu9p0XEynxL1sNqybRXUu/1+yQuh1o2M
	QO+9g25UGsIjCL8A9y18uKsZayt3y18itwb0xqc/bwsdGNf7A2oI9Orv8amROiNjefmUwPrfmX1
	H8AWrYsqSfJCGMGsLWMm8MZdWCzPlgd+9JG6ABS9CBTnaA+P2cnbp3Nw4iPxn9rg2UzunFe4UW+
	XXk4AEA1j8JolKK0GX9XQuGjFDNi/OcFmS5RTZ02SCLlYX1/WT5J57tcS95oYvfVPI85Ma5dMtu
	P5qLd+HFiAdO2oBzrQBszc5g1VKE+ZPH0=
X-Received: by 2002:a05:622a:c4:b0:50b:4e60:93b7 with SMTP id d75a77b69052e-516d45c8db0mr39701631cf.43.1779439033749;
        Fri, 22 May 2026 01:37:13 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.146.113])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc8131fc67sm12063186d6.45.2026.05.22.01.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 01:37:13 -0700 (PDT)
Message-ID: <6a1015b9.201aaea8.8f3a.e287@mx.google.com>
Date: Fri, 22 May 2026 01:37:13 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2695333706488836167=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, wei.deng@oss.qualcomm.com
Subject: RE: [v1] profile: Set L2CAP IMTU for external profile listeners
In-Reply-To: <20260522054015.431152-1-wei.deng@oss.qualcomm.com>
References: <20260522054015.431152-1-wei.deng@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2695333706488836167==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1099144

---Test result---

Test Summary:
CheckPatch                    PASS      0.39 seconds
GitLint                       PASS      0.28 seconds
BuildEll                      PASS      15.97 seconds
BluezMake                     PASS      489.53 seconds
CheckSmatch                   PASS      252.95 seconds
bluezmakeextell               PASS      129.96 seconds
IncrementalBuild              PASS      493.87 seconds
ScanBuild                     PASS      719.71 seconds



https://github.com/bluez/bluez/pull/2144

---
Regards,
Linux Bluetooth


--===============2695333706488836167==--
