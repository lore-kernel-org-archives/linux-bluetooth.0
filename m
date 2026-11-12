Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794500327;
	b=fQdvmmAOTIXw4at4w/YMyAZYwC+SP24BhGrTS2FauKXR/5CCDezR4Gy1pOmJMc4ZaOIZ
	 gYZAw75ojSDiiwKcEXeMMAHJ2NxUmU3t2aaEk3H4HvCM4QoJZMSgLUxuyQJwG9BJPtlxS
	 Zcd5W103NEcSs34dIesZ8IkyiHCWOa1EBEKKFFVq7P1gb69eYNWfC8krS2O/nD1tG1Bg3
	 W5A2AkaXRA+3FTxN+/VNZxOEI6zzr2V9fcGq/gkvQ7ARq9GvrcZEAzsDOlPtmjNpRDYO3
	 927EO/etoHOPXK5UhmSR6ts8t4cG3pcs7sK3eHItyHg3WCKPOxUlPzItoVVbnlywQWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794500327;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=1YXs3Ld6f5Xz4HUpVuVRi9CFqTaGtpzJFurgPvyEewc=;
	b=t6/xOW1kfEPHj+BVRiDKg7iCPgmGQd6yKiV2KamCHYOb20yk8gBoA3JmHG3eM3bCPSbG
	 pe8Ufj/gliithUFDt50WkuexDnNx0pEAaLY91Ty+OGAxC3So/8uHp17hJEphhX9jb/2dX
	 /clzfqlC/cpUWkyG19YkQ7eICwypJfET4Q0Jpxxdg9MPRBlq6fNNmclacBTm8m1Tmd5WF
	 +EXWuJBwcONf7N6+pbylBaxX1B0r6vn8jn0ytbcexnDF9vyltDdTl4p/wQZQwhb61NYbb
	 lzOXPikqEAm2b5nsGs3R6p4x03QT8r2a4LMhDgLVHnpP6MdQAMmxAO+ldhgnKrOwBNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZlqxgGBB;
	arc=none smtp.remote-ip=209.85.160.180
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797BE606A323
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 16:18:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 797BE606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZlqxgGBB
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-5361e313e63so48480511cf.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 08:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794500326; x=1795105126; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1YXs3Ld6f5Xz4HUpVuVRi9CFqTaGtpzJFurgPvyEewc=;
        b=ZlqxgGBB3v8vOj88LpWujBoJ78WSpDugBIVfAnBumcqH9x0ctRMwPpeS/jy4JP3E8n
         t8W78lUT2BLEmxA8pA9kgpKg/1jYapsaQSWrP8EP70Pqs0Dlpk8kH9iAEN8+kHTdEhdz
         zwGQ2ZexD20wi0/DiAh4M0Vt3IOaoswT1jXTxMyUuh3UVZ3Q0nwAahYECxn25yf4kVJ3
         IA6PrFhq7p90ahcWA2lByB5HY/3lapSB//BLrg9Fg2F8oIUGU8kps/wAyJmeyOVWAWx4
         GmXSFhPxDl4bs4yFl65+yHj8+9Wpf5rt67o87lm49leytuePLa/+nRxmaZuDonYD2KRY
         cveA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794500326; x=1795105126;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1YXs3Ld6f5Xz4HUpVuVRi9CFqTaGtpzJFurgPvyEewc=;
        b=VeMZnGmA5n2WnWfotp3cYaKMg1ZVIwvM/zdZM5Q7YLMAQqK0fwFExMeAQeTRWyR1TI
         8UGyK1vCwioWjoWQpaVGn++aBz7+Nsef1gXzZ39EF6GzzsJNbIwpOr1jcL0gtaP9LS1x
         QP/ttzygdmvlDoHx7f1K3zWhs+XVlx/BaC9JFIl85rO5ys/5xcJ6W7xQrpoyH2gGTasp
         cuJW/ORDvvyn3QRpMeWdsjYc6egm6+7JdBTIg1FyF54JB3GTldoV9NpK9LRe4qZI6gEc
         fpmp4aHBpl5ZPSawF040d960xKl1y0xtrvG5Smh8HxvbW9K+WGL/kko1pfRXrmC9SwiO
         dGmw==
X-Gm-Message-State: APuU4Z8oOcS2SwPspcwd1ZujTE8/C7YK7fAwnIfSBliwOm8W7+W5mwtP
	QMpKBDGNfzhWZbuq4vSKGv7q9Tg8ES6MrxH8jWV/22egRFv5i48wzjebEqr9+okd
X-Gm-Gg: AYBFou3dKF3kxuDKkbgakL97g5rhL+tPRhm3f0LvDlIOX911Fw0eYQg8oKqfehmM5kx
	244aMYTa6l+EvFQQeyf5FtbNjB+Vehd0Z8BR/ZDnoYm0JUjdMOqh+F5xcfttm71zXdHRAAWstXy
	hTzb/IuNc1F4FIo2IMOFWYBNUwbPWs2J9mt38PLEo7G3sQQbAdcXWQ6qmWcELVXjamRsdnbokRe
	8MwElsCYC8Rvf+DL5QioXdrkdOhDsYkDchC5tSsNmKkdDEmVmDc9b71e+tb52L4o97XCL8hhlZp
	z7ogpVh7ddBCFegQs382o3ytJY0e43TcLRL5gMEFw4P4k4iAf/77uKMg50cJf0CUpXxfmGaElXU
	RZjMAkM4b6656q5hDh9GslsCgrCV94t66GhHuSkiR5O4LFgunk8u0JoMTHaEQTR4PNplA/zYIvH
	CO1p2Ff982rHw/7FM9C+qS+/69p0N318/5iBvh3KZQWuTCaZs1t7WEBYj9WhlA3Qktd0szDMpuK
	6gOUmKmRUKKMtGLhcsy1l+0qJ9Mq3nVCvR46rKe0NbdOvK9Pj591gBiNZVX0Q==
X-Received: by 2002:a05:622a:c06:b0:54d:bff0:35a0 with SMTP id d75a77b69052e-556c28065e9mr89753971cf.71.1794500326228;
        Thu, 12 Nov 2026 08:18:46 -0800 (PST)
Received: from [172.17.0.2] ([68.154.79.21])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5550b44e617sm76482391cf.11.2026.11.12.08.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 08:18:45 -0800 (PST)
Message-ID: <6af5e6e5.0ee05534.1dc926.ad73@mx.google.com>
Date: Thu, 12 Nov 2026 08:18:45 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0260768021506116313=="
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
To: linux-bluetooth@vger.kernel.org, cochcoder@proton.me
Subject: RE: [RFC,RESEND] asha: use robust streaming connection parameters
In-Reply-To: <20261028133204.262169-1-cochcoder@proton.me>
References: <20261028133204.262169-1-cochcoder@proton.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0260768021506116313==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       [RFC,RESEND] asha: use robust streaming connection parameters
   Pull Request: https://github.com/bluez/bluez/pull/2729
   Created:      2026-10-28 15:20:49+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============0260768021506116313==--
