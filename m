Received: from mail-oo2-f42.google.com (mail-oo2-f42.google.com [74.125.231.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D02D48164E
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Oct 2026 12:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791204948; cv=none; b=GmvciRNlZaFnQh/e84pXvA9LUf/W+U23TbLIl9NaQP4NER5NI/+zzbh1eYRS1oN6v7/KnOcO20US54iDNqUTphJEsUBNxIQLLLSyLx0+0kEOu4e6I1JhixhIXFGbW4drLJgvX20BoCzrSdpoYsE486Ey3+lImviV0ngBtRnjpLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791204948; c=relaxed/simple;
	bh=h4QcGXdj+CDutEfqytnpzlu/VFRHeD/o1dDoEHmLpHc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=iaqlvSJPklLg8YcNu9ok6f+xeVoqNESljcfNFhqNToqScYGawmN+mx4OV8iK8ospUfBadG7UhObItvhP/pWGgO41qwCruLTpBm+TWkz7uXuEJD8JdEKCaeQxZD6WfmNWZFCm31ULncNqbDMutj4gvzGRqDax7HhLfj0BYumILl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XPfD2oUq; arc=none smtp.client-ip=74.125.231.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XPfD2oUq"
Received: by mail-oo2-f42.google.com with SMTP id 46e09a7af769-8274df739edso215468a34.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Oct 2026 05:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791204946; x=1791809746; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Su/GjKIo+/qU+rlXSqNwijeMqsUxSSUUHmE4DGeZXbY=;
        b=XPfD2oUqPOyAMN/p4mPbo3zhVnVniApMVziNIklOn1Ozc2xbDStWZBiCm62ys5sqsy
         nIWB/i95FTPL3oQIN/c8c8rUEwCwR9ztnQoFxNvQ6j7EdJvKekbXTmrDu31hJAbJ2S3r
         Bt2Dx0+jrV5Lq96BtAukpaHiv/xf5CNIqyraXPsJLMekL8QizJq/u72YSqMIJC4w7UP7
         /uY+4f1n16WXMiHhYWbyBWTo+0kXUAoOwTZMc5Tbm4FvBXpjOg68FNZjWgTYa65FjoyP
         OlFRSkrD8zfkVxulM1QJLI5NFfYWaMSGOdLSliZnTu1eoEbON4jkjY2B/a6UEdgfir0o
         K71A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791204946; x=1791809746;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Su/GjKIo+/qU+rlXSqNwijeMqsUxSSUUHmE4DGeZXbY=;
        b=NWDV4lcdtuqbk+5fATVRrLoOMmr2XnLIPIgDX0MKDq9vMZPv1rf6MXXAlSLGu9r3zW
         Ymbw0KRuRCY14EHxwRQ9t9kDfa9n5RxL4Blpne7kqj8S/T2kgzbR/fT0H+9otNvBmio3
         KBGjvFBUk3eT+cGnPv+k61W5Vxou5rIcFkmU+LDTjTCjWRj46GQ5Fw+1mM449IUnHhM+
         +/85Dn6B+IWG/jCXq/6s7aN4XomMMLa9wwvYwF3crTnISu9iLTxsY9T74/KxTiCcRrCo
         bEMVmdYECjNseuqL6NibrfisUaBx02JE3XGObV+DfWXhceQ3f9uaLhPIRauYkcGvvVEb
         D++g==
X-Gm-Message-State: AFuF++mfwfttpb0JJ/tTUzbZ/QcKQnvUk0o2WXOCjPH4Z8ZBZquO7VjU
	Be3m9+dgWLK+n6ITsbU3HR4W6YB9BgxQ6D+CC3IQqZYFPWZ1tQwzWR8sYXyqiw==
X-Gm-Gg: AYBFou1CxcNcvrbXCV6nR8c/uBxsR0gWa8AQ0FLo0TC2Ms4FsDCULSoa3xUKLES6RRo
	sNQHlLJbJhgm+fv6BXymy08giA7hCLdIukewm7tCkvsPpAuvpUA8zoG5dzNaSj+h85fP8BnicZD
	wIAgvvWTzWsGBO/M38VBdWdIsHGBLKxC7WHP800V/U3fbTkUuxHoCOdJHDaMJSqylwOQnk5e0GD
	MG/5Y2biS1vXIZqh2lRkdg1/hR0fjM7DpZlJie25+DP3ZgkFHQtjpZI8xhGCEXAI8R1qdXr7Cm8
	EWq1mFsK/iLfXGu+5hxDj/NxjgpM0HiXtB/jQroWWphtWTSbpFSFZ1THQ/7y1kc99zIicX5TQNL
	yvA5i1nFa/VBADUW0dQsUYGiEBmEtCBWA330KwrhiB93kMltTFi7zlHv/aWvN5Ekk5T7hS+xudS
	qJLyEEJW1LDddSRSf32MFBC1AMKbUlsjSQraFVALY9i3rsfcEhK0n4q/HoO4iiHOFBUKTeZ/LiC
	Kn8NhA=
X-Received: by 2002:a05:6820:308f:b0:6de:5f38:780 with SMTP id 006d021491bc7-6df34d68ca8mr8073189eaf.63.1791204946009;
        Mon, 05 Oct 2026 05:55:46 -0700 (PDT)
Received: from [172.17.0.2] ([158.23.147.105])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8227a86abbesm11862284a34.24.2026.10.05.05.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 05:55:45 -0700 (PDT)
Message-ID: <6ac39e51.5ed50510.265e2c.58a9@mx.google.com>
Date: Mon, 05 Oct 2026 05:55:45 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3339093155021221577=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chris.lu@mediatek.com
Subject: RE: [v2] Bluetooth: btmtk: Add MT7928 support
In-Reply-To: <20261005121156.772369-1-chris.lu@mediatek.com>
References: <20261005121156.772369-1-chris.lu@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3339093155021221577==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1179610/

---Test result---

Test Summary:
CheckPatch                    PASS      8.46 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.14 seconds
GitLint                       FAIL      0.31 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      23.57 seconds
CheckAllWarning               PASS      26.77 seconds
CheckSparse                   PASS      28.92 seconds
BuildKernel32                 PASS      24.98 seconds
CheckKernelLLVM               PASS      26.60 seconds
TestRunnerSetup               PASS      582.42 seconds
IncrementalBuild              PASS      24.75 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2] Bluetooth: btmtk: Add MT7928 support

33: B1 Line exceeds max length (92>80): "[ 6931.197167] usb 1-3: New USB device found, idVendor=0e8d, idProduct=7935, bcdDevice= 1.00"
38: B1 Line exceeds max length (97>80): "[ 6931.213478] Bluetooth: hci1: Loading CBMCU firmware: mediatek/mt7928/CBMCU_CODE_MT7935_1_1.bin"
39: B1 Line exceeds max length (98>80): "[ 6931.215214] Bluetooth: hci1: CBMCU HW ver: 0x7935, SW ver: 0x0000, Build Time: 20260601T161751+"
41: B1 Line exceeds max length (99>80): "[ 6931.643916] Bluetooth: hci1: Loading BT firmware: mediatek/mt7928/BT_RAM_CODE_MT7935_1_1_hdr.bin"
42: B1 Line exceeds max length (93>80): "[ 6931.650467] Bluetooth: hci1: BT HW ver: 0x7935, SW ver: 0x0000, Build Time: 20260527000816"
44: B1 Line exceeds max length (115>80): "[ 6935.039833] Bluetooth: hci1: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported."


https://github.com/bluez/bluetooth-next/pull/861

---
Regards,
Linux Bluetooth


--===============3339093155021221577==--
