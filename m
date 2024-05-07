Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8A56F525
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 May 2024 11:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715082109; cv=none; b=lDr6hSXmNHWI9JqwVbKw7ty8Nd8HcaUBx5RtazU6W9XGqFSUWFvU4jZC0SsuQpPih2/w9Uw5gHjpE7NGiIRhU5fFCCzSKsraBDCRN8f8qk9Q4rLwfJMA7LWnNFWegfGUZRisHKahuZDB4jlmIfa6Mnm/GSwSU2NDFN9nPhdwYuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715082109; c=relaxed/simple;
	bh=EcuwrlW8W8MHWwWmRDYLBgH/Md1xuSVe45Gw2QUUZzM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=tSePjkIye0768/uojDrXuM2/VQyxne3WVinfSBgClTD27w66ai8YKS4HpboZmm4CXrgT9MoUqmbI1Zg5FstGqPVmFEwYN1SCzFg/Do6TPapaTJRaghdHzVdX3qBOJfT0QpwiEBCTi5m122T33p6ZduGUFBvs8iYIKdAxmHkLCm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cUnIJOq5; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cUnIJOq5"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6f460e05101so1862846b3a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 May 2024 04:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715082107; x=1715686907; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=amwfW/z5eDKNNMK4jgDweu9TkD7VT3rJGTUL26i62Ho=;
        b=cUnIJOq5ehBvY4mBYPBH58a1u5f47YdDcw6mKpxBflYELjbiJFOQltHUpKMCvHWuLT
         5syHDkrtFpwGh7qWyYlH0A1F76Y5MwUcW+nFaK5BMFo9hthlUxZ9c8WToYoMmf/L59hq
         q69DM1oLjlvEr3zkUSemfCuUnSYcXK+dtSdaFfXcl/5kYeN1P5FEpKIhex5Esf80rOiQ
         EsGix/IUBfhnfB4a+Cx7giHaEisMTNo/vGgpNNQ17hwqqQPaEPclIcpje+KSsnvWVs4P
         EpyeGjONcF9Cq4iy5P/OJtQBkps8927urnYcyjneD1fqZvTrkfbu728xooUbb13+t/A3
         xOoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715082107; x=1715686907;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=amwfW/z5eDKNNMK4jgDweu9TkD7VT3rJGTUL26i62Ho=;
        b=h8r7e+Eci/t9b3t39/Ltz1y1Y3HBuiElRIUYdvXbP8psxuO0bFE/6ZlnWMgdxOlt0R
         Q/gjuv3SkQ+RXh29xuiBAhqzimUebqinFzgtXKNV5ors8RXRJYjy83hf9u5z3nGRTFa1
         UkR68qf0RqQXXtLtMHDF77VkeGX438Gyt3+LcyGaidhM385awh96UMpP/Kd3oLTKVK7X
         FeOciW4+e/05S2Psd9vaxa4cbDPWiMj+AicVymsGZ1GgW2ZeIvywmnhP9FPh66PUSGA+
         n6ZV3XoDSCmfMDFHcfrq2TvcJkahGRH7RzvzDvYCkVNZo2jq1HcuXSQ8PfPT+Nt3eK+r
         t3rQ==
X-Gm-Message-State: AOJu0YwDEWVX3cv6zBuOggMth/HRsQdPWWUPBs+IrdVwnYgDxsPLk15O
	7581IDrSMDrHcxu9PDjS5N2o8DZXn7nLboH6TCXSNry2ESLOV1kDCTYGfQ==
X-Google-Smtp-Source: AGHT+IEn1CQTvYxsyVb9GLFThV3t6Ao9/8FosIFoHaJ4UDheM43AZcxjSKfyp0yIsM/WIE5SkBp01Q==
X-Received: by 2002:a05:6a20:a124:b0:1ad:8f18:8625 with SMTP id q36-20020a056a20a12400b001ad8f188625mr3722455pzk.28.1715082107414;
        Tue, 07 May 2024 04:41:47 -0700 (PDT)
Received: from [172.17.0.2] ([138.91.70.182])
        by smtp.gmail.com with ESMTPSA id t14-20020a056a0021ce00b006f45a538b19sm5736499pfj.87.2024.05.07.04.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 04:41:47 -0700 (PDT)
Message-ID: <663a137b.050a0220.a9c9a.dfc9@mx.google.com>
Date: Tue, 07 May 2024 04:41:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7302269061984832150=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ajay.k.v@intel.com
Subject: RE: [BlueZ,v3] bluetoothctl: Add submenu for Call control profile testing
In-Reply-To: <20240507150430.689504-1-ajay.k.v@intel.com>
References: <20240507150430.689504-1-ajay.k.v@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7302269061984832150==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=851094

---Test result---

Test Summary:
CheckPatch                    PASS      1.30 seconds
GitLint                       PASS      0.19 seconds
BuildEll                      PASS      24.89 seconds
BluezMake                     PASS      1705.55 seconds
MakeCheck                     PASS      13.07 seconds
MakeDistcheck                 PASS      178.77 seconds
CheckValgrind                 PASS      249.36 seconds
CheckSmatch                   PASS      353.04 seconds
bluezmakeextell               PASS      120.03 seconds
IncrementalBuild              PASS      1477.28 seconds
ScanBuild                     PASS      1024.32 seconds



---
Regards,
Linux Bluetooth


--===============7302269061984832150==--
