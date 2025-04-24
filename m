Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891FB1805B
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 17:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745514030; cv=none; b=qOq+u12WjtmAfzZ+93A9X990sZqlD85ive9hx2jc+wa7BsiIWmXpG+8NSSSPYj5Bzyu/C2epS8sXMmaliX9+/7K1Mvj/bHYFk5VLBfJ0Mwt79kfJNQ3B1e4JXMAGFNrEoJErKEZMxRp0XJdXdaN7JK0dPfUZFXXn38QQ8w006zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745514030; c=relaxed/simple;
	bh=8QnYKedG80MVsv8SSzNfBWB0kmhLi9u61b6OWmAz7AM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=jrGmsxdlDXAZKhKJA2g4gGOk0u4tWjHvMV9Jj7b0AjFS86RkfHcqduwj6AM/b1fkT+SB9BkhMIYGYoVLNq/Z0xjE+f6p/VUrh7sCsB9cdE3UjeRAJIS4bHUUkKx/nHYWv+g9X22OkPDmoHstS7d3MgF/J5dziPP0MDoMMVERuWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MvUIrznl; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MvUIrznl"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-227c7e57da2so11471635ad.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 10:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745514028; x=1746118828; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WbyppykT3gdF0n2cV/U4Sjw9nBjLw2NyMhPQwGg1h4Q=;
        b=MvUIrznlMb1wqQ6ju+QWsU0lyecE4jnLl4O//3nIuXj96puvCf5rcy3Z7iplkTow5a
         dkn4GRuCCbJBTBWSCqJ2WhmgduvQD70Tc8NRe7y7dO0JvjicdVjtS6cGIUqrxBh4oFnI
         JeeQeEI+8ocVjzMW8LLfQb9cfqpeoKW0pSwmUw+tuMxqPqW39XF2UvJh/f2vYk84Wcut
         JMB1MfDh76KRi/DVrhNzxyplii1Cpy9v95HDvl6KtcLZnJ5c/s24XegeRDNadXtKZ8fq
         67/0ltPgZrvqsrVjykdUs9vtQl2xsAraCAuLxVstAoTYkrtU011QFoU/RgDxQSdDUwAa
         129g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745514028; x=1746118828;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WbyppykT3gdF0n2cV/U4Sjw9nBjLw2NyMhPQwGg1h4Q=;
        b=kVE3Hb82aEm3ktZvPgyvgSgc+0o5BfnCrjVNPzoOuoUcbRxFKf43rjCNYqfg3mimnQ
         KeS62a9rvcIeeKz82Mbh2Sc48x2p+2Kobim+49LIc8qUroFpcac4aWNemfaKzFeXaMhU
         wH8oUj1zWJGJoieWzo9MUmLKOO5njYyUkzxFtx/zk6MlW61jITkBWIwGfhoUhPnfgqbB
         XtLAmAnKIZONInsHw+nfXoKmfSdzVzmcML8BsQMH+3z0p0ixxKaOVAK6+nd/S7E1XoQQ
         kqTwtUcudGZ38kYCb7uMUXBVHlF8GjjFo/ng2rpL90axbjV1NN/ut3lZVCmCdeoXSmfT
         Iyqg==
X-Gm-Message-State: AOJu0YyJjz64upt8fQexZgGdBUV/J4fgfP6cYnh0Pv9l00S/wMzO7Lz4
	XUVhN/ydIVA+U40wFf98O+JM5uDDfmkG0NbZA/72Rvqq57+9dK0wmCzQSA==
X-Gm-Gg: ASbGnctoAirkwg/jT0zOcdDWcOgdmvvbzrKsGN8iHZ27SA5+EEpkpobqrO/JjpClCVv
	eppcdrQEw/EnvyqYlvanjFC6JSPg90MnthOeUZuXPl3pRhk/+RNCgW0HxjuN6LAapQezLeZuZBM
	/toKWjA2DQmeo5N2JPs1aU1Fq5UkzHcdTaHs1tG6Z3SgIVkNJAOkHo60LZsQk3BaRYCCvA47Y4f
	+1SlCsvX65x0Ww+0g/iRDNGD7RMWBOetiguXPGN883V2l8x9gNUpyOZX7KPNyySz882wL3UI8d3
	6triL+6sEFn1s//4jtsrx6VoeVuIaysIh8FGYFYXUNnRTsI=
X-Google-Smtp-Source: AGHT+IGDKzkHrhC9JJ1uwJATiCu2qod3jmjVWzYlZVW9t8InXIM+Znu+TidswE/Y3x0FgmzwMaTp0Q==
X-Received: by 2002:a17:903:18f:b0:224:2175:b0cd with SMTP id d9443c01a7336-22dbd423ec8mr2818465ad.26.1745514028190;
        Thu, 24 Apr 2025 10:00:28 -0700 (PDT)
Received: from [172.17.0.2] ([20.169.14.176])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db50e7a02sm15963395ad.131.2025.04.24.10.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 10:00:27 -0700 (PDT)
Message-ID: <680a6e2b.170a0220.167859.39c8@mx.google.com>
Date: Thu, 24 Apr 2025 10:00:27 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4425089659721332647=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yang.li@amlogic.com
Subject: RE: [BlueZ,bluez] bass: Clear the temporary flag of the BIS source device
In-Reply-To: <20250402-bass-v1-1-3e753841faa5@amlogic.com>
References: <20250402-bass-v1-1-3e753841faa5@amlogic.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4425089659721332647==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=949188

---Test result---

Test Summary:
CheckPatch                    PENDING   0.37 seconds
GitLint                       PENDING   0.42 seconds
BuildEll                      PASS      20.65 seconds
BluezMake                     PASS      2636.26 seconds
MakeCheck                     PASS      20.25 seconds
MakeDistcheck                 PASS      198.39 seconds
CheckValgrind                 PASS      277.29 seconds
CheckSmatch                   PASS      304.45 seconds
bluezmakeextell               PASS      128.04 seconds
IncrementalBuild              PENDING   0.34 seconds
ScanBuild                     PASS      901.60 seconds

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


--===============4425089659721332647==--
