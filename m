Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795520271;
	b=n6rgSLhWpb0RXFvmRacAAZw1QjPNqYtX0Ldt+tgYWHOCzoUZnBh/505mKfjnbg6qk7QC
	 omw7SKrYQ5hH05zf2yp80uQsnpLLdaFw+XW00uSLfnJrW8AZtqY5G1jDmv9bRrz7kM1EA
	 b/Xfp34DPy4rZhCcsPx4vT/n3cALzZVC3gIVBbSsM4Y/QxBd9pRnOqJa8rfTWxj50uUWB
	 L3rZklzMksvzALxh/P7OYQzOPYPcKb/6nrf023YjGWWGmBUTVEPlR1QXVEjhStXsZkpU/
	 /JJglmsdKOzP0tz4w26FUJlmjQ8G10K2JonMC95IJAEsz0MSYda2j5M3i1hawdzs7GQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795520271;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=/LBLf5GUc5nTFZC6qctIllFVSdSI2uqxwolaJwa8Dxg=;
	b=yMFSFl75e91HXw+g85UeAy+vdd0jQPjBhDSSMpKSMEVEKkJ0ByUHtCSUiayUWSvMsrw/
	 5D4T4r+2FA3lgB21N0Vd8nZR21gSOI5hZVgGDRB9UoaWRRqXf+gWHi271SmFsZZRIDOQh
	 0O+YYZrTehBDKMl2fSfvb0rpKIaUZORNSG4nd/0TLpZix7shvGywJxqCZ2gFgs4N4hKl3
	 GZe9ANBWktk3OCYovRq3N9BE2JUZkqNua55z5gErjEruet9hI7/ThJFOiKONElLYCqKVk
	 RAocvgbI86cldLquG+KLjfgjhffkZiZoZWA8nhgC2qkvrqa8YV3yVVoCE8UsGxkxnDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MIx96TlF;
	arc=none smtp.remote-ip=209.85.160.180
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2686C606A321
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 11:37:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2686C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MIx96TlF
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-55c5b6584ceso33055591cf.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 03:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795520270; x=1796125070; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/LBLf5GUc5nTFZC6qctIllFVSdSI2uqxwolaJwa8Dxg=;
        b=MIx96TlFpSTiVe8kVKBAFQVuem28vIdr5ZYwHURL/pb+ksXYtCBDI+3M1qND954SiK
         QiThgUIyoizm78ha6cJTLVQUsqthTbghBLzcnBJF9snlKJbm78E3bK3VFyVscjQTHukJ
         BrAOcPTO8zSN4nnudsEL1riYm/COKjCrKlIzZ0BUXYI5Nc9OUmQw7HGON8InMZyPOBdo
         li5UbfGgPlILirXeKO8928cXIathztmoXpoXrx6B6+UQE+ZPz2LGUSHKm8sZfTFflzlO
         BxWQ2M3sLuWfiOBgsx2cp/A4nMRGkX7Yg7ufZJ1+EwUOhOpI7ED0v6d7N2lBlBS2wxj4
         3+7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795520270; x=1796125070;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/LBLf5GUc5nTFZC6qctIllFVSdSI2uqxwolaJwa8Dxg=;
        b=Gt6Q5iIgTDQ7CVfkuXlV002Oq3BQHfiLp2O1RAWdZtUshk0mcrs01EMreA7R76vodS
         CNEZAce/GowjTbRhYhhja1ttKSuG23MvTDCYFYtLCeO/+iXd8vaMvCxqrAVude+teHfR
         hPPi36j2OpTR95K5pfrhj8ZMMxl+HBaSiBEiNvwPOILPz7ADYLzfLGZ/PKLDIYDtOweD
         AYugrVAibhbzD7GDtK/xuDmS5BkPUym8f9Ss2pOQykKi7omWi/omnj6rCKDV1L3WX9kG
         csu3XllWstvfYh/93qNkXRVh25C7QneX/Q2wJtq5lT/tOIrdZQrTpiykGqN82hSkt/jV
         SoWw==
X-Gm-Message-State: APuU4Z+mc52f17LJYAiwiu2trG7Kgh5VpGTIaei3XpLqyM5mz7gYrg5G
	378NfQjZ/BlemDQTSny/DVyK7jGSTqL1+/QdNTA80bklkmGuh/c0Bd2Q4/iFAw==
X-Gm-Gg: AZFdTZesnpaz3vNndjAXYz8yV6gQsruDtSKYqHUkNOWRtYi6FfuHKJfCFP0dvjrc1Rv
	gZvUxGLR1FKkidY730mxfhBxP3QUjsuPrhFM55HEr63Z0th6yu4yOJKHHgoLri+1OGiiGIWksGR
	44SmFmIcRXGrqdY6sRkewJt65+odAOODKR8r0CWGi63RrmVBsZCSBpj/zLmK9XENh3GvFRv0mU8
	b/MmCO1ePR4+ykD+AwVrY6wE07eP069vNO3yhSjXkVjeZi6oY9alAuUj1hqn27JOH+QFZwxMbin
	0f7td84jklnaLLUXCHxe0rDo8vHMojTdGUGjR8CbBiwNJD8dY1P7FFWXL+v81v3AjxLSUu2IguC
	YNMqlWWvFYGOb+WENy6h3rck018cEuIRFbn2u2QxCrIZ1ImmmrYaGqWY9Sl3RbsSdFJIkxU2iLz
	16QVG573caAcxa4rqr85UuYCgKY01PhbTUMTIMse5ntS2sr07hZ9sZ0zQo+67g64/7PC7LC6LvZ
	G5m9FMuo2H8cS3Ws4fBVd4ws0YfkLmZSOp989fWUZ1C8+w89zYNw7I/ERt3tGc=
X-Received: by 2002:ac8:5f87:0:b0:535:a5fa:ee0c with SMTP id d75a77b69052e-55d76a8c186mr260934301cf.76.1795520270031;
        Tue, 24 Nov 2026 03:37:50 -0800 (PST)
Received: from [172.17.0.2] ([172.210.6.112])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d784517casm123836541cf.3.2026.11.24.03.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 03:37:49 -0800 (PST)
Message-ID: <6b05770d.716f5c2f.2f2874.c68b@mx.google.com>
Date: Tue, 24 Nov 2026 03:37:49 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4301895977905574342=="
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
Subject: RE: [BlueZ] iso-tester: Accept ETIMEDOUT for Connection Failed to be Established
In-Reply-To: <20261124083322.1032061-1-simon.mikuda@streamunlimited.com>
References: <20261124083322.1032061-1-simon.mikuda@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4301895977905574342==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1220514/

---Test result---

Test Summary:
CheckPatch                    PASS      0.49 seconds
GitLint                       PASS      0.33 seconds
BuildEll                      PASS      20.51 seconds
BluezMake                     PASS      313.32 seconds
CheckSmatch                   PASS      320.38 seconds
bluezmakeextell               PASS      100.61 seconds
TestFunctional                FAIL      1270.12 seconds
IncrementalBuild              PASS      314.72 seconds
ScanBuild                     PASS      1200.35 seconds

Details
##############################
Test: TestFunctional - FAIL
Desc: Run test-functional
Output:
FAIL functional.test_bap::test_bass_past_earbuds_transport_acquire[hosts11-vm3]: AssertionError: Failed to acquire: org.bluez.Error.Failed


https://github.com/bluez/bluez/pull/2893

---
Regards,
Linux Bluetooth


--===============4301895977905574342==--
