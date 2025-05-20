Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140DD25B695
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 May 2025 17:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747763923; cv=none; b=NL1yp0cQiqENcWC69CKS12N/60OwAR6D2ltBJvgvlqfNto/mw0Hn9JfVyogueKfE+uGfDeQoCDOqVehwh9lmLAAj63HCvRYcyIibvau6TYDZkywtv+JheL8LC/DiKjaX7xEJxMxX/qUPH8Bv69Yb14qv1g42ssvQqPpiqZei2X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747763923; c=relaxed/simple;
	bh=UluBADPzrMTo678+IenP8GlXuQqXoec8g8KIpecQrZg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=g1NvB8mUPJHRO5AD1hg2HE/9GiT5MPD0HtdZOAGzhUqAPC8V7hhGpMgN+VJIMKUZFrRnNdzJjTxhgMP/nRsolkVcaA8gGu4lWjHYCR2sE8CN24HOPknLXS1BN2w3mhONLo/ccrgOxaciUyMt5O+1M6PNpWwA7836igLJhdT0Ta8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fthU9id1; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fthU9id1"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6f8d96499e7so42044486d6.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 May 2025 10:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747763921; x=1748368721; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=N5lMMjSJFQVBtabQxbAEOHUwAvRhYz+GqGumrrQc8Ao=;
        b=fthU9id1i56l2FcsdmDsrkigZfCwfp2CGeLtPtEJJs2a78boXDu3CgSW0G8UeiNTQj
         sBG6a/bWXRX/ysLPp/aKvLUmaYZInTEZrAc0W9PYbCTBMMCcT32GVJfhG4Sb5yFHjfUi
         AIY5bw/yUQA9WOu/qccpj/xfucRP1SkDMOMb8UEm8tQQkmaoD1BjQ/WNWYJfspGnqQ1I
         NDVXHkjKFteRiT6iPe97iszuc+EBoGyg43dLer1izTNHkTGB4uXVUHB3WHpgUzqyoqB+
         yH99gXsw9ISdtbVLq867AyjFLPc1XTd5u1thNmQqoYJe/Mn8l5kYmKwZix9W3QHHlYFt
         RrjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747763921; x=1748368721;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N5lMMjSJFQVBtabQxbAEOHUwAvRhYz+GqGumrrQc8Ao=;
        b=JVmW29ql5UTjCAT5lcekvM/DXidElVrX40jB0jldwC56uL+0ld+JQD4lA+pToiHNJd
         /R2MuCuHoy6AgxJ43KncgRb3p3GbwYAFH66vZ6caukIzK2dTdfREJ1dE9RH7iNQXv8lb
         YnBdorVjpNGhQ+dxtkL7ugL9wU4ThMpN8gdLQY21XLmc0WhBNK9CaSboRb3+eWuUz8C3
         oqiGAVrEMv9gMRrphCl/kjlFNFf6UqS6pF8NB89rqmdKj+mnS1nyJ9LIRfHXQeYeHjOG
         nvuj3QB4LzMBQZTsCIe8g6POKJ4tlxke0+b/fNFkD6cdR5fgQ5nrYkXcUWGOUaLuw86j
         rM+w==
X-Gm-Message-State: AOJu0Yxq7how6+hS0vS2gcyzCo9JdSLsPUTdSQ0K+nmzUZUGCNHL4xs0
	t6BmB+N37Z84+bBID9hnFh5vCnVD/BBa5cXc8P/Xu8GaheCmjGTYCQiIKVOsgQ==
X-Gm-Gg: ASbGncu+r8+jEM91t+KJINwowHxJz8WwNhIoQu2R7LWJMxVl3CM2sIVvFdNunO/HBVD
	CpXmDELSy3BuL96VOOIGPftRJgmyUs1gyentqc7AbNWMFjTb22xbi5ZN4DHBXimxhOAWxEcEH0l
	ZB2xpSPO+OjV26sudmNRfGEfV8KEfO72p0lj6lK9IZq2gweY2QrTyXGgGmkq0ww2ARLD7mRpMy2
	xNLb/MzYzxu9NZDxREPij60FJJEJFqsM+Wk77Yzjj9D9dmgjRDIeTd8rmQhZemheFG8Yeh+9wFh
	Ty0dB8l8Csp0mKi/eP2Htfc92j8LTSWw4mCAoiGSoJrLwomyDoRQ51j7
X-Google-Smtp-Source: AGHT+IGwyYxQWqcdXAXTKBTF0SLr/gsMlO0QqUfDnzTgGvh299QIWiDYuKlzIm52bqzaxiyCMPbzKA==
X-Received: by 2002:a05:6214:1cc9:b0:6e8:f2d2:f123 with SMTP id 6a1803df08f44-6f8b2c576dcmr278215536d6.13.1747763920459;
        Tue, 20 May 2025 10:58:40 -0700 (PDT)
Received: from [172.17.0.2] ([40.71.72.225])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f8b097a665sm74301576d6.108.2025.05.20.10.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 10:58:39 -0700 (PDT)
Message-ID: <682cc2cf.050a0220.3c32b7.e1d4@mx.google.com>
Date: Tue, 20 May 2025 10:58:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7963045658892116451=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: Propagate disconnection reason
In-Reply-To: <20250520162621.190769-2-frederic.danis@collabora.com>
References: <20250520162621.190769-2-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7963045658892116451==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=964653

---Test result---

Test Summary:
CheckPatch                    PENDING   0.27 seconds
GitLint                       PENDING   0.28 seconds
BuildEll                      PASS      19.94 seconds
BluezMake                     PASS      2553.76 seconds
MakeCheck                     PASS      20.74 seconds
MakeDistcheck                 PASS      199.00 seconds
CheckValgrind                 PASS      275.54 seconds
CheckSmatch                   PASS      300.86 seconds
bluezmakeextell               PASS      127.42 seconds
IncrementalBuild              PENDING   0.22 seconds
ScanBuild                     PASS      896.76 seconds

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


--===============7963045658892116451==--
