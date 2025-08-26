Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75F823026B
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 Aug 2025 13:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756213531; cv=none; b=fTbpcdEj5YCBtJx2kRGcDLAADauONoMb6R2DKMR2tzVOJaGtnAIJR1+qyPomJrUxgYlywbEZE1iAQ0L6UQB59rAtgSkHUDs6uMn4JvmFNz62IcMTte+6WcwO4pOafqk8Y4StIdEnw9KnyPNPY4j4N3tJkJla992rRYxSd739qTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756213531; c=relaxed/simple;
	bh=wzaGwGePv16tJl0p92k2TpUBuy/QKZMM4AEFkrs2B6Y=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=lf2P45p8YqnZ6p7RxnhXYk8Ww0kadYXr8Jf9+/baLnNHrTNJyqMVpYKTVLEZmN79ZeKPPEEEh2hTaOUr6gfQAdxFWqlGlbOROAUXBF+VQzS5oaulYq1diKyAiSSKMRZhQnbQV3iuG3E2HTqmOORjK0jAXiu77lkOX1EcJ214l0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SdJH9JuR; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SdJH9JuR"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3253f0c8788so4369282a91.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Aug 2025 06:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756213529; x=1756818329; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YETfH1FotXrdiOQ5GH3gfLhJL5AjKQPNDh0hgfyixpo=;
        b=SdJH9JuR7zc9xonkH01vnI9wdGk55xooe0nVaPaybLk9L7bKHco9qrQSNuRAJPGmv2
         nZVXgn/I/qam8iB2+OXuYPUlUfnVhRni3Kq+V95JYuLeljF0LMb2BHuIf36MEq1K95/R
         iXgTbhtruqxghbsKC5OE1RhYcNR2ney+nxz4iTqqZAEsP8cfdUKhtzVZoFgs335h5xF+
         YQelav/KHzuhloKdQ4JBvsLMZHWwy1c8E4e+lnX8J/2GMJhFTBI0HDfnMD8mlN47gZ9l
         rhZsO1c4rB8p4Xx4y7Gmb0TAMOT1TkCoCZwe4oJo1Z6jUnAv6Z5pVmD5UJBAiCjDNnEq
         C3Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756213529; x=1756818329;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YETfH1FotXrdiOQ5GH3gfLhJL5AjKQPNDh0hgfyixpo=;
        b=MAqivJfXe1ByQ9MhfALETuXOQVIp5IZxFPbyx9hvccxYBbFwYNlnxhSXV8d4ujig+/
         gtUZBr68ncI4avaOMAipN5XikTVbetBEXFiJlUn1erG7Gw2ZXaltGsWLjhfHiq7iW13X
         akoeCz+xmaH/fC9P/o7W/d8fI2c/SNaUEN1Rd8UMWv8tNXSBg0iXh0HtyC4UQEAMUQjX
         098W53Y92acku6Z19s2Pm+l6tCXu0KuxMZL78y2ULqMKXhULUXePC5aYo66Usu3fNzld
         m8rsbMCdXzK/AzXnLf3ZYQY5PtIt9ILUUfNprtSSU+EUIdUJOwjGIUoqMZwBzaTN59hR
         Gy3w==
X-Gm-Message-State: AOJu0Yxyj4tCbhY3wwtMomHy4FpszcrsmW6hntdC/9TyqXzVWyDzmklS
	wrY6n912O83rMAG41j0ypuKUybpCCAMmF1vzf7+eEbItD1b45sQH7yYzkF2eb34S
X-Gm-Gg: ASbGncs/RLwlZBJTR8ocQWEBXKtatX1LXmYXIMgkVnFbaoFaOo//Xw+WPf4jq/7xIBr
	tBNJOD+EB2nn5EwomXOd2JGhaDO5gu4/b53Tu8hP2T00sutBVHCktgBt8cvujZB+IQl1qhdimQX
	eA87odczhYBkHKcRyEtBIWB5ab8+sP4ohfqvcJ1bnnLlHrW9BWgXgmleo2gfPtuZuwZnY5r52M/
	ADiLd1jpBdx8XNSzOMijLrNJmxQ8kuJntDdzdh/9yLhGMaqsczj1zHlCesNDQqJ4OEMubRK4w0/
	tEBs8uDPyB8saW2etT/O2ghEBKxM0906lYMqYbpjGwNe+Ra/cgcfu7iQUQdECCfKXjzqqixhu5I
	YU07C+QCbWyhOcMcoY2rPrJhyDiy2pxslW3jw5QNldw==
X-Google-Smtp-Source: AGHT+IFYlbKhaMFMGaTwbelbciUJCi1EalJZeAvNpOys3KxS0eLQ2vs/eYQtL/3YklnsxZIj6FILaw==
X-Received: by 2002:a17:90b:1642:b0:31f:104f:e4b1 with SMTP id 98e67ed59e1d1-32515e3c8f4mr19996177a91.7.1756213528625;
        Tue, 26 Aug 2025 06:05:28 -0700 (PDT)
Received: from [172.17.0.2] ([172.184.209.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3275940a2eesm619485a91.31.2025.08.26.06.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 06:05:26 -0700 (PDT)
Message-ID: <68adb116.170a0220.34372.1df9@mx.google.com>
Date: Tue, 26 Aug 2025 06:05:26 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2107425906069099532=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, andreas@kemnade.info
Subject: RE: [BlueZ] device: fix auto connect with private addresses
In-Reply-To: <20250826114347.839227-1-andreas@kemnade.info>
References: <20250826114347.839227-1-andreas@kemnade.info>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2107425906069099532==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=995640

---Test result---

Test Summary:
CheckPatch                    PENDING   0.43 seconds
GitLint                       PENDING   0.50 seconds
BuildEll                      PASS      20.10 seconds
BluezMake                     PASS      2664.11 seconds
MakeCheck                     PASS      19.97 seconds
MakeDistcheck                 PASS      185.78 seconds
CheckValgrind                 PASS      239.23 seconds
CheckSmatch                   PASS      308.28 seconds
bluezmakeextell               PASS      131.07 seconds
IncrementalBuild              PENDING   0.50 seconds
ScanBuild                     PASS      926.77 seconds

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


--===============2107425906069099532==--
