Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793204436;
	b=t61/jVs9Ozkme/jHmzBYqzgY5rGVv+li5CLoShnqHpHoydIBLmi8z4AqPy9KnbrGXV8I
	 akzQboSOhNNZggq1EWBtL+Md5XfXoi8AzMYi4L/cRQcXwD4OXGYj2W6YZQG00l/81KCjj
	 6ImrDVgrPZfM9eu+E7VS5FXN77/CFpaIMuFqGA8++qTj+5on6bYtXjomCT2dtqd/hozSM
	 F2wG69KLkLYwxPpndQEVgjzIPno0INH5WJBj/XfarR7MjYh67ImDe+WSG7eL6iieSlFHM
	 NDdoypfdJ1Bm0fxnBAVqVWM+upgdC1DcAV/xUCwicYSJA+L5To7ZpjBeiAHmllj/3OQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793204436;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=Sh0IO4rSsdc+anG44t3Yb06MkoXoBjsAVk3V9ocvNDE=;
	b=CDtmF2C6qZc+x02KcNus0HAH1oaPyJCwlnV3lvyIzyVcNVE6cFFsjteR4+sHGuVRPmBm
	 b+L3QFcfiguRV7uL09crpAAtmAm3jJwU/oLTVo1pyJs1AB1r6JdytDNjxieSf2+Thbb4p
	 vvbmWn5OxupTBwkAaBK/eXLj89qcMXVYHjUkvNW/i4yySgv97iXan/NYROltNkIzkvPmf
	 Sc/Wwbfjf4Q35FzYO4tnMeLVY89rB7URkXA+FQGa1h07VrGzII0HDSqYDuRfWQbMAlFiW
	 cKn5017MkSm4ozhLgWNZF6CXvYEZSrvafzye1fdI4iucNeRbiV4I1p9xPcltsPBcIvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jBL5DQzK;
	arc=none smtp.remote-ip=209.85.219.44
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87202606A31D
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 16:20:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87202606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jBL5DQzK
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-91986c5cb75so14002806d6.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 09:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793204435; x=1793809235; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Sh0IO4rSsdc+anG44t3Yb06MkoXoBjsAVk3V9ocvNDE=;
        b=jBL5DQzKGSirVOQZFilLXQVPjJ3gpirJUrbjc6tstKaikSRavMQjApesEMViQzAkrC
         GXHejL1E0eWdz6XIi1AHhDRnuWQtHevAGDAR7LYJUKVTSBkwZPZgXMAF9zW7TDNfGZhJ
         lUbQheyWCDp+dyk07IsLUgltCIzLBX42si3zrhgkDuZKsSlvl8KUffo/852SWDPjzUXP
         2atCXARD00gAqVSqQrg6K3ypP5d6itwR5mZKC6H9Jqlny6E427uZYfGpotRoqUSMjE1I
         IKDpxHTWwX/GDypw4vwqFA9Y3z+g1pQ29Cc9vgrqcH9Rp6N9GVg5Xf72dJ6Wrr+iZuok
         7L5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793204435; x=1793809235;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Sh0IO4rSsdc+anG44t3Yb06MkoXoBjsAVk3V9ocvNDE=;
        b=MMxOTMjcBg3HK0s77XUrihPX/1KUhp7Q5UpSzkEVdqA9goUF6DXF1S3YpMhNK3+Kxb
         WIrANxAWo7krxeFd6TDCgd9hQik70R/54J9fV+n5eTL5TjwhA3PEfbqPQ/XZoPbDR+a7
         VRfBCCmVawBXdqG6YJeCQ0wT88uPqp2kp3vO8qOt3UAmswmGE8QsN8YNAyqXXUm8as0k
         C6tDn8tLD5rJRcfh1PLllQaqDLzzAj3HdEuqob0D5f1vEJqz6e70ec227GUaAOToGEQ5
         t06f6qdQltZKESDZ9l2vMttY2xcICvlM8FelEn3G9wGbAYIZmKyTKa9m29etbSoGpjz4
         +vaA==
X-Gm-Message-State: AFq9FYIkUR2DaPQYn0YuvmR609jxTGoesZd4GfVlTjsVHHmwZa0z9xtN
	PuOXJ1mMaP/SNgJC0Tz/h1hjkxbD8P/3RH5L4jyFSqf5hxfcQJrzwoG86+dv0w==
X-Gm-Gg: AYBFou0ImQRcvCPbhR0Msm1xNqjQj0u5T5EriWMIssnaMcQs+Q4a2oEN2x5c70WT3WE
	GDrjMhXi0VoWy9m9P6k6Qlh/ug6l/Snn+VWDRrhOXKbUaS6ZDsBkLT7UlxZOat2bch/s3PshKgi
	DebVfr2juLx1V9qAaYbxJVmRKkLyNHcdUqphuJU1kvOZGzPf7PpS9Xls7aEFPXHL7LXwu74j7x2
	caHL6hfYlNRRF0iE1G76Yp1rb20lkM7qHhrNYFNuP0H+pM2Srye9NgI1HzVzASeeC20QeLNpmEc
	kKEckkAWL0hRn/hyEIbv46L899WRDu8FKSSJ11EGKPIPT22Vio/4X+RqoDuGwFEY81SOmflDzve
	DyTuIBsGim1wUx5WSRj9sgvd2lyt/7/hifBSD2QxkNtURdlaV2JZ326Ukrihxd5kDfjoPYx7Ay9
	zivRoJglfaL+tAaWWCagsCHg9O7SngCx0NotAkF3gRZJSUvGuCH1RzxYUsNYtbR/3xVdEHMIf8R
	vlG1mGEK6UHrKFMNDg3bPH2cM1Np1rbU1x6qqxlD+i/upbUqp0ib5hifRNZgQ==
X-Received: by 2002:a05:6214:627:b0:91b:856c:c42f with SMTP id 6a1803df08f44-91c7d1d3e23mr41238296d6.40.1793204432919;
        Wed, 28 Oct 2026 09:20:32 -0700 (PDT)
Received: from [172.17.0.2] ([68.154.37.66])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c6d8103b1sm59228956d6.44.2026.10.28.09.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:20:32 -0700 (PDT)
Message-ID: <6ae220d0.8c56de6c.1361d7.2cb8@mx.google.com>
Date: Wed, 28 Oct 2026 09:20:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3182523967867306992=="
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
Subject: RE: [RFC,RESEND] asha: use robust streaming connection parameters
In-Reply-To: <20261028133204.262169-1-cochcoder@proton.me>
References: <20261028133204.262169-1-cochcoder@proton.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3182523967867306992==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1195452/

---Test result---

Test Summary:
CheckPatch                    PASS      0.48 seconds
GitLint                       PASS      0.34 seconds
BuildEll                      PASS      20.47 seconds
BluezMake                     PASS      289.80 seconds
MakeCheck                     PASS      3.80 seconds
MakeDistcheck                 PASS      146.29 seconds
CheckValgrind                 PASS      152.85 seconds
CheckSmatch                   PASS      282.73 seconds
bluezmakeextell               PASS      95.94 seconds
TestFunctional                PASS      1120.00 seconds
IncrementalBuild              PASS      288.41 seconds
ScanBuild                     PASS      1031.28 seconds



https://github.com/bluez/bluez/pull/2729

---
Regards,
Linux Bluetooth


--===============3182523967867306992==--
