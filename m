Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7873435EFA
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2026 10:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784801040; cv=none; b=OywPML+zyfuYgtG3rVsxqRdBS7J8AuFMs+TzYtgtkiOfboHEG5kB8Uz4U30iCaMvM1eCgfN4LkmOcZvVTwC+iy9HrOMp5IWwk1pTLlhvWRArmmQp6jS1HoMOlrkJs5mNGxd/aiEabr083EneRDMxlgND86G+cJldIQKWva1eDFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784801040; c=relaxed/simple;
	bh=bjfkWpnEDdO0vb7f7dL62tQP9K1a+qCQ3Yx+AQLZFYQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Sp+txH+ETarXFDtjN48ZoEwMwQ6cywcO+ZpCuyMWv0oMUZtqthNQIMj7Rs/90ISg1wKVHnsa1Np5dlMGwvHJo8Yp5vVCwVBtpc0boo2l8V28bFM675IyFqSgOLS1OfqvZ5ZCb2rv3qIP6fg0MkirtHDUUtu0292YB2HN2HR0w9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HLJEpDrX; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HLJEpDrX"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-92e5cb052edso36106185a.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2026 03:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784801037; x=1785405837; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mg1q3dKTyXJH9eWxhvk0IsLZazthES0Tx6X//+SfPng=;
        b=HLJEpDrXuf2RODvzzhRCZEB0fBcHXJIqOKKb1PPvMPPvliKs0s3xj6PAwYl8+6M6Q7
         HDktbjsCWjZNyOFCrQIDOqN6ml80LSlaeWxP9G3/KcQpZbtRrwxA99DfvHe3pPYYl5Df
         hbNAt0baYHhE5Cs/PRVMeP9RxygYmS1mSeP38gyOatk8i5oaej9+LJsnhLngfR0h5pLU
         i1Jx/UbpeP3S9JF1KoHLl0KyAzB3l0IbGEBrLg6Hz2rme71RCJCvQ++UzGsUH3gcVET+
         I4mMbDk8vb4hOszdnMHVUoLKd7KttLNuKCZSRPHdTtmJNX/YkqtQbGrxcuHxj7TGGWcH
         W5sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784801037; x=1785405837;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mg1q3dKTyXJH9eWxhvk0IsLZazthES0Tx6X//+SfPng=;
        b=SlvSRVl8CWHuwDQpML34DAoICQC5vvUuA05M61YCPj5hnNI0NwwW4F2ULpZtf+7wtJ
         ZL6In881/2FtOkFWyHQ5fIuyLOpKvusN1AEHMD6+6wJWom+/9vT6R3nTMUhVsYxl7YYA
         T6oeLhBoD9ZDBU2ztBqQaaXmx2Zmfw/cq9zFPI+TRVWLxXuALclh4pWMaMqc5tiXK4Gr
         2EB9XXuTw3VfYKvv74NakNx2QyZZTpmAf16pUQzdz3BdfrvIhKj9GLeFcT7BcQB+glMy
         ATyUij89l4Q3xs2wqzpLh0BqHg4mI1YMETUHdqC+WATwWHsxoklzov7golvz9wW3YbL5
         hvuw==
X-Gm-Message-State: AOJu0YxI1IOhkyhmWkJVGzmiVVRGilkoeC3gMTf+g9oCIPziS+NKSq3X
	/PU+X59wZk1ZfHhRBtZUYerzysdTp2uNW9nVgNE0pB/wgY4rbiDTGjyCel0PRQ==
X-Gm-Gg: AR+sD12nIVzd2cSaqL+ZQagnPMUJtgC8Nt8xL5LGM639yDJnvt9mzw4YcPx771Odwqs
	FdM1e0j38qib7mX2+/XEv3ikXc+Vl9d12E+5aQdDGEAd1Us1L3Gfn2N7bDpltTe0gEBdPgjhSqq
	pduta0W7JaZC4tNlZdmJtIWpMLQMPO1AjEmE4LkpyZUkEJD1QdIFqVWiKQdk+YwJ6qQ4KAW5X/R
	VWf7euL8XqHO0XitxIS8cuTbPvhN+QaW7r437tZjey8zz92tNcC1b9HSRpFe/QM/zf4rRn5X05T
	6Tp9mtYu+5fHkFaY6jRuqRiKF95UuzGCR3FCA7HN/U/jVE5TXvX29I+rQrnOXApEV7TbcVJwuLQ
	Uxdk+9JEvYLLMn0H4VQw5uXcSyBPXlb6tMwWUrWJmRgNlbADCvztwsAIl6DIqtrtOycTaH3lZhv
	RTOzui5JIy
X-Received: by 2002:a05:620a:711b:b0:92e:c118:18a2 with SMTP id af79cd13be357-93103a5292cmr223213185a.85.1784801035371;
        Thu, 23 Jul 2026 03:03:55 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.177.97])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930f6a0411dsm380756485a.22.2026.07.23.03.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 03:03:54 -0700 (PDT)
Message-ID: <6a61e70a.5a609c75.c6aa1.58ba@mx.google.com>
Date: Thu, 23 Jul 2026 03:03:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1023326844960926874=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zuohongsheng@kylinos.cn
Subject: RE: [BlueZ] lib: Add bt_realloc
In-Reply-To: <20260723083508.93096-1-zuohongsheng@kylinos.cn>
References: <20260723083508.93096-1-zuohongsheng@kylinos.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1023326844960926874==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1133053

---Test result---

Test Summary:
CheckPatch                    PASS      0.46 seconds
GitLint                       PASS      0.30 seconds
BuildEll                      PASS      20.59 seconds
BluezMake                     PASS      559.13 seconds
MakeCheck                     PASS      12.79 seconds
MakeDistcheck                 PASS      158.74 seconds
CheckValgrind                 PASS      207.93 seconds
CheckSmatch                   WARNING   311.03 seconds
bluezmakeextell               PASS      103.02 seconds
IncrementalBuild              PASS      560.85 seconds
ScanBuild                     PASS      979.60 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/bap.c:318:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:318:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:318:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures


https://github.com/bluez/bluez/pull/2342

---
Regards,
Linux Bluetooth


--===============1023326844960926874==--
