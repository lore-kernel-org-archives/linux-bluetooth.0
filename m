Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80A447F3BF
	for <linux-bluetooth@vger.kernel.org>; Sat, 12 Sep 2026 13:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789218293; cv=none; b=rSnGglGyrMYYF79R/cKnWa1QU2z0BIynPXB58Rn0tO0NEWFf8Yp+aiii8Jl+QFmVbBqUBg/uEAnbLOaR1JgxdEB0sSz58+cCiqBMYyVXOzHlRJkTPacHE3o5U9UGXev34nMQm9tQB532jzT9KrGYIkia262hcM5J57u5bw9QX/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789218293; c=relaxed/simple;
	bh=gpZMCMC0HkwnpgLx5LLdpgdtkFtn/v/sK7FFbnfejF4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=mua0w47/5jN1fXgCL6zkLrgg4rC03iwv6zlFcmGkgEAtD288acut3Lukz7Y9ogyET6+BanqjqQ8+3MjAd7WKCMbzoyqNqqp2w6WdU/cSlnh+R8oAib4f30cmndooocFbzOhDgr2z3a+5fT3lm1+w/o+4eyfGzXNQR971vLFAiFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L/Yvc2RL; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L/Yvc2RL"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-90cdfc6db0aso10983986d6.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 12 Sep 2026 06:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789218290; x=1789823090; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=X4Zf08qfz6f+YrcKvycd6Yd4HEdc+gELpOS/pPLNSHQ=;
        b=L/Yvc2RLG/m91j9aJe8Yry46buHjbTkr66YDHwKnm7MO6J9eqHtFKMhh53eFiiKq+v
         bANXyswYliQJrCjF1Yc3OMZeqIOqm7xjtkr+PCoCn3ZIMGbOq4sva3npL2BAohXc8adR
         40QPOQzN9DGRX4AirXZg6gfxJN4AQSo29MAMOXgf8wB6g2Hr3MWQp30rGXRR0vcuenzR
         JzMWeYZPGlS64xy4w74PNISKmPzzZzOi3B7mkrYs0ep2b0AUTfx5bhVEg38oJzLU21fz
         kYgRMQv5mJqsVeLZOW6RPBnvdZ9lB3akTX++w7ROhyHXTMXX91OgaXbnkEAqiUq4WDBb
         kiyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789218290; x=1789823090;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=X4Zf08qfz6f+YrcKvycd6Yd4HEdc+gELpOS/pPLNSHQ=;
        b=p02ZXGwBMWs+oyBY98GtDq46MZhdrEgGzk7BlacVR/OpqgFB3Sq8zCbDIcXa0QKAUH
         npse3buWZiFlSnvVPrRrkwPgbOFPHYqZnJWheEQznKGb4FUcmACDsyq3O7HZbElGxM96
         T/lRYSFePTnvGYBc/42wlakQBWronHLY12blk+gPpLdamsZwIY70GpWO7IY0J8PvhzQd
         o7Bag5GSfZnRpXyI77YQ7YflM22aFp8e7ZPHrx1E4WThKJqrtsuKj3jhjpHheZ87mTUb
         VY1puphhVyJZx+ANPLdD2QRPtYDEbKgxIyMcf78iANGJqA13Ik55iBVFYU3jriZZ7LWw
         /QSQ==
X-Gm-Message-State: AFuF++nkjgDALjnKsfqborLZKJ3xpKdncvAPG5noSQ2rQC6xcuEl8Yw4
	u7kL9ZLYhQgVPTRkrMtBXd9StmXbtVg9AFMcGH1yZqQ18JAF2CgM7LPBZi9Fa3Ey
X-Gm-Gg: AYBFou3Y5CVS9eL39t2slyUCYh1bPDYD6xUEdbH7XEWpV6zK8q7kJtRhscciH7Tn25W
	E2xTHNnLS4BlkHz2XRil8i3i7xr+19HV2tbsNai9MDwdZy2S5M3Ma9xil/asVgiPMDRGBQN59ma
	ICmGkZJbInzmXh8xuisci2C9oS/QerKUGsVGsbGDli8CSAGrfjm0442Vc1xb70xXugAG76edmjS
	EF6tuf65wrGvdkt82ruxr2GKQ0iDavkQKtHVfYAzYncUcsArehzsqW6/g/WKG6qpXb/JsmcCcmU
	XZg9/8hspk8xEUf1vdJmDmCmLf9BIONjTHkmLBvMQ0mQsODZvRn1d0olhXucyBrudI6Zg8hXw9U
	QmkhzOPQ0v9apBvKoxh9B/9WfcqFu/+cKUdJ6vcQTkMugXTdvROlLQkYKmR9Pnphnj1X2gEmsGA
	5ZWSUUoXRLtbIJS7fBoZ8+y9eDTCq9oUfmSy41suAahGC7rLxH6wJn7Y6JrWjN6/mQw/W/j0IFR
	EwW
X-Received: by 2002:a05:6214:2485:b0:90a:807d:31ad with SMTP id 6a1803df08f44-912120e49b5mr134621796d6.26.1789218289624;
        Sat, 12 Sep 2026 06:04:49 -0700 (PDT)
Received: from [172.17.0.2] ([20.115.63.50])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f477d42sm45900586d6.18.2026.09.12.06.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 06:04:49 -0700 (PDT)
Message-ID: <6aa54df1.cfe3cbd7.175dc.864b@mx.google.com>
Date: Sat, 12 Sep 2026 06:04:49 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8801142239575132517=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, mikhail.v.gavrilov@gmail.com
Subject: RE: [v3] Bluetooth: RFCOMM: connect the session socket without rfcomm_mutex
In-Reply-To: <20260912100315.151674-1-mikhail.v.gavrilov@gmail.com>
References: <20260912100315.151674-1-mikhail.v.gavrilov@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8801142239575132517==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1163440/

---Test result---

Test Summary:
CheckPatch                    PASS      0.69 seconds
VerifyFixes                   PASS      0.12 seconds
VerifySignedoff               PASS      0.12 seconds
GitLint                       PASS      0.30 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      21.74 seconds
CheckAllWarning               PASS      25.39 seconds
CheckSparse                   PASS      27.72 seconds
BuildKernel32                 PASS      22.46 seconds
CheckKernelLLVM               PASS      26.39 seconds
TestRunnerSetup               PASS      574.84 seconds
TestRunner_rfcomm-tester      PASS      13.19 seconds
IncrementalBuild              PASS      21.86 seconds



https://github.com/bluez/bluetooth-next/pull/755

---
Regards,
Linux Bluetooth


--===============8801142239575132517==--
