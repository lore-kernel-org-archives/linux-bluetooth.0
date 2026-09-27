Received: from mail-oo2-f39.google.com (mail-oo2-f39.google.com [74.125.231.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8696D3C73C1
	for <linux-bluetooth@vger.kernel.org>; Sun, 27 Sep 2026 23:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790551579; cv=none; b=B0lPH8lXkgkSPT2yOCYv8mb324bUKZWAsVWZ9cUbNArATfvSEwl97GwG8lw7juWwwZpKvPGJP6Z36B+lALK9Fx7mvYKNJUq1jtYhE0t8pmYCTOo+LWGpPMBGM6D4H1ugEZfRLrAOV5O253CVbvuzmqP/NLf1dPS3YzcidgjzCGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790551579; c=relaxed/simple;
	bh=jUjdYoYZEC4xuaKHYRTcf8F+XIL9441WwJCs5N4iBJc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=mdmLpvMWT4Nyuhs0oXVzUQxrGbDMPtbpCtB/3TUwng5z+SooBxTuwdSkoz7nACL3a4mrQZ+2NLZN4gNLyL59ZqDpTcqT4u/Zf6eXQANz5LYg+RmbshtrgGRBcsPfPZnr/u/oyydmw909tkWQluGCDdEmz4xN8o5Vg/MqX9iEUM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=snj0Fwva; arc=none smtp.client-ip=74.125.231.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="snj0Fwva"
Received: by mail-oo2-f39.google.com with SMTP id 46e09a7af769-81c4394e201so164522a34.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 27 Sep 2026 16:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790551577; x=1791156377; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=yutQM8WAjsHQWXvxv4D3WbZAE5imk5mb3iqAwAh3ZiY=;
        b=snj0FwvaNU4c+iPfVy80SzhppwXS+akN15xxXJXzeyci13APiAusRRDEuPN0OB7mez
         z0mlyoVH5JPMFcFYLxKuqIkasSlx7gUw8iVG4CKWhZ/WICZ8UMG3+BFOIbv93kDEiHSr
         p+4NbudIkFGAj0ntErCU33QsLLxfGMhbIY6OZndBi2tadVZ7Hf80oeXr1qWdYMROI01C
         0yO6wM7Yq9KG10610BPSOZbMCe6VJ2BAz3pdQWiHi4eHiyLuJ+FdyudukF8E6NWe3j/8
         rduXPkeH55bzLDokBA2WRcjTHMZfronsYggITsD5dRRrZZe8XOV/Pf0XWpp7Fr4yxvfk
         +4fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790551577; x=1791156377;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yutQM8WAjsHQWXvxv4D3WbZAE5imk5mb3iqAwAh3ZiY=;
        b=JmU8lVJ6DtV7nyA0DFKDUptQ03NWHr5IoU4JgKqfzEi0Dtb5K/825R/+IZknC0BinH
         3UzmHV1mqSknJlgIR7gP6bv5J5sQJHRKIqCI8hlbdw3wujlnMNGe8aGPkte3tgT6ddLL
         C1RJyqrZn5qUC6NqkQOtq+s3HQJLvn9IF/S7KZjc7HDN9xMAMuuDJiKFSowD1o1/IX8W
         fc/+2NIh+uHbkqV5bASHb46PEeJSP9p2XP9UT1UcTXWMRw7Li7xa1cSFwiWmvfy5AgMc
         kuhqW2sjomcqLwVC3JavVYj3GHlVPLyJW5xaUE6Z0YQdcV90wdyzXfXWC4nhM3qNMPbZ
         UOIQ==
X-Gm-Message-State: AFuF++lG2Xr7wsgdm/GtacE14rogZlh6C3ofj/dcehk0riRTqoQHzPAT
	cv+p8eaRm+wHxYE7ID5ohBr3GjB+5v62orpqRBERp+bUAFA+IPIW4zLRWjoung==
X-Gm-Gg: AYBFou31RoREA8Q5kec9d7qf+DkB8zydL06gPLrAgLUvfFUOrg+UpyYz7hfe453byu2
	U+HiCcqBkJ7G6UYu7qM8+A/pyx3bI8W5VCqPVMq4e/aYeT1CSs2064kiMg/0SAZCLajrWSgtZue
	vffG4GdKhd7++LsW4km0xevcVq75IfGor+49JET0Iwy1p0m2sWBi+f2CF2JNNTi5uh+NqynBo4i
	bZDvho//O77VeDtXGXHZvpLQpfmPQ5u+Px9r+mnlk+gxh8lpF7ZBBX8nNWYWxKKpq0adEwoTw+q
	N80E1+ppTuVF73G5IkBnA3Y/meGPpYauydtv5r/4tNKr3TeMy/6UOlsRwfUUbmWJsjZGW78rLhr
	6vY1lRqXp31Mhjt+gxlnuta7Lf7NvdIaISkbsjj+V4ORN1YB7SQF+cta3mIYrE0SiyRgHmvUcao
	LCyFPiAcDGQTBdTXnNsiitsYp3L/goZgJzoQfTRTSJFP0AcjonQ9LbeIL5RSELqqBUZftC45G5A
	4SwZAELRtXNxukR
X-Received: by 2002:a05:6820:1895:b0:6cd:3fdc:2669 with SMTP id 006d021491bc7-6d441995a33mr8180658eaf.42.1790551577328;
        Sun, 27 Sep 2026 16:26:17 -0700 (PDT)
Received: from [172.17.0.2] ([52.176.19.199])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6d88358bb8dsm3387620eaf.14.2026.09.27.16.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 16:26:16 -0700 (PDT)
Message-ID: <6ab9a618.2feceb42.13bd97.c6ee@mx.google.com>
Date: Sun, 27 Sep 2026 16:26:16 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8662796410503820852=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ngocthang2710.1999@gmail.com
Subject: RE: Bluetooth: hci_sync: don't drain cmd_sync backlog on unregister
In-Reply-To: <20260927151802.13619-1-ngocthang2710.1999@gmail.com>
References: <20260927151802.13619-1-ngocthang2710.1999@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8662796410503820852==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1174576/

---Test result---

Test Summary:
CheckPatch                    PASS      2.05 seconds
VerifyFixes                   PASS      0.11 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       PASS      0.31 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      29.19 seconds
CheckAllWarning               PASS      33.76 seconds
CheckSparse                   PASS      36.00 seconds
BuildKernel32                 PASS      28.99 seconds
CheckKernelLLVM               PASS      32.20 seconds
TestRunnerSetup               PASS      736.85 seconds
TestRunner_l2cap-tester       PASS      12.36 seconds
TestRunner_iso-tester         PASS      12.57 seconds
TestRunner_bnep-tester        PASS      3.11 seconds
TestRunner_mgmt-tester        PASS      59.93 seconds
TestRunner_rfcomm-tester      PASS      4.45 seconds
TestRunner_sco-tester         PASS      5.56 seconds
TestRunner_ioctl-tester       PASS      4.64 seconds
TestRunner_mesh-tester        FAIL      7.83 seconds
TestRunner_smp-tester         PASS      4.33 seconds
TestRunner_userchan-tester    PASS      3.19 seconds
TestRunner_6lowpan-tester     PASS      4.37 seconds
IncrementalBuild              PASS      27.11 seconds

Details
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.444 seconds
Mesh - Send cancel - 2                               Timed out    1.999 seconds


https://github.com/bluez/bluetooth-next/pull/830

---
Regards,
Linux Bluetooth


--===============8662796410503820852==--
