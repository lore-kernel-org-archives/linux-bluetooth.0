Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F6A3C13F9
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Oct 2026 08:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791275892; cv=none; b=BY4303KJNFsmNYM5EtANtPnYUyrJtRk36Su/jBpNcNunDlLg4cYfDDDsrjPpUdxzgsFV7/WY/+a6Fm64IR2li4Qgp6DLvsyxqhtVpBX4TWgj+r2+5nmJxzzLQ4h1dU6GhkjXxX39ebctqGHJxn6A+Nq8zklZdFjkFxmG8RhMDxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791275892; c=relaxed/simple;
	bh=RnAPJkGLeBZtZ7t22C+NU42Km7SPmDg8i6Z4ICU6GbQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=QlQb/xLhKSnYMXRMzxpSvHOGvD4193xgo1J1JVpL/zwQfMmFh/VqoOsGL8pf7T5+dmYhxq0cFUMMWCt8BGGaraVus+ZtgTBfoWVysPR7+2l9CKyXEVFuo8H8nHKAumfIYZWQO/2hXQOJ5JVSmkct5mHIHGjqIJp/zoGxW6C/LXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eo9gSkF8; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eo9gSkF8"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-3115c4451c8so1866057eec.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 06 Oct 2026 01:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791275890; x=1791880690; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Ob4lLfPd6H3PD1gggLN6HuNFINMpaNO8/LwJJGxRAJE=;
        b=Eo9gSkF8cmHbCEzTmaw8+jzkCRgaaTHvmSJccLylWLY6MdycnqRqcK9hCn1xwDQKb1
         2k+OdJ4yAqVHodHq7Yi2r/qntoe4lJFMgE7C5ipKz1p+MtMt4Jqamqg2YTVGp2y5OUfH
         iw1X10OCrFfv+39h6+he5qheMf7p94sJuqhPzWNKc8n2RRA04+sjvCYVYc1G4VnwdqXQ
         hiXwMeHix1CJkZW0RIYGAHrIy4gNYauXmFQe5ykgu4Ec+t0qYjJ/RtQ2ti8EZZ5u5a+u
         eRUO4rZe+0z9JV+9B6AQsrshxVKZQgeZBfi82YICSgl0paGLdsCo2ACZ4dx+mBQXDFAk
         01Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791275890; x=1791880690;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Ob4lLfPd6H3PD1gggLN6HuNFINMpaNO8/LwJJGxRAJE=;
        b=cyo9vTfgblcEhwqI3UvQSRC3USwF76pCTVWxv+oxpBL1pUEJhrZ3pUTK2j38qJswdz
         /m4dKT4Jx6R09eJJm3I+/LVJImmPicI69g4cTwiog2g/+9A+Ee5Fdn2KZMMS37SahNCP
         qH62rpUoaiFBRp3YA93vHAcvv9awsY3K2y4Uwo4bBp6cIB7rJ+lzdCuQiAManJeZZyha
         k3xkU0YgtRU2vjrASjKnWZ/iFjtSOxt/wmH5ecz4e8Povg0Tf5TyGPjQt/h2DU0UJh4H
         F7dR1ed1/6XnZbJMCKflC+cRIMCo8KbYQNsvgtAfkEwcbiDtU+H9BYPW3HVqbRLlDEO0
         4KGQ==
X-Gm-Message-State: AFuF++mMHtlOBCh59WEnjX8Rp+tshM7bemjiR6hyaqW8Mi6VroQCEOaB
	HOY66VdHrqN6tpn/9xlOQgYLdK/J0Xb6VN4by+rHzjzFvK/PoimwsP5488kSVrB2ypI=
X-Gm-Gg: AYBFou3bd3/78UpS7zQiL/Z2akh4E16K9qJZxuWYYi6+BCjG1N1ErcZFQ1+lJFrTS6d
	ACzVPI8e+wCI/MClNw+OE6pfkHJLWSSpZ0Du2D5Cphf6Rg9o56Oe9zQw5+m2IUqti12foRpneQf
	V6k4nQucGhSok/I2PsGoERWBwozGx1YxKIyo5WX6CIey90AimsaYhSIfqrZa3BJOj/wmvgDUomu
	VaECGahifgmhrMklWeA1wibEe/nzeW2W5A5TQ86np7I3TKymkf54Bg8CSzLaO+IQVt96WThtzhA
	NDnQX6g3vkKpbBH+KRUBNOEtn8L7W22s4R/xTx03sfhDUaLThxPW1A+1eJ35RNN/xEJLnclMgtH
	1lEuPG6D3NWV8abjHZxS6TyagHvf78MZc1F9h12SxJdt8rcmrl5OxsuWVrnrv4YG24Q6fMVI7NJ
	ukvpcH4KicegOEJIQa+NQEDz1Loh8MPYaPRraVZNTh0vy7YT2i29bVzcDO7qv1HvcATRo+6BnQZ
	EED
X-Received: by 2002:a05:693c:87cd:10b0:351:5dd:18fe with SMTP id 5a478bee46e88-3514501f3d0mr2476855eec.1.1791275890042;
        Tue, 06 Oct 2026 01:38:10 -0700 (PDT)
Received: from [172.17.0.2] ([20.169.77.226])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35146abff39sm5908397eec.21.2026.10.06.01.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 01:38:09 -0700 (PDT)
Message-ID: <6ac4b371.6ad13f2a.3f5ad.6f85@mx.google.com>
Date: Tue, 06 Oct 2026 01:38:09 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4999718412859482898=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chris.lu@mediatek.com
Subject: RE: [v3] Bluetooth: btmtk: Add MT7928 support
In-Reply-To: <20261006032321.465448-1-chris.lu@mediatek.com>
References: <20261006032321.465448-1-chris.lu@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4999718412859482898==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1180019/

---Test result---

Test Summary:
CheckPatch                    PASS      1.11 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       FAIL      0.27 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      30.20 seconds
CheckAllWarning               PASS      35.15 seconds
CheckSparse                   PASS      37.36 seconds
BuildKernel32                 PASS      31.11 seconds
CheckKernelLLVM               PASS      34.43 seconds
TestRunnerSetup               PASS      757.48 seconds
IncrementalBuild              PASS      30.11 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v3] Bluetooth: btmtk: Add MT7928 support

40: B1 Line exceeds max length (92>80): "[ 6931.197167] usb 1-3: New USB device found, idVendor=0e8d, idProduct=7935, bcdDevice= 1.00"
45: B1 Line exceeds max length (97>80): "[ 6931.213478] Bluetooth: hci1: Loading CBMCU firmware: mediatek/mt7928/CBMCU_CODE_MT7935_1_1.bin"
46: B1 Line exceeds max length (98>80): "[ 6931.215214] Bluetooth: hci1: CBMCU HW ver: 0x7935, SW ver: 0x0000, Build Time: 20260601T161751+"
48: B1 Line exceeds max length (99>80): "[ 6931.643916] Bluetooth: hci1: Loading BT firmware: mediatek/mt7928/BT_RAM_CODE_MT7935_1_1_hdr.bin"
49: B1 Line exceeds max length (93>80): "[ 6931.650467] Bluetooth: hci1: BT HW ver: 0x7935, SW ver: 0x0000, Build Time: 20260527000816"
51: B1 Line exceeds max length (115>80): "[ 6935.039833] Bluetooth: hci1: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported."


https://github.com/bluez/bluetooth-next/pull/865

---
Regards,
Linux Bluetooth


--===============4999718412859482898==--
