Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794865175;
	b=Qrf6N+iXCjOX93S6b9iSBnYyEG2nf/iTBvmop8A7f1SK7v48sCbB5CgZpg+87Ihqe+FZ
	 uBum8F5tk5ybWkmETRDTWwN3q2xxNlC9+jNy8JT2et/JSSJjuHDOoE7tW4+WNwlEmGfVR
	 ZFIIwTQSnB2S/NpTORjGEMIJ51SmkDCufVuo+4P/2Fs1DYx14aDoLLQxrUOEeVWGidS0D
	 9v8mWshXPfsPdDNhHa+4SphwPbmNSu9vpjGCmLPI1gJoZvePEEWpof5KJRLAn5LhFObsk
	 Kibs25NWI/+g22Y994VkN6MJbqbAYKMfFYB6K5l4FcMdaQu8ztj/0BVMqxcQmN8Vz/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794865175;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=eRYw/3nncinWo9PUSW52jujSpyaNiuMGdc4eZnV97c0=;
	b=AP2tvaPxgfmYqsuMMPeYh+wXR+dqw/lE8+rdTOcK6iMpnp5s0l2I9fkxjdFpgDY9GfB2
	 VipSc+tTSSpXYdt+AC94iqvmj59oieJf5nVy5duTddMQnWJBtlYRIWGMxwmZK1yGXLK+L
	 sVeeTX0GUNkCOa+YTOLITD5Mndq92xKKWZTs93PVLnsW2CHj6wX4+nj9s+QiCF0PJRrxJ
	 Tff11t/SQja3VyIrGfL91o2rdxo1wUKIIxjob+td8Lj7vs1uaxk2x7NzNE89olYD3wgPA
	 +FsTQZaNGPcg+j/9fxDSpB25u5apDVg2SKE86jfpKCSfe0AU4bh/te//M+0EL+4HQ0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=enCXo+eB;
	arc=none smtp.remote-ip=209.85.161.48
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB87C606A31C
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 21:39:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB87C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=enCXo+eB
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-70bf1671c21so3333661eaf.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 13:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794865174; x=1795469974; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=eRYw/3nncinWo9PUSW52jujSpyaNiuMGdc4eZnV97c0=;
        b=enCXo+eBm2N0ImILC6pTzLebjNpUItKxajXXPubhQN24/ScE75w0+w42t3JI46OF57
         q+RK7BfjLSnTwTSjK9dbxSC4kziyG76p/iW06FGHxY+6feZFT9k8QdhxnVW8RenMoC2F
         Gq0A1hFzu0zJIWC+X5Eq9p5oxjDp+hByce302lPynzpLziT2voWemNGl0/0HYABwsnK5
         uqeXzv+qL/XqzlmtBMRA4/CEULnYBB9wdSfhLZdWsB0X07EhPMoA7Rs4CeU7fyrI9c/3
         cljWfCUMwSjcc1kPrVWDsdHegJC5zZMK6aZ3QESgaWRK1k1DiU4dmn8Glm/ATbqQKQoF
         lAGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794865174; x=1795469974;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=eRYw/3nncinWo9PUSW52jujSpyaNiuMGdc4eZnV97c0=;
        b=Cm2NLe7Hx+boe4mPiztRMpzYGPsZonQ6iGwVeeRex6Kdtty6fWr1LioZjK840F0Rrt
         HlA6vPINIXLFW+wCGxbQy7WVogkwGk7QvUWISH+9IIGvyav4kFCdTvHycJtCWcy+vcDy
         sBVAWDTu2ndhnBB4PbVeloAmKU/JOgvpk356716j/ZNVIPUsZ0L4ooXtTBmbB+35fYw/
         +3t6/FK07rwKVMmWCAMQ/fu5fOx+8A9lhEa9YAK4KGXv1XbjqhEkY6yga6VzZa0TzBDS
         4Hr/Y19qvpsgS8a+lo56N5jldLFRjCpgd4YOHocc0siyr4s+6pdIiO5/BhR39AB6rZYh
         phpA==
X-Gm-Message-State: APuU4Z/gV3nihGZ/RbV7nfV0WypzLzjg8DOmFn5Qvjrlkq9I8FrsRZ0H
	zOTDPxnIsmYXy4RdfsOrJUoLY+uGw2ArfQ3Hr5SvOMfumOkODYMBJ39CWmTlQw==
X-Gm-Gg: AYBFou2UaExtADYFUt7+Uy6LjxixocsnSvYAnZfuwFWC9C3jrquLha0oMAT+5IT9Ekj
	pr3Tr/tkoMKByEeYz2J/MDeIb4MwT/JR6Cq7ICw20TGOn1wmkxqkgZQjomZTfPIuQJpn4bhIlQw
	TrxADXDSo/gNTE2AtbKVO1eVuwnOxetppt9/XE7nGl/3dE7oAp9FvSEi0J9n3JCMKViKmg6s2Ut
	X255JV+iKzCin/kJBhN4zWV+1YqQYE/88D+iIryGKr76tRJ80dUADENZmu+DUOIB/BjDlu6Fe86
	PGQFY9Noxruiq/GTwtgZMkDKwwmUgak6csxKY3xirUq1/WsQioeQBo3XvkdokhwO8VichloroRa
	huNyzZXXm82TO4uqkwHoKdhmM3V9hiEPfEpRuGDLLlxmTTuEBDuJLQZ5DasnFbqjStk+YW6YT/r
	QdnJnNxwWywPYLS5bomz2ytQyjcZqPs11D9v6A4XkltkL1x3PtIaOdcGXCIbWq7Kq9a40QTtzN1
	9jMGJmVCj0dP3GDtLxZk+n+zO1SFUsgDIOkbbE4bcZP7BZeuSQU7CO5Fi2KAw==
X-Received: by 2002:a05:6820:169e:b0:71a:f583:67e3 with SMTP id 006d021491bc7-71af5836f02mr3020721eaf.36.1794865173745;
        Mon, 16 Nov 2026 13:39:33 -0800 (PST)
Received: from [172.17.0.2] ([52.154.133.1])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71ab4335912sm9295527eaf.13.2026.11.16.13.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 13:39:32 -0800 (PST)
Message-ID: <6afb7814.a9e78534.3a5257.9542@mx.google.com>
Date: Mon, 16 Nov 2026 13:39:32 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0972917936113940530=="
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
To: linux-bluetooth@vger.kernel.org, kevin@simpleble.org
Subject: RE: Bearer.LE1: Add ReadRSSI
In-Reply-To: <20261116071622.35355-2-kevin@simpleble.org>
References: <20261116071622.35355-2-kevin@simpleble.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0972917936113940530==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1212358/

---Test result---

Test Summary:
CheckPatch                    PASS      1.49 seconds
GitLint                       PASS      1.01 seconds
BuildEll                      PASS      13.06 seconds
BluezMake                     PASS      170.23 seconds
MakeCheck                     PASS      12.77 seconds
MakeDistcheck                 PASS      95.77 seconds
CheckValgrind                 PASS      218.50 seconds
CheckSmatch                   PASS      176.02 seconds
bluezmakeextell               PASS      60.31 seconds
TestFunctional                PASS      895.05 seconds
IncrementalBuild              PASS      194.47 seconds
ScanBuild                     PASS      595.52 seconds



https://github.com/bluez/bluez/pull/2832

---
Regards,
Linux Bluetooth


--===============0972917936113940530==--
