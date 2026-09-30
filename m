Received: from mail-oo2-f41.google.com (mail-oo2-f41.google.com [74.125.231.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9FD51AED4
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Sep 2026 18:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790793851; cv=none; b=Oa55ZpNeT+ftiPtR2ZzKq3dEiD13apEQ7XsUnXLYolxayydkQBsrnyL6N18O9z42B/kLS8Gm/8t11JTSxXnChYV3WO4bQ/gM6UXI9ZMM8g1LkcGGVKDsx1OjU8yXURylf8ppnCUwTDJOu3MsKmSG/+y6q3DVd3fLZ9r38oSQzcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790793851; c=relaxed/simple;
	bh=+tZImz7cjtYxGQeYMPK0JjK++N7TCmlUkQaou37pJm0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ABCTimR+QYrRDHC4+a0VRKPjnVMiTMg4TJB7RBBw5c77jnpmhzkPJzlgz3dRr6bW1Gx7bebSHeAbDb7EZ/5iAxbn56gh6NfJQWH4RF6Ino5iQ2C/7gDYGzkH5k8bYYUT0rc6hgkz+62LO9zSFe9qXhs+C7R0MN80GUbHG2jSWGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f1zrDgzc; arc=none smtp.client-ip=74.125.231.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f1zrDgzc"
Received: by mail-oo2-f41.google.com with SMTP id 006d021491bc7-6d33d80855eso3855250eaf.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Sep 2026 11:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790793849; x=1791398649; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+tZImz7cjtYxGQeYMPK0JjK++N7TCmlUkQaou37pJm0=;
        b=f1zrDgzcpPt8U+pAF2fZ91HKXssWsaiVH8FMWRbUVJUbg0TV0CwHtld/DDNMbmAzma
         8hfPVa0L3OrbwCPJtB+KGaZ5ezNOVSdEXyYSYzRaT4Vsx+9izx5tL7MwmS/4ctf09Hft
         krCyqzmDobgt+14G+xI8POEtrNzB9iXUtCICJrKgKVxnt5J9m8N3G5rNGoAvEogoycyG
         VxuE4itKbHsOm5q3zUic2UKUunTa0JpohSdZVx2HWcUIBuV6s75DJyAQdHB+drdMDFyU
         nj79OOI8HA/gD0a/kW9gJlt0bmcdN+ED7NHdNmmoLIzGdRscYX+qwuRgSizGJObengZA
         jEGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790793849; x=1791398649;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+tZImz7cjtYxGQeYMPK0JjK++N7TCmlUkQaou37pJm0=;
        b=ppyREnULD/AUUrJpGoAHFDbpDWj1vwmOforwPEAu2Ahv7hCYbHo5svdDNGYQlWP5X5
         y6XQ/lKARxWTM3zONtME3yoxN3vXV44EaNhVgL7c8eZGp7LVlR9DOOEsNUI7psH5c5nK
         CozNQCMLKVzvushTLOLjKSPvf+nKQPvmYJ4C4h94omntZjQIIEnF8x7kpadb5Ny1gWUT
         BlTs4bwA6YHK9XFuXFjfYuv0rpTTf5o8Tje2smEvecogypcMKptp0xxmG7dHZdp+rX+Y
         yLC6bzj40TmjtS3quzkjOOxDF0cn5ahj7zG86GsrdwM+C4X9tKF0U96N0nQF7mwRcEUU
         cGiA==
X-Gm-Message-State: AFuF++nPAlxILEzxpjS2XCgHO5qvorxUoaNbOpum0QtJUO17HuqFf+a8
	W0OKR/UBxTJF9adHFbA0q0Gk7UOEF4CFi7zVtuaVlyCwsYw3O5wmvPCbTNwTig==
X-Gm-Gg: AYBFou3biqD1PMnUgZnvCuQo2ma7V1lXolAyY3oZOz+JBuI6VfU9SRrMP0IxebawMMB
	Luh2C5m0lPjayyc/L23hclezEVCG5PpHF0Y8TBfrt8G/l+O+gP+qgntjiqkZyhDvEw5ycCv7FLp
	5CLIYGDhzGljLoMP/t4OKDoQzulSiqGsBdwZ/mclcZcNAJHTWNn9Ea968se3EfB9OYP/vQGS5cc
	Pd9YE0WhDQNJt8Z6pqjZnD+cUpcosE4HBfbP9jNFCBNFS9+ieK4Qyb6x474/7nAopsWtrKGtJbl
	MZ6ZUz7rMp+Aqb+GXUIN8mbpeZKEIDTEIE55eqGgiE8p+xHUBwhULPa7B1Iap5Qb7fRRhT/vifb
	eK4+6J2P3eyr6ioPQGSwMoQJ/equdCysC4vEJXRFeJSfZZ+wUdPq2sXw03Rq62zb5F4lsSueMLr
	wHdsGS+BXw9iLuYM90vF0R8wLhTirUDqlhvuqhaKj0son3iRD72ZLRv5HNe5sdc40aCh0OVzuPT
	JnzaKE=
X-Received: by 2002:a05:6820:625:b0:6d8:dc94:e519 with SMTP id 006d021491bc7-6dcf1ab041fmr2405921eaf.1.1790793848773;
        Wed, 30 Sep 2026 11:44:08 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.144.101])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6dd985dfee1sm830262eaf.12.2026.09.30.11.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 11:44:07 -0700 (PDT)
Message-ID: <6abd5877.7406aef7.8a23a.a62c@mx.google.com>
Date: Wed, 30 Sep 2026 11:44:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2413450207205763492=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, qwertyuiopyyy@gmail.com
Subject: RE: Bluetooth: btusb: add ASUS 0b05:1825 to QCA Rome quirks
In-Reply-To: <20260930181104.3375-1-qwertyuiopyyy@gmail.com>
References: <20260930181104.3375-1-qwertyuiopyyy@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2413450207205763492==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: drivers/bluetooth/btusb.c: does not exist in index
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============2413450207205763492==--
