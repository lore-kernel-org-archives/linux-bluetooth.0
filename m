Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795705877;
	b=kA0bksM2yrQlYIX2WYY5t5SsiKn8yy324W4xNG1XGidby62xeLZfi/+mdz5mbtMiUctc
	 0aWZWkvxxXJnPkn2wghlUGw/yWEXXqB9o9ooKQrI4b7R3JTsWxYc4hc2BdoowFYtah87x
	 DeztO1gr2RjMf5x8Sdr0jYhqM3TJtyqL5Wvhnr2AYUC6LW9xsKXefBkhS03wXFeDuEgHj
	 ie+uZSOFzxYgXawrnnmwlLCDWsZc7qIlCi1QFt4+Y6uUOAYMft/SVOZ3JI7CD1DXwuxIy
	 Cgh1g34a9TWiCKipllEGKjojDgS0Ra87a1cI9jnDAdkQzFg7P0CPAdQdYchOHjjE1bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795705877;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=lNDbrNT7MlAM/+VM0YUoI77z71kPyVEY/oIOM7o08yA=;
	b=ZSJWCcbk3jZDP9v0hhDxjo6b+SW0NK22cQx1xQMVHh/B1g2aoI9bASU2Lw7+Jv5LJMt1
	 lSQxRAK3JbJoc6Ynu2EsGJnea5yy9sZc2Gs5nYZLpsx5qd2Phubv9gcQlmkxMXjwuffVs
	 DWCK0Yyt2NUFeMK4ybQG1ogXXCdY7NVPhhMFgZ+zWnnA2Xj0rSsxgErA/IPjzcRYxJVZL
	 x+yB1o2NViKpBGxCWwq/NYQb3Nc1SLRXTKfmrP3EX4A6R0iE4Bt1Ue1Qv9O6PbDt6eDux
	 OE9MT/ovblzIjF+4AMUM5bv4tSQc2/8e+ItV0TGcutqDBQatxIYRoNM61kgvzqqmiCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ncgP8W9n;
	arc=none smtp.remote-ip=209.85.210.45
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A2F606A321
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 15:11:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44A2F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ncgP8W9n
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-862df509d48so5385388a34.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 07:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795705876; x=1796310676; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=lNDbrNT7MlAM/+VM0YUoI77z71kPyVEY/oIOM7o08yA=;
        b=ncgP8W9nvdXTmkY0qS0n9/++cIoVdlq54hVDhgBnAWiRI6tQ5Ku9/xlz7xmMpRD200
         eHOxoK4CoGZNb1xiBlR08DDu+id2S+YFM2HTovjc76M3XBIHtK8bjgoOn6sBfPIuYts3
         8uQ827Hwds2Xm+sU0ydHacPgTxetSsU07YZB1kLYeWvW1jr5b+sFZEwfg23n4Fn/9oRl
         tKlIEb4cZuH+uBZRWhPDtylr7aDecN2h4/c2kY4UGRy5d32pQGHVeJWgtMN6DEw/09bG
         KUe4Zq6iaAe38BVLXSQSaz2VoF571CbByG0MGPHYPSaA8+XuhmAJ7XGA6fFc60zNNadO
         dNeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795705876; x=1796310676;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lNDbrNT7MlAM/+VM0YUoI77z71kPyVEY/oIOM7o08yA=;
        b=It/tqDXBumSoyWgoqn7g70fzfT1+0CmZ09ObwVI0eLSxeXDr4z/SeRJt14nBTtzREA
         /1Z55j2l8X7cSWG2eneiITRUeer+KdeLxwxDOrftmSBwayj1ESzHg4kPSZWuBL91UVdu
         cDsWrnAvtGJdAo8fzm9W9vmB93aNXnV8XM91LOXUHcoHlcmZipfQqW0zNzacRno0+AU6
         Ildkg5weL2Qt2yA8TaLqBsu/machpUdjgBwQlf5OGf1DDCBFSQ6S16PySLWo+Z9tVqm5
         u6juGA0BOJ8J1iE/r+kuAdb/7vGBG9EQgYHoIgzfcf5KYDOf4yrWwLikT6uTxovmfofc
         CcEQ==
X-Gm-Message-State: APuU4Z9V174dfez+n45RsCZs4XmQzlLMoquFBu9Krx4tw26igDF5thJP
	nM9AS+NDXjvq8dNSi2c9Qpak79m7+UaQ/tv50rteZglf5+/UUJLYCoHaIqH/gA==
X-Gm-Gg: AZFdTZcy3AgkCRL+JNkZPBHPAqveZ35nxIDMjTbAVZ4GNBd5LDlNagD4C2KedUjgXRh
	D+fEsKY/v2xtKB2LYxvXUIR2H3edna8KOyw3Flx4MnW7KORAfJeq2VNqld85X4ECYRNqpLI6Lt+
	xpxUZhSDt3zVKX1zq/s0lSeF7v/GR2ziQqBiJmpZtIP6KLn9UULEIFtHv37B5j6N0a32HbF1fj5
	IpSiZexBpnAqICtRetg7lLmMvxUtkv/wo8XdN0n6vO4hgfTxruBSybthTRid7Vu1gO+SphOCEo/
	AsR6aPP0prAFW4rrP3975Bg1qJC88EjMk6+WlHI8PjovUGdP6n15HHeLjaBungvMDits54293j5
	rdWLy3bYFmT32mwd2V+Eu3cum3nmFfwCeTKh+Wuc44BCt2fgmyQ8Smql3UeXHJLVBS5OlzACcSP
	0+W2YsmTm+zwc87IMZYTH6BH3jJOBlx9YLhkQP6Bw2dpJpLuNqKB1lJD8aMZGIVORpm9HCqmVX0
	co+JnlUycp4LTpQ+IjdubR+3xiJMiJgZB0dyms8ylpaC8x6J0U=
X-Received: by 2002:a05:6830:264c:b0:862:a575:22c1 with SMTP id 46e09a7af769-8630925990cmr17567264a34.22.1795705876087;
        Thu, 26 Nov 2026 07:11:16 -0800 (PST)
Received: from [172.17.0.2] ([172.183.133.244])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-863168dd6e7sm17168075a34.12.2026.11.26.07.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 07:11:15 -0800 (PST)
Message-ID: <6b084c13.5293ddad.2544a6.64a6@mx.google.com>
Date: Thu, 26 Nov 2026 07:11:15 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6168264758894238479=="
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
To: linux-bluetooth@vger.kernel.org, sadiq@sadiqpk.org
Subject: RE: [BlueZ] obexd/map: Populate new messages with event data
In-Reply-To: <20261126095439.2113609-1-sadiq@sadiqpk.org>
References: <20261126095439.2113609-1-sadiq@sadiqpk.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6168264758894238479==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1223189/

---Test result---

Test Summary:
CheckPatch                    PASS      0.41 seconds
GitLint                       PASS      0.29 seconds
BuildEll                      PASS      18.32 seconds
BluezMake                     PASS      275.10 seconds
CheckSmatch                   PASS      251.65 seconds
bluezmakeextell               PASS      90.99 seconds
TestFunctional                PASS      1122.24 seconds
IncrementalBuild              PASS      276.93 seconds
ScanBuild                     PASS      973.49 seconds



https://github.com/bluez/bluez/pull/2934

---
Regards,
Linux Bluetooth


--===============6168264758894238479==--
