Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD06B1C8FB5
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 Nov 2024 21:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732570319; cv=none; b=F6GwDD2VXdTZqsg03vIqn1vF9P/L1qj3wh0CUjoHFHOjFUJIy+QOwqpaEtWeptOikDIMv0za0O/qAxJrFWUX15UTI699F1KqoEgAAgGZvCK1TMsCgapWkWtevDoMPUM2R0UYx10Gld3h44bsoLj0dW6pGz05Yt2vvweHdv8fwTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732570319; c=relaxed/simple;
	bh=fYE7qpZMVxPWstr9KQanKvf5lhee2eUun9r4bdJ5VaE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=eJqHb7FAVOl/+WgNFNseaRi+9V5su6ybpwNeNwWCzKoNjsJL2bF3KmVdp7mmH+n/1iYX0be+9h9pfl+NDq4fUiI0OqI3RTZvGFKq3Aa8mEpVnMkQ+f1IL0oA/rK7OGeHZCKjV5knmF4JA90GoJ7690eo0BVsjbvQtl4Agoxnsnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zqtoz+4V; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zqtoz+4V"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7ee11ff7210so3778294a12.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Nov 2024 13:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732570317; x=1733175117; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mvYEEyHXcm1Il8K4alNEqOazZYbx2r0TlM1Jqf4b/bw=;
        b=Zqtoz+4VxPpSFt1BvkbMEzLTFt6uusXQcqC19pJNlxiRvoH8rb1Ti8DnIZUP1KxvcX
         naXH0P2wnwmQ7U0oeWzkAQkZ/nuU8R9ceYvr+cjGCXv0gN4I+8GM2HlzUS5+Jk3jCGGD
         NDHM2mfUv88lv+o2ghzUW3YSg5vrNo+4JvOkGRdDh5boh+wIzg0RG9/u925szxhyUwbK
         zGUeaWO4FQWBYcA0tpqPqtJxh/LwLlhJSc0ZUWhg8ijLLSyo4frvb1l1k7Qp555gvXVW
         tpLyl04vNFOLf+nKdqSMLQ7wk3UWYjwQcBQXek/+K/vFVxrFc58gMxyJvlFX/XTk3fW/
         AmiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732570317; x=1733175117;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mvYEEyHXcm1Il8K4alNEqOazZYbx2r0TlM1Jqf4b/bw=;
        b=UZrWNWqzcCy6cI6R5ReVRi1ihtnG8ir4zYNbry2Deb+0/GALVANa/rfnkT+4zex2vA
         TeWfhTPhVxut7J6DJSR2tVhwBeyVxPXrw+X6HAlqGjkqYZjvY7fpYP1RJtu18kR4Pgbi
         NGPL1qRem8DN9+a/JyAGFBhHBzk78kOairfp2D9Z/rL9km+EkEz5FuNfq/lDe1Q0s5Nx
         eKtk7OPeRe/uJBPBs/6OoVVzNNOp7zliF6h4IxQa7y5GzXqV4B3MUUhBRoDKjkDKdLmb
         XBEyrFD6zLTJlioNYJ7w4mjz9MOBtd/if+jxfbe//A2fH0KAZGJA4dW4t5dxUbcUu1/d
         010w==
X-Gm-Message-State: AOJu0Yz2XRyeOOPfRKoAnBNxZ4AnyCbVsq1A9oSflqWLg/nXtt2k1+u8
	WldTJWqlahxTpd2OXr1Fllbze69zlqcKT+7BHzmTF3UEtSVM3SnPehnW1A==
X-Gm-Gg: ASbGncsXdJIbG0VNGkAUWJL/vNpB+KSNFw/2V30+8a0KvHBBgIyEB+CDL3xjjr+c5G3
	vDa8QLJMXaSETpYNpG47LovODmJi+cSQfJvRWkYPVpBo9S4Ef4VLUAF1mP5wvtKJc4odyc7/WRJ
	BWSG02H83fph0xoZK7GcQPstfbvSLkqkCxy1/h0XJh1Z2nhgA9UC+rEkX+DBk4vatcBFcvLN2QP
	keX7csGE4ENQCdYlbJItXqK9kGd6Ebp2A0ax8x1OwcRzsKfZDDT1qUv
X-Google-Smtp-Source: AGHT+IHhC2JQXFxAlK/U8h7TEFdPrSe3dGjPUvHZWpAmBbh82iz8cvZozOh/ZDXpT8B2brRsW8Mr+w==
X-Received: by 2002:a05:6a20:d8b:b0:1e0:c1d5:f3ac with SMTP id adf61e73a8af0-1e0c1d5f429mr10778446637.32.1732570316581;
        Mon, 25 Nov 2024 13:31:56 -0800 (PST)
Received: from [172.17.0.2] ([13.88.170.233])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fbcc3de284sm7176671a12.55.2024.11.25.13.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 13:31:56 -0800 (PST)
Message-ID: <6744eccc.630a0220.295132.1a0c@mx.google.com>
Date: Mon, 25 Nov 2024 13:31:56 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8785749758906718222=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1,1/3] Bluetooth: hci_sync: Fix not setting Random Address when required
In-Reply-To: <20241125204211.716883-1-luiz.dentz@gmail.com>
References: <20241125204211.716883-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8785749758906718222==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=912340

---Test result---

Test Summary:
CheckPatch                    PENDING   0.39 seconds
GitLint                       PENDING   0.29 seconds
SubjectPrefix                 PASS      0.18 seconds
BuildKernel                   PASS      25.82 seconds
CheckAllWarning               PASS      27.63 seconds
CheckSparse                   PASS      31.88 seconds
BuildKernel32                 PASS      25.48 seconds
TestRunnerSetup               PASS      440.95 seconds
TestRunner_l2cap-tester       PASS      20.45 seconds
TestRunner_iso-tester         FAIL      31.29 seconds
TestRunner_bnep-tester        PASS      8.00 seconds
TestRunner_mgmt-tester        FAIL      124.13 seconds
TestRunner_rfcomm-tester      PASS      7.55 seconds
TestRunner_sco-tester         PASS      11.38 seconds
TestRunner_ioctl-tester       PASS      8.62 seconds
TestRunner_mesh-tester        PASS      6.10 seconds
TestRunner_smp-tester         PASS      6.93 seconds
TestRunner_userchan-tester    PASS      4.96 seconds
IncrementalBuild              PENDING   0.68 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
Total: 124, Passed: 120 (96.8%), Failed: 0, Not Run: 4
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 461 (93.7%), Failed: 3, Not Run: 28

Failed Test Cases
Get Device Flags - Success                           Failed       0.116 seconds
Set Device Flags - Success                           Failed       0.103 seconds
Read Exp Feature - Success                           Failed       0.084 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8785749758906718222==--
