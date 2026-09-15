Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08AC04BD79E
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 17:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789494199; cv=none; b=XF96Y43gvQJ9rkxWP9eowt3rmkO6ixc+PS1knXV/PjYOs+80/8wK9FaKeTGPUAg0TWiMskYl5kKzKv9MCc05beZSih8rkUVOxFrFRsjVdAkilnBvl57PX41e2CR8lr/Q/x/73UI93/2uIYmqbiqW5aM/TmWjfSWrWA+G9rN+JFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789494199; c=relaxed/simple;
	bh=QnYjADe4f5EJ1AXb+/6tE9q9TJyImLJNPduW+xH9fuw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=iREikt/4iSKPEAFeSVxECyQ3gvFjaF36n1cwbA8lXO65B8RvVeqTSywtdt/7BCfdospu/ihOv+VmzvcC3qIeDz6lGXNZ2HRTYcK8upPDk7IQgj2ZE7NCUseC9lhfyIMEThkPuFpf1aTif4JEqfJ2/S612Qvr+1Xd4ft1e/REPSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AIsh2svY; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AIsh2svY"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-52fa9c055b5so13168011cf.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 10:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789494187; x=1790098987; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9X+t/zyaiQC7a0fWwGbEO8GNRgAzsWWUQnyCIgkdlc4=;
        b=AIsh2svYKN8jAB/dMoubYF9REbezJe6UlfV90dkAN5AD6G88Psj48XHzd0aiwy+c0I
         jZ2sPIlF7raWFtyhdkEzLfQyeM3HvvTlqIDqz4SZj/xQQQv7wb6gs7RtLyB5LcAfF/fY
         wDcxURgzD9UM8L9DR9GnjaZIsak+yBjwesZm820rWj2fL2qb5CackmJiPUsSUiZ6G+FS
         oLvEhMfvdgaHR/AL1aMnZtBIwVlZiLNHbQf4GZt9szTAs06meh34buDVx0c0OUsdvaHy
         ywT66C25gwTPhJ7RBuIwguYLG6WzRIHfI1vq/QZlcoNKqKyiz2EDblmMACyB6osllYpP
         CifQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789494187; x=1790098987;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9X+t/zyaiQC7a0fWwGbEO8GNRgAzsWWUQnyCIgkdlc4=;
        b=gOmTSDfB73c1TAabTWsn5GylRUNYb98sGpw4GliuADSiN3MHkre4dkKaUDiB9SHW0G
         VLdqNuU0l4a6OxwV3khPRtDJwFq72zOuqE0aqjuvtAyarRoMt0+iFw3rFg7K0nQTNvQs
         PsfZN8x2byQ9EqTn8HGiqFhjFMqVNHHk/TyLqq33dX5d/pED9uAyyrM8RVpXWfXlkdIe
         /2ywp+RmypEqomlQ6xWrA5QQ7hYXrimwn3UVyFgtX1cHIHKVbj8neOBIAt5KrWndRnwX
         whGV8IRNHgl3HKyU16omoMEpl++otnLlOf2MaTH+0HBeQOFZb77YK31vP5GSb3pRCLd/
         x6EQ==
X-Gm-Message-State: AFuF++n8tXm+IcgK8lKDboB/6PJ/QGIXgNrdo2IGLmYm9F+RSQ05Mz5U
	IqetyQCcET8+jCfjkdULEt6WZkOb6WPcSwbOqVdRfxv6PfHPZKyDU83QxrjAAg==
X-Gm-Gg: AYBFou0hK2kg3WH1bjATaOTJWwxTTPbz5j9VibMZdq6sdQQfAE8rCG6m/P83HcuHvZb
	cDtxW6m++E9Z/qfrszOxdIoDEf7J4zRNaF7A1VYMdF/GT3KnVIR4Qqe3oYDXlVdRz4T/7ODnHv0
	sM7ZY10H5GhQYvb3jgi2VcYkGy8INpSUsI1WR41/erMtMzf5ozdMul1VpoB8tJQhcNydmaXXiij
	Cg4PkQXCFrDPkYm480ouuF9BKHyZKys3PGqbUCTaqZSj7hafXZmM28/EgUPwXwcUkZ8r/7kDiiS
	6ev2IytRug3mI1oWHEAz0UuzzhGM0aRwN3If1ig1ChmpNe59VIo3iHh6qHXMCAX/mXMRGS35zr7
	oArDc+hRoOIB9NIXW6mC8BpSaRD8BlrLw5v/ldocPvjQ4PpZbXRhJHXVf2TcAK6y0uYURme2It8
	l2piMHWatnmQkgsZvEB/JLaAjZBsRwjdxz1cALppIjs3dQaW9NY2oaMJDaAtAa91Hut0X49bmYx
	B8hNWfr
X-Received: by 2002:ac8:59cf:0:b0:531:2394:9663 with SMTP id d75a77b69052e-5312394e8bamr31590691cf.7.1789494186640;
        Tue, 15 Sep 2026 10:43:06 -0700 (PDT)
Received: from [172.17.0.2] ([145.132.102.224])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530ca4e6a9csm130734061cf.23.2026.09.15.10.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 10:43:06 -0700 (PDT)
Message-ID: <6aa983aa.49dcfff9.259c95.c3d1@mx.google.com>
Date: Tue, 15 Sep 2026 10:43:06 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7667518554849235948=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, qwe.aldo@gmail.com
Subject: RE: Bluetooth: L2CAP: validate frame length before control and FCS access
In-Reply-To: <20260915160239.3106697-1-qwe.aldo@gmail.com>
References: <20260915160239.3106697-1-qwe.aldo@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7667518554849235948==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1165734/

---Test result---

Test Summary:
CheckPatch                    PASS      0.99 seconds
VerifyFixes                   PASS      0.26 seconds
VerifySignedoff               PASS      0.12 seconds
GitLint                       PASS      0.35 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      28.81 seconds
CheckAllWarning               PASS      34.80 seconds
CheckSparse                   PASS      47.07 seconds
BuildKernel32                 PASS      30.62 seconds
CheckKernelLLVM               PASS      34.12 seconds
TestRunnerSetup               PASS      779.46 seconds
TestRunner_l2cap-tester       FAIL      9.06 seconds
IncrementalBuild              PASS      28.07 seconds

Details
##############################
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
No test result found


https://github.com/bluez/bluetooth-next/pull/774

---
Regards,
Linux Bluetooth


--===============7667518554849235948==--
