Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795651084;
	b=e6TvBSidqubMnLkiqbOFlrxP9iGfAvy5a8ZOJu+xLvnUpiwIAXpsI0faC5gtotr+m7Cn
	 HGcCQpz3WHCl17utehbSyiBKLpuaIVp1GyXNvi0M0+0EWHkWt4/1tFIQRSdDs27eodEVa
	 /KeW9yI1ei/2fPyLyYuDfjMZvriB2EOknx9yy14izkiSbbXHVeRfDs9IeJMNuV6BzwSVK
	 sS3NTEQWRPI5Q4B9pzpdAfEqavXgLFYtcoFMj4E+oNUkl3ywwutLegHn7iBZbc7dzfZFA
	 74/8MaKmXaW5apFvrnwUURfXGkAFRPzbsBG1oCMjJfTZsYojgYxfq+ykPFTMlg9wdFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795651084;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=EHcMaN5yW0GbvH3iWHnfojNxySRehXdHDiXd/WGM3XM=;
	b=oXSzp2usZd65+FNdf/ejdoZHECyUsAAmLkcGtvlcq7N14LrNB9Q1JlpmQhuqYGRvMz+d
	 yqlKqIsZB0TlJZSHr4/2z5C9GRLRKcSTh4GzJC83kYHhwksaSrUZBKqBXwCNDlwuvnNl9
	 s4rCBnJTviluywMPSe2+CufkUg+ZyftSdglgrcoc3HxTLb02yCAQSUEY9OR3pDI/4ho3H
	 u5DQCg6XuAYRel7GjsXFaZmTL4W0Ur3EuNLSJYGvTI2bLNvSxfQJsHmqE1IXjzQGPfNan
	 3A8wyzEr0dEBwt/cePxiVdCgOS9/BkW7gi7y0s8E9ATptBnmXUErtZQKuYgeytX3Vjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RDyN1VkL;
	arc=none smtp.remote-ip=209.85.215.173
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881D0606A31E
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 23:58:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 881D0606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RDyN1VkL
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cde5a7d7849so2835059a12.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 15:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795651083; x=1796255883; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=EHcMaN5yW0GbvH3iWHnfojNxySRehXdHDiXd/WGM3XM=;
        b=RDyN1VkL1LXaBE1RUpc0Z4Vob2PfAikudXheOVjPBNy3ASpniyH0cwK1Rh+M/CJSkY
         7h4qsEcyXSKku3QYpwIjHw6trcMsOkrSNFnWWpi75ZGgv6Qr9ODqNNACSJqo315/CfaS
         3cddZPiY0ENwD0Rt1ozIynJ4MoEVA1e60G9I02jZyYg7vZCeWpiZD/xNS9lRcTpZceDx
         iRPjdiJ1CWBzs2k+ZgnFZ+7d7LZvaZMPc9oqsfBn6veBgJVGPRzHyX4aSQoaOUVSJcPJ
         1oS8bDvqdKJX7Wk/DOzXWmrXn4uj5uNBcn9sDKsI6Z5nJ1qMpQxqGXwg7K0AM7ZGptbS
         6Y6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795651083; x=1796255883;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EHcMaN5yW0GbvH3iWHnfojNxySRehXdHDiXd/WGM3XM=;
        b=Y08VWzzFwcGOutjVjUWnuKJ8A3qmj5xn8DyqXB0UEfuVlDWngoV5SAeuCucT7/EuVz
         XtURninK19g9nLDhNF6n3Sbs1csoU77ByVq9YdL7nlRyYwtQGngSEtasiqkRu5gGHQyk
         IAsipl6CffiEUttn248Hbyqxw9GsY8hDLq5d70ca+yT08MO60W7JKq/JlKtYOBiTZEsI
         QV+wwVWkrkctDex6jZaoVr5GeJCPzDLA4vBYJLDtAM6XPujTqzfIIIRJqomf+VhNGs7K
         mnKB6KLOEAyyMp8yA3vVFyiUnNp9whNXY7DZE7UuHVe3mTBwGgCvQ4v+oJEg8L/Aomc0
         rXRw==
X-Gm-Message-State: APuU4Z9LN1WyJB1hH0oGpBltg0jZ3DreOynioAU4YyoS8VmsRwlZm6So
	c5OIBxD4rHNWiw5Z1KI3iyxd5rwFy9N9+ds+uIANTTTiRLjtJMttk1Y9aWjUI8nt
X-Gm-Gg: AZFdTZeTEnV7o7DnHPXGVWQnKr3TIKLtxPuFF4zAf7r5TPEOZvVsLBzVWE2lmz4/QIx
	jAdzIf286sWxz5mw6G4QxRhd5gEvVBht/E/wkV5RXWNhA6bPiuJmwiV8Xte6aq0SN8gOfjJr6F8
	whSZuESCK5xfaTjuQLvpyuJGxW1asBvq2lfKzDftGTdALuVrZjcG/JoJ/SC0/8boUDAFfAyAJ11
	ERmbuPSqamYcDAIYF4zI1ZRsGi0MYAw/RUxd2HrqFNnr+lA+jnTjV5rwb1A3kvBWkbilNvPMfXC
	MRoWdWQQiWvlLe0eGti+bj+ZnxxTPsdP1AZs+IDEJGij5wER4yDJ/s5+Ks1f4mGbHCHfQwwvZtw
	82iDDFGIITn15U4lw6q6ZctdBWAQ8m/zAf5awF9vs8nXxn22myE5oQjWASTLYHj/pZSC8aaevlf
	BzW3+MU8Jucjok1XfXOB4FbC7sBvmYVtFT5rLd9Ag4uxkmnLymLHVARWgNQp9uw8rAvVNFpBqtA
	O8Jz7qE0c2LTXiNl/FO/tXU3cmYhKe4dldPWikl2EDjl5EpTLx5fyu3wMPoLCx08vivz1fUL0FC
	cn7o
X-Received: by 2002:a17:90a:d2cf:b0:3aa:f2c4:12e9 with SMTP id 98e67ed59e1d1-3b41c7c22b4mr16742435a91.3.1795651082557;
        Wed, 25 Nov 2026 15:58:02 -0800 (PST)
Received: from [172.17.0.2] ([4.154.7.1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f04f8aca00sm84954975ad.38.2026.11.25.15.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 15:58:01 -0800 (PST)
Message-ID: <6b077609.d7c98a4f.167ca0.0853@mx.google.com>
Date: Wed, 25 Nov 2026 15:58:01 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7293651557461282695=="
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
To: linux-bluetooth@vger.kernel.org, simon.mikuda@streamunlimited.com
Subject: RE: [BlueZ,v2,1/4] doc/org.bluez.MediaTransport: Add Mute property
In-Reply-To: <20261125170207.1648671-1-simon.mikuda@streamunlimited.com>
References: <20261125170207.1648671-1-simon.mikuda@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7293651557461282695==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1222366/

---Test result---

Test Summary:
CheckPatch                    PASS      1.43 seconds
GitLint                       PASS      0.82 seconds
BuildEll                      PASS      20.57 seconds
BluezMake                     PASS      318.26 seconds
MakeCheck                     PASS      14.73 seconds
MakeDistcheck                 PASS      153.34 seconds
CheckValgrind                 PASS      361.21 seconds
CheckSmatch                   PASS      322.18 seconds
bluezmakeextell               PASS      102.36 seconds
TestFunctional                PASS      1256.17 seconds
IncrementalBuild              PASS      350.81 seconds
ScanBuild                     PASS      1213.77 seconds



https://github.com/bluez/bluez/pull/2924

---
Regards,
Linux Bluetooth


--===============7293651557461282695==--
