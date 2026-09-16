Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47173ACA46
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2026 06:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789539124; cv=none; b=XVYPniqswH9Gu3OzvTGz3U+dLsOpAVThg55g50+CHiyZ6UPuRD5EqUsgo4jQxFJyojQ1ExOBXYCMcz+2HTT9+q8I0vWM0wNu1Nzp+FN3+dXMSsdB515ROgZxhJZE08mv/jEV/yJpnhxkw5pjdgO90KV54TOH/ZRGSgZ3+68I0dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789539124; c=relaxed/simple;
	bh=+eGU0dB99k4W2+SIq83pCUXuNxwZBT7saEKZkeBnYcI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=gLtL31dl2qtHZA7tMM3R5Rp7wAC/gM9ioemrQ7e2hZEdwJj4LJZk9N/cfV4TgkZe9Px+hmVFwjC9oOJJfQGABQmg8E/RZWxumhyjDaPIrUXcoGqlkwgLYXTO8/9Q9pGvlVdFaIa/JOsaznsIYp8NAMa9YlgMgC03g3US2usVvMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RX+69dWP; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RX+69dWP"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-93a10f9a2easo149328285a.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 23:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789539121; x=1790143921; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IYNqc3PH05T2rj3C2P5gWicPLkd9McrPpBKlibTAWOo=;
        b=RX+69dWPZPycFi7KAAt/bEo51NK5h1330SnCgPE03lYzTy/jM6lcnrwHZR+vXMiRBg
         OpWDUizXuvad/XVKEpzd6haET4hm8aHxVubY4tlymn0zbof+KbrfDBUFWJh0fXWZ3oOE
         72O4NA18/ECxtY3KQ1KFlQJgF4MKPnYOdm/FQ9/UIQLNfyYiV2w6e/bbtJ35HmuCXtWv
         5Oj8GJAqEDS+SAFHLIKvhX3ci6U18oGCE8aoFz+OHreyxQDFHw/RSHhIrvuVWF95K5qD
         FzRRCWyMJdx3bR0/+kZ0gSfOzknoyi3/cr9f7vLMp3bovkV5HCty/qfSPou3uLTEnhgs
         dQWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789539121; x=1790143921;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IYNqc3PH05T2rj3C2P5gWicPLkd9McrPpBKlibTAWOo=;
        b=bjzfNRTXCQq+YgmhplPLw2e/YKckUj0WuoL7sB04yYJ7CFn6r2dnjTZ/bsToeN+kTv
         rw9F57pEgFpFEXs27rsdMo+uGr8jaoThCZHvaEGOGhTyUt9Io4nYlYQWbOIaJQJ5LWuN
         b1kiuqVFKnr7mqnJnm7rrCJX0evt8dzwpnp2huQn0cx96fsPf28aVFs5+w0wIgV/6SgE
         a77VhoLY8QKykd9eMbK4but4m9Krd7mxuxqvn+R9bK1d/TYXgQf/BJcc1kCfL+FiSSs4
         kVufSVhCnyH7aM9kRo4oz2VTSEMIX8yavduYNp3fDLXSllJufLzdneBj3RuHekJeUULA
         UUHg==
X-Gm-Message-State: AFuF++nAyZQ+QvpMFHYqJQgETRDmgX98AqVN+W1LqJkYSUILyhC3F4/P
	VoUt7p2QtluSv/Lbhiwf57k2smp2J6ICn84sr+1mJA7IAWR1XF0VjtEsO9/puA==
X-Gm-Gg: AYBFou0TmWA7BR1NqcsHmJW3Y5u/j+0MN/0i8g+otvKuvgEB+1wH6qGlQagxJNo+c7C
	4sxgcE9XM6VK52IZv4+xhMRQxo3WXP8WhuUnvn7MpFg1/CBrlfh0henFmsP+mZhoCH7gbFcfXVR
	MqlpQfTKvfYFMEBwZ4T+GjelHVTi8Tkc2riYj68Pa6CdZcLaiIMy1OgIWwiCgJU2H/8Y0m707Py
	D7bMe7Eo2pnbTv9Pgpc3c5y2qCXkrgzXpfulFNO04APnBkwzkA7HaJPHYUef671YFzdpob71kgW
	cLwMNhblvpUcEXQMqzMp9rU7lOY6+DpBQgPNPYbiahSzkGT/Ng06muPjU782OiQCQcX0VcLLjNZ
	WRLbs89nR9nO2ztOQSdyCu6LhbGYJB958mt04ZNwF3jiaxUHisXAgjJ/EUeHz65TPQzLTxJkEY0
	sIdznL0Sh4N+FCtQd80Sizj0ksXYvpkAyJeimMB4AjTFljbwD9Efg9fUsLAGQVnW1mhb0s3D33i
	UDXkvQJ
X-Received: by 2002:a05:620a:480b:b0:93a:1196:ce5 with SMTP id af79cd13be357-93a34724dabmr871219585a.33.1789539121456;
        Tue, 15 Sep 2026 23:12:01 -0700 (PDT)
Received: from [172.17.0.2] ([172.174.188.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93b81d27515sm141448285a.47.2026.09.15.23.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 23:12:00 -0700 (PDT)
Message-ID: <6aaa3330.fc1023d6.a2142.adbb@mx.google.com>
Date: Tue, 15 Sep 2026 23:12:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7063114293955181388=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, alex.zhou@oss.nxp.com
Subject: RE: [v1] MAINTAINERS: add entry for NXP wireless Bluetooth driver
In-Reply-To: <20260916020719.61981-1-alex.zhou@oss.nxp.com>
References: <20260916020719.61981-1-alex.zhou@oss.nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7063114293955181388==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1166007/

---Test result---

Test Summary:
CheckPatch                    PASS      0.69 seconds
VerifyFixes                   PASS      0.12 seconds
VerifySignedoff               PASS      0.12 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 FAIL      0.12 seconds
BuildKernel                   PASS      30.07 seconds
CheckAllWarning               PASS      33.84 seconds
CheckSparse                   PASS      36.47 seconds
BuildKernel32                 PASS      30.01 seconds
CheckKernelLLVM               PASS      35.91 seconds
TestRunnerSetup               PASS      789.12 seconds
TestRunner_l2cap-tester       PASS      16.64 seconds
TestRunner_iso-tester         PASS      45.59 seconds
TestRunner_bnep-tester        PASS      3.63 seconds
TestRunner_mgmt-tester        FAIL      61.39 seconds
TestRunner_rfcomm-tester      PASS      4.47 seconds
TestRunner_sco-tester         PASS      7.60 seconds
TestRunner_ioctl-tester       PASS      4.66 seconds
TestRunner_mesh-tester        FAIL      7.81 seconds
TestRunner_smp-tester         PASS      4.33 seconds
TestRunner_userchan-tester    PASS      3.19 seconds
TestRunner_6lowpan-tester     PASS      4.42 seconds
IncrementalBuild              PASS      27.91 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 501, Passed: 496 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.022 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.427 seconds
Mesh - Send cancel - 2                               Timed out    1.999 seconds


https://github.com/bluez/bluetooth-next/pull/779

---
Regards,
Linux Bluetooth


--===============7063114293955181388==--
