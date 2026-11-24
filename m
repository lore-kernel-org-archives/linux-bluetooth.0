Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795552659;
	b=EvdVB+8Sf+Wxg5ER/sCR7e2JSBfoJj8/i17M1eWw8e1JKgVYzOXOFdZHKgyQT+iExry5
	 Eq7Y0CQdE6ACTXgdMLvCy02TtuPyifM5RnxZztaiPk2Wq+nlxZ/TKbrqeMPhYQZOA0us7
	 2lA5LSMUTeq+QBMUDxmzNggj3v/UeJg3Kzw3rQOt9Z4GATL8XjMNf/skn5S0Mw1uQQJFM
	 gi1KpnMci1gK/E3GDWUW3vMVwgdVmmhnvb/uTJFtrN0iVAzzkut2CGTfyMaQHGy7NUl2v
	 IyARH9vdJqpLsnMPh/pepg0+Up6u222HlTzUhoUHZj72KkbVj/zGC7PhtMRLZVDZ/1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795552659;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=UjWke1t55hoLONayEgYMvf2dybr+gz6Qo5x40awvFOk=;
	b=5f/N7m9UyXT0uz6E5TW9yxDyy5wE1/XlrUbBfCbC4yr6V3iPpa/VR0HwOItmApGeP8nF
	 ZrEqaTO32pC4tvQA5WfUflAfDQuiDzMW0nEx/o/HsAN+Xr5EdxsMd9zadc+1mCcaH77OW
	 e5PNglfDkQIYKDNfWXuBQkVTEjtjahoy5WZ2fFlwHROpupMdiNh8ITSGzpom/vE3cAwrR
	 fDruJv+aUTqi2Mcn/CWKNGOUJ6JVyy090L0tiuC+yx6Gi2wiFUnWkGYw2fWoL/BKXzHre
	 GkiWM/VuWFy8Xiva6ewFJnJCn7e5EWcPGCrijvLnYjLsSvhFGa7pH9HFUw7eYtXtNhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bAGJFON4;
	arc=none smtp.remote-ip=209.85.215.180
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9EB606A321
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 20:37:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A9EB606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bAGJFON4
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cc4be0e5351so3941052a12.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 12:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795552659; x=1796157459; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=UjWke1t55hoLONayEgYMvf2dybr+gz6Qo5x40awvFOk=;
        b=bAGJFON4MsVswhOMqZ0reVdIBBh2w3AaIExCmof18X6pfVAhxcMpDx3ysd8uQklr1c
         hGOssX4yhgf04NS4c077JlVivecOIlyJ8Dn4MRUVrHWGotF1y7OKvs/feNIRB2LqUarG
         y0wu0loLsSCbynymmLdDZwqFsUJ2YGmAZ9uridrVMuojDMfer8NJb2Nv8/Ewcfrcw3cV
         DXXAgAsDv1rsEAWtAUCc+/pHlVp5L1Ab5DHfvijpTR52A+QcdEsnUw4i2/qU9c3c+LeX
         m7YntpGnkhqiTmzqZKyqriXjXi1+RteSU6GTwMfAcWxfLjKj3VizOL9a+gOYNdFcnJgS
         7uZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795552659; x=1796157459;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UjWke1t55hoLONayEgYMvf2dybr+gz6Qo5x40awvFOk=;
        b=t+JMwzIKTUVIyORv/UVgtaqXUwD6fakv80yrs44LfZBAPK80p7qrw6wudwMS/g5Uq5
         5yQUHduS7pm50/F5UV87HVTkV6K6kAlhRQ9AtrxoCXN6sDcTjIKZAQAXciMPMpkJ8GWl
         I3upjSEL63IylydyA1azUlYHsq1oaUIGuL6O/rLRFNSnA2e6dgqkT9zRhBChYpp8+YCO
         QxGKAsqJsJ9F+D5Kz4ign1dBbK828SbgchmlhG12nWtEPBAjvLYvi0VVwDB7KEih1qWZ
         JB4altrrCXi1+0sCqT0brnkGmADgU+gyZeQ+ffnLZKoluYuBhQE6Ej60Aa/5yvrj3kZ6
         4c9w==
X-Gm-Message-State: APuU4Z//RuuB4AYtVCe2Mat83759acu3F1z7hPvPh+M75Q+lO8rTjoaf
	U9M4TN8jAr8hx6cc+iVK6oNCUlSoJ3LBFzoABNLZrfRDMt6LAd4EsrH/LBLurQ==
X-Gm-Gg: AZFdTZc2e+CuK8oRSAmzGZwa/PPGulXgqPWMlgklNEZpcqQE/prJRwYhCoM2S3rxjQK
	bWUpxhbFaWwqLuzB4MANDbmxOuANED8CjrBsSU2Jw/2qgicwxKRIHjZfwc+xtpVvqF64rZYfl/v
	IAFevtEhs38CvJuLGKEfckxqBvlShPNgFqcbSSpSaC5ZdCRIfMlXPNiu3RugPRCIsKcqypbRZhA
	3N5vIGVpEZDknGIg5ThgbO94rCZVigao4e7jHo4EdKezkcRS/lugXfPu7XYXIsLynNzDDKuArNV
	6aY85Lh+8cFnHLF0GMk7eERvKbZb98AINMFa9OR7qrZ3opZqosGRYm+2sgXn1LqmY/234ENpl2a
	ZdDLmyh3GPjLDgN7lbK/Kyz47laHhvNyB7XBDp24mBz646PurgwMXK2s7ovfviqXFZYscbnbBhf
	vyGYNM5jySEpz9NdD02oi8eBQMgd2v3rTY+DhZwrX+0BaY1exU4wvx2oNgZ7wl4lawbEW4W3tcN
	ZlTKxe4KynxyI2refagMiHLXSJy4jOkjPArhvw0rK/ncAIug/frs7AI8NhAmoUVF8GN7KKB61AJ
	2cv8eMCIDF/Th0YlnsBvUvpEhN9vL1q58Kl7qwRD
X-Received: by 2002:a17:90b:4a48:b0:3a8:7096:9b48 with SMTP id 98e67ed59e1d1-3b41c7b5fb3mr14785127a91.1.1795552658850;
        Tue, 24 Nov 2026 12:37:38 -0800 (PST)
Received: from [172.17.0.2] (ec2-3-42-157-119.us-west-2.compute.amazonaws.com. [3.42.157.119])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad8e93asm24033942a91.11.2026.11.24.12.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 12:37:38 -0800 (PST)
Message-ID: <6b05f592.10abdf86.154696.ccd3@mx.google.com>
Date: Tue, 24 Nov 2026 12:37:38 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7441514394238811208=="
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
Subject: RE: [BlueZ] a2dp: Don't suspend a sink stream on our own
In-Reply-To: <20261124132108.3899705-1-simon.mikuda@streamunlimited.com>
References: <20261124132108.3899705-1-simon.mikuda@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7441514394238811208==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1220855/

---Test result---

Test Summary:
CheckPatch                    PASS      0.20 seconds
GitLint                       PASS      0.15 seconds
BuildEll                      PASS      13.29 seconds
BluezMake                     PASS      202.01 seconds
MakeCheck                     PASS      2.51 seconds
MakeDistcheck                 PASS      103.59 seconds
CheckValgrind                 PASS      107.82 seconds
CheckSmatch                   PASS      183.57 seconds
bluezmakeextell               PASS      65.62 seconds
TestFunctional                PASS      925.41 seconds
IncrementalBuild              PASS      205.15 seconds
ScanBuild                     PASS      686.82 seconds



https://github.com/bluez/bluez/pull/2901

---
Regards,
Linux Bluetooth


--===============7441514394238811208==--
