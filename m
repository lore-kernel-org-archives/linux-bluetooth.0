Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE95839CD00
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Sep 2026 23:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788566214; cv=none; b=aSbBsqOTuwcdTHafj6bkNpTHVHhOX7+IgHD0ypR6VWR0wLOpgsNz/Zk+Zk5WCrsw7eswXWoAhHzKwZZfKA488Z3WqBySTsSqcRHkGPG3KaRZxhNTMe3KEfApszuYJW8LzCIn+NSLsDNeKjPEaHu/20FXiYiKCYSWOwEjcoV0N9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788566214; c=relaxed/simple;
	bh=U1B1NhrRBlZ2Kva9glRqzXaAdFuQ4vtL09kR/ZeisAM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=j++qU1W6rbP3QdAVI6XkC7+n0sJTRhcP93IXXTP0ZbOSi8UhXHKqYiluRK1Lsp5Z+k61Uy4j2H+UG9eMlihytQp8B0fsGKBfcPq8lVpTOjDSD2LDrkzNkUyPsdogxZAx8Gtx6ii35x/tvBGyL2RyUtCCt2M35QW9vhxJRb9eh0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LT9CdmDt; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LT9CdmDt"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-4a483a552efso783604b6e.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Sep 2026 16:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788566212; x=1789171012; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5Up3kemmGb02ixFDgsO0683FakJ5o1iR8DW7t+qHz4E=;
        b=LT9CdmDtTPn98/YToR9FRQ0z2sKhy63gr2lSh4dU+a1bbpsbEUHkKc/gU76mW/d8u+
         J/3gBYMu3FtAIuIZZl+d87jbKRNAN19H0MCP25xxCClnWOsQnC3H5bB/zR9Szip9AzMB
         eWvwGiBpXv5tgwPh4QZ0NWvkb5mU38nFuPmfmf5XWPKLc1Dk5aTXaabb3gqbJ1NJtHJD
         e5re06RTq+eGgiVxW28v+ZtJb+x+8YCKVRu90mvT07bbrK7g9pLdcXcMCW3xPc+uBB0Q
         HXvIuKQQu2yG4fRtzDydoj0Ce96c6n4iYWFD3K5L3Vjl9qFlkZeWOqXxz8PpYaO7SCos
         e9fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788566212; x=1789171012;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5Up3kemmGb02ixFDgsO0683FakJ5o1iR8DW7t+qHz4E=;
        b=lQmDQCljged/Lezb/fLgqyIZUZWoZxK01iYRFGtr83Tm5PpDlXA2kok9nqT8Y0/p0K
         OjfAYiV19za2quCa/bQSyO2kKMGgYYLEH/9FhmXbH0Porjgks+99BfPsUvZjzL+9XEae
         Ha3qQbDcrKIOgxDuBtxqOT5xyXoId8EB+kQFMpKsBgJ90G04iNfmAuhnnWRUiI4cRq21
         +3dj0vtbB5gFQIOk9ei3IhPq+aPQGPddGpDoNSy7ebNAfnknFNf+dIzAV87NQtFClzSn
         TQqXz0PP/Ut00eE1XqGopmT9QlbSULQ30Tb8hn3T2XG3320uyHEO8PgGFMhherkdy8LE
         8I+A==
X-Gm-Message-State: AFuF++loC2xtFIZOjnqx4gy3LRc+8gmj903bo3EmBO8iNxAmUdzkuMKT
	aee/nHVs4mZUJ73uV077S8W9xps/CQTMu8ICJhfNG691kCKzqEgKproEzqx8Sg==
X-Gm-Gg: AYBFou0wB4J+Boi4bsmdAcZQuPmaqi3GfoEyFaWb+1i644dEsy0BQZ+7EBoQ6QRpcNh
	W4t+B3jl3w5IgjM5otf1dgYSj2TPCd1bGI843ZiPkpsOVDIKr6Y3thhSNz99bEmnReaasUF15dW
	fw+mRlG01/4MrsiMv9W9ik9Nql5VmFkiC93zj7ygKIVOBcJ/xGMprF1JqCnbVymFZoSGsy/DaDZ
	3nkhHcLa1AMQia7LuNnZp75HkYpkaNhn6ATTDOmdAvfTsVWBtcW+ZjRVWDJptJLKPjQcdvho3D4
	u1pzr978j6HTowM1BYXIItN/wrAP5hGNIcCRHMWwHmp78+uJDb0edvYf2Shj8KiojNkndANlUDP
	1iYwXDMAUFqyPW/FLqpeOjZVyEDq44w3/6zQYQlCBWsXqRAbUISGghhUuZNiz5fPkkdY6HiNgxi
	jHG0dQrazxEPVueH/HXSb0paxdepySjDpgKa86guJBk8HNCk7uiasNvIf8P319+tFxhpYgLJrZW
	Hcfzw==
X-Received: by 2002:a05:6808:f06:b0:4a4:c12:49d9 with SMTP id 5614622812f47-4b964523f8fmr6903512b6e.3.1788566211665;
        Fri, 04 Sep 2026 16:56:51 -0700 (PDT)
Received: from [172.17.0.2] ([20.98.142.52])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b970d1cf26sm3963997b6e.4.2026.09.04.16.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 16:56:51 -0700 (PDT)
Message-ID: <6a9b5ac3.9911d07a.2de7df.3fc4@mx.google.com>
Date: Fri, 04 Sep 2026 16:56:51 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3424605589827078746=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, johann.fischer@nordicsemi.no
Subject: RE: Bluetooth: btusb: do not probe non-HCI interfaces
In-Reply-To: <20260905-btusb-skip-non-hci-ifaces-v1-1-32dda494122f@nordicsemi.no>
References: <20260905-btusb-skip-non-hci-ifaces-v1-1-32dda494122f@nordicsemi.no>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3424605589827078746==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1158397

---Test result---

Test Summary:
CheckPatch                    PASS      0.57 seconds
VerifyFixes                   PASS      0.11 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       FAIL      0.26 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      22.46 seconds
CheckAllWarning               PASS      24.88 seconds
CheckSparse                   PASS      25.86 seconds
BuildKernel32                 PASS      21.71 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      396.34 seconds
IncrementalBuild              PASS      21.55 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: btusb: do not probe non-HCI interfaces

21: B2 Line has trailing whitespace: "--  "
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/707

---
Regards,
Linux Bluetooth


--===============3424605589827078746==--
