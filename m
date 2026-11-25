Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795605973;
	b=FK5aQqBhysu4RavSf1fRp44fh+Bmg1lDRyDPoY/fgNGaTqw8KU/0m4sBlC6fQwQ872n6
	 tlbiXUzk7VCHrplgl0RkBZqHcLW1CVbwKgzHIZPOlW99MV3OgQBGMbSKbjV0blusv/gtV
	 yG8ZRV0ZAu1j+Xt4Z33Opf/uQf9cs5DDCZJRsgPVTxn7YG2segX6boqGGEYgRbQZYSarH
	 XYJklWdni5BU+BICeAzOnZ+mMZ8Stv0QccbxmLH90arRTdVIcN5FicnkT6AlHI0wUTAJX
	 u5ZXCO4oxV2lYrSZOMbqTuo07Qs+dWcbjXnsxwrEMV2YyluzYCEbu5dCzTkyEshjXvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795605973;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=gKRxPw+LpTLideTbkx7EsmV8SDYnquPjpIX1ZUL4Mx8=;
	b=zLROn+g50PX2B36nw2OpcB2e5BWKnW4Vqmq/0qceF5Rxi163WBa8RoyLyXekubLib0RW
	 E4JsDCo2LhbDmmRnh25yLxqlmpNEa7inyvP3hb+X1QsAqJybP55yOj9XvL067I6W/+K2p
	 M79IHrDBl4R9OcJTK1NB9WQpkKMQRY1ox3dA8nwEkRkBzUZZ5L80IT5QCbMR0hGIms2ru
	 kjA87YQPl0fgWdVKIIQ37omfaH0agwcpXa+9JsV5IIENjRTIQNCpCNUy3uC0On4VcF41e
	 2sSHtAR3+/RpvaFZIdwBW6/n71gh9TgjKyPV1USwt5SWP3z4vc6yq1w9z9Kb+eMMTSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EsIDofnm;
	arc=none smtp.remote-ip=209.85.160.50
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1D4606A31E
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 11:26:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B1D4606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EsIDofnm
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-43bf9548df4so5145996fac.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 03:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795605972; x=1796210772; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gKRxPw+LpTLideTbkx7EsmV8SDYnquPjpIX1ZUL4Mx8=;
        b=EsIDofnmyHL6Aaic2CoV7LIx4KZQQx4U6uTC3ff2tHy+gmi9QFsj4pIvPIHoa41QhB
         qC1xtanokHoiIeswAxjEJuW6FwhRuwgXocReQJM1ai/tg8t3+ET11BRaoW7l5Qq5rXnN
         wt19LqUWiYNp6O3KC5LoyRv/zADcSHkBeTwXormEx454ISzTMnLTKHutXooHud8KzDgr
         ptFqEs0NcC49dPh17ncERf8ETWS8Qsh8q6tz7J91YVH5fFyGyHA6r1qnRZ7HjYBKhhTO
         6shr/tJkEwgfPUNP5zVSFSLkMOEQD6W98NARqDzU0GhTIMX8CMkiuteGewQDZmwivXIs
         8ezQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795605972; x=1796210772;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gKRxPw+LpTLideTbkx7EsmV8SDYnquPjpIX1ZUL4Mx8=;
        b=Us8NgXR0gqflm/G3QwzcEi1+Q26hHTphZ0WetiWrEIuJHsYIYXa+WSRiXIAyiw8bBR
         yKDECkus1kZgg7Igu9GPCEV9GTtPEm7dOSSJG5wjGH/aG8zmppdfOEPrVxpcGSUeq772
         Nla2E4XXi5rlR3L2Mlk6C5t2e/7gV/nPv3JW99Pn4Slu2o4UMuH2O24cc7VxlhIpmmh3
         gvZiUf0d4POV4oXbpCJ2KBIfwq7fQNFp6lpTn3WRUPaBdrkkHYNV6NwaxGZABl8YI/dL
         kJqnDL719bPbGoMaKRbI0XqPENOwGftYskFBrlcjqyGD52O2ghGUmwqG14goDn38sb4e
         acbA==
X-Gm-Message-State: APuU4Z92rZZozFoBXEjv7Fwlx2ofuGd2LrhpteFKL0+Vaw3LHqjvPtWG
	+nWW2hg7od+fJe4bPBFgRI+q4dsdlFUdbe4JqvWq0qxU3TyN3J5GTQquR/MszXd+
X-Gm-Gg: AZFdTZeqHMMS6tBf7+ykWxmEZfei6i43rTZFa6Uxmpv3VtDtI5bcKaGeMfuAemGCjdQ
	8btWjcnNZo5oRvMViCbv9qn1o+8FgCAHUU+90jDdkyJVpcW66p7ThkEjk5yvOdSryQzjqdR3/QR
	isvVk1CuDzF/Iva5PJ9tD9rERFIA3TdlQV1F866Rpa/x3F50ZoLhV8JYa1LttIqWIXsdcfSyvH2
	IEzAic+DvOSF645WDwowdrQ3wRWOAMVRTgL7chiPNtxgFFjrFat57v8FCsE1eOGQfc81mhOwQYh
	ohmB59f/bvJgS7BEzQwC3Wo2O5FYHIlIM0p8BOIuV+wl8juc9dYp9QZbIuTAuIx5XojhrA05+cv
	5qYPyoihBunKXCzdPy9uOb8aXJp7OFC2pb00iJ4gL0/57ndw01hKAfLcRVZ3AQWe+bWkClzIpoX
	Llc3E8YSdbeGyYjDGLyqEBOnIcIw2WyKtTkUm19qYRMzXl/f5NinY+zFTNQ4w64ny7sadjOzZJT
	v8zPL2y+gRGli6Hto+uMgR+2zb4GupvV/ZBRDlXmUUg95Z23TZ/bF346+H5
X-Received: by 2002:a05:6808:5147:b0:573:d802:fc9 with SMTP id 5614622812f47-57a0d2e765dmr17967380b6e.59.1795605971996;
        Wed, 25 Nov 2026 03:26:11 -0800 (PST)
Received: from [172.17.0.2] ([20.80.77.31])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4bc55895b9csm15157989fac.0.2026.11.25.03.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 03:26:11 -0800 (PST)
Message-ID: <6b06c5d3.36cccf01.14fab7.e343@mx.google.com>
Date: Wed, 25 Nov 2026 03:26:11 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7224117336003177630=="
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
To: linux-bluetooth@vger.kernel.org, petrvaganoff@gmail.com
Subject: RE: [6.6] Bluetooth: hci_core: Fix not checking skb length on hci_scodata_packet
In-Reply-To: <20261125093708.227125-1-petrvaganoff@gmail.com>
References: <20261125093708.227125-1-petrvaganoff@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7224117336003177630==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/hci_core.c:3838
error: net/bluetooth/hci_core.c: patch does not apply
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============7224117336003177630==--
