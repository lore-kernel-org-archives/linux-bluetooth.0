Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E614F39CCEB
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Sep 2026 18:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788978814; cv=none; b=ooMCvRVUzVxzkuMhM7GCElkEpgCgWeaTx54JgEZdU9pOS+NnRoZ8jpoazOQhkufyCzQQxjjNL8Rc0cSAJR3ISquIZRZk9sDgMyB55xY8NPDKZrTov97orj0w9vA5zczF84tg84O7hQlQgNaBasPM26ODc/s8EDmEOrA+zWoOApM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788978814; c=relaxed/simple;
	bh=peV0QDmOv2RpylKNsqiOQ0PlLLqXwh9h6AojzDr/wKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PYxv1gCDJVxfMDIrn20D64ooi7PCPcpSSmvsg/zUxdNVX59sO5G3+QJmMzCwzJKM7SInu4I/qglyQGjriWBlx0ydKSTnD2SwgKEoxA8scn+DpBBH0lp90oewXh2M+dNO+cQ59fSAsoL4eQl3jVtCWgLqJ9oRotl2YZPhmAX268o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=esoV/yEN; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="esoV/yEN"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843c2790ccso911953f8f.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Sep 2026 11:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788978811; x=1789583611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=peV0QDmOv2RpylKNsqiOQ0PlLLqXwh9h6AojzDr/wKQ=;
        b=esoV/yENBNtN1UrvqGVE0kwhqKEqRRRE2iuH1G81A6TbMmhLUI/ec9NaIs+OpmaMdP
         ZmD7VVxG7GNk9zsD1dnNat5u5VnaC3fhw2GnZviyPobyIz9GP7QCnmVyJez+6t1TGQd3
         BAAIX1g57dQ3kOELqfxemrJORENKTdf37qJ+C+4XnH1jmxrRvBZioKxJgNdvNAzLbWzX
         9xe+la6ESQGrwqwJO4olhW5xYRl+YPCur93lEcsCqujXpEjEgWPhc3q+fOHKiBPQk2oN
         F5MzdhzsJ1xkahcgryRy90VI9yk+mnfu9/0T+lOnHRKGTkbb1et4ggteHCVbUBlu/W4A
         PLvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788978811; x=1789583611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=peV0QDmOv2RpylKNsqiOQ0PlLLqXwh9h6AojzDr/wKQ=;
        b=AAUmEloVk9PHxD0UdIKTtHGX/DHhboHTKfKQ8AW9lWXseKIs6BhJXiy2r1ZzQZi15j
         xr6+feXxywOY7tQdri7XcaaFdg53F6VAtiMHYtYIhn+CAPed4cqBy7KaZp0ElMohmv88
         FXF93l5CniNB2WY326j6gjF3Qei5f1NWPONUaYm9VemR2ihlZg+ky3JHQKcx6c7syJ+W
         YQ68Btqs7cgmjwchmZMYaf/ljWgSkxwokVT7KynnOHtPeua1zK0mQVcMJP6qg/7AmRKv
         4/QhykNviWK7m9TI1oOpgDX0Nms1fQt9/DIFsberoF5/JgCvH9D4kktg7OLrA9wTohiv
         RhtA==
X-Forwarded-Encrypted: i=1; AKwUvBwiqmaJJS/vM3RW2FTWp771sxDvIaafzlfXJnSCAAigTX9QFxMcXCP0d2/fr4x92HHYcnjAh9sKkKJNvzmrACk=@vger.kernel.org
X-Gm-Message-State: AFuF++m9ddLvmrj1kkCUW/VK5/FQRgn0VApVBUhdZfjihq884jgJ79vM
	IQ9W//5zIxXj4kP272JLEKRtYgFgmK95W7RZCxQbMINDLBwSnzPAul7f
X-Gm-Gg: AYBFou1vwTJtUL/oathyeQeBbekZfjfYYYg2UhXDVSHWHA+9x8ggZDK5v3N/znwNU4V
	HuL78jMlg51ZhQq+A+wmH7YNftJFMzx+4GO9pVJTUaFzD6Caq4KBHqClbFWGT+Mn+fss6KrjVjf
	4pkRyfwQwMt4Ygrn8tpln7s7OlrmLfDSG/skHT89og85cPPKFAZHHYryaoRRFbfPeL/c88mWERc
	yz9PLWI0rQn1WetOp2pqaUc6bIt5u7QHtLQ3e7dWgQbpn6WnR8Q6gcUMcm09NC09vHMM5h4VLuW
	+ee8tOsZMpmcKfvu27maVrjsZ4Yhj2dDzj+6tITTe0+swUWc4Gu9jFnCV2+ePbNlDpDu7l+Kaom
	mXgHWj3xJe9LywWIcIjKVIdAE6NKe9haz4dmXmCo8r8SAGzoxtaAjGaoL9kltC4b/gLEmxmV7vi
	ocCgczlbPrphoJHiMqAQPAmI2Uh971Lqxz8l591Ip9a26AkRipn/7VJWW+BLSYkA/hH6OzbdNcg
	XK5TN47c4M56cbC3lLlYWzGN2VzGC6+Gq2PHX7GDH0N489xeASicwljk9xG+lLeACOSg9TkYd73
	mYzWwQ+DWY2eOtYrtujAO00GNA==
X-Received: by 2002:a5d:64e8:0:b0:485:b169:54fd with SMTP id ffacd0b85a97d-485b169576emr7617081f8f.4.1788978808281;
        Wed, 09 Sep 2026 11:33:28 -0700 (PDT)
Received: from cdev ([2a02:8071:68c3:bd00::8998])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485885b1320sm44363262f8f.27.2026.09.09.11.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 11:33:27 -0700 (PDT)
From: yCduIhFgkD <vladimirkondratyev2@gmail.com>
X-Google-Original-From: yCduIhFgkD <83831960+yCduIhFgkD@users.noreply.github.com>
To: lsa.uz@pm.me
Cc: arnd@arndb.de,
	chandrashekar.devegowda@intel.com,
	chethan.tumkur.narayan@intel.com,
	dev@lengyelf.eu,
	kiran.k@intel.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	luiz.dentz@gmail.com,
	mahalingeshwara.chambarakatta@intel.com,
	marcel@holtmann.org,
	pmenzel@molgen.mpg.de,
	ravindra@intel.com,
	ravishankar.srivatsa@intel.com,
	vladimirkondratyev2@gmail.com
Subject: Consent for Assembly
Date: Wed,  9 Sep 2026 20:33:25 +0200
Message-ID: <20260909183325.20971-1-83831960+yCduIhFgkD@users.noreply.github.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909123416.71919-1-lsa.uz@pm.me>
References: <20260909123416.71919-1-lsa.uz@pm.me>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Sergey,

Sorry for the late response.

I consent to the assembling the series.
Also thanks for the extensive testing! You're really rad!

Regards,
Vladimir
