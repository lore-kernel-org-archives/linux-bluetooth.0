Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795368137;
	b=xzpSnVz8kTtgaI+cNlXYbqhfddvnR8VW5Doq28aCxSKCeccrLCl01zc4+l2QBEvar4xX
	 S1KrLTlIHwEBgNQCpA/9HcJpax5/icV1FjKamP6WqPfeRfkN4O/IP6IKl/n+Wl5qD1iV4
	 dCjvLdhdNoivZVnPZM+x4TCKI0DUy/NMiFPKQYgJl6YYCwxuXSfgAUAAnBa4RpLFERvM7
	 kr4bnfIcTPCOFFGhw/6TjilQv8Q8IMfIV6ESZb5a10shg45aDxg2Os8t3EgOdYxmIzm7b
	 aZ5L7Zm8Cr8Z3qzFPjkz5rgu7/QI9habPJj1K4lDEMOzPC/YZWJs+8zWYy0N+P+2D9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795368137;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=tvYWNlFYukJoS9CUFkNIF9BMTMcDA8Yw3zqN8Cey32Y=;
	b=vwJbz9Gpwc2lh5JOUcOtZF2nlIGxx8WgowJ1BwvrZlo07+smDjGWzJqwzhgChcE+q/9L
	 dy1bMYCcWWBDrrfPlhAq5elhcTOLw9VOUBF9vGX5IprYcHqTmNKS1ZZ1PGUVVSLT1tHhT
	 Ri2wlZpd6ZQ7ZGvO8pZluPnCxDmKclH0hCl5WfQdMHBM7FzhFFgtqaeu7iBrDXj/Rak22
	 aEttZIbSnjIh7lUiQ6eRqKXsqnRiAjXoRplH+fGIF8WcSi+sYDlWPiCzsgIh5CxeGB23J
	 zcf52BtqfQs1ALC4ifk4mLoan31ERdlQqZhfMu3AwXKB8baKzyvJphvr6AFyNGkznuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O9aONFFs;
	arc=none smtp.remote-ip=209.85.160.180
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D2F606A320
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 17:22:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41D2F606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O9aONFFs
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-55d30c054dfso29735891cf.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 09:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795368136; x=1795972936; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tvYWNlFYukJoS9CUFkNIF9BMTMcDA8Yw3zqN8Cey32Y=;
        b=O9aONFFs6qNr+Kn/UoN7wf+Hwp6Z9HitA7avufTWLl/lMCiPsfzgynE724fec35qVr
         qIYiqwIw7OrXHNv88ZLqeImCupDn8a9Kqnr0FPThMlivcfFSuAOdEIUV0fk4T3/0kVcU
         wLyzu1pMTkYyQmFTHXzHe9za6VrTlsiWB0pHv8dcetRVh3yA50Vq4ColBKiwc7jkE0yq
         EOySPTgN0fdfO99dnVOYhwhK+Eleqyh8AR/6eaKBKBo0SpOD7rgcznd0Wk8HTTHbpQGi
         V2v5FudceUiZz5zkgR+Mk90U/lXkTbw0jnpEcVukOC1g8B80gZpa23OMKu3Z+9C7YKDJ
         VV4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795368136; x=1795972936;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tvYWNlFYukJoS9CUFkNIF9BMTMcDA8Yw3zqN8Cey32Y=;
        b=bqCtMjYY9f+PalUvdtRbP+hkvJMzhbO8wYvohjSQ48/7AgViJUv/CYPyz+Ytyn6rSV
         +OVw+uRMCzzpdSlRWm7Zjb+FkxpRAmp6evSVXS5p6FUaREte/utWPUGarz6EOaXd7690
         0Ww0NKTXau8PnbJNqn8B86vOBTO4NlBBqyIrGUuTTlXLagdpp/6f4/F3cjgqOueaCV7u
         VSMHEF5wRvb3kqMu6VP9tF5DNANVNJoUj0ub3Nq3jUnROqWCYlJsghlA2i5yGteNQTQb
         rMyJSUgg8Fl0Xhr4T9zU60yeSLOiYcdWOohO+e4z0wvAdtMkEjkoOyhZJeS6b0WQTBab
         JXgQ==
X-Gm-Message-State: APuU4Z9D9xCSfrUEpE5obD+UFrhoQ/rXTZVnvU4ibuFgJ85S8b8z0LNj
	baEopCqG4xphCWksp2OawShpT3z44o2qZzeXgECk2UcPZKyQXknffFy80J1KwA==
X-Gm-Gg: AZFdTZfw85LhsDMZBE24h+xGjtcyRIGdOFCQjteS9oPtcDDkWSLn4EZvxHQIdi4S34x
	l7x3d45zbr/05WJdKAMYuIeKB2alIWiv2vbVrH4yroHfNnuW/NH6zEd52TdMVCFKVGEy4DVddos
	hdUYP/r1XKG7yEetcRKHE0zzBfcu9QqNGKT/JCs9urdQNq6QSqwUlPlV+/abe/6hcwlPjDWHl0o
	OgOu9TPgWq4bglKobp4kRv8MawY1DokzIohDVD7bs+bh+ZkkFk/Yl/ADWrUSGh134BNfGxQvsFG
	jRn+TzCq6g2qQr70TnMh66yqroKXtKixWo8ALDHCe1a7PkC+oliDriZT/0ZXe1m2wF6o5nilZmT
	lauk7uicd6AqYeC+wgG9EEc9kuF7giAVFbPRQd0ZOS58+jdVllFl6PpkhAzEuiWBgzJW8rhv6WU
	70OAhg1X/n3vDquKe1SN/kF8Dz/zgS9d6llI2k9GtrfBgB+yJRSYvHG+vUsZNiW3Ywej98sg7aC
	8mCs2IplovCHLoBjg9l6AfyoQL6AP+etQm91vvq9mF6ex73zHp4Y71mimBW6d2Oe5Hmy+nK4k3Q
	s1RW3t1gWOp38oPgf6Z1sdtUuwa6ryxRIZyHtHfm1YY8ZNy2HQ==
X-Received: by 2002:ac8:5d0e:0:b0:55d:25a1:72a9 with SMTP id d75a77b69052e-55d76a17bcbmr174757491cf.32.1795368136030;
        Sun, 22 Nov 2026 09:22:16 -0800 (PST)
Received: from [172.17.0.2] (ec2-3-41-210-69.compute-1.amazonaws.com. [3.41.210.69])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d7882ea2dsm77638821cf.15.2026.11.22.09.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 09:22:15 -0800 (PST)
Message-ID: <6b0324c7.25f1da37.8c6ee.80a9@mx.google.com>
Date: Sun, 22 Nov 2026 09:22:15 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8276725939259730602=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, jperlow@gmail.com
Subject: RE: [v2] Bluetooth: btbcm: Add entries for BCM4364B3 UART Bluetooth
In-Reply-To: <20261122165132.14015-1-jperlow@gmail.com>
References: <20261122165132.14015-1-jperlow@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8276725939259730602==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1218823/

---Test result---

Test Summary:
CheckPatch                    PASS      0.56 seconds
VerifyFixes                   PASS      0.11 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       PASS      0.28 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      20.31 seconds
CheckAllWarning               PASS      23.98 seconds
CheckSparse                   PASS      25.46 seconds
BuildKernel32                 PASS      20.84 seconds
CheckKernelLLVM               PASS      21.14 seconds
TestRunnerSetup               PASS      492.41 seconds
IncrementalBuild              PASS      19.24 seconds



https://github.com/bluez/bluetooth-next/pull/1188

---
Regards,
Linux Bluetooth


--===============8276725939259730602==--
