Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742CE4E3242
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Oct 2026 15:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791473219; cv=none; b=bJwumQDp4sKiBDZVqUZZVxShbn+wzfxH6BBGD+3bnuSYb565sjeO+6Rq9FotGE8Ue3LF7NCzqylat6MmUG2Zk9yIVMJKOrJsxrXMUh8I7jJka+dO1qUuDgesCzL0LHZ96kOS9Za3I8C7v06d0HNoeWu6vlOBWQeFHvXPvr5/JWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791473219; c=relaxed/simple;
	bh=tL8UL97hwem7fol6kvIlnkVi8sgxc+BhyIk3LV2zc3w=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=omtoBE7h4e2at/z7rdM1o/dgDk7Mfgpe5eCLYJ8bhneZwqsRNWGnAu5T/SnkTLNruQRkCxQgqFHmhP5Cv/XHt9p8F9SzJJF0q39e/WV5TmjlDvcBkq9k+JeCEzfNGEOKQq+AJQukUylqLQYcvd9rF2C0SRHPQ1O2Xl/pn0wS+oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Toxus4kA; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Toxus4kA"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-93e76469b93so300379885a.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Oct 2026 08:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791473210; x=1792078010; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=QUUpnbhr7oN4Rh0korXXGyRtCjqw2T6dGtqnNpPO5VA=;
        b=Toxus4kA14Y+O5f93MYek3kdUbgcgFJoBjvEVfx96CReeFPmsLzjeDYJF0/FfPARHH
         YXghegmt7gJCZ77lV7e8ExnQQEWPE7s/slKeHIAEuCCND0njbfyoClweykEhaKblReHB
         8jLugzfeQu2KRD0MPsHm4u4TCIftaLHH+f3vhfcfDK8kvLHhlzfho1rzgaF+QoCkF/Ms
         O5coGi79UEPZMGMnHbD4qe2wVCDrQs2iDHRpHHWE4JU1/WFX9o7wODDLAioIzsGf6zI3
         RSS1BrrhRLma/wEG4yRxBqJnxdsdADZy8M2LjhUVZwEHZoNO/PZCc1SJoaNvd3zV35nM
         5XpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791473210; x=1792078010;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QUUpnbhr7oN4Rh0korXXGyRtCjqw2T6dGtqnNpPO5VA=;
        b=BYXdBkP02lhPTo6YNSAjoi1FkOxod/h1w6XI2ozYk9Q2F2S+ZpQF0xXLN7jZ7s4S21
         eBXjaeYVYR1h3LZKakjCd4tsDDd5h9VO0FSbyJKe3M2tVA7nEGGWfu7+5GD+xLdMJzeT
         xtSBx1zMMZySMEWYK/D6QX++FiqLZmogz6M1vSdJCldSemieHbHoiyuDY2G7E/VYfrLv
         /h6Mi4EbslFpvZFFBs88WIaYjLn+jjw28/mBTJ4KZQLFFDWnPYfnV+a3jjjvopFXwvLF
         YZYNBiQTGNxp7Zx2cD0wg270e1ysq9VC8JY4ALm/F7k+edy0Eaxh5YcZr3MdQ1Gd/WV9
         skkA==
X-Gm-Message-State: AFuF++nHQQmGePZwHKUUD5qVv8nq1YqLLuU96ePLoMH3xal4PXCOGG74
	tOQNpykUt9s5EyqIDao8JiuIdl09UvdT0ycLbdURm84o449rAmXa5VHFyeR4Mg==
X-Gm-Gg: AYBFou2b/gw+vgke57SRok+52ri/Bio4i98pNvsj/D35hj40ItZyubtlCVLUpEKQy+x
	iBQF5qmu7a20Ykr5+Smk4KeaH2cVMwiOKwKeaVe0nQbE5WcUgHGGpOdH0NZiIbwiaA70u7/gXP6
	ipwicUF+OfL48vws33Tzejt1Qv6YJq7N29GPHjmHfhHhWdaJvyqpxXzwRkmYTmLRMsBI+5bvuoM
	clYa50nCLe+CX9HC4kpo3FrSDG3CkpjIi6q2k4vHYD0ld50xjin4UM5YcdaRvt1arNnKpmfkmr0
	eR9/OWTa9ByYyTyAuzW1u27VaFuBNYyb14XcTwpttKfwib71u9FJamU1HoJ0grFs8VO4cS3+80r
	Jh1R+PzygEbPqQpcxwTS/oJjj6ByRt3zSfc5h9NdtYhJHHvxaAHDWNETQyRy3DGST0noIr5KBi+
	zYczVMPLW1Qv291XYEpavEzQsEZxgsh2XvCxsJVBOz/Ivdj4gdDUV0PYwPAsHPeRRF3XwfxWqZe
	Z3qBg==
X-Received: by 2002:a05:620a:2b45:b0:93e:92f1:4222 with SMTP id af79cd13be357-93e9b0eda3bmr1099147285a.4.1791473210022;
        Thu, 08 Oct 2026 08:26:50 -0700 (PDT)
Received: from [172.17.0.2] ([20.161.77.165])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93e99231974sm505519285a.46.2026.10.08.08.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 08:26:48 -0700 (PDT)
Message-ID: <6ac7b638.04a468da.335c4.cb52@mx.google.com>
Date: Thu, 08 Oct 2026 08:26:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7048757485460462353=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chris.lu@mediatek.com
Subject: RE: [v4] Bluetooth: btmtk: Add MT7928 support
In-Reply-To: <20261008085559.813654-1-chris.lu@mediatek.com>
References: <20261008085559.813654-1-chris.lu@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7048757485460462353==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1181444/

---Test result---

Test Summary:
CheckPatch                    PASS      1.29 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       FAIL      0.34 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      29.56 seconds
CheckAllWarning               PASS      33.77 seconds
CheckSparse                   PASS      36.63 seconds
BuildKernel32                 PASS      30.00 seconds
CheckKernelLLVM               PASS      33.74 seconds
TestRunnerSetup               PASS      794.22 seconds
IncrementalBuild              PASS      27.59 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v4] Bluetooth: btmtk: Add MT7928 support

39: B1 Line exceeds max length (92>80): "[ 6931.197167] usb 1-3: New USB device found, idVendor=0e8d, idProduct=7935, bcdDevice= 1.00"
44: B1 Line exceeds max length (97>80): "[ 6931.213478] Bluetooth: hci1: Loading CBMCU firmware: mediatek/mt7928/CBMCU_CODE_MT7935_1_1.bin"
45: B1 Line exceeds max length (98>80): "[ 6931.215214] Bluetooth: hci1: CBMCU HW ver: 0x7935, SW ver: 0x0000, Build Time: 20260601T161751+"
47: B1 Line exceeds max length (99>80): "[ 6931.643916] Bluetooth: hci1: Loading BT firmware: mediatek/mt7928/BT_RAM_CODE_MT7935_1_1_hdr.bin"
48: B1 Line exceeds max length (93>80): "[ 6931.650467] Bluetooth: hci1: BT HW ver: 0x7935, SW ver: 0x0000, Build Time: 20260527000816"
50: B1 Line exceeds max length (115>80): "[ 6935.039833] Bluetooth: hci1: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported."


https://github.com/bluez/bluetooth-next/pull/887

---
Regards,
Linux Bluetooth


--===============7048757485460462353==--
