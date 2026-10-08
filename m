Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C11F39CD1C
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Oct 2026 22:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791499377; cv=none; b=R5bp0C5x0tBjWmsMCz2rT4V5oIXbyM/M8sZv5RvzYto6ZguU1MGNvCfz1kigYJoeEhQul1Esa+5BWDHB/sTWS0HEJBlz4ncnljKNo/qiWu/GJW0HHnhDjRRtEz588sHFNcSjklIMVZmVc49L5A6BIaHFyL2UEj8xMBMMA0isi6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791499377; c=relaxed/simple;
	bh=5pFH80yRExIKrW8I9SCLWdSp8Fyk5fMTLhbnjhCPVko=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Uly6ElCAL2+WaKv4fuEqm4BWyZslbk4WhG7VWfiUUMXOdY6YWRZG16lKqJBAgbtdNSTtfQfyacn4IbnwSezSWJ4ftmmeFohKg+bqbEnH9HAq9oZCnjq0BEns0IVhPcGSNuySGF7OUb2CpauwkPpFqYRkMnsXWYSLK3aZmsM06nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IHzB9ngi; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IHzB9ngi"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-93e50170ba7so445601585a.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Oct 2026 15:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791499375; x=1792104175; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ay0sOawys4PKOSfkUg68ABfPCGFbhiAv/j9sxEIm1Bo=;
        b=IHzB9ngioEbyyyPdz3XtLJh1E4RUNCdlUa2SFf1WUIVItp81g2RZTrShCnR9fwNZN5
         NY59fdH286vIjoIXQl0ZJQBuSq0p4Xpcg6HNLGHAB+2B1xfTLbVK+S0ccXd6GDnt6Rr2
         gWxRMKvAFXT8fm3O7XSheYiniIbgHijfsnwbx13DhC4Ohe/kPSr3cNRR9FlaWiHUHbc0
         xl1pAb5Igi5HMxnf9LX36hZ09uFIjYN4BC5XTapaS/KslSRuUtMZj7V1WAagVR5chSrV
         toywCWs5b/t81gVDaVGv7sXFXnvZwzXw/1rG0f3Nrv/n/6Scv8R8ko+0KSzD6a/EFmRx
         69OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791499375; x=1792104175;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ay0sOawys4PKOSfkUg68ABfPCGFbhiAv/j9sxEIm1Bo=;
        b=fk3W5yXX+9jupRFVKtMBRNnnh+YZ4/o2I8RZhWuCW1SKDKDbm57pv9z/iARMS0eeoE
         Jlf0Mg74Thv3UAWJ5iqgvVyw5q+GkxaUwSPFN9bHwraWqT5639jRvV7NplDMyffxpbAm
         aBTLNivtXb0qn0HMhz/ur6sfhHiTpqk7pHMvpSlnxVZdBTLkA439vo32Oqr4MJUJ9L40
         dYyUX/hZSomjucrI9qOSgAYBA7yLgBZeS4UNYdBiE7Dkc0VHapyR8EernMDWFQqcqRcx
         VKogVS1nueGgy5G9pCRbN0zeOiKIzevftHt5GXVg13BVF77yLzjgl6Kuo5RkuxZ0r/2Z
         DRYA==
X-Gm-Message-State: AFuF++kGOVHDor4HxUq8Z4yTCQ2tEMw6RyWPhoTYuuEcJJABL2vLnm97
	eug8fTreqleuyDebAwGDW9ZeQhnOwO/6Rhk6QhXSMK7AJmHxczNFtiadVv65tA==
X-Gm-Gg: AYBFou05QjXSI61dtocyr0ixHep+cDQUtlho1wdtA5VG/jlOXA2uK4mOFDRbmd0Ly5i
	6l3JBIFrb9fYKARKbxNhhGaDED8QwiOyqiU66RoVn1lfXPm3mujp2XXfIhX0nl7sA/eSZ55m+Ze
	oMNoI+gqaMTZ5tH/dnXehEZJTlBUxr38iruchxfzCxbQEOfg1DFtePGZAgI8pX4ApBb3xEzbIUj
	UzvEb2P6EOwhWUvvtgAMrIK58oPhx1uOYYG+vd6dbBslCx63N4XHkm06wNyErO1gwgy/iMhKdy8
	/KNzuqFRDRj/M7w4XywbwjFEQhFZzQqnOOX/gAnVhmuRCtN7RJzvb8YQAfk+7TFj7aSPamGI1bW
	L1wB7NV2S7rSSl1PS7s0xk0+8673x8j5k6pj1wJM05Nen511QI30T7Dx7ggDzLuNxwk3p5WceUr
	E2/GgnoZgeeZPfjqfYCp0l+qOVgBZvizM07q12KytzKE/iTKrWhBXDPbubBkLbnV3AgLZrRlydU
	qv2DBE0C8ULxOkYCA==
X-Received: by 2002:a05:620a:260a:b0:93c:be5f:b807 with SMTP id af79cd13be357-93ebd224f84mr12697685a.13.1791499375265;
        Thu, 08 Oct 2026 15:42:55 -0700 (PDT)
Received: from [172.17.0.2] ([20.106.231.41])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93eb98d0234sm41473785a.38.2026.10.08.15.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 15:42:54 -0700 (PDT)
Message-ID: <6ac81c6e.1c2c719a.1408be.a1dc@mx.google.com>
Date: Thu, 08 Oct 2026 15:42:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1165866923860036198=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, gabriel.berfield@gmail.com
Subject: RE: [BlueZ] client: Handle system bus connection failures
In-Reply-To: <CABNtnOZr1q7J6_bY4qr3Sb_jugoEyiR=a+6GMvK0JeK=psw7NQ@mail.gmail.com>
References: <CABNtnOZr1q7J6_bY4qr3Sb_jugoEyiR=a+6GMvK0JeK=psw7NQ@mail.gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1165866923860036198==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1181803/

---Test result---

Test Summary:
CheckPatch                    PASS      0.50 seconds
GitLint                       PASS      0.32 seconds
BuildEll                      PASS      19.49 seconds
BluezMake                     PASS      372.05 seconds
CheckSmatch                   PASS      292.07 seconds
bluezmakeextell               PASS      94.27 seconds
TestFunctional                PASS      1166.02 seconds
IncrementalBuild              PASS      377.97 seconds
ScanBuild                     PASS      1160.25 seconds



https://github.com/bluez/bluez/pull/2638

---
Regards,
Linux Bluetooth


--===============1165866923860036198==--
