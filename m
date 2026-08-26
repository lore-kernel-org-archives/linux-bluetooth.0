Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25835472798
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Aug 2026 19:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787771616; cv=none; b=MrPAcC/haBnFvxa1eCyefmTnNUk/bUbwrSFDB7W2c6Dyl7skRCFsWGr9Cyf9HZdnJIf5Zkfrb1bR0c254KFWDwiTIaX309Ah8+Rbe5Q7MWONESpwHKXGgElGemcA2egujFDX5ciIVa7GR0wKPHlYcSTGpUX0JFEwvTccIdrAQV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787771616; c=relaxed/simple;
	bh=pdmYNjYgR+yNzzAAzjK4L4ACf+seBEs4NdoRrrB52NU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=dg2U9CVOzMSHSq/RQ/jq4Elh+U3+OTRuAkRapSlT1G3ANPMeVcfzY9/HMXtTQB/mOva15T3GpKmxrg2ocd67iW1LFfZwayFDDU5bML65YrBW3bb0p7wPOs4siHDi0ZwSjG7EFW8z2uUFQ1Wolye7mS53NccKONviF1A7yhqu0z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cowXKmfw; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cowXKmfw"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38dfe910e9dso1052855a91.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Aug 2026 12:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787771610; x=1788376410; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kf8t5ZIMIlPpSZMdUvSJHVEUJmQdvfXVTT42kVpwwAg=;
        b=cowXKmfwGCgETQBtT1s1sbM2w2DD8DEU63egIYtT1Mbka2jsQ7oRworHzBeABu/Rho
         kywEe0YjybtLJ/A9OL/t+JHCUVPe7N8KmSYemx+Wf1jbz7BzWxV1ZltMWnowMCMLkYNo
         Sh27inV2zTmsz2YbzxwRviR4r9x7DkbwmoMX0Nn6h/9ajjpHOoNV7R71IJ4pR55KqP4W
         NQmgzQGxfgB79Ug2o2zAiREYBi97taonAQ8DcKFhYMLE8+Z93evjXjjxVSrL+84QgdjK
         32UDh+/oSKRoC9BOW9ySxKxrwte251ddms4kfv0C7VtHVesSirqxGzvQwZ0jytULHSmh
         YjTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787771610; x=1788376410;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kf8t5ZIMIlPpSZMdUvSJHVEUJmQdvfXVTT42kVpwwAg=;
        b=GuNsR+5+iTO7uVj3i22F+iuHLx2f0ilnEnqzvakXmDPi3JpcjFtPRg2Hzv3V0rhF9w
         AD+if2ibxVqlGfyAOhDxjgYX073VWqqCKcTI2gIOSuBanviyWrRJ94NtZN/XCn2lCnqE
         M3uVSXjpO+CW7EvyZfUYCvJzgFfh7O9bhpe58HkS5FheBw/MhOcATqn0inrvw30fuQh6
         8p74cno1S5pUiWjvD5WKoB3XVtUyWyvRtWSD8ss4KgolmS1P2YTJKUjxzhokPhHu8AOd
         66YzMnuStANjrILkgceZI+oYse+FRlW2zJUP2vMtfUD0oXLrCgw0N6ISGNKa9X/8zXbN
         1SqA==
X-Gm-Message-State: AFuF++lDuEZ87foxhNSaR3+eM27US6Z5tfuFBkD8mTaHtNmNTl6iNNId
	X1//Lko7p9JyQWYGT7cIgeB1rQjrJIL0u9IsS6bTMp+MTIkALSWKLIOXm/O16Q==
X-Gm-Gg: AR+sD11d60va8mkdwEIHlqMCJrb3GXbnTPHmjnG5XhJxrKkSa8nIajt32Z53x6hM2ww
	Nf3oR2gQnkBx0gNduXjmAQ9Uj63KLmHAXSO/B6Wdj6rkYtVFvTBWpkGqnRWXmgtL6sYl7H9Pgkg
	LEZsE8ilhugl6EZJtkmacPGe5dDzmqGceTBVUbRibb1pVIOHDtZ93NtOQlikS+PU4JEd03ocH8v
	I9Kv48MTIX9czTaT8KoUf+3e7noVnn5IplTrT8zFml8JGhd7oMiXZmXrx7km8redRBijIwJModK
	BPmoWnOWAmNwZ8nx5+L4JktRqWJpgJiPitRBhZLY58s6/y8KiA2U2WBenXIoLi2W1Y5uevV/CSv
	BjJ7AS9yS6TvIdx18USqfhnDn8AmOnmp5tzy2TQ/YFS/sCvEjMt3hLhwrp/WOToPTw2fun2dNOd
	gG/A9tIGFY6ksjy46dylIp1oZfXozGiEpIrmsrsOEstMovF49buxdEfIS+ZfkPVTUzYBy8
X-Received: by 2002:a17:90a:d2c6:b0:37c:6910:5758 with SMTP id 98e67ed59e1d1-3966d1776d0mr19984142a91.1.1787771610068;
        Wed, 26 Aug 2026 12:13:30 -0700 (PDT)
Received: from [172.17.0.2] ([20.184.135.199])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141a8f467c9sm10007960c88.7.2026.08.26.12.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 12:13:29 -0700 (PDT)
Message-ID: <6a8f3ad9.ee10049a.dc161.6857@mx.google.com>
Date: Wed, 26 Aug 2026 12:13:29 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4140639360211182687=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: input: avoid NSP1 disconnects caused by Sniff/Exit Sniff churn
In-Reply-To: <20260826164106.293951-2-frederic.danis@collabora.com>
References: <20260826164106.293951-2-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4140639360211182687==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1152198

---Test result---

Test Summary:
CheckPatch                    PASS      0.63 seconds
GitLint                       PASS      0.40 seconds
BuildEll                      PASS      20.36 seconds
BluezMake                     PASS      597.60 seconds
MakeCheck                     PASS      19.56 seconds
MakeDistcheck                 PASS      159.04 seconds
CheckValgrind                 PASS      229.06 seconds
CheckSmatch                   PASS      312.41 seconds
bluezmakeextell               PASS      103.17 seconds
IncrementalBuild              PASS      601.76 seconds
ScanBuild                     PASS      1014.94 seconds



https://github.com/bluez/bluez/pull/2438

---
Regards,
Linux Bluetooth


--===============4140639360211182687==--
