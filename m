Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F28732BF51
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Nov 2025 11:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764241227; cv=none; b=VuZS8MLuys/FlicM8eH2remZjcZ9i+z3/RV5GVtMf5JbdSyzGgtHVoPN5lAoeHt402gNMUihPn2OP5U3t3mWFMVaI8bf1iyFhP6zWaerCnFAAknwS2ZywIsw8i6clJCC32b0Gj8uqCH89mclZUfPaSSorOPf7r4H2szs18XSkZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764241227; c=relaxed/simple;
	bh=EvWET4RBXU3xSarLpVXSKlHzVoIKWUfkqv84DuItpO4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Lp5DXeDhaV8qkBnR+qKnkuOBXh1oklHCfI8aBUUdTsmtZlKRjeRFmV2OsFOIXqCuwHWoDF6yIxoaJBnkMfi5QzM/yEvQH0S3AE010ZIjhwKPBY7QIYSFmRJ8Dlx6ByHQUXAmYYpIlxDqPjf9pmXSqVsAvdAV1VkRefqAsVR2W8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EXnprcEs; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXnprcEs"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4ed82e82f0fso6549691cf.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Nov 2025 03:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764241224; x=1764846024; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AmYmlEWzWOQqfh/6yo62uaktTzBo+Q0TDO3RRsNwdAY=;
        b=EXnprcEsh1RCnr5Z/RR9mg+qccBnQnY9heHuVnhAH1MO0Qi1Xx6u3cEHNbmhjn18B4
         dU5OD6a2WMg3e8g3T39dwXAIt+uQ5qjYGyEKveLc8HYl41BUgCB/IdCYGxEnc7z+KlSU
         RA11KIuovvEk93PUIP+SXjbUmx+W7pdvjXlNYdDQ8xsE9r0BEUvAtBaW9CvylkrgZSuy
         dAGSYI+H023hB7b/cx0vXoX0METxGIzW2uDDXTh9KGJS89Z/SzrW92E6NqeXL2ELID4z
         RiGVMVHIbLc+YPVyAAVFMga8DdA/o0C9hcm6sLfD7kW63pXCHfcj5VfwGSXJAOX//K4n
         jZFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764241224; x=1764846024;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AmYmlEWzWOQqfh/6yo62uaktTzBo+Q0TDO3RRsNwdAY=;
        b=VNlTr46uy7YjVGrrNUC9WjKvrtQmdzDrBDkGV/oo9Adl2AuMzU/a6EVKHFge4nDa3o
         V+WY/DsnDOYMNT+Fup+1r8C/xnPf1xYLK46ANI7RDkjO1a7amrKBa8s+mdtOPvQMNJJR
         S+Rvy60si2iypXXq/OLMGZuz2JXb+1OU3mwi7bsVNI1TXRme2+zcwC8wa8lVsvCzH2sB
         JnywHlo0a5ZJZ/klPFPj1qjuyZl56MaUhm4L5iwg0475XB9OSBCdPCRc7jSKAYDcp0kN
         26W7Q9tH2XGwE/9alE0x5jVfM0tYEjJ4vKs49BGLKTlII2HxpaDRcdOcVnOi9dsd8tuS
         LKZw==
X-Gm-Message-State: AOJu0Ywu/7wi7EdAX5apbInhp/z1kt/q+849CFmkh+3GlTTD9N6eYdUR
	KuHnUZMOCr3sxsZm1mKGFSul7IS41Jktw6uQfz2b068LP/hgNYUVTy4sUoaXEw==
X-Gm-Gg: ASbGncuYpf0IX0ldZQV3fraXr3wjFC3BVZXFXRKX4UKJQ4OfIk+e+eRbWHXGJm7Id1F
	BOzblkFmC9J3hcL7MOVM8TNK+jhAIU5GfcGUHYkXRkuQ2iPWgDjQPQ6f8EOuR+0+enFjsMYQbxe
	lvdIbhZTdrO3YKylQH141h0hqMeWN9NNOFJSJSOaDJqDZaIZIDGdBl9tq35x8JU2R2dKOP9TluG
	GxiAW302BKtkH9lmf4IQweLSPd/x/xMVcDPZuEkwpzZlm9J5u13KI32SmFB70tIH7lM4zz5Mjo2
	R8LU7VgLkOPMEy3kyQKhZpD7/gwaX2v9XayqKL3RAXTABPY9yGO6suEalkGWK3WWkeJY8P+vG2U
	eemmXJj1qrMrJazzJgH8thhFvvXnONWPjDr58EKiRgDBuAqBw1Rza9hkzlHeZWZsCka5tBpUcZd
	dFWVVE5KGp/JQPa4Q8oZE=
X-Google-Smtp-Source: AGHT+IFzDNsvZGLEb6jG6Nb39qWBvtWvGYiz2TU7evyWxF7ACUSBVgo0iKZHY271zw+YfzhBrJSPRA==
X-Received: by 2002:a05:622a:199d:b0:4ed:62f5:e1fc with SMTP id d75a77b69052e-4ee58953e8emr309376731cf.75.1764241223398;
        Thu, 27 Nov 2025 03:00:23 -0800 (PST)
Received: from [172.17.0.2] ([172.177.209.211])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88652b73542sm7218686d6.44.2025.11.27.03.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 03:00:23 -0800 (PST)
Message-ID: <69282f47.0c0a0220.11d912.121d@mx.google.com>
Date: Thu, 27 Nov 2025 03:00:23 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8920204026737637035=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ye.he@amlogic.com
Subject: RE: Add implementation of bearer connect/disconnect
In-Reply-To: <20251127-bearer-impl-v7-1-9a5b06468992@amlogic.com>
References: <20251127-bearer-impl-v7-1-9a5b06468992@amlogic.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8920204026737637035==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1028205

---Test result---

Test Summary:
CheckPatch                    PENDING   0.31 seconds
GitLint                       PENDING   0.35 seconds
BuildEll                      PASS      20.18 seconds
BluezMake                     PASS      636.25 seconds
MakeCheck                     PASS      22.17 seconds
MakeDistcheck                 PASS      240.52 seconds
CheckValgrind                 PASS      297.11 seconds
CheckSmatch                   PASS      345.68 seconds
bluezmakeextell               PASS      180.24 seconds
IncrementalBuild              PENDING   0.32 seconds
ScanBuild                     PASS      980.69 seconds

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


--===============8920204026737637035==--
