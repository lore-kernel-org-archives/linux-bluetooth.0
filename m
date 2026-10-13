Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732CA3CE4BE
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 19:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791919752; cv=none; b=AngzRC88oqsS3oaiOk12WUVfh5wZuZD4VeLbiwU7sjX/+yil7iUjEoOKS3HaOt6SThQ9v6CTc6XOYjFZwEp17E6k6SXHHX25DSs4H8kzrxT2otVCLu08JKTKDo0vPqBwNDnI64nCB1LxQv8GJO2O/kRXJInEXlqb0wJerLINh8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791919752; c=relaxed/simple;
	bh=bJj/3wF3NpunrN/YNqODUZA4Ba3Mcn0EiOgCYMmEJ5Y=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=SjZDv9Av3KR9KeNw0UUjqlJbWqIq0tG/cPMi4bNnd023xTmHj4YTrZFqwoygqIwiNpZoihNbZciuFPZwE9AF67DCxeNlRhwWsccEr6liX5dQ0xPfkYgpjTW4h/ctakWZXnHSTEiKIqcdrKEvwQTpOLyxUeKBWH/DKjUlxEbQYis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lnZpFWUP; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lnZpFWUP"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-30b6dad2382so7733240eec.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 12:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791919750; x=1792524550; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8WGlFXngHtadokgUkj119dmJuN613psb1Gyb9CEAw1E=;
        b=lnZpFWUPMLsdkvSpZYeBMtOPe5OkVP4SvmGc4O4cUn8p3dUiSE3TZgHBe9PGf+Jr6t
         ZikvJsNCemWbXUmfMQoOLi/b/uxh+lbTkfO1eeLlXZ3UEFHLPNWZcQYVvGaXFZcjH67d
         LAQBgdhTa2CK1k3S3pXRYvJz4ZDOTTzyajYjTL3+kLDc5n52aE8A6idmwmubkzjFjHPf
         NB6CdVRZxUXkBmnQcmrRlR3l0CtyswW42DSO/rgJGl1o4vaOA2auszRhNaIvoI6r++tf
         uMSn7tqIw7zj94a2t1da9IIemI357wXDrVUBZRt7Tesp8357rKhG2LhzdBbGdMvIiAiI
         erKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791919750; x=1792524550;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8WGlFXngHtadokgUkj119dmJuN613psb1Gyb9CEAw1E=;
        b=NrnHybraPmv46bWs4t48/e/Yy0HsNzDOlTSSMynnjxKCeaztIU1/f3Y4F8HUvfZFZl
         ch2s/6dfmv7vgyhXpGLH2i4bjp4dYSyXvu0BY88InR2hGWxUSctup4IneibImtrwotX/
         vpjrN2fAmrgDb6jYAi4hGi1qbjFMkJqX0fIKq6DTYKRHU1oWoC6BuqOSONeadSgsGrZF
         AfuuN8deX2T57fbi5U7TjqRKIY/IMRMiUgEC0zQD0/0fx1WAG52FG/CV3thn/BsQCAAU
         GyrkIMULoNDjpqjFJz7+888aYkZnaAWru12UkitA//fZQcLVkmEeqEG8ANBRSc9PPsPU
         XNkg==
X-Gm-Message-State: AFq9FYIZto+ejKa6incND9Ose6I3uEG0ncfO2nRBB3WuHEJj3jiia6Ix
	Zja7M8BwYAGe3o3LjguKC/txsdp6oGPN6jZ4v2rXuPPSCchPlQYc/y7t0EoHag==
X-Gm-Gg: AYBFou2y+j3kovT34ethUnexwDUr+SKgjiv464kqW+DnPTQdLAOizR9764sLkOUEG8M
	4A+4xekjCJn9PKQ407jsQsOb4+qoV90aAv/pgKTUjwnA4v1gkIa2RhynAG4w/yV7AQRGyHODpvX
	GP0ZB1c0EJFftwqyq0RfPay+Gr1ED1XfdY3aJxl4uqgnHqDc6KzTemSlL5IYYk5WFfJvlRDMuJi
	PNSPukrpc9xoQ2SD5o8IbC3w32eIEOXbOFaa8oyzv8Yw+k4SZS1rMoUwTpf0Zk3v4UmGG5nojeC
	Nl3NJs+W4/kfe9uS+dNXCS1vpYHgXRbcgmUGXJTjDL9bESSSHHjS6iwuBxCrIFKpxFQ6p54X1cD
	BZudR9RLtpg9MbeuSKnBLBAvBqUYMN98QuKx3wVNsB3UrBEjlUuGBe83kJ5UyyQ+y4PIWA5arS7
	lx3FU4trDCh5ikBwEK6Dl9pYWMQ9yEXSCKr5B8fLUuZHqmcYMasmjCtOVtL/LJJmATNq78HtBI5
	R0=
X-Received: by 2002:a05:7301:540b:b0:355:fdc0:a811 with SMTP id 5a478bee46e88-355fdd012f1mr16681655eec.37.1791919750254;
        Tue, 13 Oct 2026 12:29:10 -0700 (PDT)
Received: from [172.17.0.2] ([20.169.56.52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537c841648sm51293065eec.3.2026.10.13.12.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 12:29:09 -0700 (PDT)
Message-ID: <6ace8685.a5690e37.2bee02.b73e@mx.google.com>
Date: Tue, 13 Oct 2026 12:29:09 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6422776059249686352=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] test: functional: connect instead of pairing a bonded BAP device
In-Reply-To: <20261013150336.579039-1-luiz.dentz@gmail.com>
References: <20261013150336.579039-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6422776059249686352==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1184865/

---Test result---

Test Summary:
CheckPatch                    PASS      0.30 seconds
GitLint                       PASS      0.24 seconds
BuildEll                      PASS      17.55 seconds
BluezMake                     PASS      272.61 seconds
MakeCheck                     PASS      13.65 seconds
MakeDistcheck                 PASS      131.54 seconds
CheckValgrind                 PASS      225.56 seconds
CheckSmatch                   PASS      246.14 seconds
bluezmakeextell               PASS      88.43 seconds
TestFunctional                PASS      1035.10 seconds
IncrementalBuild              PASS      265.87 seconds
ScanBuild                     PASS      988.13 seconds



https://github.com/bluez/bluez/pull/2673

---
Regards,
Linux Bluetooth


--===============6422776059249686352==--
