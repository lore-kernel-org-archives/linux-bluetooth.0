Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4505280CCE
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 17:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745517489; cv=none; b=Au61oNrlr93rpnB4V1kpzdeXZAH85roq6J0/1jpf7ghmcvyn7AyHrSWdWkHj61SSBIYw3tVUFNkKHv45AcTH5B6s7ZLIp4SuZ/TRrOTqdKkN2BlybxczGpmcjnPS2oL4gugs19hbHJlOrR9k13A0fezHDxoFWeDCkVobALmOCcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745517489; c=relaxed/simple;
	bh=EnehdyiprGQvnkSHPLNncIltv7yE/IIuRs5vBe93ggo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=jX3QhGOD/IRbwUN6My7exrIs9Vz9hE59dIXsRnXxvGj1OY/WsW2YSUtEGkNB8kvKHTSH08DbmR5XAWNr7ffx3f2fscdhBUkmnbgd3v7Ukfwn3Jaq3i/ysrnND70EaumaQwH/cgt705pJWTw41Iewjof38tiOJoouPx9IXGUk858=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CVKR2JeI; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CVKR2JeI"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c53b9d66fdso190529685a.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 10:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745517486; x=1746122286; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=g/FM7RBMduetnju9NHiRdGb9ku9PPXQStTdjSCwvAJc=;
        b=CVKR2JeI2SrTfw42cpo7DcuN/72jw62zHo5ovapgdL0hhdtoeTe6nlKM5FFMC/zDAn
         9h4At22FSS8wFdZ49FM7qJrImD5JDgzN9eM4666mThuZu0C/zgqaZ93/1TbMw6i2tmuY
         og7IehVYud1PSKQengYeBtNAKguNxaAilQVR4nDPxYNkXS16xvO+X+iHMILGznerVDOa
         uUfdkrRfQEsKzKCh/Gq2ID7U4lRMsi1OtyPrrrTMYh2Mtl2/KwUKG83rc6v3/tmtKK+B
         ThkKKw/6Y43GPXYFuSvupHbqkhtngtZ8n40unIhARy/Td2HeD9ASf4an/0tItZx7Q8aR
         QaUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745517486; x=1746122286;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g/FM7RBMduetnju9NHiRdGb9ku9PPXQStTdjSCwvAJc=;
        b=nU99BvlZfPW7ojYYLZLUXTNcLOJaGwePpqIZZU8/37u/xfFD6UH7nIu+y3PAoAx45G
         zHYwD4UjGycMGayGEBZuYRlc5x7LLjIjiKfoGd/5Ic5Gl7DpY19hN6npfOjjnbepOdDa
         xmgcuAQw8hwapB+omPEVcKCB+sJXlrC4Uf8mkZcmPgwrtI18O48dmEoaGh62TExaEZWa
         bF7HQg8VIMtIRT/IpnCOOykJWHUg5U3YhM/yVoeOP5mKKVZDazArHFB4Yi8/ysiVZRc8
         PlhNoGUuCBpFgrXsgDZChuR7me9gOPHDSO0dh6hBpjwPuzY+aYOHLC2Jj++j1EMl7/jo
         KeRQ==
X-Gm-Message-State: AOJu0YwdO6pmmJnaQ4kpPoXUG+rDMGQATfufTFuwUoIc61lAVuOGBI9Y
	zhK6DtbTU40dc+TRIpluViMqo1Tmnh8TgtHOlgyzCQvutMMAMjLXCvTRoQ==
X-Gm-Gg: ASbGncu5f3NwMH58tPozHyKcXzjGf1x2kJOJ/nlzKwO9koacph7IeqMGojdXWksSawy
	7Ge2EE+5BgzWyopkz2q+WER782VcYbyi0iAtw122hX5iKGcrMdYDEcxPpH5IVnAXKfQ60Q1LdWo
	JlMEs4Nq9aTIwOu52GJP9VRaecuWC5QgSxDO61f0tfSPYxx0qrU/P05VcBKvEtyyqGmT0nETn/u
	x7uEZdyYV7rbKut7Ij9OsJqRticbFsNymqPKTvWJLqbKoQEo7nZPL3dfvvVlXNJApCtGFasvXHH
	nsojdOM6Pj5iDo1Er54ILjrkeTUYvid2lJSwHvszEhLbOCsbRg==
X-Google-Smtp-Source: AGHT+IEPtKfVF8XdSsifNip5pYwGgcsiveNiFGh7+nI0nM5IUzEiM7gjkzAwvLMF7N0NR4mxfgazTA==
X-Received: by 2002:a05:620a:424d:b0:7c5:6dc7:7e7c with SMTP id af79cd13be357-7c95ef08247mr55037385a.26.1745517486487;
        Thu, 24 Apr 2025 10:58:06 -0700 (PDT)
Received: from [172.17.0.2] ([172.214.173.180])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c958cdc7f9sm114328485a.59.2025.04.24.10.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 10:58:06 -0700 (PDT)
Message-ID: <680a7bae.050a0220.3c5e9c.615f@mx.google.com>
Date: Thu, 24 Apr 2025 10:58:06 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3173033385080739407=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ludovico.denittis@collabora.com
Subject: RE: Support Sixaxis gamepad with classic bonded only
In-Reply-To: <20250424162933.182103-2-ludovico.denittis@collabora.com>
References: <20250424162933.182103-2-ludovico.denittis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3173033385080739407==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=956700

---Test result---

Test Summary:
CheckPatch                    PENDING   0.27 seconds
GitLint                       PENDING   0.24 seconds
BuildEll                      PASS      21.34 seconds
BluezMake                     PASS      2888.91 seconds
MakeCheck                     PASS      20.90 seconds
MakeDistcheck                 PASS      207.84 seconds
CheckValgrind                 PASS      284.02 seconds
CheckSmatch                   PASS      312.39 seconds
bluezmakeextell               PASS      133.40 seconds
IncrementalBuild              PENDING   0.20 seconds
ScanBuild                     PASS      944.83 seconds

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


--===============3173033385080739407==--
