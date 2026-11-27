Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795790996;
	b=4csU+wbXeQ9gpQYz9St3Q92FmolMyU9l6zFphEwF3UEXInUi3nDAPSxAJb4DNBXXQbku
	 ofdU2TIOwaM7+V9JX80GPGVezxImOGs04L73tXeySQZFBgygDMnUET8SDVLgQ4Tfjx7dA
	 V7rzeN2l2SzbyGwGqaivgBcqMSXDuh7kq4awFGQXiG098uSQKaxx5WvhJ9h3D1u4vIxW/
	 R4vLSW61KPba8i220oxjdO9wp6Xl6kWh2+OG88WZ0vneyDhj6xtYXmPw+wKE+QdyEENNM
	 Rw3WZyjJhDn9NF5zitA2xlOKrt8rvSO0yVptPyN07v5SWOoXOlWIXCDhLfO3buTF/rQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795790996;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=hdKgwNIiBuwFHq7mydL2cEVwvVNp9zi++2/hqJgGniw=;
	b=u8B+pocwX90knLLNN3KFDbEm5IqHR2C9zjYsfZ2FxduWH9A8goo4SYBE7oDKRoKpWUvx
	 cCRQ1l7Q1QeDUFJ08ux0g8fV2FG5lCBrryxA9XimaXM+WkoyD4jyoZzKqY4s5hvHX6Yv/
	 05Lvw2z61ANRdLtBfiiIg5Nsy6RfvAATsHdZlo9vOhBz1jaMdoN/LXOeQn0d7z2UjJmhK
	 ude8V6HjB9x0073f1VKPVkQOVN9W+11zZLu4lzDiNRZdp4ArXgf7Tyo5sNqOqo8f3eSP+
	 aTTAd9DZWLJpN9C3qAaAJiNKU4k2fbiAZ36U9P7+1fhZZAY5HmetiHAmpE3YsRwKAWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=y4yWk3H5;
	arc=none smtp.remote-ip=209.85.210.175
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09C9606A31C
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 14:49:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F09C9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=y4yWk3H5
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8a052aff9e9so5871348b3a.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 06:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795790995; x=1796395795; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=hdKgwNIiBuwFHq7mydL2cEVwvVNp9zi++2/hqJgGniw=;
        b=y4yWk3H5Xq8gvlpsnaLIWbBWMtxHG8/ZvEkrHWoBsBkgHLUv8q0qRYj8y8HHai9LNB
         B0wnDTGISgmmAYwYgb/FutryLTJdSYwhZyytY+Nni12g9i3t7PKPOuecc6qjWXyd2OIS
         FeEyaXEwBGkn18lkIDumy0z0xhxa3wOn7OG4FiUB9JdDbsVU8S1pzGGTygZ6MinZfNsc
         1ACVDj1fEjJZWbTb8n75kJTkqaeJWiK7UKY4L9QMJNHakL8e1i5OE0MqvNBIBhropfxe
         q2l99GZ94+/jyswwkNTck5z+pp3tVnFh1UIvE51oBeD6kViOjzEJNmjkDi595w8IEQE0
         Jgig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795790995; x=1796395795;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hdKgwNIiBuwFHq7mydL2cEVwvVNp9zi++2/hqJgGniw=;
        b=W3GCOH0mnDhJ9iNVKw0HzEtQk+bp1ahWfwl2pp9mHLNW+8h1boWMAvJWxCbDW4zAp6
         GCVLg4cm15LpEidT8xaMZSzOoW+GTTLSEHdQAVmBQn4vtlHgSmQ5KeseicSmlCN+dOf3
         2UP1f9aWUOvmU84FbsMLo4kyzVsYq48ph5OJ6REgx8lWZKjypFMuVlmIxa6sIAyZg37G
         7TPY+MP4jenRSrGxeAKqG0lSQctYeFaqCMguKw/COtbT6s/ye0rMpywC46NEb0V8/Yf5
         P2iepGysArinUoI8c5SrYZHC2ulPcLnXqRsOIqVoOq2cManU0NA6xYIEA3CkVlU6RO4o
         K8lA==
X-Gm-Message-State: APuU4Z/vz8W2f4SR3/Yx7fjJCJ1rtO3oGyQ43D0U17ubiTvx+nRQojON
	0ogLZDnG4BLKYsTVp6ulvn+Ghp8OPLLqVzwHJ3HZh4Jl/BPOY0ebzVFo/fIMcA==
X-Gm-Gg: AZFdTZcCNU3B/tMMTkeJ7anTpMvDsJ7hbqzL6g7Z6PwQlH6NkcmDigzg7TTokF2cbWD
	I/MfWn2HWdSsLgp8A05vu5uQzjob78N6wAK2iVFSNom2WlYVUgQQy9H+W0Y0KSpGWUHMHYUogF0
	TiKi2Tw0MrxTS7LWgDj31rDVob/KYgZCBiVQ/eIPePu6LNNxKwPeXJPKR/k0r70f31CzYxEE9O5
	GvYT8F+hDjdqEvP6RBx9FKjjMieCVnpmWBVijvfb+J/HYyruX52fgZHMyTTii5UHT+owETJEKn2
	+d1uvnVCEZL01oiPN4mZptzC1n0yxM7fp6d8P1ZjpLgCDCBTq+4n1O5iCyQiQ7xgFciDWZ0k1mc
	Vv1nLh0a2KfJnci3/F9j3P4OW8HGWIRKtd01Hw72mzL1sxkzgsJxRmCTelp2Q+PkQTBb7mgxUSc
	NTHZKtHKNCeYbIjMmyl0eFGeiT0IHWuQVsFYPgG27VgvE/oOHbfVrgxICEtGPKZhPBx/wISLp6k
	GnCW0IIFBGWFp3nP+JP6/HoWQRMsRec2s7efTFYxyjHM3sdioMMDmSCDGqn2QawX10N/7P+9xZ/
	nFJp8hic
X-Received: by 2002:a05:6a00:1483:b0:89d:7d72:3433 with SMTP id d2e1a72fcca58-8c87c388447mr24108765b3a.21.1795790995174;
        Fri, 27 Nov 2026 06:49:55 -0800 (PST)
Received: from [172.17.0.2] ([4.149.244.232])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c872e4c43bsm12465530b3a.26.2026.11.27.06.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 06:49:54 -0800 (PST)
Message-ID: <6b099892.28ab9576.198600.d985@mx.google.com>
Date: Fri, 27 Nov 2026 06:49:54 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8995415221171956397=="
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
To: linux-bluetooth@vger.kernel.org, cochcoder@proton.me
Subject: RE: [RFC] l2cap-tester: Check deferred ECRED batch rejection
In-Reply-To: <20261112022522.185562-1-cochcoder@proton.me>
References: <20261112022522.185562-1-cochcoder@proton.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8995415221171956397==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       [RFC] l2cap-tester: Check deferred ECRED batch rejection
   Pull Request: https://github.com/bluez/bluez/pull/2811
   Created:      2026-11-12 07:43:15+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============8995415221171956397==--
