Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091DA542EE3
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 20:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791922880; cv=none; b=M8hyazS7O3YQczbhsw7OEojYEqi5ZdIOzvdzsIwAsOOswSh8ilBrs7r1Y9NZ/+g5NWvbgX5tY4XjwVcZNX0C6gLAK71xV51RMFoA6GgLatsxZXkrtfuNNJpMsos0s6KWaoGsEGSeEggGGOJu26QpdyobXHmoX3ZKx628t/UDi9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791922880; c=relaxed/simple;
	bh=rvQrISBPvpIy5WvGGH/9iD10r6FG7x9Q/MgpYudqYWM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=IL/45ADtAb6a6q/V4EbzJ68qHBD0Aii/zI5/2CsDT2ZVzsHZ0ZSCatWCfSQ1uULUEFXkGtoOMqHu/gt5aV3uyjvYtYL05I8VYcGBNaQXWD29XqJlEYHnc/T0ji+E+NuPn7aMhohlRYDJnT2Ao4M+EG7PH44G9W0woef5bnIY1Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W/Ij+EDE; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/Ij+EDE"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-8258ac98bc2so191015a34.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 13:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791922876; x=1792527676; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4MuqEHkZ15TOYkw3wlpPgDwcZrz4l+ck1aFVQmAFLqw=;
        b=W/Ij+EDE/eYhPNWfXw/oiBvH4piaArvdB+datov4mpEaaxgW6f8XJsFGZWfvcci1ri
         d2qGcONbm6Y9LWvQ/ffI+shbEul1MTJCM2aEkESiUSaKIN7kKlXVjclyt9Uc3mxkWW4L
         CY9J/JPieSYz97lEN4M26JvKNIoWBvwx7b3Z9yrXkOCg4/q+zdDh2EV6fC1BWi//NjS+
         hLcX6lnRfZYl57+bkFpLQI01uBS/dld3x0QOFzpcfxV9FYftLy/lBL43UwyC/Tef9cb0
         I2Yj9hGVVVi6kjj6NFtXalw6wztkPvZBNOOfHmKSmiwcPiyhPlxU0jjKezbwZqgeB5qz
         Fl3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791922876; x=1792527676;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4MuqEHkZ15TOYkw3wlpPgDwcZrz4l+ck1aFVQmAFLqw=;
        b=GLDkWmsvJIQOwpCeJ3Xr6o0m1jXpht0duKvuaKC5E83ygO38NqeMZmORUr/Tsg/6f+
         AcWaJFpxNToPfxvYXnk9wwmf/Q4yE5JohEj855q+NA3SCtxDkMr+I23iqIqWzOURyspM
         YEdJjFgTW+L5nw3spupFtLhGGysJP1Bxhnucvsa3FvD0NfzIShhTgrnV+/yQbsnwa+a8
         /84+gFvx7t0DVZViN1ZO9IV2Q0NUZtceNGuJk2pZQtSd/I5nj28a3ldkn90sixViZzv6
         lQgJrFDbcaLxHVOPdftqUXmiyyQ9af2SPBK/WeDwV/Dts5vKVp4sv3h9+M4uqBC4YTAn
         TIeQ==
X-Gm-Message-State: AFq9FYKczm+Kb/ckyRqKu8kiwiJgxYXHd3L4rlFetC4Lr6MeAuLJ3VRs
	vjqBdN6cCb30H9DuBIdYiLe8I9JodHdTL56JP2CdEGEy3dbnf3dhbpa1mMuqzQ==
X-Gm-Gg: AYBFou0WXbjTQUleNzIqAJHEMP47ypXDX4g4jaBBTId0SGU8g+bEnArXjwQXoTyv+lZ
	v07INs52QfevgfTE5Ek0FBv0v0z59ZsLdvp9gVMxIRl/zDj2N2eepzg5wOoXNZFt11r0htkNzry
	oQgZDH7HWq6QOIawqHXpBXa5AeBsgghMBIBFP2VWQjX0aJqiwkwhdQzp412jYZQKcmaeqhviT+l
	poCKbpFRDiPUaSr4QT4W6bcz4feXgZrtgZdZnVDBrCihltfZuvEfa69zYSXpn0C81yId/US7w05
	7Y8AVavab7GO55KYHlPs88NM+edWXZyBs5+HV9hH/zKIqq2m13jIbI+Rhv0fLmGOsVM8/elW9vI
	jLY+vUJEzwqAY5FVeB9ctu77IHZCL3un/MULdYH/KSOZXNQ+FOc5bDezzrc5V0WbuWUua3Dm0Kb
	uW1V+ETtcKToCukiFcpVN/ptdAPhzh7SceF+dO2WbixB7Ooyl0vyIzjv84qBa4dcbzB9d3AQ5yG
	1VbZQs=
X-Received: by 2002:a05:6830:82e3:b0:826:1ccc:8bb9 with SMTP id 46e09a7af769-830946a18a8mr11957565a34.6.1791922876523;
        Tue, 13 Oct 2026 13:21:16 -0700 (PDT)
Received: from [172.17.0.2] ([128.203.190.88])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-83c9bcddac7sm924611a34.13.2026.10.13.13.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 13:20:46 -0700 (PDT)
Message-ID: <6ace929e.7096dace.37bd42.7f83@mx.google.com>
Date: Tue, 13 Oct 2026 13:20:46 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5690977963184071102=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zzzccc427@gmail.com
Subject: RE: Bluetooth: hci_sync: Drain LE timeouts before disconnecting
In-Reply-To: <pm-bluetooth-objects-candidate-0087-v9-625f001f92d657dbf938@gmail.com>
References: <pm-bluetooth-objects-candidate-0087-v9-625f001f92d657dbf938@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5690977963184071102==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1184935/

---Test result---

Test Summary:
CheckPatch                    PASS      0.67 seconds
VerifyFixes                   PASS      9.42 seconds
VerifySignedoff               PASS      2.61 seconds
GitLint                       PASS      0.80 seconds
SubjectPrefix                 PASS      0.20 seconds
BuildKernel                   PASS      29.46 seconds
CheckAllWarning               PASS      33.59 seconds
CheckSparse                   PASS      36.17 seconds
BuildKernel32                 PASS      29.23 seconds
CheckKernelLLVM               PASS      35.23 seconds
TestRunnerSetup               PASS      700.74 seconds
TestRunner_l2cap-tester       PASS      12.59 seconds
TestRunner_iso-tester         PASS      11.22 seconds
TestRunner_bnep-tester        PASS      3.10 seconds
TestRunner_mgmt-tester        FAIL      89.64 seconds
TestRunner_rfcomm-tester      PASS      4.44 seconds
TestRunner_sco-tester         PASS      5.58 seconds
TestRunner_ioctl-tester       PASS      4.63 seconds
TestRunner_mesh-tester        PASS      5.48 seconds
TestRunner_smp-tester         PASS      4.31 seconds
TestRunner_userchan-tester    PASS      3.17 seconds
TestRunner_6lowpan-tester     PASS      4.39 seconds
IncrementalBuild              PASS      27.86 seconds

Details
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 508, Passed: 507 (99.8%), Failed: 1, Not Run: 0

Failed Test Cases
Pairing Acceptor - SMP over BR/EDR 2                 Timed out    2.289 seconds


https://github.com/bluez/bluetooth-next/pull/923

---
Regards,
Linux Bluetooth


--===============5690977963184071102==--
