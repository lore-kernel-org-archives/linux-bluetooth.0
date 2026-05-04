Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711D53DD500
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 May 2026 20:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777926329; cv=none; b=rAqdEZrJgnxS4yWs+n3A8qp3nX4OfWoTXy41BId6qFoGYNxKgL+xQHXXaNYtpUI4wyjwiOzbYJ9U49L5MbWkuXxN4rbry+rR+VP78flQBpSYf4mBxyy+lkNQ96+EzbwIuUI++rYM1/Uff16cW8m8YIy4AjFyvLSsxUP7ODSKkSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777926329; c=relaxed/simple;
	bh=GbXHFvDCORaNBseQrzVOEg9YzVwu9lFU+ZuZG5bICxA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ccO/9rucCfnEqu/pNShw0C0tb5cTbzy8ECX/vhiTiyyGD7a91/P2JEbaDdxpxYGkdneglbD6utE0goRJEdAt7uX40It8nTz20bIWIgxIDknRvsr+LlUDVHGhAmugTSnTM4lEl3hEYLbx7xwo1k8Acy9OMAunvW0/2XCjNuI7Hmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SQ+C2i/H; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SQ+C2i/H"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2f00a567cfaso1094028eec.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 May 2026 13:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777926326; x=1778531126; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5wCvXj0mjpOtotClqraxvrRWo2r8riappfBy61R27pQ=;
        b=SQ+C2i/HaEQtAzVNUfDqPu97gPpTF0ZT+crHAXt2tHIpAUwS5tMwsiLOfwVqi1+SFw
         xkhX2q5T9Ezr2aUP1Y5hAT6vXIlk+WEYAMyFxv4qxEDUKk19mMQ8dSA04+gYS2pNYN9L
         i/ZEzBHR9cch+sUu32WgesfFLiJUb+huXIoOvbD2lyiKm4y+WklNR4xAvlU8/SmjIGnI
         z5zeGTTvpwtNPnlC0+wA1YhdW79VC6K3O9hnna9RGowOiSdR7HNk09Btk+tQJzpxm7nT
         M1EzMIC5i8UBe2UZC46mR+KpILydPVmW9B463RE6XMIVmWNaFW1RR7DyV4cMF/fp/xua
         Btvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777926326; x=1778531126;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5wCvXj0mjpOtotClqraxvrRWo2r8riappfBy61R27pQ=;
        b=GKXAA2yaQhQmhRjlobmlx+GcAXmBfQMYVRHt1eXD9ge6Is4uF5yuqghY9U+GtODw3/
         Zl9v1WwWyZw6Hou7BnT8PnYGZjp+CtyA9mtUwwjg6wkATCDpWqp+CkPEpdVnxvhZBXub
         14CtCpUwDGcKFDUDcAIm0IK6RUZRoPxbWiN8E6JNExSFgM3f8h4Fl+5J9Evy8sFbi9Uj
         FeCHR0/jvpx2rb2mmRKlvHISP0hBxpg+avbKA6UNgbi70lwm77ImNcACOA7iJBB1ivfy
         5bNXUFxbiKwecb2EErSbXkA++gZi1zolZLYiaCR4P7f/XzIILaLTRAvhuUTifeiLDqyd
         jehA==
X-Gm-Message-State: AOJu0Yw/putrUEm1mToAE4yH0GvDGhO6+uioDrmhq/TEgmwkwMBw+jzS
	THmrH37rAqt+1cHjD0ALmnoi9ys7cJTVYU+y5UdI3MVFTM9Atl8HqImOsVPZhA==
X-Gm-Gg: AeBDieubshR0bv1wNvVkp2LJPG05MkdDGMWv1S/6Dmo8quWQ6YyD/fFlAJHJH8yDfCL
	+BQe3oaJdvLTguCcva6YZUTZehGW1PR85Z0a9OOPFqiWU+5u4nVXLIX8cNfc3pkGI6113J8QUmZ
	4gTPCzXjRdA8OQGGsU+RYAjmbsfawjG0KidfGWAw7NGRs7S69+zKByGaHJwFtE2NkWIJ+TDvV/f
	HSw3RKg7ofa8nLBuEDmv9MQdHglcHemQ7IPBa1B131Jdo+cs4xIHX7gXSILcUvUB07YssdOHh6P
	xM7pVSC1Uh0sBLgdZCCMs11UklCfFQdO329Lt60UyKiLgWuWEH3Zvq290dO+WC1ZH7Tje6Yt5qV
	KbAAaq3nqApL0ID6SGmQi4nm6WvkSx37T07dUO+fmo54SDqbXWdyHNAf8ro0Y+yvftswLx/xBYQ
	yEp2BMrqdKan+IazvZUiNzB+d6FbDqM5c58YRK8A==
X-Received: by 2002:a05:693c:2c0c:b0:2a4:701a:b9ba with SMTP id 5a478bee46e88-2f3cfacf843mr491300eec.14.1777926325729;
        Mon, 04 May 2026 13:25:25 -0700 (PDT)
Received: from [172.17.0.2] ([52.161.59.2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee3b7815d4sm16696481eec.20.2026.05.04.13.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 13:25:25 -0700 (PDT)
Message-ID: <69f900b5.050a0220.2b32fc.19f1@mx.google.com>
Date: Mon, 04 May 2026 13:25:25 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6503719858590040781=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, sean.wang@kernel.org
Subject: RE: Bluetooth: btusb: Add new VID/PID 0x0489/0xe156 for MT7902
In-Reply-To: <20260504190353.9358-1-sean.wang@kernel.org>
References: <20260504190353.9358-1-sean.wang@kernel.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6503719858590040781==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1089463

---Test result---

Test Summary:
CheckPatch                    PASS      0.66 seconds
GitLint                       PASS      0.23 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      20.23 seconds
CheckAllWarning               PASS      21.71 seconds
CheckSparse                   PASS      22.09 seconds
BuildKernel32                 PASS      21.81 seconds
TestRunnerSetup               PASS      414.17 seconds
IncrementalBuild              PASS      20.46 seconds



https://github.com/bluez/bluetooth-next/pull/146

---
Regards,
Linux Bluetooth


--===============6503719858590040781==--
