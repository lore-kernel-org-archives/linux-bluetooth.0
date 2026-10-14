Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17DC3AF66E
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2026 12:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791980707; cv=none; b=Zc3Jmm5ifvjR8nMPEGRBm997koub1MbAeP8sncah4TWR4kpqrKnz97eorcEg5mybel9WzO/LnKVCthYWU3XqoYRnmH896J04cu+Iok/Zoo7Klo+87Ok1/r1tx6i5VSP02Wwpq4qzCPDtJx023Nkg5CthxGVCSP+9NUFdLG6MxnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791980707; c=relaxed/simple;
	bh=BAGwqYjgAcjIHhs/sM3PyswkP1Ol+eoO5PJdMKTErJQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=QIhN67+Ch6nBgrcOSGSTpDGWxbNXQi0CGeTASyL5WqNJC2mJZxKOg4OehQi9CpiCptXynKfE8r1ej/LOiQt6hQFV0/F0rx+acwVIri7mL39xvVLNcCh0HLfuGGhUUamvTBYSXod9wS4uckOQpvvlJHOtC6N/eoM3aKPjHBEmFQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=omQqU4cN; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="omQqU4cN"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-82395ae2ea8so685250a34.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2026 05:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791980705; x=1792585505; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BAGwqYjgAcjIHhs/sM3PyswkP1Ol+eoO5PJdMKTErJQ=;
        b=omQqU4cNcX3UmDdh8CKV6gu6GwwaXSTwWsnhhe+770WG+jZ00YD6cQcLJnvPD6ZLKg
         fB8I23HCmt5gIbRa47Vhy9ZkLOqiLVGgNj/xOn9GtFezp0BVpm3WdqlyINyM+yHRcMKC
         CSQjltTXvV4NUw6d0rEUe1uMI5BT5bWcTkZz0tyavrJWJF8ZHRsHdKjOLr/8pEy2yjdd
         MUzWuDmyMOwo9sGaHuT8AsjWXpL/CX9OKHgIziLq/Ofr01CdjHKusPcDeyhxO6fhwJ9Q
         y2xdBqpmDatSlQq43q6d8NoixnB28Qtz7Ik596CXoJ/e5v85KUjIpfT560XFYF21wF/X
         bytA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791980705; x=1792585505;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BAGwqYjgAcjIHhs/sM3PyswkP1Ol+eoO5PJdMKTErJQ=;
        b=Q2XsubFrBZBgDfU+qwW/4ObNfht0wLquVVU7hX7/IsMPPQPawqcVtg+4Hi8tGYEudg
         UjqQcpyNHmAZvYWJXKvBWnlSMXVuIdoBC6KoaaCUhOxFu7DdKcYh/2t/AC8AuogwenB2
         RtU2BG6yRKu2hlLZKoZcHmPkWxLjxZ/GzD1RHC7jD5KMjmFjlCIbzRojmxIDwGOlObhA
         mR5R/BT9Q0eok8cM48mpQ8FZlFI/u/Sd1duPpbmyRFs3GhgygskLuqcxrigHb0hwDwtN
         HSRfkDyLI6gJq1GA86tZL3tFQ63tpUNQBxbVi6XsOaejgmrjQUO+CmqxDIU/09t9vGiE
         YQ/g==
X-Gm-Message-State: AFq9FYJRa93MFaI+CKPCdtWkTJpXGZeoaRgYFPjaffAf2LBiZtizvpOD
	tMTFP1yROgSqAijP/hh3lTMfOzRrlhVR+Rx0liwkNmn7+1LH+UZGBx4v6yUaCA==
X-Gm-Gg: AYBFou01TsmiMruo7IVWWYJnzxMmHnhx3yRVEGBb9kRGat3u3I/kFKU2kHxIWbjzh1B
	kKug+7/ca/e1XzE3TmBGLfwMNo5lRZjTkyFeXqeR2NZ3yKTvDQvVFu1/YCOIbeqfEaAuv4CFs83
	69Hd2rm3t5VwCTIPz9o8ZjhfvvZqBWKPhISJq04BoYnFAUycB52VGqeGkxlwvWW4WCsbd6PGXPn
	Ivy7u+ZeaBJ+roM/VNa3X13fqDxQTVEcQsfwBVw6SSiNsU/vGyeKhvycf36bl2puUGUUBKEnwjh
	g8kRghROOUcsmDhdYnKGssZX4ntBfq2/z+N9NyNgjswlhzCcI2ossod5J97ktkB5Xtx9gF5Iiw2
	UfKHr250oWkDsKMdlv7hHqv2Ei+jEMF43B99qMIGEx2squ3Rpo9XvyVM/eyZEF+TEQSMMfNvXq1
	VD4XNa7jAi+UXSHc4rVZGOitd0utoeHWbpmzd+1R6woJz5tOIIXHG6kr5Lft+2Y1Yb8c5WNpUXZ
	luoKDTiS3k6F53E
X-Received: by 2002:a05:6830:3490:b0:81c:a8c5:633c with SMTP id 46e09a7af769-83095f0fbc7mr14104371a34.17.1791980705451;
        Wed, 14 Oct 2026 05:25:05 -0700 (PDT)
Received: from [172.17.0.2] ([20.186.239.36])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8302f625a10sm14768404a34.0.2026.10.14.05.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 05:25:04 -0700 (PDT)
Message-ID: <6acf74a0.2a54a8ff.370b22.5e1f@mx.google.com>
Date: Wed, 14 Oct 2026 05:25:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1794827431655130107=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, mdmitrichenko@astralinux.ru
Subject: RE: [5.10] Bluetooth: HIDP: fix missing length checks in hidp_input_report()
In-Reply-To: <20261014102016.1807-1-mdmitrichenko@astralinux.ru>
References: <20261014102016.1807-1-mdmitrichenko@astralinux.ru>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1794827431655130107==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/hidp/core.c:179
error: net/bluetooth/hidp/core.c: patch does not apply
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============1794827431655130107==--
