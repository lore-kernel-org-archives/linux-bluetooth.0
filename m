Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9F34E2349
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Oct 2026 15:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791473205; cv=none; b=EPACWvOJayOHkYitAhPadr7bxuIhnyTl6q9DLsLGmcM44CaovPYbEaRSmw2YA/mExKmLUkOK5z1U86QJB2vYCN4cNQBq0fc8LepX0oViDTsLjAskRd72CJK9tF2BkWT/fpVACPKgrn7lQ9YNAGVYzAUfuqXzN5v6+YlCz5kVx7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791473205; c=relaxed/simple;
	bh=Gg9qPn9MqNlABQyhs4P9s9FZmlrmmUxgan4IYEww1RQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=DdL4YWygp8ru3K7YRN8LQ+IjHbd8kgincG04Xx/ok2B+elEHRP9go2vGI88HB1n2ssWbz8X39jqYIJ/hMs8Qm3bVvJDwv701wC8OOw1cnX3pzD5W5iYtz+EpCKIJmPTdna67ORxOG0YCIXotF43mzaQEiBMZh500u+ZT7S285+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UkVRJhtC; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UkVRJhtC"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-90cc0ebbf4bso32097776d6.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Oct 2026 08:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791473200; x=1792078000; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=oXloRcbjbsm5ObLER+b7yRZy98qRKnkdog/5SgxbOMI=;
        b=UkVRJhtCohRAfmhCpTzBrt/kFnhMys7c1xYhdMTZwQZBP5yRN6H1eNeIQXpBHEycuF
         nKxb4LRMW7nu+pt3sPm514bT4YwVjQkUI7libTNLdaMRg4LZ8xsbGggKJ0oWtITSoA/h
         OH44gq1GWgn/POVTEtbVtXwD483Fmappmi/3JTYScipfjkG+dgv+/qFLR8O9ywhkf6mC
         6cK1AWauM87/R1c/F5nd6Qdigqqz/OAgELb91kmUkEkJ0Ml8fhM9rY5i8DGHSh8cdlGh
         UYREggbywj798hWTjUD2lr3Ti2cas/oJ02wSVnbAf4yG6FuTmdRN0Z8VNHiPKJKgpOsN
         vpzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791473200; x=1792078000;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=oXloRcbjbsm5ObLER+b7yRZy98qRKnkdog/5SgxbOMI=;
        b=k5C/ekRx7IC1hJEJNv4cCLgYso6yKM2yRWw2kHegtDwcaBR22NEy1wzjrmxxEo2ax8
         MlUBiFFxIx1dWanGC0FUZQnHoZ/TSOxlEn8MFcMKWf3/YPLexd35BeRzs/5UQT19ZS4h
         +b6pYeUQKRmnUfxRco7FYFLijGWHTBa6ZqpD8WYFGWvJ48uPloSHKAYmCqEb4TL1NDz3
         gpVSrwgZmjau73tuULf1Gs0qfkvGLDZWbOSWdGO5fPYA5NWM6xsqpoVqktnSL7TGOFrx
         nbtk0hP+gzAwwSEEoODX+22SXqnBNMO2sLCIXbrsDlM0cPcHwEQV5dZJuKerAoFkfAZg
         pw9Q==
X-Gm-Message-State: AFuF++kzYj9zQa4olTMezG5KWOeYKlKpbtnsudbSh8u1Vr4o6/WJCVTb
	eU69iZO4NrQOVNQJzPVKUnI8gplrtbbgbUJ9heaVkU4Z/OVj/kmgfBi0qBTuHA==
X-Gm-Gg: AYBFou3EavmsXj6LyS0ZeO2EWdGNa7Q5nCstdatQpCQbGaqKI7S6F+fTXYp3WJuBUXA
	JDo5683FzaJld9xQQDtPvYjng/HjJnEMbJGYdKwVAKlua2oI23IylTLoFtAPcaR31VDeWg057kC
	KavJADngwf9hEXeEauC1Kxe4CC7aPLMw9LYUBrzh9fV6P8WGcsEARnQl20Cld6l8i7j3H09KXve
	SHo4ZRuQk5n8pVIjMgxGcn2VeSXbb+Kp1P0zc4lax7cMz0lcbdlk+9n2qAlLyzxFE7C7SfWukBL
	bleRejVmuBnqoLBs43wPNbcUM2v5ue6HlPrrMhmmW78hDovhKI6cnxLQlaEckseptyjw4kf9GTl
	XAGWpGGpcVsoTPAg+ry/nC6WUagDDfNwb1l/52YMz99kfRr2xvN75jmZB0EFHLZqYbpUhrMDOs5
	zo0ez9UqVMtuxiynysjFwY0gwD6yoptD7MWG4/y+f+J4cQQaFcYgmnLnBaWQmPc/HwMpmHQwAaW
	2Q445aNQnyqUFyhAw==
X-Received: by 2002:a05:6214:3908:b0:912:ab5:9e0c with SMTP id 6a1803df08f44-919977d3979mr107788286d6.21.1791473199697;
        Thu, 08 Oct 2026 08:26:39 -0700 (PDT)
Received: from [172.17.0.2] ([145.132.99.104])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-919aa12c6e7sm23895756d6.45.2026.10.08.08.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 08:26:39 -0700 (PDT)
Message-ID: <6ac7b62f.201aaea8.b5a61.2b70@mx.google.com>
Date: Thu, 08 Oct 2026 08:26:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8059688144188913599=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, oss@fourdim.xyz
Subject: RE: [v1] Bluetooth: L2CAP: Reject mode changes on connected channels
In-Reply-To: <20261008141714.95709-1-oss@fourdim.xyz>
References: <20261008141714.95709-1-oss@fourdim.xyz>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8059688144188913599==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1181680/

---Test result---

Test Summary:
CheckPatch                    PASS      0.73 seconds
VerifyFixes                   PASS      0.44 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      0.32 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      29.10 seconds
CheckAllWarning               PASS      32.91 seconds
CheckSparse                   PASS      35.56 seconds
BuildKernel32                 PASS      28.89 seconds
CheckKernelLLVM               PASS      34.86 seconds
TestRunnerSetup               PASS      767.82 seconds
TestRunner_l2cap-tester       PASS      12.53 seconds
IncrementalBuild              PASS      27.63 seconds



https://github.com/bluez/bluetooth-next/pull/889

---
Regards,
Linux Bluetooth


--===============8059688144188913599==--
