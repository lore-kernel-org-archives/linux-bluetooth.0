Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620F644682B
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 14:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786456811; cv=pass; b=sPSEp7aI//fs6eRNBlG8PRh99kBkw1ASCBUmVj0hJMl+eGCuDSzNHOxgqJ3Gti7WkjnjJkkNSy45Q4mz2cuJ8htno26XllAoXJ5keKII0DHiETtTtcQ12oT91sXXFWjf9rdhp3HIjv1kf7PxfBLN48Xk68KVvJi6xaiTiu7P8Lg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786456811; c=relaxed/simple;
	bh=NeDovPps/cHcDdPDJbv0gS3dE+G4VHcxMGXhsM8qZxM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oIaxOTvv0gdyr1DHPqzeHWRcypkiM3zGzrKMadOtiIFp8Plc1w2hSjgLgNWRO9ZN8L8S8yoG7pFdBB0/cDcTvIjSAeokTotRNgLHi6pTzsqPBfv2RhoEefvj82R3uxs5nyxuD8AqT3KHM3NxbNzaKhh+21EXbKym4hhK0APBZYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ndbsjJPa; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ndbsjJPa"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-80e2cfe6918so34495337b3.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 07:00:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786456802; cv=none;
        d=google.com; s=arc-20260327;
        b=bmi0nAsQLk0pL9BXWbZ9Xa5FKENELKAy4aF39jyxABmhr7ExkexnWMQ/zpdAJ7XRsu
         rqwBwTCkEXFA0p2ruJlD34nAlmn13EDxpO9J9iFZuSkiEvzwGY88zg5TnjA0ULbd9XCQ
         qE8IGvVYALLZKH46kYB0jxD2oYOuq9bkp6rnoOIBfPkHVVvy6T4vhJwZc0rchp3HUi7J
         fO9/ucx+VhQw09bO5R5oBJKlsNWymyNXBWiW4lzitCTd96J1A/qDlrTDikwPB+kTP6QL
         UmuAA9BueROSVgFMl3+YRtrSOz4+FPh/NOQdox3OL5xpNcZaB2BlIesVRz+qlD56wggy
         yF3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DGUNDhd1v+PKLFfP3hZy1vJ4ahVIjB6rKs5rU9QhZhQ=;
        fh=Op3E5HLcggvb8//r6Zg/oem+rFLoYgsR4Qs0Yy9pSPE=;
        b=Kn9tqwRw9YNrZECiDyYOa//1W7VWcCawxjjnMtNM8rfrvq5ake76UHoOsa6eBHFTU2
         bfaSW+aAPLo6hal2PbS2opLISYl9y8WpBPc3fJSBLFNFdTH0m78WI/17bJTizZkz6+TE
         2bdoy0CnyAu582XvxvRGLU0MXWT1z7aQKlSEWNy1A/L1JrluWiRJuftw0Tm5hYxgTx0J
         LRWP7uYYdnJcoY6/tu2lsAzpaehfvUMnbh67HYpcd6Hm1Av+PZwz1SIKGlvboIQdBpjj
         a9YtxIwYYzIk5mPvQQ0b6NivejM0hHXlc+e2wCsUn9w88tr4htxzxARzXOkJuRHZbXlv
         KwDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786456802; x=1787061602; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DGUNDhd1v+PKLFfP3hZy1vJ4ahVIjB6rKs5rU9QhZhQ=;
        b=ndbsjJPaL4vfmMfdM9c4Rl+RCS4o1jF5i+/SBqEG9z6bA/26SXRo034M4UWtc0roXB
         9NRwhpKTKUz5nE4wraO5aUIHDiuDRnmVP6CUa3zA9e7k2qpETRQLIaMv+4RJ+ilyIJ6y
         Ddni7ki6CBQ7Gz89RPRsdDkA8p+sBQ5eErBiVUhqsOUOc2YHgxWnGAAShJLsbIGw81yN
         go+4KaeKfDVBv7ZgxhvneGoIgPHqJ7ApMT2jPWk2b23U3pdcKkbutBRIfH7Wd4I9gxD+
         wo6aB4fgYQNyNdQBy7YnJp5LVSeqUfg3Ah+EaA3WnibZdYJDFyavBE1h9/dTQuiEbAHp
         5ZMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786456802; x=1787061602;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DGUNDhd1v+PKLFfP3hZy1vJ4ahVIjB6rKs5rU9QhZhQ=;
        b=WilR94Iv1CtMv7YcQds3f/ze7rBmcUU74G19e8AJwiTtp6Fjd43f15oGuOuznU9epU
         +uZMFwQcdijdJFkFYrmj0+wBeT1ED7I+ESMTHwzeP11I6BadItEft8NzfUWQ+OhSYESj
         axvUHl6AXNQafZoCxo1pjsluZp3tz9rS8NcydV9LrjtdsysoMTiDU6B4CccHZQIXUNcM
         RPIPqZSUqAjN3QlxMMeeMuLzd26oo9M8m+fK5Iublt12evvIecFKc3SDw0i1UZ4yy7UT
         7Vu0aZeqwGzJhLWoEVRJvf2Y3xXNNYiHYO2RaKwCmDGAYvu+hKPghu4/eaqCS9GvMZUP
         Takg==
X-Gm-Message-State: AOJu0YyURbyHfesTJQNUbWomRUaMwsa2CaUjAe7dEgxF4BoXAQUtMsvL
	VNuf5YU/Q19UWTX6g9PP5xPG4quXrTwIFRzIYs6VZm+kpzdNLd2l6hUIb/QgwzBTD1m/OZcPQEC
	hYPQf1v3BSp7nQK4GaR8ULpIoDCi1JbW8YAoejmulj4kT
X-Gm-Gg: AR+sD13khLz8OHcsfbIn7rEOdeWMkrkAXMFo7qWgLDfHs7YNmTv7kE/03ZxnP+AOFIJ
	M9DNCHo4YTVi9mHeeVJWrXrCjPAe3iGik3OqH179nKTi8hcKQ/NzfrIrvKBRoOCAnEkMv2JiOP5
	1KQ2G8Eoe3wQTlKN/Dmo5y0gd5v6XvYiNBlZGpN/u5UG4NLnO8bDiPrDDBsNcdVOgmftefUGszI
	WRFsdBhYWZ/Xtm0RCgFuQB7xMeDpJTKrY1pBB/86zIu941onMFLbrnL53eJ3ciZ3GaO0+rA8A5I
	oS9frzFWgNRDQeF+CtmfWG6ElvX/j1cFSWu7bRdVoGh2nZPownbn5t1Wtfu1k0Gv3rC2Br7Etxo
	x8F4i8neIjagcScly
X-Received: by 2002:a05:690c:2608:b0:824:a7ec:e33b with SMTP id
 00721157ae682-82f309631bamr22958077b3.34.1786456802588; Tue, 11 Aug 2026
 07:00:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811083730.71393-1-johannes.goede@oss.qualcomm.com>
 <6a7ae9ed.9e118ab0.227f96.1808@mx.google.com> <f1e1dcdd-cca7-4670-abf0-febf16c72e15@oss.qualcomm.com>
In-Reply-To: <f1e1dcdd-cca7-4670-abf0-febf16c72e15@oss.qualcomm.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 11 Aug 2026 09:59:50 -0400
X-Gm-Features: AUfX_my2IWLMjyg3V78lktxpU3goi-sJ0zPbP1X24OulANRxAi7qBfRneGCQxFA
Message-ID: <CABBYNZKPA8UjfY0uo8cPE4BbxTRON-OgEpMuuHdwJ=br91H3Tw@mail.gmail.com>
Subject: Re: [1/2] Bluetooth: hci_sync: Clear HCI_CMD_PENDING when dropping
 the last request
To: johannes.goede@oss.qualcomm.com
Cc: linux-bluetooth@vger.kernel.org, 
	Ibrahim Abdelkader <iabdelka@qti.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Aug 11, 2026 at 7:05=E2=80=AFAM <johannes.goede@oss.qualcomm.com> w=
rote:
>
> Hi,
>
> On 11-Aug-26 11:22, bluez.test.bot@gmail.com wrote:
> > This is automated email and please do not reply to this email!
> >
> > Dear submitter,
> >
> > Thank you for submitting the patches to the linux bluetooth mailing lis=
t.
> > This is a CI test results with your patch series:
> > PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=3D1=
143947
> >
> > ---Test result---
> >
> > Test Summary:
> > CheckPatch                    PASS      1.86 seconds
> > VerifyFixes                   PASS      0.13 seconds
> > VerifySignedoff               PASS      0.13 seconds
> > GitLint                       PASS      0.67 seconds
> > SubjectPrefix                 PASS      0.26 seconds
> > BuildKernel                   PASS      28.31 seconds
> > CheckAllWarning               PASS      30.35 seconds
> > CheckSparse                   PASS      28.39 seconds
> > BuildKernel32                 PASS      29.13 seconds
> > CheckKernelLLVM               SKIP      0.00 seconds
> > TestRunnerSetup               PASS      503.14 seconds
> > TestRunner_l2cap-tester       PASS      64.96 seconds
> > TestRunner_iso-tester         PASS      81.82 seconds
> > TestRunner_bnep-tester        PASS      19.39 seconds
> > TestRunner_mgmt-tester        FAIL      226.68 seconds
> > TestRunner_rfcomm-tester      PASS      26.62 seconds
> > TestRunner_sco-tester         PASS      32.84 seconds
> > TestRunner_ioctl-tester       PASS      27.17 seconds
> > TestRunner_mesh-tester        FAIL      26.97 seconds
> > TestRunner_smp-tester         PASS      24.42 seconds
> > TestRunner_userchan-tester    PASS      20.61 seconds
> > TestRunner_6lowpan-tester     PASS      24.04 seconds
> > IncrementalBuild              PASS      29.81 seconds
> >
> > Details
> > ##############################
> > Test: CheckKernelLLVM - SKIP
> > Desc: Build kernel with LLVM + context analysis
> > Output:
> > Clang not found
> > ##############################
> > Test: TestRunner_mgmt-tester - FAIL
> > Desc: Run mgmt-tester with test-runner
> > Output:
> > Total: 501, Passed: 496 (99.0%), Failed: 1, Not Run: 4
> >
> > Failed Test Cases
> > Read Exp Feature - Success                           Failed       0.252=
 seconds
> > ##############################
> > Test: TestRunner_mesh-tester - FAIL
> > Desc: Run mesh-tester with test-runner
> > Output:
> > Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0
> >
> > Failed Test Cases
> > Mesh - Send cancel - 1                               Timed out    2.102=
 seconds
> > Mesh - Send cancel - 2                               Timed out    1.984=
 seconds
>
> I'm seeing the exact same failures in other CI runs from recent
> patches, e.g. :
>
> https://lore.kernel.org/linux-bluetooth/20260808062541.3705446-1-zhangche=
n200426@163.com/T/#t
>
> So I'm assuming that these are pre-existing CI issues and
> not caused by this patch.

Yeah, don't worry about those, there is an issue found by sashiko that
perhaps we need to address:

https://sashiko.dev/#/patchset/20260811083730.71393-1-johannes.goede%40oss.=
qualcomm.com

> Regards,
>
> Hans
>
>
>


--=20
Luiz Augusto von Dentz
