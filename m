Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8B22FE0F
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2026 03:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783914996; cv=none; b=UHF5KLeYgzODWU9qIUyD9dDEDqAef/1/gMA7E61qyXlBWkG82dzwXZtOQYSTxd/nDHrd+zoVtAm7QnM5agFIs8LVHeppvtvI7usSnPSZCgYRb2SAV9qn1G65ewbIQ13v3p06M4mIBx9b7e4CqQOjXZexMBtUPlCRVE/VAW2WPY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783914996; c=relaxed/simple;
	bh=icAG2J6TfhF1GYce1l2rQCWHyVvSqwxRXtQjoDmzBuU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=NPW0ELTRAWu4AEOsZWh0XVjsISDJ7QtDSD9pHqG59f127xtqifXgGitK9Kn+idunmO88j1Cgf2WVAEunansNBupAVkfkKORuATaYt6JuTCLSsyELkY5iuJVHR3y0VrEOvi7r14In3gGxz+i1irZRO5Qbxq0DXkLK4ZjgIkXZXLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=coP5g6bY; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="coP5g6bY"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-902fc790cd5so24880496d6.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Jul 2026 20:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783914994; x=1784519794; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=icAG2J6TfhF1GYce1l2rQCWHyVvSqwxRXtQjoDmzBuU=;
        b=coP5g6bYaU9SJzYqRjzM18TNnkVKW90fW0qBXrw9OWJKM4KMGA2IOZRBwsOr/ksHZe
         Vdi6cv8rEzsofN3YqW/Ul2pxj/3JO2WdzP3+pIbYTCpemoV+1UigsSj38+AaN5CGeAfd
         b5Y0NAD7rMYof062ec6xsYYePaYdO6M6+7MAqxdDMiAE/ijVGb+JASIiJNFBdCcg/Qot
         d24Mp2ahE/L0qLWKdXVS3W6qUkc0n/6O/RWS3lq1aAv8GB1dEn1GF47JnqkyuJ95ei9M
         3OV2fyuxxg8XYRik8atNYdYFctPubvwplbwO4dtOMLslEE6YCP3VUI0cP6GLoq/HNn36
         6lrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783914994; x=1784519794;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=icAG2J6TfhF1GYce1l2rQCWHyVvSqwxRXtQjoDmzBuU=;
        b=K5XK6PdI/v9SeRS88GSEw23BS10bxDFz43s1TrvdDJS1nGtDhYSgvbhD6429qRQZAT
         L8ONb+W/fKeHxpqBw35gJC6AYMtTG0LR9BSNpf2yin+OfVUrZ5nn7upzNVVWwl+nLOzG
         IvZqE+OBR3li8DisInuf0Z2jJCpWb0eZ7AKzV+ank7puaR2fuQ14qSlhNAn37YRqGSkG
         W4Jpb9UgKCC9xn7EjLF2HMGBNtVHtJW3IXtanlvmMcNOFwQoHXWUnZjtfLOXTkMS6VQu
         SYBSESz08kpd+FP30KT4J3zTkI9XALC+chRDFfsIq/X5rZKetNSMsoK877sGla1woPAu
         h/4Q==
X-Gm-Message-State: AOJu0YycPnnrHLMhtO70og9j9UdPuavhrLnGxgSe4xO2sDoEbhxtPy2m
	xiJBtCKutL/GVCZvHq02tWwPXJhDoeFRwuigrpYM2V0U12RNv3hC/UBEtQOjzQ==
X-Gm-Gg: AfdE7cnoSms98f03aIK7tPzJvAqvQf5cavH7v8CplPJTbQiZ+ljTR1zbEi5QkgLEdXG
	XPBY4KvLf+vLL3rmYFS4GdAaWvV5+W+1SHORHc1VPkTNEuMj/k+B/RdOSTaQoywY7P5GebdLNYt
	zAMSjvRx00rEZvUXnQwmhmKkjNeKY2pO90kyL6QC7LhU29JFuqi7bIYoLluD9Tl9d9F8G43DGj1
	pP+v48phbAcH4ab8PdxaJ5jJeJsH/V3izEPIVKrO6pUDIVJc3l9KuRTA34NS8sgfxup2Zv7uLBD
	Ot7pBqi6m2vE0SMBfL2mgInQtHjOug9wjzloJVZol4DwkCfu2DTdizIPWga+n5cExFIL4cPVe5s
	Tb7bArB2TbgwjTlJx2knnJR+/7Mihy5tEvONOdkfkkKsOgTMgFtiTksLSdUeYb3DJbEJKX7PUr/
	NiTnKa8pSVnUfCBaCzTqo=
X-Received: by 2002:a05:6214:23c9:b0:8cc:de2:3b5d with SMTP id 6a1803df08f44-90401a7ef49mr94637476d6.16.1783914994235;
        Sun, 12 Jul 2026 20:56:34 -0700 (PDT)
Received: from [172.17.0.2] ([40.76.117.242])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd87cad3csm119619326d6.48.2026.07.12.20.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 20:56:33 -0700 (PDT)
Message-ID: <6a5461f1.46adc49a.1045f9.5936@mx.google.com>
Date: Sun, 12 Jul 2026 20:56:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4254913815483232816=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, sherry.sun@oss.nxp.com
Subject: RE: Add PCIe M.2 Key E connector support for NXP i.MX boards
In-Reply-To: <20260713023435.235765-2-sherry.sun@oss.nxp.com>
References: <20260713023435.235765-2-sherry.sun@oss.nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4254913815483232816==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/pci/controller/dwc/pci-imx6.c:1382
error: drivers/pci/controller/dwc/pci-imx6.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============4254913815483232816==--
