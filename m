Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134A025A2BB
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Nov 2025 03:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763956099; cv=none; b=jG9jhI257ecpQhkj0bd0qUgDYHNDmxXKKfFfld32b+moYW2sKfjc/e2Sf4U0+7LTVJhEbIN0LuWs1ePlUTVuKluyI/HbbJYQman0HKj0Jv6SfiUhFo5B8ZOI6qszWR3uxZYCwUfLQY7XIVflxQgB/2i/CsceHaUBZXscgAoyQ2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763956099; c=relaxed/simple;
	bh=7Cv6ybEepf3YAq53Bp/KndyaS+cuP8OimV2j4bdVJp0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=tRNYin7oLTDMfMbyorHFPQ7ZDU6Ree2v24mn4oIMiYKPf7HxNnVX31cPv37+f7SFdiFTqBldo58/dVP1j85lCYAYzJjC3YecxYOCAfxbVETXakYsBl7BeByljT4I7AETz6m6257Yogohc6/DzBKt3hkFdYLYkZOpPvQcTL6oDXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jJaj3dYG; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJaj3dYG"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8b21fa7b91bso321918085a.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 23 Nov 2025 19:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763956097; x=1764560897; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nyDAQ9v9MNnbOdpUQVPW6F77B5tHitMcusf/ZLJE/qE=;
        b=jJaj3dYGAmCyWEQNnlzCGWTQk/qA8lK7yKdbT2t0n2ylCP8Mmng7ORvUyrNXdDIpvb
         c+rN8ogs36/HVcnTXx2w3/fPcFANXC55M4gK0Aj2jxHI+NVhJXSalvrm3TC+UAVIc35e
         yYXStxf+XD+njXlMAOmkbWtaXuTrpobbGvxtpO8UX7ubOAarAzS498HDGsS0R6UqNDbl
         awEeM82jzYzvf7Boj9uNFrY8ibCqrtECR7Ox7SDokuezoYxTtHZhwM3HjbBW2JkSQdmP
         d5TO62nZRQDYJL/vOHKa+2RadBdaNbVuqGcwFA6J4DGxE27BN28oJxYAcTb6JdHszo/5
         ksCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763956097; x=1764560897;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nyDAQ9v9MNnbOdpUQVPW6F77B5tHitMcusf/ZLJE/qE=;
        b=W136HLadtUV/UGGXM7m8Gx55pO0i0vzdl9Y7oVR3iRbc0BwmTmh4JBAvXpZamZfrLn
         wiq4ILbgeDWNIA8cMoSh9sHr26sRz9QatAYTIBDX1AHBZFGpIERvZ+0NJiKpjMxphPAe
         r3UcTm5fTESaVwwQzZmqPr9baU1zMA7v8GITNXAPm5+9bb2M4RXBnVu/gmlgt8c3wI6l
         Hcy331GI3f0aBirCt5KgA8IyzbN+jatB2Mauo5oPavH1PkTm8TAEAGTLI7i3KA2I6eav
         Kj8bdhMw+cm/WBp8vSQZLRo9Nm82xYPW13EH4f3/o2+6rkcLrIRQ56hzv+8LNIlhZtqf
         xp7Q==
X-Gm-Message-State: AOJu0Ywz+sPHcfWH71X34L4NDuWhkk2Je7l9wdT64bCw8ibOyf5NfzYS
	MAY7Eap4LLDse+spn7Ppe8MY9NXzyDU9xhy0tYuUYiI6WFYxrOT9Poc0UHU63g==
X-Gm-Gg: ASbGnctddrKw8W27vHILuuhe8g9sKL+T7n/+ReryQrdT8q1hs89kvZruh8+UWxNKHcg
	dC2kLw0ymgL0fG84Hh/tkKPNs9AgjUh2pIpmLPaXr4vIcghLxksWuUb3LcSw+15q6fSt8dAI1gZ
	DAN3f8bwVe52ig6BhbRsfcyIOAsECCSJ3quZuJu6Jh5DckpdkxJicvzqOCYbO0TvdyVZVtnpoaD
	2zAqVZ4THl0hN5v7MLSnDHzGuc0UoPeld+x9TKaRp6cuDRAj2sXcuLji5aABwIAI94he5X44zuu
	h0NLoxndv7JDmeu07ViXypXoCgbH49Lvxs4o+B5I1hDJZ33qrN6oVWkn6/6F5k3LNWLbreeXhTc
	nllW/NO7X8ZSBqRUsBgVrx9VO8Dx2eMjHazmA9D1/vLvfWfFjlzOxfVZa7RODydka4b5oDP/yTc
	8aQq9QcTyD2c85bxxATqljpj0e
X-Google-Smtp-Source: AGHT+IEdd/GTxkNuOHRb+5Zc1gzrEqiXjr2p2qSLylzQrejBSpaOZ1ed6HO5QMMbBxA+ElNrjVGeBg==
X-Received: by 2002:a05:620a:1a03:b0:8b0:f2bd:4764 with SMTP id af79cd13be357-8b33d4d84aemr1354824885a.63.1763956096675;
        Sun, 23 Nov 2025 19:48:16 -0800 (PST)
Received: from [172.17.0.2] ([20.49.61.51])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b32e82eb0dsm824069285a.5.2025.11.23.19.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 19:48:16 -0800 (PST)
Message-ID: <6923d580.050a0220.2bfe29.3e26@mx.google.com>
Date: Sun, 23 Nov 2025 19:48:16 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0120842973067740395=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ye.he@amlogic.com
Subject: RE: [bluez] profiles: Add bearer field to btd_profile
In-Reply-To: <20251124-profile-bearer-type-v1-1-50b377b65048@amlogic.com>
References: <20251124-profile-bearer-type-v1-1-50b377b65048@amlogic.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0120842973067740395==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1026777

---Test result---

Test Summary:
CheckPatch                    PENDING   0.21 seconds
GitLint                       PENDING   0.28 seconds
BuildEll                      PASS      20.36 seconds
BluezMake                     PASS      625.91 seconds
MakeCheck                     PASS      21.51 seconds
MakeDistcheck                 PASS      237.74 seconds
CheckValgrind                 PASS      293.64 seconds
CheckSmatch                   PASS      339.45 seconds
bluezmakeextell               PASS      181.72 seconds
IncrementalBuild              PENDING   0.31 seconds
ScanBuild                     PASS      963.39 seconds

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


--===============0120842973067740395==--
