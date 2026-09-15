Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62E93C7DEB
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 12:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789476981; cv=none; b=IPGUhihbZ4RDTvPX/vB59E8KPntdCJXKawLEb/EQylvl4qYykkv+HYdgNOW3iwyFuMvu3SOmdZmiKPy9EwCVqGPurTbcNLAsNEIymhgIBJ6Xo33sqRRlGHwrVz3V5D1V90Uz7SiZqd4k/gBYwxNUxQOgvB6xbPYFGaFba22bEeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789476981; c=relaxed/simple;
	bh=RMGU95jJS1Lu5Pc/iQG1PHgTa6p9Zemml3j3gGtPdt0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=B8rYND0v/5SbHP+StYYXQHCYQ4wzEkck0Gfs1MBIgu1SXZaXQmNp8mIHiGbCfZJX8UoSQE/ZZcuglKTSb2vyt0t5xsQDrs9QtpC7sxYmuHqSSnVniHny0Og+MwnYMndZCeSOaphdnEOiQ9DeCYZ/qFYIeDABeb5ZhRDOGDQdruU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aJ1mR44v; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJ1mR44v"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-91205165f71so1243026d6.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 05:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789476979; x=1790081779; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=puNEFVYpD4edoSMtUYI05tIO+c4+sUgFuaK1beWPbio=;
        b=aJ1mR44vzePUB5hvcT2qCrivpHpUriXZ6I4MhGzpQAikaiE5TI2TuXZj1Kx8vxjabs
         q2zcYzb71VinZIwq9BsovAQMP+LiCAwWR9u45z3vAGChQVChc9x6/PRfTZscZC2OqZh+
         3xgj/mmNcYo4edVSEMkniukXkRzUFbQ5AZ/ODZlpNOvcQ2zsU0zaWrEDjS70J+MyEKfk
         LsrgNKkCxImdyyOS3G3wxboEdLnC23seFHuYnhVgy71GqWCFQPy7TIWYwMDWIYAl3NIS
         qGEXyEcEUQNOs9BTU0FriSSdvToWJomoKnMoKcbIQxWlC89MQvyGjRcJPVSN25Ry1R9U
         2eug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789476979; x=1790081779;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=puNEFVYpD4edoSMtUYI05tIO+c4+sUgFuaK1beWPbio=;
        b=ylV3pPx7awGMMozhB7kU4uMWZWujCxwiZGWL9t8/g/Pi/BklliOq9Stf2//RYiPJcc
         hzy2709JOSUR7p//d3korpmTQPYed5sMGBJ/S228JCTDZVJCY2O/hJtIAvolWT9ZABvg
         /rH5/oFUdIHcUEAwr76GTruWrkkqTXT4wPUXjolKdh1u9y3cmt6gNn1KOWE20sxQ4usW
         X2ddpec0oPb7GA/o/b/ZDV5JkgXFty4f2bDtKIV8VTwVrRZgrhRp61nRJoB71nkt97eA
         b3KwntWQ14Ef96+rCxR+AMXFNlpxeWFssNKNqE68RM2KAgZUwq8kzHZ9wdxYNhQyQhLD
         oxLg==
X-Gm-Message-State: AFuF++mjM3Xu/+27PcaVvleHHi+XP9Q/5dvhARcKUMzO8ZbNKTUGOwGp
	QtnSfpH2t9OrAF6rIgA3kFhvljI5kVijs2mEnTNzQ8yljEDNbCzGnXCGdgZTCg==
X-Gm-Gg: AYBFou2gtvZE9CNH7n56d2NENROTjHBg3HIVFBOvfgqnexX3btmxvNlJN/w+wzGmrCn
	Mj1ByyEC/zwcjTgFsm0saroGW9DEgrEouetghzcvxcKvao2NkNV5L6NUhyajVTv+4bq/VxwTnWc
	V9vvwlQo/Fuip2Vu3ZlYVigw1W54Tz50CJlylAgYogkP7fD/54XGZCOdfY7O0VMUNN0viKionUn
	hcBmOgi1jIRv2szprpAYHCCxeyuXRnR4d3wD4zVnWlz0Ef9POwHRqnJBXR5KPkO1J/MRYS8kpMd
	/teEJmOiT37qznA5UhLZs/fFNlKePdkhXbD20OmmiHdQSazJEBu0nY1L/s+dlNjSRPlYCnupVYY
	fdPpn76nMycH5k+Vhw0jggrxezJ9Bo17ND+5ydLiCEAf/QxbX01QcUAkaU/Zu5xy17lEeRJt+i2
	lzTAmbTWoTN+mp765SWsUoRUERaRlFm09zhfCxI+BJPJRjYQpMiRWnlGZW4pJlOVf5xlsN5UEms
	qdWHQ==
X-Received: by 2002:a05:6214:226a:b0:912:33c8:80a6 with SMTP id 6a1803df08f44-9123a533885mr13222016d6.37.1789476978729;
        Tue, 15 Sep 2026 05:56:18 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.223.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91224b74247sm72628246d6.39.2026.09.15.05.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 05:56:18 -0700 (PDT)
Message-ID: <6aa94072.2842b724.2f298f.7f4a@mx.google.com>
Date: Tue, 15 Sep 2026 05:56:18 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3816965018958150897=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, lee@kernel.org
Subject: RE: [v3,1/1] Bluetooth: mgmt: Dequeue pending mesh_send_sync entries on cancel
In-Reply-To: <20260915120823.3460208-1-lee@kernel.org>
References: <20260915120823.3460208-1-lee@kernel.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3816965018958150897==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1165484/

---Test result---

Test Summary:
CheckPatch                    PASS      0.77 seconds
VerifyFixes                   PASS      0.12 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       FAIL      0.41 seconds
SubjectPrefix                 PASS      5.05 seconds
BuildKernel                   PASS      28.89 seconds
CheckAllWarning               PASS      33.54 seconds
CheckSparse                   PASS      36.17 seconds
BuildKernel32                 PASS      29.54 seconds
CheckKernelLLVM               PASS      34.56 seconds
TestRunnerSetup               PASS      745.28 seconds
TestRunner_mgmt-tester        FAIL      9.35 seconds
TestRunner_mesh-tester        FAIL      8.15 seconds
IncrementalBuild              PASS      27.99 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v3,1/1] Bluetooth: mgmt: Dequeue pending mesh_send_sync entries on cancel

30: B1 Line exceeds max length (105>80): "  - Advance mesh queue on error in mesh_send_start_complete(), skipping -ECANCELED to avoid self-deadlock"
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
No test result found
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
No test result found


https://github.com/bluez/bluetooth-next/pull/772

---
Regards,
Linux Bluetooth


--===============3816965018958150897==--
