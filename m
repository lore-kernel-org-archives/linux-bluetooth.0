Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795730582;
	b=lN7afd2F/z9f9vKVe2DdvQD6YLMoaqbYcXtcJEaMWH8oQoDmnmALna7eVMyTFl/8G7pa
	 ctsVjp6+r61FLnwGw+MkJUXsdEzqkt3qN9iUH5z7WzbaDxmVW0rGKvneDCfMtaoz2Zi3a
	 KuLpBHMxQ9BIioCS4FLtcQ405GAs7d8VM3p9QlyrnZnMB2tZ6bYAoSlFVBlhEqf2sTKQJ
	 PELd+Q/zFufxSO2YjQA8ARMviVBYi5ErMIaf9/8WR3UxPaGQVpqJQlhAlzCVkFoFrymcL
	 B+8wPlCnZt+ffT+R4GRG2/LBQ7y+H9G6torZ1IsY1FMxOLKm0j9kG+HRl1obFxiIALw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795730582;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=XavCMft0vcYgImYhb6yAERna0asMo3mW1wRu2YpbaZM=;
	b=BXTMlDv8jKvbuK1Ewvs3CYKYxnZhIDqxeMxRhEKGTCHdcWnQ/iFyGIYzpnqssaJZf4pW
	 J0n4cUEa9za60yq4Z0R+n31u9hoBQ0iJvZguCpk65CvckMdFTmR897/mar8TooiIP1kgn
	 izx9SDweEWyTS8e42x9Lu7L5nLwEyCi/BBYPaO0LKBFa7SEWiEClFS2LLP9ueqARgog8N
	 zL0eUR0NgOnHV40hveDl0myAjnvX/KT6gxyYXGNGsfiDQnjgNi0MEa8ElOmUQKXGmwH78
	 iUsAd0zogm+4Ys/EX70AIkFwYX268WOC9RahGTBbnpGniP3+oXiVrbj4sIZVBniptxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rIpM4d7B;
	arc=none smtp.remote-ip=209.85.215.173
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D15606A321
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 22:03:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31D15606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rIpM4d7B
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cde5a7d7849so3249910a12.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 14:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795730581; x=1796335381; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=XavCMft0vcYgImYhb6yAERna0asMo3mW1wRu2YpbaZM=;
        b=rIpM4d7B7sTL/kiJ35V0m4pmg7oi06RkhrLTkITQBB1nKfierDaUHdeFWcumcbld2G
         9q1ZambiNywVU6MczEG/zTcxfU3F+FHpA3d6ZVLcVzxxdIwB+VuFBxCWhDjm/1hfo9ba
         82K6HLr4w/y/iZU2mGFaBXonK+5IcUMHbOg7WIQzRIua86FZcFhlKkp1+6rHQfyIQTIP
         4urBwxrW88dc3IW7oR3iUoFvjnFnKRXNf1zn81lEORwbnyMqY3vyJkg3zZB+Us430c5M
         yKt8bLqFsg4+d1EB//GqLOLzWXO2s2C8AEyKJo/uNQ1+Zl/VgsAa7rCJdAajIJgOwV7y
         VvoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795730581; x=1796335381;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XavCMft0vcYgImYhb6yAERna0asMo3mW1wRu2YpbaZM=;
        b=p0qQnRzwWCL4Li9fCojsLfoQJ/SeaN8KxbTF6OQJDg9XDnQIDLNAJlnPAEVeQ+dP4u
         LvZcWJL22M9Ub7I3XdCxK0GgvqvBj3nZksdo3+3TCp/JtG65QxDpIhe5gpcXB2b+o2sA
         SCy66Gl7N2bfUMc7cyTo/TfzrJPGSwp7Fp1KOFwHlcQE4JSJF5g8XbJFH0tpsD4umRto
         PTjPfAoAD3O0qNqBjrAhdjB3IyRjhC876M9bcLlwnq+4gOMI2jx3kyhmGdF/+Kf3FJVL
         ywK+deiUPHtED3gx5I1lFPv98MuYXXrINCraROFmzBYw8S44CylQtEZVQYXoke7QIwU2
         CVww==
X-Gm-Message-State: APuU4Z8Mz0+D0+YfDHcYcyegPtKPg9QuwCEL0CV8055XacZxtBv68PEb
	cyceGo9dCih58krMn79lOLhPVdINp4JQ7souidGLJXfSiYVYcqcf+IIiPJRIig==
X-Gm-Gg: AZFdTZfdqjiKfBGQpAKKFH8vBRUZHb+7/kyZI9tMSZM+cmScMxVCYwWJjdo7SdwRwXX
	+pKmxg+SaWyFmweV0shRAo+sAiLJ9/mIPZ0QHZFAUqRVgpSYlgLAEu8bhbMZ2LXkRI8xnvvNuqg
	W7/2++I0U7SzYuXcARSv9nCMsBS7myoai1vXUBinKHeg7Rb71iWXYsHZ2ODbzbnSV8u8M6ot4rX
	eor4I29lh4wKr+ryrsLRjThJR8Z68R25/ZIZMAqf/tpvLSHTy2Oke+MULh7+PYTpX2Y2KEaDNh5
	/cTdsYTPUZNXBW++ZQ/9LRGYEvj3wG1Eu2oJ3LX2pX5yv+V/aDR6J2ljzbbaTgzx9nW/NpPsK82
	ALX6+hT48Rz8XahJ7p08zOEok29iZ53wj1UdkPPrJgBe2ySwUpRPT0uRgkNioRgossYVnvW55BI
	ulqI8hbeZAiIZHzdUJNaMDPZ8NQm2e6Ao87E8koNMn9Ks6fvc6m8GXAztBk3aj2aSZhjdjRG2rP
	j9QVha0DlePK57SSIiBveYpWtUKz8EiG3bR4i4/Sbu1iP8HG/3xDrrDmQHTOs/qGbMNS5XNOsTw
	9oxqk0qjD80KFpyuBmUSrQrQIo2AzYYU8Mva7j0I
X-Received: by 2002:a05:6a20:2451:b0:3eb:b103:6ec0 with SMTP id adf61e73a8af0-4014d2535b0mr23137776637.14.1795730581445;
        Thu, 26 Nov 2026 14:03:01 -0800 (PST)
Received: from [172.17.0.2] (ec2-3-42-157-134.us-west-2.compute.amazonaws.com. [3.42.157.134])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdec1168866sm1738514a12.25.2026.11.26.14.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 14:03:00 -0800 (PST)
Message-ID: <6b08ac94.e68616c1.145774.92e3@mx.google.com>
Date: Thu, 26 Nov 2026 14:03:00 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4146031232945744804=="
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
To: linux-bluetooth@vger.kernel.org, me@michaelmcallister.org
Subject: RE: [v4] Bluetooth: hci_serdev: Unregister HCI before freeing the TX buffer
In-Reply-To: <179571958163.81221.18219121256319863408.hci-serdev-unregister-v4@michaelmcallister.org>
References: <179571958163.81221.18219121256319863408.hci-serdev-unregister-v4@michaelmcallister.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4146031232945744804==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1223637/

---Test result---

Test Summary:
CheckPatch                    PASS      0.38 seconds
VerifyFixes                   PASS      0.04 seconds
VerifySignedoff               PASS      0.04 seconds
GitLint                       PASS      0.15 seconds
SubjectPrefix                 PASS      0.04 seconds
BuildKernel                   PASS      20.67 seconds
CheckAllWarning               PASS      23.42 seconds
CheckSparse                   PASS      24.98 seconds
BuildKernel32                 PASS      20.57 seconds
CheckKernelLLVM               PASS      21.97 seconds
TestRunnerSetup               PASS      480.64 seconds
IncrementalBuild              PASS      19.06 seconds



https://github.com/bluez/bluetooth-next/pull/1234

---
Regards,
Linux Bluetooth


--===============4146031232945744804==--
