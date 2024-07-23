Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E05C14A4C1
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jul 2024 09:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721727785; cv=none; b=TEV0CR87FOBXyr5HBYiGZJUL87ADRyC0L6qZOx61Qq2T/NimJMbnPeiW+L6Ewq3pb4+SeOJ3BW5sBvyxuigLgHxVJ7ol6akSId5UGhgT6spxONVXjOO46sJjyWViQilDkdQ+/fjJghriC+LeGuiCjdgQMVYU0y0zoxVjSoN9NuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721727785; c=relaxed/simple;
	bh=2Hyf9krgJixxA8ljX9qYYnzlf7Uo2DFZMIAusqEmt94=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=jHTHp9k1CsXqaiSP7eqFqVkaWEUD8St4hRlZKsThdJ3yn/qyhSllXxIqnCTGR0zn0Uk2N7wmPH5m+ihCp7BBgoMSzV35wkTqCkNMcv4xzvrN/d0D1Y6MJY7EwkHk0H6cvPhMgpaidhwCrfR1eHdmiGOSVvjbF3067lmnb+s7IAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ir0ZQjyw; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ir0ZQjyw"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70d2ae44790so1177626b3a.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jul 2024 02:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721727783; x=1722332583; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EaUElIB1tUR1xZpX3WZOmagXxE5ZMSAF4K6M+8iBsto=;
        b=ir0ZQjywTHmIsgfVxqqwUprY/zpnQpkmxUINk12A0DaLIDrhMVUm/SZ7NsCGkHpJe0
         HUO/3+DlcI8Bq8iK3Ah44m+u+PHnvN631NPR+9x0sigIQ/cIhKIeHrVP3u1T057oG6h1
         vYvVoDKPYkJt9gw/Mfco9ViRtAmx0RxDvFkfrwxCuzThWvQKEQMCWxdMEWJ+g+qpyPnX
         uOe7LOPQ2Yh90BeWbLxDYhKhCfb2aiUBAu//TJMFygE+DVLwUM9s3Rb4nANhOhavCcYa
         S3ROxYQZ7O+0GlzhbTE3U35e8WLrDCa57YmPF6fCCsJ7CTzOsO2ft+d8gBopOsjL5ZcE
         AWYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721727783; x=1722332583;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EaUElIB1tUR1xZpX3WZOmagXxE5ZMSAF4K6M+8iBsto=;
        b=GjJr5sMYbQPaZmrhB/MKmQ/cSb++z/FzHzkJ1Ax7fO50JlNFy1tf+FrcYaUXXmQjyv
         4g7RppyHZTuQgGZEdBesHtI34wM0/kkGuGkapGFiAsY3n3zby+IpLgNowGNLQpIDHeBM
         t2/A2JXac8ckNYqcgQUa46rhlEkPUkXjOxeS5LA5CAJdyqVCora571mFAn07ceUAJME9
         X4RrLvhKJmmPNNLwf4pBMyX2TK1/71W6QrCfZNMrt4dxY1T2l9mivgUwm/Kx7LNYbpEk
         jjV9CQX4bxUoSJ4EwgdlCWLPpOkVWucXarbtkjIoCZdTClrIbF4kqwJCJ0518YKi6aqG
         G+ZQ==
X-Gm-Message-State: AOJu0YyxxKNQFXsjBd1vFAI4xZx9iZOB9JJYWr4cfMYD1Dsb4HWyPWAd
	ZwcyRkoxlJJKjLJW6zoN7VXq0uvqtydmiawHRcTZSH7f8WShW8Db3W1iNA==
X-Google-Smtp-Source: AGHT+IGZugv2w0hu8qokiCqio3RXce/UweQfBhpdkAkai82kvfDSzmKqp+b/2XSv2LMQ7ldEY9DLAA==
X-Received: by 2002:a05:6a00:a90:b0:70e:8f89:7e2e with SMTP id d2e1a72fcca58-70e8f898fc2mr1046210b3a.18.1721727783384;
        Tue, 23 Jul 2024 02:43:03 -0700 (PDT)
Received: from [172.17.0.2] ([20.171.122.188])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70d1889d815sm4272575b3a.34.2024.07.23.02.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 02:43:03 -0700 (PDT)
Message-ID: <669f7b27.050a0220.45086.9658@mx.google.com>
Date: Tue, 23 Jul 2024 02:43:03 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1689913928241553351=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_dgangire@quicinc.com
Subject: RE: build: obexd: Add system bus support for obexd
In-Reply-To: <20240723075455.2934376-1-quic_dgangire@quicinc.com>
References: <20240723075455.2934376-1-quic_dgangire@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1689913928241553351==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=873161

---Test result---

Test Summary:
CheckPatch                    PASS      0.29 seconds
GitLint                       PASS      0.23 seconds
BuildEll                      PASS      25.96 seconds
BluezMake                     PASS      1621.99 seconds
MakeCheck                     PASS      13.59 seconds
MakeDistcheck                 PASS      175.82 seconds
CheckValgrind                 PASS      249.83 seconds
CheckSmatch                   PASS      351.98 seconds
bluezmakeextell               PASS      118.79 seconds
IncrementalBuild              PASS      1393.52 seconds
ScanBuild                     PASS      994.25 seconds



---
Regards,
Linux Bluetooth


--===============1689913928241553351==--
