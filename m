Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99C61E51FA
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Jun 2025 15:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749828530; cv=none; b=JhQmktwnQc0yD6TNwaaaSI3CKK7jdhWDJsiZsEqJg7T7PFjus8MAKNXZts/xFY8hxEG4RURop24IXFqJklTEuu9p2nh3WmpfOAKPqVQ+GidVQGLNJbD0bcs1SI29c5TBJnk+3WrO+HqsLmfv6A0jeOjF4OVdJ/Gt4gUUzE9uxu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749828530; c=relaxed/simple;
	bh=tcCrvyzC3dRUcc9rOihHAQzv9RMdhFOIHnXHzJ6g7/U=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=MXG7DR6OLT00VbC30KFsPbfVpMMV4TaBysAqQE43obCkEUIH/E2eyskrMwrA2ZD7Dk8QQLSLS0XmXeffsvYQEuDibDusGH7LhXHPZKlji6E3s7qNNo/FIwJk5SJHMpa6BhI4qZh0P69CaQFW/FORt8fDvueEAb+tJzOOAaL0xJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O8khptdR; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O8khptdR"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-23636167b30so22461025ad.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Jun 2025 08:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749828528; x=1750433328; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AWH6eib/WswPA0Rd30oKn46VgXZTkI6tjsR5g0Cq/c4=;
        b=O8khptdRqBRT7cW8HyDWBLivOTC/WE0sLFz2WSnugP0n+QnmisjxWCT15+5ige12/D
         NSwmqsHRfPXRd0qZc3m2Iu0JDKbK3H68Vrpuph5lrXAlqyMraZpNWHVGZvGrgKHGmPuN
         kxTrau7I5x1uS3CuoYNDgBaWpS28Ht+CHD26cJVAUq3gb0ZM/CFpmDNvt6cPyr3FzkaH
         9BIWtXHQ1Pott4blaMf34qVg2O7ljMUYt2qT0niQ+pU+w9sbK+Fe/sVEb1sCb3MSjinW
         nuzN1nfFHTcJ5ky0cppK+OA/BQG5LlV1jEc/DGEfn5Yi5EOE6/ZI9eLjiWAfgYhRsvW8
         x1fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749828528; x=1750433328;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AWH6eib/WswPA0Rd30oKn46VgXZTkI6tjsR5g0Cq/c4=;
        b=vJ2Q9Q+2sJgxijqeKdgp0Vyu8sgut2bM3CThBTZ/McyW2Yp1Dbid1NUtJIt/sVZSXK
         HQTyEoksQ7z2fpkJ0eCncbhToghX9qhG9sXG9Oequ3uyq81KcGGLxhfJz5m1iHgmTWSp
         vzMRoM2vdWcxUCS99P9HYqSEyjxdW7Jh/2w+CwvPhocBDvVw+jsQlXWq5s8Ie091v5tT
         +1SU5M4Lhx5bl3aTTJ+McTVUFyYR3gvErpnHzt2iaSdY8L5XUupHZG0JZF11nGp27f4p
         LvO0CU+Q88xb7xc9bm9L0VZhTP5wliC4rE5jkT8thxLZCVf9WENP+ujSuD2lSoS2VRpH
         7F7w==
X-Gm-Message-State: AOJu0Yx3X97gJNpI317uWI/4uAiJlVRKr0Z1FA5uBFm6+Su/nxb82Pna
	JfwCc3DHcS7e5L45SaquUUmMzIF52V4B1jhfVs2kVOPe3Bc9xGRPHpLTh11ikQ==
X-Gm-Gg: ASbGnctV37WaVa4Ed3d/Vg6IofcMqeeJE+I6GtHPFbeF5i7yAE0PzSvm3IRn9k74/Ji
	knNdCXqj8nykHa14zCkSw5WLvKdChRei82ObLLo1rKuOBGXtxACIMnBSkxKtrdUyB39wKwN9+Zm
	6e+9AhDJrHRrlxqRwzbBrZ/ITqFmeZCQTozQLwt7EcZl3rOd75XINGX6derxW0bNnO3pdXjhtqr
	3ayeZgHQfqoYcYZK29DuK70zOPoSLYRMzqWAtanA60vTrhGmDRC2qRsywQCYm4STHZxWbPr0cgP
	GmCOzJdCakImRE0CzEGP9aitbqRLjp1a80iPb+IMrGUDoElSSJgSbnptf/wCPFdmSQ==
X-Google-Smtp-Source: AGHT+IFhJ5opLpD89tqIp42/j6YgCfm9uh9cMR2TbvCINLw0yjI40DJp8RtDmDdlZ4u8u1LuIjzbrQ==
X-Received: by 2002:a17:902:ce8d:b0:235:7c6:ebbf with SMTP id d9443c01a7336-2365dc234d1mr52936035ad.35.1749828527649;
        Fri, 13 Jun 2025 08:28:47 -0700 (PDT)
Received: from [172.17.0.2] ([13.64.63.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365de7827bsm15516915ad.108.2025.06.13.08.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 08:28:47 -0700 (PDT)
Message-ID: <684c43af.170a0220.101772.a0d4@mx.google.com>
Date: Fri, 13 Jun 2025 08:28:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1264575223522150186=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] shared/gatt-client: Make bt_gatt_client_read use bt_gatt_client_read_long
In-Reply-To: <20250613140445.1997694-1-luiz.dentz@gmail.com>
References: <20250613140445.1997694-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1264575223522150186==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=971855

---Test result---

Test Summary:
CheckPatch                    PENDING   0.41 seconds
GitLint                       PENDING   0.31 seconds
BuildEll                      PASS      20.22 seconds
BluezMake                     PASS      2720.52 seconds
MakeCheck                     PASS      20.52 seconds
MakeDistcheck                 PASS      202.22 seconds
CheckValgrind                 PASS      279.65 seconds
CheckSmatch                   PASS      310.39 seconds
bluezmakeextell               PASS      129.80 seconds
IncrementalBuild              PENDING   0.38 seconds
ScanBuild                     PASS      930.49 seconds

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


--===============1264575223522150186==--
