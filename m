Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795641601;
	b=mUuL4qsgOjkrUkIltEO1Zxt+XKO7uqrwN4BXsCKv2kTuosVhSubmz8b35FLX0Y4YQhKa
	 SEAbBl8vUueUshCysZ2KWr7VHjiza7dJBLHallg0pswutnF/Hem3KrSKQS9exAs63bdK8
	 INA0eisFMbY8lvOL6PdcmZfi+IuyIoYxuN1buViOOL2+oeeI4fpUQQImecAdWmpfWN1hJ
	 SODciE3iB40qmia0p0VmrYFMw8t7kj/ON3+F4X5+tMlFwPLybhf37agZBUMfD4P8d+zVp
	 Gba5Yf3coQIwciWZpgYR7W5cTYDHZXsyJFSynuiPUSO0SF036IEXezVCkyUTNuzWeTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795641601;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=ICU284ziUsoz5+LWUu6KOZqVGbXD6NbhWrnNEQD7s8U=;
	b=xk9XiouzNQWdCPh2qkPttw6ytWzCtalMOq1Tt4CCf1IYhQrpIlPtFC3YzcScnyeTNhak
	 bzNAYJUOjd6uzfsXuwyOb8E+YA7zJ8GdNcLn5uniLCx7zMUPYvcV8fZMLjSfY9QdL82cA
	 Gmn+lbDnB8bGdjnXVmeWkF4HuZIl8E7uIkQy32RPfFRnS++2EoeCHy73Ozo1ppXw9eage
	 Fy4oXePOZIfXHB+TR1ocnuVVbRmGN869LJokk3k20tu9xT5jIkDI4dX5BEXSoEY0nycA1
	 m08KNS5FyIlGG4WIrlOqlalbcEIgBD+0NGVg5/HrgQHGPwOVLakzKYADzJ3M8w9XRuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=teedlmRr;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1A7606A326
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 21:20:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E1A7606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=teedlmRr
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso13324608eec.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 13:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795641600; x=1796246400; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ICU284ziUsoz5+LWUu6KOZqVGbXD6NbhWrnNEQD7s8U=;
        b=teedlmRrUE3yqwBRcjzay3upJGrX2/IsXljlX9ZlnvFJ2ZhKaTemmcpkAolapTc81H
         esLRRRYhCT8klFHtwYc86P0bIW1YVN7wjs+nD+o1f+l66u6aZIRu5RF/D12/d7Pl3nvu
         +nd5+rxr7Q/JYlX5xdzekzbwLAiONdQ2QpL12YvDNoKRmKmojEdodq8Vk6NZF4v5cUyo
         Dmkk4G2zorsEhCvRlV2SaVFdDdIPwrt1TieBCjQ8H3hPTPN7RmSmuSwuZwHQfGtysVc5
         EmHDqwL4BB7CALrLutr/3ww9/qxSgSwO+VEpk+qrfDcC80r80pgSKhVZAZAEyNfGBC5C
         BFnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795641600; x=1796246400;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ICU284ziUsoz5+LWUu6KOZqVGbXD6NbhWrnNEQD7s8U=;
        b=xKT8PPzxhm1t9OqvPQ4Wmxe3ZANZSfgCc6MKUFxm2WLm4RRqn73q5VLTE13Wf5NoQC
         +/4ScTkLEWAM99wQ0NtdxBDTPUKylEEiwpA8WdICnmFQIf0xkMrgegpSsPvtvUp8Sm4F
         FS3dA2fofJPRjKgVQqnHdtyPWLcODtmLjHUOS7XunLCahoPWkUiz1EUqNhk7Gbw0STtC
         bFGMKRtri40t/RNOxEOG/H8NfFpUiYplyMhPJq4WfaMthIXU6yN4tzvcuNXUPAqNfCF8
         Y12k8np+HCMue/U2tSrUN/dA0wA4ahd+enl0fzA9H3atAqegv/0SSY/n1MhBuidHsVWY
         1Gyw==
X-Gm-Message-State: APuU4Z/dCyYrwx+/ZSo4ydZClRckksoOGcoEVh/9SuCdCJVCGdxjGNzA
	Iw+f2mio8fQyXtALWSmvECAqax5haNC9Oaxx7o2VY6uWJLiuRPvttS4iKHH2vQ==
X-Gm-Gg: AZFdTZePpSXBzQfU4AFa72SPw67MDCmb8sYZBBWqfEEELCPCPAOcW6kq9SHBnsxiY2C
	8tg033HAvOU1OJ8V/INhqARggqNwc/m96PaZ4fwTYhjNI4CEs6WTktl9zQ3wy11Q6exGgYkkfsF
	D+LvapUbJbT52dG+13li78Q1FyWGFE4Nfd5y19nFRjASAskhBCM7OqBIJDfJumozTlP9FEMN8BF
	S5W200yhO3uAr0e1A38zPFbNuTBdavHgIw9oTwSbJe9HqbRnDWqIqyKZ9f8K6T4MydJ1iyGeCNL
	g39T4FRfb+5toIzfBCZbEuqvJYUtrYI7HftqSc5cNHkkWL7HT9j3dtGP16zBKud91xeYX9QxLrX
	1FckfJdoKuFiT1Prd6WAZLaNipAIU21DbPR5FMbXCOxFFIEc/8rqCh+w/ePhfehy6JBJzgJbPWA
	eDl4wYRMGP7JrvRiMcAS+/luehhKFLWGEkzDvv3vBc29sq39q1x+XoECuNBt7aBPq8U/WhQnUu2
	8p85SuOpbHI0UWJoVw+wcU7AcxLc/n/rwnbDctzBIpf0Iukq+fJ0IOqWawgWOE=
X-Received: by 2002:a05:7301:416:b0:356:7ddb:2e54 with SMTP id 5a478bee46e88-38570f27b33mr19620595eec.29.1795641600353;
        Wed, 25 Nov 2026 13:20:00 -0800 (PST)
Received: from [172.17.0.2] ([20.168.157.85])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385646633d0sm100462728eec.3.2026.11.25.13.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 13:19:59 -0800 (PST)
Message-ID: <6b0750ff.a5690e37.19a5c8.f05d@mx.google.com>
Date: Wed, 25 Nov 2026 13:19:59 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6419711835557380886=="
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
To: linux-bluetooth@vger.kernel.org, zzzccc427@gmail.com
Subject: RE: Bluetooth: L2CAP: Validate responses and serialize security changes
In-Reply-To: <pm-bluetooth-objects-candidate-0069-v11-7d5800a0c21420dddac0-1@gmail.com>
References: <pm-bluetooth-objects-candidate-0069-v11-7d5800a0c21420dddac0-1@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6419711835557380886==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1222197/

---Test result---

Test Summary:
CheckPatch                    PASS      1.06 seconds
VerifyFixes                   PASS      0.06 seconds
VerifySignedoff               PASS      0.06 seconds
GitLint                       PASS      0.40 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      24.72 seconds
CheckAllWarning               PASS      27.41 seconds
CheckSparse                   PASS      29.89 seconds
BuildKernel32                 PASS      25.06 seconds
CheckKernelLLVM               PASS      25.20 seconds
TestRunnerSetup               PASS      569.12 seconds
TestRunner_l2cap-tester       PASS      15.37 seconds
IncrementalBuild              PASS      25.38 seconds



https://github.com/bluez/bluetooth-next/pull/1226

---
Regards,
Linux Bluetooth


--===============6419711835557380886==--
