Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282AD12BF25
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Aug 2024 08:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724661763; cv=none; b=ogcs+Irh4F5mWALeYihKWuG+Sa5F8Ng60nKhH5X0OgQpnN8gnf+/DQDsyVUnC3wIxw6g24AlIuFxqnTpOH/iiyB41xSbTtMpLG/uvFWWoaRn3fCDp+OkqXbIp9gGh7AwFm8wBcm5PX1Z/xXoey5e9ce7N60uQFYYNxymOhnBMuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724661763; c=relaxed/simple;
	bh=TAEJblbuUIYgESgqBvGiZLqfuT4kny9+RosiVBaio6k=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=PTcJzRlr52dNRwshAl2+ff2reI3pgIXufpzg+YR21SHYZRFFZX8i7wcuyaQCo8U8NSUTej6Iye/z0m/ACMAIJIohCeczoMlLgH3ROJTyzLTVx/um2PynE47kQdyCl1vwaJoRB3vfqb0JGEW/66cKuEQnCVpDva7EDoK8YxaStTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ThPfLc5S; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ThPfLc5S"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e116a5c3922so3839393276.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Aug 2024 01:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724661760; x=1725266560; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TyL68oNqbZtPoWt4Jok9Q00ZD6OwLQ40Gf8znS4WoTc=;
        b=ThPfLc5SG6nOFMsvBeG0fadPKx7Ftyzw5zLb08Yyz8LeFDDrD5xLFL+iLZG3RzHG1F
         lfcF6SaLPTMm8PryBnw0QL7Qyx7bi2kHweElAmb6AWdWWnpTNT4xn2oNvUK8QLXGqNlE
         /GmPUP2jBpZevaK8OvjilO2pSX7zWq8IqB/Z4XpOyLGd4OVLcQRvL3fYGw4ylgBUY8Dx
         AjPy6R4Y/kb8mWntbZk3/pj9gsSUPw4oy7Q+KpVmCGgOUDnxDWIz49bS/G0AiPjhbDRT
         vzN48vhRkbp0UjkWGv42wgS8E2BG4gvV11EdcZNt5Zm/eiJgjTmlOatw6/H+/ThGXUMs
         XkAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724661760; x=1725266560;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TyL68oNqbZtPoWt4Jok9Q00ZD6OwLQ40Gf8znS4WoTc=;
        b=QV8Gfs/s1vTrHQxdwVzg9MNzytn0vAIoxtRDkyyfZ5cpOz9qZiIA7YkpgTOR8i1Med
         xrNC2emKPc8Lk9sG8Vu/oVSMR9R+sUmPCro5m3NB12+e5ixDR4DYQtsH0mM2rlniwAeB
         eqmuPO6md2/FFAXBROl/6+oom6IbvZNz4wps2YwDmTtW8dPyPfMTAhglVr/wNUdsifAk
         E1+DJn/lPeAnCvcq5jCTIBhM9ktnQfZQv8JUeKEoXQCHB/TzDXi8A3dr0jYSym4zgnXi
         znoFeh4IJOjeGQnbMhoMmm10HfGtPXwDhvFq6IVYWhaN2z8SjKwJG9SpLySS/dEsHCUh
         5liA==
X-Gm-Message-State: AOJu0YxLcWIcsmUeXHwsdfwVcZYEiyCSpCD+QkS0RENVI4zJhrT9SD7a
	RKKmseMk/DOviEQFfUZRvf8z1GMsiTHr/hgY6yZJNXM4DWzS3eFckJw5Vw==
X-Google-Smtp-Source: AGHT+IHrvSficghlT7TocPrA7zz7gpSIu1FE0cA7UgleKu0u+tj1Ji2YENbFyb3lKhI8LJKjW8NO/g==
X-Received: by 2002:a05:6902:2188:b0:e11:7176:80a9 with SMTP id 3f1490d57ef6-e17a85eb523mr9140956276.26.1724661760422;
        Mon, 26 Aug 2024 01:42:40 -0700 (PDT)
Received: from [172.17.0.2] ([40.79.247.110])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-454fdfc2835sm41269211cf.19.2024.08.26.01.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 01:42:40 -0700 (PDT)
Message-ID: <66cc4000.c80a0220.26ca58.c69d@mx.google.com>
Date: Mon, 26 Aug 2024 01:42:40 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6160995548822945997=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_chejiang@quicinc.com
Subject: RE: [v1] adapter: Manage device state of cross-transport SMP keys
In-Reply-To: <20240826070438.557107-1-quic_chejiang@quicinc.com>
References: <20240826070438.557107-1-quic_chejiang@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6160995548822945997==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=883189

---Test result---

Test Summary:
CheckPatch                    PASS      0.50 seconds
GitLint                       PASS      0.32 seconds
BuildEll                      PASS      24.74 seconds
BluezMake                     PASS      1699.99 seconds
MakeCheck                     PASS      13.24 seconds
MakeDistcheck                 PASS      177.91 seconds
CheckValgrind                 PASS      252.14 seconds
CheckSmatch                   PASS      355.88 seconds
bluezmakeextell               PASS      119.64 seconds
IncrementalBuild              PASS      1581.67 seconds
ScanBuild                     PASS      1003.40 seconds



---
Regards,
Linux Bluetooth


--===============6160995548822945997==--
