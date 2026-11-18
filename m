Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795032418;
	b=SMFTE3lkWPpf58M1xXQIdFvqURCtNByrHPJHt+lzRrDEg0kp72lMNIQuJpvSzeNWOQmj
	 lL2Wy7VOWSCRNUEhwq7o8GtF+LTEcy5Ug/qgEXkdnkmW6mRoxGSzIiNtvtqWmem6JFpC9
	 gWSR1OCDVLeSGV68Y7E9CQ2+e7K672EgfEsiq7JyoKh2oYO7fNOwFrPyiQnUeA5AhkntV
	 F6bsFTGXrBu3C6oB4tH15cVwwSv3qf4lw19bQbWcHy17wE1rhPbgEftAAarnGdU8KdBcX
	 2eQnPlFlPxLL0Uk/crPXi8Jhw7iX7B23UyVompqP9IzzwznjC3ExnielpZsIiY969kQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795032418;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=Eo4zfIyzQiNQac1rrLg2Coxls1edA4Yxec6nEWygMiQ=;
	b=qmxZK/7755tsXv1AWzkZSfXolxuC4X4ILFgDNBEWqculZZeI8kEKKas1+Zoy6Y74HvpD
	 TsWJgC4/hDixoOwYaJ0gJLM/VwPWNMBxKEoytPFhf5V+ssES7H/pZBY/00JBF7EEIHITS
	 O3mQU4PJQ1ukBQaWZmkxWS09O/kXXKjq7UAwrzCaG6FJzlSYqcOgx2Q9v3sABubKjZNoH
	 nYsuToZEQSnOPOWgHkyB3+ycOgSVijELOmARJ8ZIjRKLS7VQOn5x4BPO26PPoen9iEBgY
	 zL1d9Eyg0rpXO0SOu7QgcUPz4UtAdJpVYcqOSwasPF2lUwpIjpI+RsS9OjK0QGNSIPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vSP99EA6;
	arc=none smtp.remote-ip=74.125.224.44
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4365606A85A
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 20:06:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4365606A85A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vSP99EA6
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-67dc7eb1442so1481229d50.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 12:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795032417; x=1795637217; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Eo4zfIyzQiNQac1rrLg2Coxls1edA4Yxec6nEWygMiQ=;
        b=vSP99EA6ExDjdukd2LsL4TbGXKWcg0ImqvqPxnJkgPxedNB+6/d09MxPoTQoDHcCvf
         L+ZNksa5CHkF8MftZqfPZoxMlhDjXAkcA0gFELirPYOp+7ymbTE4b4mC4ZXYFJVQ+UVt
         JUGItsZIpvCOKARiJ0S2smhi8t3jU9Z5+64fVjFCkACThku8oZr1n8nL4rjXZU4t72/L
         XLzvACM/983TPExdMM82W80azX5WxcuOImeruE7ZWEEEwRNd0UxxJK2moWP+A7UGYhki
         ktpOqYp5TI5fDw8zUzH6NTN/yTQHQqq3TvQcCIZlxDknk76SYWlLJuw0OSMVbP7EsX7J
         vNTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795032417; x=1795637217;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Eo4zfIyzQiNQac1rrLg2Coxls1edA4Yxec6nEWygMiQ=;
        b=xngCwymRrUPzuPWmwOboJq1mI971JLhpn8W0Cu+bbI9jE73tiDrt6myNcQtZ4cZS4O
         tu1oiz6HfAq0T0c4XX8btn8UFaqSqRbcsA2Z9Rjgna3IbqpiPox2xDUDodIutrxguBb5
         Hc/G4feCSeimOsq/b31DEA7UxuLvkSi3itVJCxuJDgqIEEMPsP9tL+ru76TObrn0+1P6
         ItBbafXfidZZjvQJ/kUz//v+CfjQGLn7h1xAln73y2B4zQqJIukU6u9+tkfoD2ur9ioz
         lvCXVHw6HMlnVof6rLxASDryzl0UA7acN8DVR+YCPoNMeLnxuhEWxqxbDUsHNSJ4P02Y
         rDsQ==
X-Gm-Message-State: APuU4Z/EF3T+hFXQaOkGQ6iOGaOHwR29WrS1/WG9g9rylqiEUjYb53zd
	w3B7AN3hZ0pUvUlHltw9Xnsth4Ap/Oj0Z0G5dcRvjyEl05qiMaGXfRK0aAvCSw==
X-Gm-Gg: AZFdTZeVVlO/s1zxlZAYuCv4LReVecyELlDyJCI7osh/AFDuUXl/h4cL6LiKaKTlazi
	IWDsAzvpj2oeBoQc/evWcAQNHFY3DiypIGNoD9rCoTbOar9UHu8j3EUTl1wHniMashi+2QL6eF3
	GGHH2115nEuiyRcS2NhvAhd+2k8z3pM4ApJLKGl3emIJc4aq6tGg+iXEZqb725gaikXyFVIdsX8
	56f3aTOVVsBfqJKaWMns0/dZv1DMHNRx+Lsy9wK4siLoAw3H5X9NpfSUKJdPF33+UAKT9KxdA/O
	9D/rE8Rz3zMOxkPVe7QxD7vrvMwGDcdo6ZrHkHRdBSqFUJeB92U53zGTnTvDJ3HbjXO98uDeLvn
	onCox5SvarjGthBylpTjk/XJuMhXNxz66RfQXda+hl31MJRrnDmBd41ttE7oJqTnC+lg64DnUCC
	ArdiMLKa3Y1RatG0ESvI24IjCcT3mkK9OGMB7luL4eYF5Hc0wGblrfcMwuiH8LW677As8V+v2uw
	D142O+3dIH5JaycjJ0tmPzT9g71Z0P2+irPMvFWA6krChjcY3vXqp63wc5jLlyq
X-Received: by 2002:a05:690e:4886:20b0:67d:bbf9:11d5 with SMTP id 956f58d0204a3-67dd3f83317mr1365102d50.55.1795032416761;
        Wed, 18 Nov 2026 12:06:56 -0800 (PST)
Received: from [172.17.0.2] ([134.138.41.153])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67dd58733aasm2217085d50.12.2026.11.18.12.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 12:06:56 -0800 (PST)
Message-ID: <6afe0560.1caeda21.38a6e9.21fa@mx.google.com>
Date: Wed, 18 Nov 2026 12:06:56 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7017627988419444980=="
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
To: linux-bluetooth@vger.kernel.org, khidarlaminehamdi@gmail.com
Subject: RE: Don't probe LE Audio profiles on unpaired devices
In-Reply-To: <20261118141438.308232-2-khidarlaminehamdi@gmail.com>
References: <20261118141438.308232-2-khidarlaminehamdi@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7017627988419444980==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1215085/

---Test result---

Test Summary:
CheckPatch                    PASS      0.97 seconds
GitLint                       PASS      0.65 seconds
BuildEll                      PASS      17.87 seconds
BluezMake                     PASS      265.62 seconds
MakeCheck                     PASS      3.56 seconds
MakeDistcheck                 PASS      136.21 seconds
CheckValgrind                 PASS      144.07 seconds
CheckSmatch                   PASS      245.57 seconds
bluezmakeextell               PASS      90.92 seconds
TestFunctional                FAIL      1168.70 seconds
IncrementalBuild              PASS      276.67 seconds
ScanBuild                     PASS      959.21 seconds

Details
##############################
Test: TestFunctional - FAIL
Desc: Run test-functional
Output:
FAIL functional.test_bap::test_bass_past_earbuds_transport_acquire[hosts11-vm3]: AssertionError: Failed to acquire: org.bluez.Error.Failed


https://github.com/bluez/bluez/pull/2845

---
Regards,
Linux Bluetooth


--===============7017627988419444980==--
