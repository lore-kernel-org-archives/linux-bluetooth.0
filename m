Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0049C42AA3
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 May 2025 20:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747427871; cv=none; b=fpDu6JbfeNjXWs6MeeDTmj2gTV0lXQcREPDvSLz0oJGgp6cJEmVCZzQI35j1vwoM/0tYZ0BnMGpJ00cbyW+TyIz+B0O67A/yFg9KwLpO7tRkzECjmRZc1we1QBnjReTmsxnCqJTDydXseuLdatgm6xFgSnrROHoCzQPnwFhZkGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747427871; c=relaxed/simple;
	bh=tGpq8KwjLaIpv0sdE6ZDlQyWLy5kVM/epIJ0VMIixsk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Gv8Ttr8W4M0O3a7ivIYrAx/q7dtNjrLHr6csjZOlWgFmJQk6bW2sBCai7y2amrIkeMFP7HeTR9okUbMonXcEUO0OHZZfU8WmAZ8en+Kwz2N1wium4K0eXhlnfANzAFm98nLOTXF/tTIlItuw2AM/HDEoNUjNoKD6BkCdgXvVGzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WguzxwBm; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WguzxwBm"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6f5499c21bbso41647946d6.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 May 2025 13:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747427868; x=1748032668; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TRfkFQRTbHEV6/oewUH6GmTBg//M73oi3Ip50+xqGjQ=;
        b=WguzxwBmkCRS6shSuagJenD2qWuy8uqOhvOIIH1OWn0R5OKKXmceGUZLtB7br+aoYU
         aJCtcK8Pk+dgVnpV+GKiN0xs7fG3fiP827r62Js+J+bhk+Pq2TPIDE44M24wD/LSjt0l
         dy1cJ53gryxe+iH3MZR9PUzGHZNvDFWEr3NbEvOgOVlOhaLbJcZ6GfFetVHYbnHF7110
         KGbTaYhS2fo8nm2CIEQ7aP2RjqJe8gFivmZznodYtPLonXuniq0q9aFyBrs2UT/ewNTC
         IIV+NQKLBaYBmM4mOnjv/kJOLHs6yg5Ma1dwLfpGZyHahuRKd+pwF6ctydr/UWzOE54c
         ShYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747427868; x=1748032668;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TRfkFQRTbHEV6/oewUH6GmTBg//M73oi3Ip50+xqGjQ=;
        b=R9nk+KmgXoteErLHIaGYHOa0BGsG+7bVykBPB6IIS7Ga0wow1fGuZhQOGpsBc+x0lq
         xCkbbujOy3kQWzysi33DUDy0N/jJVaiTt/UYgYyHPdrsxcdo2Ju/IZY9QTSXjodhoG+c
         0KZTNUXTmNH7mngM0XMVfjf3hGMHfFmedMXmM9A5Y5AP+TBxUdLcf5BLiTNTZ/9GBb/F
         9gMkpaaiDr5SQxmvV51OzNSo1SybehcIQydpqDfeDQMqwzXi27QY9Z8bqTbYZj+2ogYP
         8ErqG1/7OV0nj7ts1MwaJLwc1JRDrjmoDyP8zA/q81AEqdbSQKLZCCL1hqImZyqQVRgK
         Af2g==
X-Gm-Message-State: AOJu0YztOQll8Ndlh7KRt6+CGh7klCJVEhQy4bLdePIXfPiQs52j1qCy
	qe4RGeIR/uykaICll4Hj354YYsRGKGho51lF6h7hay6Z0Nc/dJwx6L100LTtJg==
X-Gm-Gg: ASbGnct31ikSd4rd+kWJjiE/vIxPQQ1FOiHDxqCjq/+wb983VqBD8InR38CZZbT2YWU
	mb2Yq5OqLCrkpcBwjKdUArvxcy2UEcAqfRXkgToc/POpy0qn6XJYeZIQvNcHTzRLEyNWlqrjUwR
	3o7Tv9z2w2kQxpIVyMN2mhf+rveQSzC3/JSy6WgBkiZMK0X/dXxQ673gvzoA2TrDJeOpzDs0HU8
	yQhKZUPpvj6dssJFMC3uqohHcQPq6RLn/jETcpPn2PgUFHu2tGPZyw4mo6MCpj9T81jYWG6PwmQ
	D25J+34vRom+nAQnOBM9/qxV5bwll+q5ABj/A6Pd/J6KeTMTOiiN9u0aM0DIdgS4s7yMfQ==
X-Google-Smtp-Source: AGHT+IE5PCvojaWKxUTvolTAyb+oi/TPnp7tNrMy5u3s/fldVQWxmpzqtsA1UYeQHXapEE8nEjznDw==
X-Received: by 2002:a05:6214:5096:b0:6e8:fa33:2965 with SMTP id 6a1803df08f44-6f8b2c650f2mr59908996d6.14.1747427868311;
        Fri, 16 May 2025 13:37:48 -0700 (PDT)
Received: from [172.17.0.2] ([104.45.202.117])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f8b0987259sm16273546d6.120.2025.05.16.13.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 13:37:47 -0700 (PDT)
Message-ID: <6827a21b.050a0220.67242.ae5f@mx.google.com>
Date: Fri, 16 May 2025 13:37:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9161251642837718787=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v4,1/2] avdtp: Fix setting in_use flag for local seps
In-Reply-To: <20250516191039.1975460-1-luiz.dentz@gmail.com>
References: <20250516191039.1975460-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9161251642837718787==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=963746

---Test result---

Test Summary:
CheckPatch                    PENDING   0.24 seconds
GitLint                       PENDING   0.27 seconds
BuildEll                      PASS      20.19 seconds
BluezMake                     PASS      2614.55 seconds
MakeCheck                     PASS      20.27 seconds
MakeDistcheck                 PASS      199.23 seconds
CheckValgrind                 PASS      273.12 seconds
CheckSmatch                   PASS      298.44 seconds
bluezmakeextell               PASS      126.95 seconds
IncrementalBuild              PENDING   0.29 seconds
ScanBuild                     PASS      904.58 seconds

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


--===============9161251642837718787==--
