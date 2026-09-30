Received: from mail-oo2-f36.google.com (mail-oo2-f36.google.com [74.125.231.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0F3353A71
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Sep 2026 13:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790776159; cv=none; b=nSQs/7dshbpZ93etk7hhactDhvmOKhNsrIrtoj41M6C8UDbAiMovdEVhaka6K0vfZxX0ZykMew9aQz//azIufeotl63Mob95yKBabW6rTX40V8WcIYbo9rqDLjhWpt9MWsTPulVyzV34SfCYbT5f5wOpcmZXK1glfG2YE46J7vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790776159; c=relaxed/simple;
	bh=IhgVx769g+Mnmr0uOEio18xC99aCwm0n9g6LH8FJSbM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=p73i48iylJ7mHmIK+wj6ac3fHVVtEqdC0ruuzPGjHESLmovR/GZzT7qpFsIIqD8vZD4yieyqClaLUqUw/duuB1NNOZiuaZr1BZyyeRC1jhFnzXCsCMaYRQK+zD6WIWq6PbYMbW3wOivGEOCsz5vM9/IIXKuvyhP+2dt8vRXEpek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fyeCpjG3; arc=none smtp.client-ip=74.125.231.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fyeCpjG3"
Received: by mail-oo2-f36.google.com with SMTP id 006d021491bc7-6dd0088ec00so165258eaf.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Sep 2026 06:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790776146; x=1791380946; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=uWb3NiD8T9ysZixQ0GQgC1Z6yCuB+vPPFMdXTTKm8bw=;
        b=fyeCpjG3AHIG512eGkJmAamiHO7aFonR8jrkDfxnt7IULUu5Gz8oGYU+kXy+nTcgYH
         /YLqABLHjq7bZEuZ8KLtamQt6ctTmo7/E27EhkafTZ+kbmGaax6iCdF4dWuMjK7drm6a
         LGz56FZM7tvTJp70RSf9PkclOpEI7/EAN7EQ03/LB18WvehstSLYJ2sknVp7b5Ywx7t8
         WU3LtU3IkJW8wK+cAn7Zui91MNVjvH/6IiEClqPzd+0YzA22JqpUpg2QgZLesri0sS2V
         j5Ja7ilzAhyMyyUPvtqNf5hGj0o4q18MlxFdgjyAW2efSv7vubWKXXEszWROnOpDgKjB
         veAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790776146; x=1791380946;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uWb3NiD8T9ysZixQ0GQgC1Z6yCuB+vPPFMdXTTKm8bw=;
        b=InvlKi57R4dMr1SwLyvX51jyzJIPvpQeAjWytSBNMJyIKNfrQfuQ9fObmOJx2RSN2I
         37Yu1HCBMHwyp4vGq8MpL0RyW+I29r3+cLbSJh4K7lZF9nCbageC9hKS6qUQtljHEyhK
         ku5nLKtliqjKCxv4aDD4pZ6lF3lyg+khYRaC5r1Svpnc+w27bkaLSIhKGBx9wz60rMxt
         jNkUPx3JE+FMPBg/PIRv0GPWUF6PNNtZp3JO9BWWwHJtEX+x0fuiCgs02G7VS5isEjQZ
         pJ4OcLVE/CmX4/QKb/fuKbHhHi7AKHk9exJLQuVtahdMqs2W4xF5oA4ZC1G0vM/TAvGZ
         dmMQ==
X-Gm-Message-State: AFuF++mOlGoi5q3yBvK29l4f4N72VCAbrv4tvdEFnOaUWncQcuBpEp33
	W6pIRAnGr+umM5u39aIH7rjVPio1337N5JfC3NfjdmfqcDk1U4Lbd/d4btgu7n4G
X-Gm-Gg: AYBFou3f4nzXM7dF3bWwkBYcG2JCAZYQWEjkkf++1wpUNHTSMhdI/y0FawcoaxjozY2
	EaqDcdK03BD0w7aFC2xNXhXV2cifEPIGwt/lI8YZ9CGwJnXNz64jPQcfc6HOGSCSNwNTcHosjHt
	uOk5fUO7TgAMsN9k1/uXu5pvFO51XWbYEjfiTpENJPtJuoTvkIlm+JbIY4q1RURhviL7RvA/BO5
	IhJV5JRN3EHIHR4QOK6k3A9IBYsGuolGh/Snexa+WVF4bvRV55gKfsLgTk9P4ZWCYC5r0tKpxLw
	UHgz8hEanyODtGRD6dZ0xFJPczAJRQo7WtrcPSDKyhTvFe4cYHbQvnyp65CkSwOZl53DKxQxlqH
	ReueCNZ1U31mTH+6sL2ldiWKQRJzd0FirARFOT5oCVwINg8+UatA337yEfH38Bc/cOo+zNrzgH8
	1z18yYomJjzbC/NKM35BqZFkrIabMUwmpQbZg+iI+FCNUX4+bsG/n6QLByGBsWCZD8sMZJf9ID5
	OQUcc0=
X-Received: by 2002:a4a:e84c:0:b0:6c7:af50:b2e4 with SMTP id 006d021491bc7-6dcf1ea9608mr1301830eaf.13.1790776146230;
        Wed, 30 Sep 2026 06:49:06 -0700 (PDT)
Received: from [172.17.0.2] ([52.173.124.198])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6dd92361b67sm119090eaf.0.2026.09.30.06.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 06:49:05 -0700 (PDT)
Message-ID: <6abd1351.870d8f20.84d27.a235@mx.google.com>
Date: Wed, 30 Sep 2026 06:49:05 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6846745626837678336=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [v6] Bluetooth: MGMT: Add management security level changed event
In-Reply-To: <20260930095147.554276-1-frederic.danis@collabora.com>
References: <20260930095147.554276-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6846745626837678336==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1176737/

---Test result---

Test Summary:
CheckPatch                    PASS      56.36 seconds
VerifyFixes                   PASS      9.07 seconds
VerifySignedoff               PASS      0.68 seconds
GitLint                       PASS      0.29 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      19.64 seconds
CheckAllWarning               PASS      23.17 seconds
CheckSparse                   WARNING   25.21 seconds
BuildKernel32                 PASS      20.11 seconds
CheckKernelLLVM               PASS      21.92 seconds
TestRunnerSetup               PASS      468.52 seconds
TestRunner_l2cap-tester       PASS      12.86 seconds
TestRunner_iso-tester         PASS      8.36 seconds
TestRunner_bnep-tester        PASS      2.75 seconds
TestRunner_mgmt-tester        PASS      53.58 seconds
TestRunner_rfcomm-tester      PASS      4.03 seconds
TestRunner_sco-tester         PASS      4.86 seconds
TestRunner_ioctl-tester       PASS      7.01 seconds
TestRunner_mesh-tester        FAIL      7.65 seconds
TestRunner_smp-tester         PASS      3.88 seconds
TestRunner_userchan-tester    PASS      2.72 seconds
TestRunner_6lowpan-tester     PASS      3.90 seconds
IncrementalBuild              PASS      16.96 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.747 seconds
Mesh - Send cancel - 2                               Timed out    2.000 seconds


https://github.com/bluez/bluetooth-next/pull/845

---
Regards,
Linux Bluetooth


--===============6846745626837678336==--
