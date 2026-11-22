Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795372778;
	b=helhw7I3iBVRwLG6S+4pyiNNhBLC1PvbWIMsYg3NN6zW7syGesGNz8Egw4KDE3NfExME
	 pRPXoLG2TF8d+jX87iVStgDwS+SHVKlYGzRlb3f9SaSfwQKz5VhjnsjnUGIGK+FmWwm0F
	 T7BEPCa3Igsr8egWyl6QTHk0F5InJgkxnxTTqesdTbs0T3qVGqYXHrylwAjBPYCOKdAyP
	 KzTt01zmnX/ApMcJWxKp/FH98pqZaG0+E4hPxCCyLwKEVbH36BgoQRNP/uQRq3kghpbZq
	 iuXDe/hFY+sRoR7piaUj1/gnNec7mPRe/6xGDA32xJxpH+T+Nt8aUHHmN80qK4tVo+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795372778;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=YbhwFRCnwVcvmqQhz/s5jhq7g83n5na8YW9S7oHRjdI=;
	b=0FDguaTPjQq7mYRZE2lC0DHKQaDdAVDECvfmeqZ5phPVYiZ7upF2uVk6GroA3bm88y1w
	 nscEYUIFKjA5/WgVkAhVdEUdCgbjb2kKiPoj8IpWcMlTZ85EkuuWHWSjfwGZ1KzJGaxtu
	 1rg8HEYNG8o8TVC5AY8gBTcfdNzMxkdS0Q1xWe+HktOWpAWAcgG+WHnYUJtn9QBaGCN4e
	 XxWtPSj5xgs0iLyxe1vWZhiAYrwxhr9jQM+4jwVO7sLW8dzCgrwV63X4JMYbaS5VV7urE
	 QHi/8j8vxxpbB4SwCTfpD0oI7vJ6pE6g5rfBbHLpdkCcykm8wti0V267xjMGeeluwRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w2KEStXb;
	arc=none smtp.remote-ip=209.85.160.172
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C17606A320
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 18:39:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63C17606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w2KEStXb
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-55ade1de0b4so32883841cf.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 10:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795372777; x=1795977577; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YbhwFRCnwVcvmqQhz/s5jhq7g83n5na8YW9S7oHRjdI=;
        b=w2KEStXb0Ni/bKUH8c45/6ZpneqIYVOxJmUJrHZzfGkky/v6bTo0i26E23OjTvppmk
         4YEO9Tqf/TdlRz0ERm6lFO/rmScnjweJo0uc19xYpwwcy+GcBVTQT5K4zNKNw41BhfmN
         LX49Qo3BChy6cQoKDcwplRoEiJOP/hKRxR7HSANGhhMUOFsJOUgO8AzEVIitPvqFr/p/
         w6TO0batf5zzNvHW5bJsypEpiKOis9DUVQQ0B5Dfu5Am5rZ+ic34uMcTLDuyhzHCP1pY
         MblO1NOJWxdQWUmfOWecqizovpuvDNrYYac1pLC9Qh2GssmLw2Yybq4ckX8kqM4+5Eda
         wkew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795372777; x=1795977577;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YbhwFRCnwVcvmqQhz/s5jhq7g83n5na8YW9S7oHRjdI=;
        b=ECc0fl8fMs4SpRg8H1LaYjrhGQh9VLkJ8ZurdT2aF2TjX4i7DrmveSHVRNLvfI4080
         PdEhXft7nGsWgia3OdhzscRwmq2APa4sh4o/JFO0+6ohKQuhzfcclXd6clIhPTA9FhyK
         XZTYKZd/falZBeCp/tPPFB99NFMglnwzB7yxA6VHYgPA42o21wyGSRGudDEnrOnQLKwy
         eoO2MaV5R4qW1Xzfa1+F8nzrFzcnku7GYLykJ88bkDf5i7Mo8E5QJfY6gODcVDV974En
         8I2aVPFvVy9mGqRnpvMximPhfvhM9fGDNIYHKsbZS/C1IJvu+uUJ3EuDHIuK3aHCmZqp
         AINQ==
X-Gm-Message-State: APuU4Z+8wL9xtzl7JovmKWjrN2X1MHzvy+dKJ7Oo0hIXwqJ0Y7dUvWxn
	J61qGa5K7+jcDLHKlnfVNBW/mENLPLvcSJtWmnXV/pefw7kliSUmMm6Yp2gagPuW
X-Gm-Gg: AZFdTZdeUKZiG+UjDL726NOMp2S7u5dIbY7nWNIvuskQGgQmc5j2VcY6dBExUFfrSEy
	yyaxjsgugS4eaZ1ND39s8V8qqpygAxIwycccg4+axZfWxIh5XkUvFttgFFUKFUeaSO8DDQDZ7sq
	6GVI1rHkRTP57rx/ErMiTwPsJWtGtgBVPp6M8dYB+Tuczm/7eo3FIy0WDEtNq+WlUje5nXZf7Po
	ecmKSPLGQnXRE/+T1UxWGnBXAyj7owp2T91j9icjdNcaZTPon9CXTrAW9I7B0kV8AEFM3olPcyE
	hbjsM6G1sV99Bi2uIKsHwkk0qhoyamWOWgD+LPYg95xxXc/bmQ2Rm33Wsh8VWHUu/Sh/QIHLbwl
	CcxeNu5qhu8hQo4wGW3yhlei/3hktQVqWI66vgj1lFR65ApXKpd7xQ/NUvGf7LnGrEjlGIg08jM
	V61CCHHYvTMe0qe7l+0OUKGQAAjMfJ52HKH3rUzDZpkQfZXsDWMi9FRRcv3j16pwDuSLRbqi+zK
	t6ABUeTRreY4ghZUxSvq6QHVqRayenDQT6PWg+LR0CW2WyvUOHpp9tDA+gr0hxq
X-Received: by 2002:a05:6214:4599:b0:91f:882:4854 with SMTP id 6a1803df08f44-92134bbcd86mr153981776d6.55.1795372777055;
        Sun, 22 Nov 2026 10:39:37 -0800 (PST)
Received: from [172.17.0.2] ([74.235.103.135])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921349cd592sm86458976d6.16.2026.11.22.10.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 10:39:36 -0800 (PST)
Message-ID: <6b0336e8.9ebd51ef.1441fc.3da0@mx.google.com>
Date: Sun, 22 Nov 2026 10:39:36 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3160111943242088031=="
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
To: linux-bluetooth@vger.kernel.org, simon.mikuda@streamunlimited.com
Subject: RE: [BlueZ] avdtp: Fix error parsing from failed delay report request
In-Reply-To: <20261122103851.681782-1-simon.mikuda@streamunlimited.com>
References: <20261122103851.681782-1-simon.mikuda@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3160111943242088031==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1218571/

---Test result---

Test Summary:
CheckPatch                    PASS      0.47 seconds
GitLint                       PASS      0.32 seconds
BuildEll                      PASS      16.23 seconds
BluezMake                     PASS      236.38 seconds
MakeCheck                     PASS      2.66 seconds
MakeDistcheck                 PASS      119.52 seconds
CheckValgrind                 PASS      122.69 seconds
CheckSmatch                   PASS      240.77 seconds
bluezmakeextell               PASS      79.79 seconds
TestFunctional                PASS      1047.08 seconds
IncrementalBuild              PASS      242.21 seconds
ScanBuild                     PASS      876.72 seconds



https://github.com/bluez/bluez/pull/2868

---
Regards,
Linux Bluetooth


--===============3160111943242088031==--
