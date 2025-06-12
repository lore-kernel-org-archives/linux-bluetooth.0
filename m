Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03AA195808
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Jun 2025 07:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749711629; cv=none; b=IBiZZq4zZSkn+IldFyapDEL0tx2T+WKIcABjGKZ19HoR1LsVcums/3lL6vIn07abpCMn0UgZbIsA5gryBjZItYQP0BTVqKpH2C7LVXqL/Le1LhYNgTGuIzO3Nd7fGGRm69HB2PjUKrdQ8tGR2s07RzdnuuwJoJBAgzrGHVDAR4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749711629; c=relaxed/simple;
	bh=0LNJ3qJ8ZayEFTpSieLidgTLASjnbpY6xzzTTGzyr6I=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=qQm6zyHHTzRm4X64Dw0HyTP13lbK9SaXavLr1wBFgFA0c1Ddm6BAQqIVgvj1tQxhBum+3/69Y9TTZKis/AFw9oSY8o15nDlPgKzFBdjGxT64VKpxnh+MuX7xzMMGVdiafwgbb0nyTMPCse2QbzKZi1NEDJQJHeeFczHkRjCYf4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gNzh4b6Q; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gNzh4b6Q"
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-877d7fa49e0so362344241.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Jun 2025 00:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749711625; x=1750316425; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rWCU86zB/X9DyQpS3tnEa4lSVyJ1VRwYKYHykF11d/I=;
        b=gNzh4b6Qo11NyIgPvpj1drTjGFyrxZiFya6u7zCCVo3Mc+RcsG4HJTOqTjZL1kTVIH
         IRrDyygZQrQ0o+aT4llT+A6n/v93fGIKpHS9/nFNASfWNrVQB6WsxU4jcXqH13zm/b7+
         /UBWZspSTiBg/1KepeV8MTrWHMlozgwBQJVsG+Jn2iAJQeI49S8Rl3Nc6pJWJcpyJCme
         RFcz+DDTh/SoZSpESheFavUQ8QxkHtAnRMy6aHILtmiptVffvaedLJjhP+Qh6z3HCNic
         gglJFD15yZuA8fMt0Zr4SHNW8MjUd8iC8CyOrDB8dSEDQDkYt7ePUHP6LnO53iqBYRB+
         4qDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749711625; x=1750316425;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rWCU86zB/X9DyQpS3tnEa4lSVyJ1VRwYKYHykF11d/I=;
        b=j5yEzz3Mc1JyRY7s2ewoHN50HkET8BxgHffinT9xH2bJWIheeMjGJ3ATbKZTWIPr9k
         +8tKhvf38zpAtkNFnhGXR+rpwXzkZ60eYumiwz46aJgDOkz3Gfe0/cp+FHMwrWX46OxI
         gpDkB7zlaYqZiWW5npFR92v+LDvmjk+GY3sJWISVxUr+whrVtHCoqm1oI21QNvShh8Op
         nRDe9B1IBmT41P8YB88F2R4Mvlf2Hh/9UVpv5OUnBF8Wv1voEfzWgx9rc5YV9WRnrOB5
         B4o2BtFC0UMEFChyiIqU4Y4hBiwIoj8Qd+C0dRfOswAOxXV9cM44H22xXL7lFQcOu72G
         uvXw==
X-Gm-Message-State: AOJu0YywQlQNze4sZrd58fy1AWc5anuNaecIwYmHzppDh4xBlcAEFEGA
	5I8cf6en6XC+TdUMdGeJc1mRNFwbGl3vKn/WkQISsLAGuTheBHBBxj0a7UenM3nm
X-Gm-Gg: ASbGncuIQ4ovsVohEpcLgPfSt3cn7AwBBHRCswp94ftLMIlIpJpv1c1RV7hIotgVT1r
	w8OLqkd40/3JO+4b/TIw7u5W6D5/zsHKhX+VdzWuw6962EHtCZA5G6WWGiJ0lP5inlFRfs1CLaj
	ind5I9JwyGBrGclaSJPUPUgEkF9SN1cxo6QAOPQGbuvzPnTf8cfNyuVvlRTrpetxFzlWoNnB7B9
	wvQ2Nr+DRxT8Gg90HeOjNEAlpE4rYDMMlYJ1BF2JEnEcps1D4Fgw9zJtKVs7OTMjFJPTRx6QSOk
	pQ5szHP/43CJFSVpbRGXejfMDW9toNg9BQ458yHybhd/EoVhQvvM15kpNSV0KxHba2nR
X-Google-Smtp-Source: AGHT+IGUw8hSUocXB2hzP2QYVWM+XhCHJqMEE2F8KY5ldEWv46/Ju4w5n4R/sB4m0D1uDDblz4Y3hA==
X-Received: by 2002:a05:6214:b63:b0:6fb:33f7:5f34 with SMTP id 6a1803df08f44-6fb34ebe79emr25852476d6.43.1749711612421;
        Thu, 12 Jun 2025 00:00:12 -0700 (PDT)
Received: from [172.17.0.2] ([172.178.11.88])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb35c8511bsm7187836d6.113.2025.06.12.00.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 00:00:11 -0700 (PDT)
Message-ID: <684a7afb.050a0220.367d9d.0c58@mx.google.com>
Date: Thu, 12 Jun 2025 00:00:11 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7648541822233193545=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yang.li@amlogic.com
Subject: RE: bass: Support for Encrypted Broadcast Source
In-Reply-To: <20250612-bass_for_encrypted_broadcast_source-v2-1-9128a437b595@amlogic.com>
References: <20250612-bass_for_encrypted_broadcast_source-v2-1-9128a437b595@amlogic.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7648541822233193545==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=971158

---Test result---

Test Summary:
CheckPatch                    PENDING   0.25 seconds
GitLint                       PENDING   0.24 seconds
BuildEll                      PASS      19.96 seconds
BluezMake                     PASS      2591.70 seconds
MakeCheck                     PASS      20.09 seconds
MakeDistcheck                 PASS      196.51 seconds
CheckValgrind                 PASS      272.12 seconds
CheckSmatch                   PASS      296.57 seconds
bluezmakeextell               PASS      121.05 seconds
IncrementalBuild              PENDING   0.21 seconds
ScanBuild                     PASS      881.66 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7648541822233193545==--
