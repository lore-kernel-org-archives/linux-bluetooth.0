Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B4F54856A
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 20:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791922686; cv=none; b=esPZkwn8XD2xCNF8aGkbTYqHWTRnRRoOrEJNkCxqKTPKG5RFML0SSIQoNacDMinBDVpEigTQgMty7sxr+QbTeEm0N4leMmLnqCCPrd6rlet4x+dC53jgWOqY7HEOCNHWhP1rWi5G8Ml8W34TiBQmJTlVd/I7WeCr1ZYUXhVnlGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791922686; c=relaxed/simple;
	bh=oqRSPJ/mgXHpHWsXbMcC+AZXtrI6J0d3YSg6GsDyW+U=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=mqvz6e0kx8LtRlW4+VpnirRUI1leZlaYNFb/uOrF83PRCq3OVYA8NVfr7veMTMmRQx+/HMwo8BSKo7rhHBajgH/SMjEFT4BeuG6JT1PE/fFKY12Hb/SpfzUlO9Olx3cKwKRWUmddZhwailKGblCIy34tBd3tbKmVU9MrPPk1nLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bBm9oGj6; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bBm9oGj6"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-828f4eeba13so2510162a34.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 13:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791922684; x=1792527484; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BDvn+uSqKiuebgN1+E2taEnpeQOa6jIp7q8N1gnmNjw=;
        b=bBm9oGj6/QS2pkPkJFNWFblzqEAFBJNG4FLaWndiBZE+mjal7W5jvqx2ksuLG/mwS9
         +SHrpZ4q/9Fw+2on1/n/vpnLyqXA2LTga55b9w7McIb7rcX/o+rzW00qb7oC6ENMJbX8
         XdqJWpHiaYSMHvwo4arLWClTw7HWTNEKP2gdPfuRA1JiGdpAoXXcHFOdiQfmz1jZ4NcF
         rskwKxv419mzINyoawkheTOUx2P+MiPhW7gkVANwt0Qj50Vidy2E2/IeDRIKXE9U+YUn
         b4pXp87Mf5FQl5JYh9dWY4dnmXY8I4xidkf/KWNictMK4jIvwS/mhvhwqxtW8ZngSSlr
         BwpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791922684; x=1792527484;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BDvn+uSqKiuebgN1+E2taEnpeQOa6jIp7q8N1gnmNjw=;
        b=WLWZnkS3UkPdy3Khu3ftPSdpSjd/czkSeyxaU5rXDccU+3XCrGIVPFJZojQ1k8D5NE
         xQhZ3FVqoMlF54ltI3Oo2+ZhLH8Du5s+eK5iHMfZ3a403eufk7jJ3EUyhJN4DVFCWanO
         wT1xzC+H2Pm2dtci+QxJJNwz06iVu8TKAxKtZE9vkaih41YU8PmcyJGAzgbdYPgyHwOg
         f1Lzek8FlFoWUtQIaBQlEHNAAUtu16S7C0g4bimNzD7cgS2MLyIqQ5gW8vl9bMOuKQM5
         RyQEzH/9x4TwaFj0Ocjv83rt3eImvREWZHMQQi6xN6Gb2hYA0j7KNgXZth3j2U59Cc8l
         WxWQ==
X-Gm-Message-State: AFq9FYKmCTy61uIoixkxKbQmO/gSJbyuSgyKsBu+llSgMBNsjsf/qUPS
	7I7CK8VVLRSF+NiEWo2d5KbJFPdZcCt6IWm0h5c3Fc5sctjsydzIXorTTTM8Hg==
X-Gm-Gg: AYBFou1axc1EPVpBfwetwdJNkEhjMzf87KJ+joyU1ZJ6/HL+Ts1hxXWZxcfHr2+IdWL
	q816VpZjm1V4h2anxBVfW65yCIng9RWPh9JYkR0Qbt29yPc5BuvcEVi9qj+w4Pv4nT1aINsVQX2
	z6WzVXogrNsp6FToEtlq+p3tlmy5zsNWBMMpImGUl9L1fK+Dr6l948xaPB8295dMM2E5GKib8NS
	OATTradBA+kkqEYd9R844Ygpb/e/as0Qz1SuIuIOEAeputX7OlhfhvUQ8juMRfKVCiHNVFmHt7p
	at/czFSlKlEnhmXmeqScq94r7hfTSrGWiwd9qaDKiVF0o8L2sVTe/4Zy2yRcXaSx4CJ4hRe0L49
	LNUj4VfngttJp9kUrBQa38bwg4U9d8xUkxpNV0QMJtzMquWdVYcx8eBPrebbiJwJZj/i8J0PHDl
	d9OYv3DdawbyEc+JzUeODja8kVIEMYDyxN2c7B54TcvpO1GBDz+FqmEyHDxUg5Xg1AdMVA7Rpg3
	Wj6lA==
X-Received: by 2002:a05:6830:2306:b0:822:e81b:3ec4 with SMTP id 46e09a7af769-8309506c286mr14928987a34.7.1791922683435;
        Tue, 13 Oct 2026 13:18:03 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.153.89])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-83039a3dfa1sm13378042a34.18.2026.10.13.13.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 13:18:02 -0700 (PDT)
Message-ID: <6ace91fa.965be603.315991.fe97@mx.google.com>
Date: Tue, 13 Oct 2026 13:18:02 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7324697225175638996=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, oss@fourdim.xyz
Subject: RE: [v4,1/6] Bluetooth: L2CAP: Reject mode changes on connected channels
In-Reply-To: <20261013153720.2635387-1-oss@fourdim.xyz>
References: <20261013153720.2635387-1-oss@fourdim.xyz>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7324697225175638996==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1184901/

---Test result---

Test Summary:
CheckPatch                    PASS      5.99 seconds
VerifyFixes                   PASS      0.11 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       FAIL      3.59 seconds
SubjectPrefix                 PASS      0.74 seconds
BuildKernel                   PASS      30.53 seconds
CheckAllWarning               PASS      34.55 seconds
CheckSparse                   PASS      38.13 seconds
BuildKernel32                 PASS      28.88 seconds
CheckKernelLLVM               PASS      34.50 seconds
TestRunnerSetup               PASS      667.05 seconds
TestRunner_l2cap-tester       PASS      12.35 seconds
IncrementalBuild              PASS      47.78 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v4,5/6] Bluetooth: L2CAP: Only accept connection responses to outstanding requests

1: T1 Title exceeds max length (83>80): "[v4,5/6] Bluetooth: L2CAP: Only accept connection responses to outstanding requests"


https://github.com/bluez/bluetooth-next/pull/919

---
Regards,
Linux Bluetooth


--===============7324697225175638996==--
