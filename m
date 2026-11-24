Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795546616;
	b=ePz/qkluEFKSNA5ai0/GXN/k062p3JA3KQE3TxnCp8zCpSlYDilafAMCpPm7inVVl/HU
	 DJ2QErMcDgUZTYU8Ephz1QJc5NxmpjWT725r6Fo6mGNQ+W0jeS4XD6K1Go14DKFsO23z4
	 qgZEUafMYyfPgk9SSV5Mg6zVIgPzRwauFTi2/KMWN6KvpV5n8EWKkczReR6hbQHIXQ+r0
	 qfqYYhM0bOtuUUvSQR8L0Y0tjTWd0W+X6qIdiHEmP7OT6Qhmi85cIItxU/ATjaohaJjMA
	 i0qwnfNTBunF/8kI+eUJqFPhHpBh+YQeY4WB0WhOiExfRQxbo6cEBjXxu0FDCZtC8pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795546616;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=s1D1FDhmUprotsheqViiwcldx9tlraKO76Div8IhRKA=;
	b=GbRxGJ6SuIuyBMpIMvNvrhgIVVjyusZ7WNWNOSW9j5gbEapkR8Dto3hGsaIzyidhk4ST
	 Dh0U3ZUyeYMlUG6hfYM/n3r7o0DEvx5MRV6GnuF6a28MK4cOSV+VeUsSNAv5vBoLfhTno
	 mDSLTmOVN3tLFqM1Xv6TbGoA4SEvNCYHAY5M7W2o4cRUYsNGV6XyR9UCLdMF2zawlLo6K
	 krsrf9gA1QUGaerqln/hoQAxzREO64Bf0EGc+WINMuO1Mty8TNEQYA+nPxpkFlUTl18Jm
	 Az70D0B5ykNwu9jlhdM9LdzAkPoubxw0IEoVfpsgtUJOmvCYiR+M3M87GFfJlio2pcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w8Z42piB;
	arc=none smtp.remote-ip=209.85.210.51
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0F9606A321
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 18:56:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B0F9606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w8Z42piB
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-843b6f8e2c7so5420179a34.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 10:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795546614; x=1796151414; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=s1D1FDhmUprotsheqViiwcldx9tlraKO76Div8IhRKA=;
        b=w8Z42piBo2sejym7T7tkRO7NfG+932V/RMogYFp6qXmDMhPVhGYaoyHmsJXa2r4ndA
         DxACpWiKdKNGu9Gx62pv1KPydDXE5aT8MtB8mincbIOj8gypDlXH2KfA1W2gxwOOcCnE
         22viHBmOScSzwgpkYmCHAtC3WEYogjHGgGEJTHZBTEHzYZWmyc5Jn+Ycq0Io33edbqOq
         wW9IKwp4Xx2TsymRAHKReweijl2Vj7/6CmlZ161P4t3tsbWWF8tAjEY/KZogei5rhLlV
         HG6NTmAtpn6zScgdI2aVWL/sk8j1x2YhOGq6g8bqAegzP2HKS6w+3afQaZEOUgHEyxsk
         ub2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795546614; x=1796151414;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=s1D1FDhmUprotsheqViiwcldx9tlraKO76Div8IhRKA=;
        b=Z7J0qvriqqPdD24SRcUKI+irOM51BmkgN62n6N9hHwy0VXLhOE9s43NNlszHyIu4Zz
         otdOqrADHMzmq/Oti+bz9nFpYdPBD6PNnTHOE391aQcCB++v0xFwFzrnjZQJ72SFZ6Lv
         g/fbmGFF2iA5Xp5Mx+ZUxoTRnZ6CxpU+Tea2bvSBNbeM84Iw19Rmz2ir75O1wzNvDBI4
         KatoV2MmBGSIneNVX1+ACM9eh7mz3eA9vd1biqNDWByjFQr5m6+f0NOYupmG8qVgrktW
         fs8rDuZ7SulIdOCMsjzNb84lJGZyC4vcPuLFlnL759xIiYexoYoTWsglPoVncBLvirSz
         ayMg==
X-Gm-Message-State: APuU4Z8IijRYm9Z9HOzAUqj+VUCiWDtMltDaEXTRXIdcEe1Toj0yI0fC
	z0wsP1tzG2lE7zVffuMG38Av7eel7mddZIKS8igLsxU/XAn257U/tUXqgMpqzQ==
X-Gm-Gg: AZFdTZdgCnEwuD8FS4TDKBa0oXivRw9vN0t6ficgBLFSFgBHBVpdhuOlE2Czrinr4hY
	4yysvIhpuEsWloRydH0P1dYaNG/Rn7TcJnglJy9byZF9izk0Y3trrJ4Ki00M/CGaMHFbhPKamv+
	MXqysE0ZvUir+KsujIbHNZgiqTJYYEJxZVQ/Gx7hO47sJfSX6+VfoUezQpMsNhvDp6DmboUiiWp
	raiJPBpZ2482QnDUK81kHYRDEf2f84ehddpT+bhF2rKhmu8uEB+vUf+CxIhjwPZPEP0eCGrzb71
	Lmh2BrC52pWtU28uW20kI0Vs54/3r7GQiq0+qFso4UJt/1ceJK4XOXloFrtEw1MOTYuVPu1C5HT
	ZLzeimSZ+b8W5pE7RdrKzTF8/9OX5Gt0pDU7YcBkLEAgKT7BkuMfV7g8fAJgbvXeOrxaq44btbq
	W6pB8zHT8J9doM2wnZnW2xacfwHBJvvEVD+g3Y6rILMJu6UMOu1T8D1lMSEZaFkKt++HRPvx4SC
	Q7aSABj4P6upuQvMkqphQ45uyc6hJrzcbyTo+aAIVYzodiv4oKWCnPK5wl71k/PYwTZpX5skarT
	3JnfCc7kNg==
X-Received: by 2002:a05:6830:4103:b0:862:7ba1:9b35 with SMTP id 46e09a7af769-8631597709bmr19215897a34.11.1795546614333;
        Tue, 24 Nov 2026 10:56:54 -0800 (PST)
Received: from [172.17.0.2] ([130.131.55.232])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-863168dd6e7sm12782726a34.12.2026.11.24.10.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 10:56:54 -0800 (PST)
Message-ID: <6b05ddf6.5293ddad.2544a6.f4c7@mx.google.com>
Date: Tue, 24 Nov 2026 10:56:54 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2182411945223137092=="
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
To: linux-bluetooth@vger.kernel.org, cochcoder@proton.me
Subject: RE: [v4] Bluetooth: request LE data length for MT7922
In-Reply-To: <20261124140325.3092381-1-cochcoder@proton.me>
References: <20261124140325.3092381-1-cochcoder@proton.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2182411945223137092==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1220932/

---Test result---

Test Summary:
CheckPatch                    PASS      1.69 seconds
VerifyFixes                   PASS      0.10 seconds
VerifySignedoff               PASS      0.10 seconds
GitLint                       PASS      0.30 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      30.51 seconds
CheckAllWarning               PASS      34.44 seconds
CheckSparse                   WARNING   36.64 seconds
BuildKernel32                 PASS      30.46 seconds
CheckKernelLLVM               PASS      33.87 seconds
TestRunnerSetup               PASS      730.38 seconds
TestRunner_l2cap-tester       PASS      14.56 seconds
TestRunner_iso-tester         PASS      13.04 seconds
TestRunner_bnep-tester        PASS      3.20 seconds
TestRunner_mgmt-tester        PASS      88.61 seconds
TestRunner_rfcomm-tester      PASS      4.52 seconds
TestRunner_sco-tester         PASS      5.62 seconds
TestRunner_ioctl-tester       PASS      4.69 seconds
TestRunner_mesh-tester        PASS      4.54 seconds
TestRunner_smp-tester         PASS      4.39 seconds
TestRunner_userchan-tester    PASS      3.26 seconds
TestRunner_6lowpan-tester     PASS      4.47 seconds
IncrementalBuild              PASS      29.23 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):


https://github.com/bluez/bluetooth-next/pull/1218

---
Regards,
Linux Bluetooth


--===============2182411945223137092==--
