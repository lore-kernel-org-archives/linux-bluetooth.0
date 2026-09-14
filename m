Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9398141D629
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 11:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789385383; cv=none; b=DIiqK5F3T6VX18A2ufyEBYw/Im7Toxjghbn05WZr4+7qc7cE96y1UqlCWeejMgHuv5i69zpcPJlYLjuGZL9EW/UgftFUdBIiJ9ydGs+5Uzv9SYKMgSham1JJkJx4B79IzK2XiQmFDOr0WqreokdMd4unvIoLORPP1Aj4UaVFKjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789385383; c=relaxed/simple;
	bh=c2ruL8kWAyY0+iEF5IxnoGllxf8AgPo5bev51YxdgMo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=g/g1Gld6YZww19sAykUAtP/Hp0ckIMxnV8IerZ6sBjAjF4GnpQCj/RItT+GgJ38NAmWHU/3K/Vuv5isD7MtBj+HTIF2Hjoj9m+VLq7q6gTW9/41vGzRycXdCrNZRVpTQFypq4zUVvF+pY7MLWFbOFQsS51cjqKNmRjRBV5tCA3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B+Y66Ch7; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+Y66Ch7"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-52fb76ef1d0so21839081cf.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 04:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789385379; x=1789990179; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=lhtz2O9Qq9LB8HxdqKxcwGe9TsvZT5klV1CeoJOs6OU=;
        b=B+Y66Ch7JAcI+TEU0tglNqHz46+P2LjMyu9ZYl+yDyv1GXf8c0xgVKJ+yJo2Lruh8J
         rDFvpokz1vfV14narXuzffQVYEfvFVMonPw+IYgvhM9AwHvVOXTR/f87lk9E62dffrCs
         BKVtu6Z5/YQRfGidauHGWLGECouzfDXQzX2ZzhT6aM0V9oYxM8NKyYHrm8pbHMwg/eRM
         TRqJ5rLd0iHbwPMhDd3aqmt+r5XVejLKpMLFPiyXtAi+SCXxMwwBfZwjF9A49sO+Q/gA
         sUX/geohp2O+c40Bthj5QMPBIRe24ve/ndPfrr/c2Xeq+Frdv6LnMJn4u/yqmm9byQoe
         e1MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789385379; x=1789990179;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lhtz2O9Qq9LB8HxdqKxcwGe9TsvZT5klV1CeoJOs6OU=;
        b=e2LWx+YYXdZ5GyMG4Ah3n5hY4nsFl6/hxU5wW+ijl/anKy1KLHACrNZgI+rtM/BfAd
         piE1rP92+Fa69S88XmqQUbIiOx5+g41qigZwTYUI+GzZMh/X1BPDspYhbEeD1uQICmlV
         rduSj+hiDBanLFZ7ckMjuVX/8chBsJmmu5XBgi981q4wvw3QiB2mK6scv3q8joNJBNto
         VgHqrCGE98FluFvw8+tVQ/kUDa4tPPWFEx0B+Xid1hWsdTYLPIL8DCByL7hNA1JUQv64
         M0O55nu7Jz3IaguYBg5r3PeGwU6DOqCe/FoCsW+cdpxMFaOKAG+55IO4HAiHRSPJj27Y
         Xhbw==
X-Gm-Message-State: AFuF++nOIgbk2qVWH9ILXF0xtxFJntchwk1x0TbqQAgRrcrtMilm5Cxc
	nkg/IU65XaQdJGKkU5V1zHuMEH79eZNPpMLpnZDML2F1UdFMFYyFtqaOflWM9A==
X-Gm-Gg: AYBFou0+u+7fc0bvKoeManRlL/URhZZ8Q8yuPSuJ3RdwknvMlffxudZ7L2/aiQHuIJp
	ah1NG1bg2s1junkZ2AHHcvrHw6rqoKBp31w226PTXwUbwjyMKXDmI/7SsdRG3H5UqCKHSGCadwz
	JFm39TFtTpFjf6s3F/qhMyzf1s5DsaNwzgm5RTyjb7Q+IcdhXORaUQvIholw/GOW+rBq4usk83U
	xOlb3Gdhv7GadkorOl1oHbT/iX7D2weYjLIlqT0U9zzR3aQGeB0Y5oFWq+/SKzcjgL7QbW9UD3b
	SIJxzenIPoMwp0/rTZNlaE+zAbfD6qd5gJ4zztaZqeeMB/3ZjXAgK87KOA2tRayOMxz9sAQO0II
	aptqTYserMwNQqofCD3ZRAVvAauHrvospZ+hE+QBxWvx4T1VQyvewDlEVBnLHwCA2rEwtRsManm
	boz3xJx6AVJi4z00ZmpXb/NWgxPbHfNl3DylLfWVLaTrg0SP1jfPnbWC7iuNWGdfG5RZ6o1iCND
	eru7Jiy8tO1+gE=
X-Received: by 2002:a05:622a:550d:b0:51b:9878:8242 with SMTP id d75a77b69052e-5310cf143f6mr28237241cf.6.1789385378832;
        Mon, 14 Sep 2026 04:29:38 -0700 (PDT)
Received: from [172.17.0.2] ([20.98.23.162])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530ca45b61dsm96621501cf.6.2026.09.14.04.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 04:29:38 -0700 (PDT)
Message-ID: <6aa7daa2.8d510ab8.195387.7513@mx.google.com>
Date: Mon, 14 Sep 2026 04:29:38 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1417487481883910100=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, tzungbi@kernel.org
Subject: RE: Bluetooth: btmtksdio: Fix spurious ownership error logs
In-Reply-To: <20260914094631.3222026-1-tzungbi@kernel.org>
References: <20260914094631.3222026-1-tzungbi@kernel.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1417487481883910100==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1164390/

---Test result---

Test Summary:
CheckPatch                    PASS      0.68 seconds
VerifyFixes                   PASS      0.10 seconds
VerifySignedoff               PASS      0.10 seconds
GitLint                       PASS      3.39 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      29.09 seconds
CheckAllWarning               PASS      33.28 seconds
CheckSparse                   PASS      36.32 seconds
BuildKernel32                 PASS      29.03 seconds
CheckKernelLLVM               PASS      35.00 seconds
TestRunnerSetup               PASS      772.25 seconds
IncrementalBuild              PASS      26.05 seconds



https://github.com/bluez/bluetooth-next/pull/765

---
Regards,
Linux Bluetooth


--===============1417487481883910100==--
