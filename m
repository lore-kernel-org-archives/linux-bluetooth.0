Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794005450;
	b=Uj/F16CCtKrxJ43mgRSn1Bjiqn4aWh0J6lBiB70Ujxi73ffin2Gq95/dkEO5g9M3YDtl
	 ZfzMjkou2+r+XkBBd7dTTMf3N7VDFe0lx2Hw8zuiQIa6RJmBzQudXWIIKOGnYIkpzdCQF
	 anJ2AheeNuOXmYOUZkRfO7TeULP8Q76nyeB4/HPPqePVIkjtwHEa7uJv5K7aNp9Qk0Wim
	 KRT2/9XZ7aORCUihqngKMr7V/Xe1n0DiGRAZpGz8GzfilEa+vRmvLqNzjylt3Rsv2DUKP
	 j+rS8e5m5nO24q1tENcbutm/t2fd2N0R+IXcZTUI/OI1z1JFhu7/OrxmA0ja7bw9/ZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794005450;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=JBR0e7ta9x61GfGV45Wp8xDDnnWwz7lwmqKgHmDn+uo=;
	b=CvCUYFFMrm0Vzs5TP/qIo2ZoeaDM9vT69tNciAOJkH0W4x0cttpYmovovoMJ7ync6Aw1
	 myhezQ2Vhs6OryivEv/bLafuxCePVbyRQplRNe8yUfjPr+s3bAbEu+1kVSLtf5Zl/OACI
	 K9GwJNUYbCNoGekq7n8QtlNZupk+VwoO3ZKfdpR3XTCJUM2tjZr4ZJ3GpK3+/r5N2Phdf
	 STZDMnKUOs9DFQGVTMnLilDubAuzGUvziZXaAigdSFjc6Ol59DAxVucAQiAYYIQEF9gMP
	 qgdBqBjWXts3JIHPLm1RdE5vZ4CaI8sqovswMWTXtBmK6srDlFk/MCK590cPrnPcLvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nk0rPcSJ;
	arc=none smtp.remote-ip=209.85.219.43
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BE4606A326
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Nov 2026 22:50:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56BE4606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nk0rPcSJ
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-91e7af9a67fso8170716d6.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Nov 2026 14:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794005449; x=1794610249; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=JBR0e7ta9x61GfGV45Wp8xDDnnWwz7lwmqKgHmDn+uo=;
        b=nk0rPcSJVKy1p6HHOIuEMpP+oWSlwOwTXlItidyauARba4fzz4HGx+35YFe+hdLD1a
         r7Ul7CBf+25qFrLEBgnL7Z6kopq32sG9YwtDlqMBhUq/rMt5Z9Dg0dhRVqOnWtxdgvqA
         XeBw2bpcd9JDDDo9Taxid4QeqpCbu7nu5G8YAWREZPHvwbSljlOTsfNCZvevJeuOjfk5
         XsCbzr+LJ35mR64lD5YBS7NgB+OLirh3LQXZuqUIHGZgHt57XRKP4EdudPpG6P5n/WTy
         hfTGGU2xwylbT2UWpMPFICMSYY+6V5g+B8dgrSfKfrr1hofKZGCo2wEQX9RTvaUSyj7i
         oIww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794005449; x=1794610249;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JBR0e7ta9x61GfGV45Wp8xDDnnWwz7lwmqKgHmDn+uo=;
        b=CX9EfI0lLcJF3RQNlrnx2T6cG2OJamzrAhS4Gf/l/gMNshrKDcFAD1d/W8cKM9tQEh
         j3mXoVN6drCSyJKcX45Js7Wk8H9Xd7kYOGB7ilF+o/qlj4MMe0yRJBz3DfnRbg+VF1Ei
         5w1Nnz5gP0YIwjlPsBz9Kd/CD8s4MNtrdTDxmB9wzxReuV1YH3TTDewc/ZeTm4Arja3z
         NAIUxvC38b5X9cgPJJ2nefBIPDTPGOPHqw0Hjz+wEO1/K/eUnanvX7eAa3zDmKXnp4Qd
         NjzFDatdNY5fbqLkl2YnyAC/FDeQ/Ss+/TqqHWyhszFzjs44qZw7ZCt2gSsWGDc0B82z
         yzyQ==
X-Gm-Message-State: APuU4Z+wR/ww+PPCUaiRrSPErG1L1DbcBb8eN/oksPjWlapZ7toTR5ns
	K3+tA9l1NQkZOz5XO8CQnBC+YWUdk+zjM0llNtvY5N0ehxoI5Rbf/cpNMQbCTw==
X-Gm-Gg: AYBFou0Uao0kT/HKtR1eW4fYX6P9Noku+wWz7uAFhTWys7abyaJubHIhRiG+Ny3VNgL
	E5bjWLY+Cgo84/tkE9BO9cNBUCcuwD6fbed9S8JWgnChbJnG7I3+zRF5B8vlgZX6M+svm7F+2/s
	w66iPyYFpdtl3qIAYTdlCANCUX4jaa4u+vz7V3cZwqAeB1OPRYaYGzvMjztRAy9hMIWqZCjXjHx
	EyoNcW6cS/XaOzcQas9x/fCp1fLQCXgND1zMM0rPeevwrd6jzhLe0FfJ9rL4GSXxT0dTqFODp7w
	e/wY25IxAmKhyfwf/Rpw90LsC9b9tcC4ondBFjnXlIRMaqg8SjC8CRnOV4oXY9dA2yWrb7MFmXp
	ajuk8qGLl1ii2aFQW+WlPXpIDHLwr7rs90oIRFWOn1e9uVZfRR8Jozr9+QniZqYw8zBqqXTkbaa
	neRbJDj0vnq3CSfZc1Cda7gPsoSpm1i4KUzICgZBeMMtcp4JIMwGUMHeKeTm5KYoNi9VCWaeI12
	+tpDlEyvMXs9l+8Vx/c63p7mg1Ooms1dpHxOqTGgT/7kbBnW8KMeadNrzp3OTw=
X-Received: by 2002:a05:6214:212b:b0:91e:9642:5c3f with SMTP id 6a1803df08f44-91ea9742da9mr58952186d6.13.1794005449179;
        Fri, 06 Nov 2026 14:50:49 -0800 (PST)
Received: from [172.17.0.2] ([20.102.95.181])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ea6a2c110sm30641496d6.7.2026.11.06.14.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 14:50:48 -0800 (PST)
Message-ID: <6aee59c8.714d0f95.45a9a.5649@mx.google.com>
Date: Fri, 06 Nov 2026 14:50:48 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4230390967885313870=="
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
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Bluetooth: Add support for HDT and EKS
In-Reply-To: <20261106181745.3134593-2-luiz.dentz@gmail.com>
References: <20261106181745.3134593-2-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4230390967885313870==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1204429/

---Test result---

Test Summary:
CheckPatch                    PASS      12.99 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      1.93 seconds
SubjectPrefix                 PASS      0.74 seconds
BuildKernel                   PASS      23.90 seconds
CheckAllWarning               PASS      27.96 seconds
CheckSparse                   WARNING   32.03 seconds
BuildKernel32                 PASS      23.86 seconds
CheckKernelLLVM               PASS      24.84 seconds
TestRunnerSetup               PASS      553.02 seconds
TestRunner_l2cap-tester       PASS      13.23 seconds
TestRunner_iso-tester         PASS      9.68 seconds
TestRunner_bnep-tester        PASS      2.99 seconds
TestRunner_mgmt-tester        PASS      84.05 seconds
TestRunner_rfcomm-tester      PASS      4.14 seconds
TestRunner_sco-tester         PASS      5.19 seconds
TestRunner_ioctl-tester       PASS      4.34 seconds
TestRunner_mesh-tester        PASS      5.19 seconds
TestRunner_smp-tester         PASS      4.06 seconds
TestRunner_userchan-tester    PASS      2.96 seconds
TestRunner_6lowpan-tester     PASS      12.60 seconds
IncrementalBuild              PASS      106.40 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):


https://github.com/bluez/bluetooth-next/pull/1081

---
Regards,
Linux Bluetooth


--===============4230390967885313870==--
