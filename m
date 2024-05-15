Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1453158DD8
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 May 2024 21:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715806953; cv=none; b=lBZS3etq8whIik9xnonHP+NhTs/W1L3FjUWdye16nCqyBjWlozUmrI55vBOkM6jmb/LM4GnOblG1uZJYmchJoMPMCATalN4KwewR4XV7vMddqDhJuKJxKv2HHxwVWgeJToz4fCxH9glV00vXvFoO/PTMGwYKtUnyWEn5VwPIC+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715806953; c=relaxed/simple;
	bh=IBnHGsSnS5LNqVsPJ1AZ88hyqhEqH5Z+BZty5W38CVg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=fBmVy3RGHY00YT4gK/EBBiEozXeVTqNPjnsuZAB0lXpwwSS447pdWqrOmW2VbhblmclUMt2eTqJv3TLKM2Vg0Dsj/vhXxdWBda8cmgg/jlIRyZ70TguyeEQzyz6TXEaq+0xoTe8TWPGaSgq87i7/Sz30RpXShVoZPzlvq4dRdZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ip4xuJWx; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ip4xuJWx"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5b2768410d3so3420841eaf.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 May 2024 14:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715806951; x=1716411751; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Tb1OJLTb5QdBjdnd0dSzfZOZfMlqeD1JwlI1lo3b4yo=;
        b=Ip4xuJWxx5w3vnZQqYhmHjCzIGPMjyoNT4/i7uxD9Zt0012FkjGeBnSAZK0ikK/2o3
         xTtrY5StImzfpkFb+y3P3/T8ALECg/g3EDGFEng9CNhzZC+Q8Yr/LhN8Q69xdEa3QrDg
         8gASB3T/LvnPGSACTlJyCnRELwKkkTT6KJWbsRDBeDGfmKLjUY0I1bDSSToMbuY1gdQq
         BMhbFeaNpUSHcdxYOcmpXqR6IElvDYcq443TU6Je3sNVVG3uiB5sb/BJn4YvsBFBglDi
         xQy/pSOn5fwyjZPSrhSxHRG3U3/jFqbMcQdN7j4nAK7hHZXFkonwkNs02lteOcPF1xy8
         6qxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715806951; x=1716411751;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tb1OJLTb5QdBjdnd0dSzfZOZfMlqeD1JwlI1lo3b4yo=;
        b=BLxY5Fso1/udmyKvLsHJQJopsQr6nFwWMDv04MRDJgITwOsxzsla2z1Qa/UmQuH5Ua
         +ntoozJshq1VDA1RBOCW/lvIn9z6ZmcwbdAHIp1IHEZW4jofgCxi2L9JUFcfyy5S8u/B
         9iihkiqf16gs0ZwyWNb+AT8kjYXNsaG9Ig7FAR8vRqxJ87LZW3qyKlRs2pbeinKUzMF7
         KiPnI1yYpuUoaMUXqs+Qf4QyjExqP30EjnOHkxeI8lw1E7tyTL9SuqZfyZCNtbZUC5TK
         nkbJ0flYXDHbFLbooKxr7C6KIuxwBcMTDk/EXQeI5sFPqdov5SG9HodYgm0vo2BAGTtG
         GZ9g==
X-Gm-Message-State: AOJu0Yy+s2wtTmxtbqMqJLDWEr76060Pm++9Pbx8K7flEaqX4QXpmAgb
	8T4eNLwaw2p2gWHU7T1CA8WxX5mArPTIrgbawY/COZnz9QylYKqnLvMU3Q==
X-Google-Smtp-Source: AGHT+IHV0sfqwRK3dDcdTtDDajpXgQCkWNTMveZqVILA9xiTRlSO+Aaunyt9utdlP/zK3lyZcEtceQ==
X-Received: by 2002:a05:6359:4587:b0:183:9ea4:74a9 with SMTP id e5c5f4694b2df-193bb638a50mr1407440255d.15.1715806950601;
        Wed, 15 May 2024 14:02:30 -0700 (PDT)
Received: from [172.17.0.2] ([20.109.39.147])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a166309ba5sm62297296d6.122.2024.05.15.14.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 14:02:30 -0700 (PDT)
Message-ID: <664522e6.0c0a0220.78588.68e7@mx.google.com>
Date: Wed, 15 May 2024 14:02:30 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1653334201423404049=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [RFC,BlueZ,v1] doc: Add initial L2CAP(7) documentation
In-Reply-To: <20240515192655.1784475-1-luiz.dentz@gmail.com>
References: <20240515192655.1784475-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1653334201423404049==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=853502

---Test result---

Test Summary:
CheckPatch                    PASS      0.44 seconds
GitLint                       PASS      0.32 seconds
BuildEll                      PASS      24.34 seconds
BluezMake                     PASS      1684.58 seconds
MakeCheck                     PASS      13.09 seconds
MakeDistcheck                 PASS      177.33 seconds
CheckValgrind                 PASS      246.23 seconds
CheckSmatch                   PASS      357.46 seconds
bluezmakeextell               PASS      122.35 seconds
IncrementalBuild              PASS      1467.60 seconds
ScanBuild                     PASS      1008.10 seconds



---
Regards,
Linux Bluetooth


--===============1653334201423404049==--
