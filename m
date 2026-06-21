Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D943597B
	for <linux-bluetooth@vger.kernel.org>; Sun, 21 Jun 2026 19:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782071808; cv=none; b=jMAsP4wNSFQkqDfrS1ySIBiVD5fj/7AQu9TLWbVTNSgU0ZL2LdRJQqkCybLHvZyHkMTuJ/aYAnZEYoUxYY5Z7/B8P1GPUSdLCqAiXy0Qor5G/6zVTJwy9lvaKgVcASFfJ2qPpDG2NnXpGW8+fFnICkpxIDrZri7g2ixyNN9ADMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782071808; c=relaxed/simple;
	bh=Lm4lusNs6e11Pi0jpQYfd3L6YtyK088mwKyLpNM/PuM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Iba4g0/rAah8IALeXdDY7T5iGBDVvBLexLwKFEDz3FumP94AYvDfT9AEOka4f42CwoGphp8N7OVKANzv3lXNF6LS0ZxXywFDaj+uG1hsexs1JMRbGCc91xnDm8cqV+ZKc/NnN8/cmufCX5E/c4/XBUSqsb/fzuyDOwLkWezE/Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QKKOctn8; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QKKOctn8"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8de0fff76d5so30853926d6.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 21 Jun 2026 12:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782071806; x=1782676606; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ovEI8pyvpPk0/xW5ZC/o5F9wBoxoEEvgekRZIp8rMNA=;
        b=QKKOctn8r/q1gMuadRfmb5wp88TYJUoYQPCVr8B+XwHM3h5Vk5pJk7maa9FoIRWV+r
         3CEmrlS7DDjwozFKfl1qJUVXyqsa1lXNtm6c0EZP9ri+P/tNDHl6d+iIbjVrDvlvlWBo
         YjkwGOh6P+tRnKYqEi9YLbNhrK3PPcgmmuSXE4udWDn61hu+wcJxT3QBu4eekfe9N0EP
         eoEEukt3lracXaDr5tmg9C4dxCynuFOq98FEvo4y2RRO1++1AFvclh32ei2CVpA8+ZV5
         S0UuUOvcXLHQIJNPeANWQ18HzjZYA9qjWZGVEwpJiUG2lJAgL/H/sJ9dAqP96bHSIkMj
         aDYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782071806; x=1782676606;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ovEI8pyvpPk0/xW5ZC/o5F9wBoxoEEvgekRZIp8rMNA=;
        b=Uq+EuZImH0MwAbudAn1PQe4Z4WXUW0rk5zOm5whS4kLeOcXzQGNuzhXXXVYF3HKwK3
         GdoSKbzBAulOmXjQCFJpxtytW7LAI1/cpE2Bf2s5p3ghmHCIoPwem+Gt/XTtV7/PTGje
         ZdPVRjzWNx1C/y/LQ8eGdi1IMyzByymLm1BtIOLwZe9EYBXBVO/iIPAyIjAh1p1ORYyd
         00b64M7bSfAE6S0QEGQ2vlgP/Pzk0MZFi0Y3+WYUAwpWu3IqCi7iU4b+7M7LmveK8elY
         7LuCZNKIgYID68tIceV4cg1emB0XPZ/aLSEAtvnKb+J/HbR9PE4U/PBNuKwNNVhbZFIk
         JkzA==
X-Gm-Message-State: AOJu0YyD+1eCdXbc+DEKT21Jx7CWKjQCgdMP/Ud9VRu7YNHgZWX6VKwX
	823ooU8uWEmVrCln9iX6yh/ZAG3e1vbSvS+J+On8cGmbUvFMNAPSs23wPw6xBQ==
X-Gm-Gg: AfdE7cm2YaqAX7QN0aQin99p+UUC0hxmg2YSPm3ge0HF9BcDf6hSBS+YlBQuiQDFuzW
	QBs/BcMUXrlVHWDgJuN/z5mv8RcUZNqliyStGdQRZPd0XvQPdGMa5cpdhXwe2HRy91xs4kASLxe
	Ia7TPOcivQommvGAf3T+/9MdZt4ZdBADnISzH7XHe2FTl3k96aJZuFh3kRV5kxDV2BOZQf6v/0m
	tK3SYM09c2Ngqh5285LzFz1fbC0EyRmEp6qquh/2rd5xOYq2+0q/GBXYUsCYg4Rm1n2i23kZghT
	2L4gMaq8pzBcmbjz9tXarqE8oRDKSvyv294TnJ53iRRLi48lcOmyw4hABiRGtsKpFtprT9f+5Uf
	3zzhQTIltVttjp4OQGFq33jkgbvCvqDp4Yo6+RW0ONEM94w8fRHiy6OGo30x4NYIzVF40ULZlj1
	EgvbsCwhMeuf7+XYURPOo=
X-Received: by 2002:a05:6214:3213:b0:8dd:fcdf:37c2 with SMTP id 6a1803df08f44-8de41f84819mr202270346d6.37.1782071805829;
        Sun, 21 Jun 2026 12:56:45 -0700 (PDT)
Received: from [172.17.0.2] ([20.83.158.130])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df7f015805sm72704126d6.1.2026.06.21.12.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 12:56:45 -0700 (PDT)
Message-ID: <6a3841fd.faeca26b.a53b6.726a@mx.google.com>
Date: Sun, 21 Jun 2026 12:56:45 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7758174847089848507=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kapoorarnav43@gmail.com
Subject: RE: src: Remove dead assignments in batocomp
In-Reply-To: <20260621181534.92005-1-kapoorarnav43@gmail.com>
References: <20260621181534.92005-1-kapoorarnav43@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7758174847089848507==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1114380

---Test result---

Test Summary:
CheckPatch                    PASS      0.87 seconds
GitLint                       PASS      0.54 seconds
BuildEll                      PASS      20.26 seconds
BluezMake                     PASS      655.79 seconds
CheckSmatch                   PASS      354.56 seconds
bluezmakeextell               PASS      182.62 seconds
IncrementalBuild              PASS      660.77 seconds
ScanBuild                     PASS      1029.24 seconds



https://github.com/bluez/bluez/pull/2247

---
Regards,
Linux Bluetooth


--===============7758174847089848507==--
