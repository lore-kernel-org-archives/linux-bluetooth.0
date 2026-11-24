Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795552227;
	b=pNRXWX0NNxNqvc+3xkj61KI3wLKpTFJsyJL2ijv7zrOJnNdyYdAkAg8rzbvt2C5cP2xk
	 kGw9Esd4Ha+Kn+tT0oJJw8GwpEBNMEl9ObTjuijrXMo8ybT7Yf3zu/EXNkxFCwr0tUCBc
	 9+WMoU8jMlBI8RArlSqAHPmMqCTbo9IzFMqj/1rBpT6fxJBX1Q2Nd32wuw8Of6LjRvuH6
	 EA5DgfomBU0uKMOsbIB8BMqk0TXjmnjCGEobLIukTHMnrMz5y8AHXDIdFbIdav+CA1GHI
	 RAvSA2Leheoj5uHIWGTFsh1pUHciIWo+pKTLWVkDJiTepNz5TWipPK4FbhmuOAStVvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795552227;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=JKbNa2ouhEwsct9VQniHwpJi8e5jhSxWVRKmdmB6LGY=;
	b=NHYwp060NJZ9nYyg7Fq0hkmFj2c40BtStuVxpkHL/EcreO/ps1PHGzswehmKRP+dXfjg
	 pYx0Qjwq6/CWIZWDBSBOMEEAH5vFSMhI9tWzWpXZgvDQNXyCYYZNpTRCdjkliptYTbnm3
	 DyHeLFY3FbUVuRxT8Z6TzQ/HrL5zF3lFXTRJiUHCouHHgjtN/aUXrAgTD0+Ij1y8YObUF
	 QcrpUcq/bWAupno4O9u0d3FnPyl0x19G2N4bGb6KzjlCp0jNV/EHymu+/TKQDPFJYTDld
	 d+CWGVHpS7tvvl3jCZ2W04dTMOjDPNkoelnRVPDJlOqRWnrd50sDi9asvdA5H4X1hcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WjY02fqI;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F36606A321
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 20:30:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2F36606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WjY02fqI
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-385c497bf94so992227eec.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 12:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795552226; x=1796157026; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=JKbNa2ouhEwsct9VQniHwpJi8e5jhSxWVRKmdmB6LGY=;
        b=WjY02fqImH/pf0UH9HwXV3CSXKP08HR2+N6O1gRS3ojwypim4CkXJMx04oBEqpAIYt
         r1tWQWvycOZgkH/D2jQ7/7D8KvCZY2AR4aZ/scZscWBM+f7bub+cMKBXGNvvREye9NnM
         2DmE6W8TIT5L7uKQ5vs3/ZDc42EoO+SCl7/XlaNJpvSIogLJLK4UwV031D6Gd3iegKLY
         ZchIDsgIibJ84ly2x2aivi/WpokreZfzKQaKucxUSX7qEquMSfHKX3iy1Yq8rj81x2J/
         5hzJQUZYkmYYLP5ixtvmcc+10vQShTN4ud51oi9P9h+u+yiP4yKCY4iHZa0kDkoLZtyo
         KwzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795552226; x=1796157026;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JKbNa2ouhEwsct9VQniHwpJi8e5jhSxWVRKmdmB6LGY=;
        b=nk8/nm/ZK7ueW436yQRIN+/X55/IDPmoJFpRlnf2k2Ebc9xbLt9fEFvQ2j+ogMIgRy
         BHgW0wgZtesX3GTsgF16vBS/OmdHdF6iUd/tE8GMOsuF2emnQ21pV8+PRj6v+t+CzakN
         BeEdPSbW2v65HQHBgsRGLakQB3fRldFbAw4WGutEtD78PoEkBBhcfo/K8GtXB4C8Srtl
         d0kBOmQOvFG5xxFQ0BTvPUJI3N8nXmInCdEGMRZWUwAjnGw/CeNvNpzMqVabJQxRl+Vb
         HJKQ+m+k3VESG4+LIPszNvZR2uG/+lKZp+vhMxv8pYsh4ImCGcNgvyYLOfQtbhCzMdbu
         n7hg==
X-Gm-Message-State: APuU4Z8ayWduGN4wt+fjk4X92pDujNI9g810WnWZ2L6h9/7i6CD2Qh+W
	3jHMYmVDG/fCiSSdNxA761AkXMyd8RGl0YmLTEkDB232xbTTUAF9jF+uSEw6hw==
X-Gm-Gg: AZFdTZclI9zsppHaAK2IId448QVoVLeFxhxeWXv0CZq1QufIsMj8biJiZ9EbrBGzG4j
	D6NzHPGpoBRWO6o5yNBf3DaRzYf7mIVrSa0+37XIXmZrW04vnNqLnm32SlTeB8cTZlXT653h6Mf
	IZ+hp5o2ixnKoWwwANMkU1EPHLk34Ut3N3K8TV2Yf9RqhbQTRf4ISbwOg7SgSsyGFPJijQnWTDW
	GZwwk4/KMVXdTUPhrO/1aSoF7HnEYvFKgZJ2+Rp/JXtb8cA1tUpObd9f/RQFEGzTcxFKh6IEeos
	k9OnhOOHxqS944uYWoe1Yz29/ioe5Z+s+9k2DrfBqqBGzdWer3pcEQDTcNTyR27hn/APNKkm2Er
	RnCaXIufUQ17ZTz4izyKyrfdiilBHbZr5IpZ8TWw2NtfzbfBR/+xnzK3CjvwOjIGGVrPTqw0YLj
	honZ8cVoMLXufltYoeXO3y+8f5Ly6xdYjKwP20ajB1/If78udJui3RycDhiS+EYFgMvGwi7NS6X
	a3Jh/uHJ5pYcYb977zdzQzz+x1qIkijukPnJb6tH4juIfTlM0VatGkxtQGrmg==
X-Received: by 2002:a05:7300:c00f:10b0:384:bc32:fe6b with SMTP id 5a478bee46e88-3856e63b194mr19276294eec.13.1795552225536;
        Tue, 24 Nov 2026 12:30:25 -0800 (PST)
Received: from [172.17.0.2] ([20.169.116.72])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3866f299d0bsm39699208eec.19.2026.11.24.12.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 12:30:25 -0800 (PST)
Message-ID: <6b05f3e1.3c98296f.354233.0e0b@mx.google.com>
Date: Tue, 24 Nov 2026 12:30:25 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2572169109245036006=="
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
Subject: RE: [BlueZ] advertising: Allow ServiceData with no data
In-Reply-To: <20261124133148.3959415-1-simon.mikuda@streamunlimited.com>
References: <20261124133148.3959415-1-simon.mikuda@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2572169109245036006==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1220884/

---Test result---

Test Summary:
CheckPatch                    PASS      0.28 seconds
GitLint                       PASS      0.20 seconds
BuildEll                      PASS      13.03 seconds
BluezMake                     PASS      170.12 seconds
CheckSmatch                   WARNING   175.06 seconds
bluezmakeextell               PASS      59.95 seconds
TestFunctional                PASS      883.50 seconds
IncrementalBuild              PASS      173.90 seconds
ScanBuild                     PASS      587.77 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/advertising.c: note: in included file:./src/shared/mgmt.h:95:25: error: redefinition of unsigned int enum mgmt_io_capabilitysrc/advertising.c: note: in included file:./src/shared/mgmt.h:95:25: error: redefinition of unsigned int enum mgmt_io_capability


https://github.com/bluez/bluez/pull/2903

---
Regards,
Linux Bluetooth


--===============2572169109245036006==--
