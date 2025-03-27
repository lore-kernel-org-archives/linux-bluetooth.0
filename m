Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780831A8F60
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Mar 2025 09:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743068249; cv=none; b=nG8KwdgOioo/Zt3nqRjJdMIlZa4F31JJTkAreDLV5G2AXarcg668AxJUDPgxXZcO/YqQUFzWTtOVhF+XtCPOAvZAeAWn6crbWM3dQtiJWh8o47LyjJ7zypFlzBaaEIDSQK9JFzNmHHOlfaYP4jQaL4g8OjlHRJKMfKJdIVyBP+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743068249; c=relaxed/simple;
	bh=mO6sKsxXOtkkrfG73QDQv6wCM2WIhkNBp3WBAuPXWyY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=bTzuGdH6xgMXIE2lyi6Y2WlI/ZXcYCbj6nVmlY94x5HK8sTcRNuWVAnHuPurRTTdPd5zAdkoBdrANjo9GZBoaEkVCxnWrEieaL7vzJPWoMpzGxWNfnKPGy8rVt1mMSZziV+Dby2hdoH07O/KUscK4hqfyEWL0Kng13Gzl1pu0T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cl2EW2gg; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cl2EW2gg"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6ef60e500d7so6566497b3.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Mar 2025 02:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743068246; x=1743673046; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oCcV4JEmqVhfMqwB6gEOMkZwlwvgOq/9WnA93QzFT3o=;
        b=Cl2EW2gg/W2tn4b7xJMqtltoNEoJyniGigpxdK/qIpM6PdftAm+J+vchEQnPqduLDG
         Gn2VL0+vD4Y8+hu7b0vB69UybWEHwu+1/VdXP1rIwuZtZKgn9kselJNBIDcKEijwi6gh
         HTZy6P8VwdtHa82k4eGMMRA2meZe87vxvN/MqTyC5Geayn8hYalI9EltsWP01N5CrMJJ
         4NV9xr3A/A89Zk39TO6xH3+bQwk0kJi4tooCZVVAOCZ1GMAi6ltUZdrmxo/3YWrxKb/1
         ABYH9jkDRfWn7KmbBZS8LOhkPdITUz72SCsyWojBjkd2POBiXRsw1fIht/SDCIEvt3ik
         alYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743068246; x=1743673046;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oCcV4JEmqVhfMqwB6gEOMkZwlwvgOq/9WnA93QzFT3o=;
        b=iZVB72V9WVO9u0KHUWsGlMSoFJSnK3DpwN+PZNvCnH7qA4OES2a9ylVakwiV661hwy
         khoJh5HVAp/6sM/o0ThWhxfLkKkXDhByUKLTm4q4VmMoEjw43CQwZxwiesQpOHI4UlwQ
         TBw0zedz2ztIJKXftoq7uOvZN80y2robWXR8FAV5KGww8cXNaiZWtHEa8Dd/CotdIqj+
         phrKQyhZvH2FJKXNHiZsOsZ6N9iBFQldyGx9F03/5hAVfCtRd3K2IwUhyFrslLcQEk07
         NSEPD97AEQ16qHremaWC3ZUrdKCDVGqoRu4IwfBxdzCDfpPUS4iieYYgVt2V2m25iek0
         BSZQ==
X-Gm-Message-State: AOJu0YxykE/3p3WIjItnovL8dHDFQeIgqjp9jleP3D9byDXa0cTNCyW0
	DzYmAi1RXNUcK0fUnldfsgd7dKyBslQf26kUlJE+uGEU12HVdlPLCkN+oA==
X-Gm-Gg: ASbGncvHUihmu6ETMGd7pFtvYplkcqOANSlyOcvLM/fpn1HH7VKcVFgyifFZa1/cKO3
	L78ISSACC9o9iFOfl2RPaqDsZPfH1xQ9+CPkZkaN5vG/pAztFiFccr8PjfrqM8GYhahKs5YxUrH
	bCcyA+pUNFVsFuuarzlFSvegGS65zh/C00LZwXFI7AGBBrXZepoPHjTRj4oiY00DCMKd9x8C4dU
	0L3tVHwUHEZXoDQKhMRblNddNc/J8okX5owRyhF0qj7sQyrcLkEv2clMlUknIiuEKU8B82UGCkX
	UZ1loGMEvEeCEa4eRDcclIn9XPXv75sNOhTRzr40KgeNyvIY8uk=
X-Google-Smtp-Source: AGHT+IEhDDNBy7G/5lJr9uob7LesCD1pmSDhOOspj39wTunf2yOSIZhMGWKEGsQYgnP/rvxMnSUkHg==
X-Received: by 2002:a05:690c:6f89:b0:6ef:8dd0:fff9 with SMTP id 00721157ae682-70224ef9a35mr36767717b3.8.1743068246037;
        Thu, 27 Mar 2025 02:37:26 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.54.74])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-700ba73b9a0sm29652107b3.12.2025.03.27.02.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 02:37:25 -0700 (PDT)
Message-ID: <67e51c55.050a0220.264bb6.c82f@mx.google.com>
Date: Thu, 27 Mar 2025 02:37:25 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7113973618789725878=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_shuaz@quicinc.com
Subject: RE: [v1] dbus: Fix add invalid memory during interface removal
In-Reply-To: <20250327084128.3315736-1-quic_shuaz@quicinc.com>
References: <20250327084128.3315736-1-quic_shuaz@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7113973618789725878==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=947676

---Test result---

Test Summary:
CheckPatch                    PENDING   0.21 seconds
GitLint                       PENDING   0.21 seconds
BuildEll                      PASS      20.58 seconds
BluezMake                     PASS      1463.81 seconds
MakeCheck                     PASS      13.21 seconds
MakeDistcheck                 PASS      156.36 seconds
CheckValgrind                 PASS      211.73 seconds
CheckSmatch                   PASS      281.97 seconds
bluezmakeextell               PASS      97.21 seconds
IncrementalBuild              PENDING   0.28 seconds
ScanBuild                     PASS      859.96 seconds

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


--===============7113973618789725878==--
