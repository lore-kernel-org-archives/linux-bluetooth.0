Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0708C485CDA
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Sep 2026 17:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788282621; cv=pass; b=EtzjHVSQGgu+w64qEiPSjA02mJdz/hwC7C2DD5BCyaTZLE1mcafMNLIpm+0lTmLkOX4Bo6QlOCaMpOTMtWiZOwujHDSUwFAhE9mtgTgnZC/KA1u0u/R3MpdmAUs4G7wk1WRfaLlAGrpxA0v3TqJ1k3pO54VNfzcvnco80N5uGYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788282621; c=relaxed/simple;
	bh=AMydxk7uIiL3VAT2zieujkU5+sJ8VPOtT0Xz2k3Rglw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UnWK9voEIpb3bG9vbv3x4JK9jJDCa/EcpUEjhwnX3oXZNgT3sOr7pQEhsFZdyqyDn0Tq4nruzTxIOUkZjhHVydUxX3zmOjCy5F91sNf0d7YHyRpsOql1c/SNaG09uevmIHvynIm1nlP0TMMVAZJuS1Di/JycCfB7iVj2iCZGMEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RjFd8pJf; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RjFd8pJf"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-836cb2fa1bcso2949137b3.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Sep 2026 10:10:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788282619; cv=none;
        d=google.com; s=arc-20260327;
        b=G7eSabMLVCJd/MD8FMIVzJuPyBP0creadUXYp84ySU7tBbo4qXXoFrsahTwxPyr5A4
         hd2NkjrIgwc/BGZqrBWFhaptHu/3w1bM8nQpvoyg4aQZD4f4nockuimbGhaQazvugAac
         Iv5BkoP9jMGkU6JecDA3aYLG0y/RYkZLXcdEJON8RR9M9tsy6A9zR6iuq0fgiMMgPAIF
         WxYTS+CjaombrNvTRPHXxczsAVuV2/l0uZdF/y4vk8A1T1UitgKL/sJKdCHhF+izGT0w
         FlPJxPbuaeL4cQthX0jV4pwG5fAxp+YbiBeDQwcna617Rsfgj1j7uFTaQfydT/XKtH8o
         bMwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=V9koDaeAHs+uF9fiXqlnSHIKMNLPCq+t9lj0BTeAerA=;
        fh=/+cLqUpL6pLfEHh869xT3PIhol8pgGf5DY4o3DLUNw0=;
        b=l7AYKb+fTeWMaT4SH73KrU0KJpzPOwnyuRwItsB8rjSVsZktc8PAjSL3lPEBLsU/TF
         jPkPm6+Md5/JTQ0bnBgvUXD4ZO9zN9epQGn8QF87bRLBkpwssWHftdjvje2ogbO8x4xG
         eK1JJFkaqC2iuf7273Zo0rDTr/LWv1qvM5VAS3MAhK9Ktremt1qVOgJYaQK08ROowg8P
         dZatHdpFksXnhe6YyrxEmerZOTwB9wXHG6gB5/K7wu5c9VanpEgrLEq/ZBSJmEZ/ayPm
         RuZJiCoL449nWpofsCjHdoi25xaA4wbZSh4q+aGDrtW7rVoOJ/j72IGrlyUGrcFmR9F+
         pwPQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788282619; x=1788887419; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=V9koDaeAHs+uF9fiXqlnSHIKMNLPCq+t9lj0BTeAerA=;
        b=RjFd8pJfnCtIWnxXlGtkacrxn+CIfsQ9xmfn41QUFlniGDTLVi8z83xH0jEhhOnjz4
         opR2VBXRwKOyXDOedndICqr+NU3Ow7fycW8zb8N7v3UCkx4jYrlj1Uzxxu+rTEbVlI5H
         RrRmIbPek9GHtzOOYL+re80X5PmKiBpl4YOMkaUEONsRiJKYTGFAg8Om38+jqHLNLSpY
         LfAimNdBWzmi9R6Nbs7rYlaqtOSvUeVBPOvzQnj8HLQ89PXAdeT6Izh7BMHlbyKp5Q5T
         L2yakORz5+a7cRJcZyPbKWAKj+FvJEyigly/SS7KeN3K8uGhf7b9HF292vrxnx/vnjj/
         pl4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788282619; x=1788887419;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V9koDaeAHs+uF9fiXqlnSHIKMNLPCq+t9lj0BTeAerA=;
        b=WX0M2ZHkEX/pJwbV6ARxf3cJGqpc5yuz6vY0ZrMa8GUu9FWW8TPwhVaTsJeqhOxXcI
         zhpzmOeYlsEZGhUTcreIrds6zmmgTZFlFtgvWCf5AIGYJz03veu5DwZPcsrPMZ89zfVa
         GLfJQ3DlRgufB7NT9dnwN8xqhQR3epL6Pxn6YR48iaWllWR5vzQMqA66v+PACZLphtVC
         3NDzEM5wKfOrGobvQXiBtp+wY2H+YEAPGHNkpCKMMRvYKkqBZUL1vAENILpMfh4efocF
         UJy8eIFtiuYGVQlCjEXLcVn3v05BiMVkGtEtQejE7sk5YM46sOnqVa0rjgLV5wOdV/rC
         7UKA==
X-Gm-Message-State: AFuF++ncbvxZyVLU57XyFoseBVtxqFq4dTBwtVB6RX8H7vMxV9N+Qb2M
	hOdHKOHhM3HBf6KDhrCCwkgD8AT33Gq8dINEN/uvoa4/fTIYLf4p5kKmTAa4nF4WdQC5CF5depn
	TahQorI7NX49UFvZiQJ1tjvBcW2Uz/Vku5eu8
X-Gm-Gg: AR+sD12PPkT2MI1Vat/V7MdOvRCCpCogg2BSTgrqE2nZCO3L5Y5byF5Qik3i9Fd6LI3
	TB+dQpP4jlLv58PxtRry1+tFdMEQWpctvnp6qpfSIarR9jowOxF2SXF4Wy4YoZ4PUsEdY7ckoKS
	5Q2JlqFOezz/JgaatR0qiQVBJOaOagCcMCNmwBBySjeLElWRnwKNYnK6R+WyIS54OgqL7o4bJT7
	w0P5S4SaevigrSG5UxVH+JZlf/lqYSpr/jLt7GtAPAerT8f/HR2DE2Vjl+eUj3azrV6iZ4Fnt2j
	Ltaz5U0mNIyIaET8Wonq9yG/co8K8avk47bojyj0pSspMDTRIs7hH/UXQM1AMhH9OyY6K3VUTY9
	bQoGJ+plkSv0Mw8ge7ifb4UPZTFqX5b3v8/g2nlEhag==
X-Received: by 2002:a05:690c:a6c7:b0:830:7633:a1aa with SMTP id
 00721157ae682-85d6d889bf2mr107440327b3.21.1788282618914; Tue, 01 Sep 2026
 10:10:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260901154427.3991920-1-lee@kernel.org> <6a970648.557772ff.f1661.edb2@mx.google.com>
In-Reply-To: <6a970648.557772ff.f1661.edb2@mx.google.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 1 Sep 2026 13:10:07 -0400
X-Gm-Features: AcwNN1WO5Mj4cfWSP9pI_gDfyzAwCNMlKLPXFU_PLMvHRQGKveuljj_3aJvjX6c
Message-ID: <CABBYNZK8yPR=abu6xmnfL-XQA+3CRYH22TJZOScG=1MEZpJH4g@mail.gmail.com>
Subject: Re: [v2,1/1] Bluetooth: mgmt: Dequeue pending mesh_send_sync entries
 on cancel
To: linux-bluetooth@vger.kernel.org
Cc: lee@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lee,

On Tue, Sep 1, 2026 at 1:07=E2=80=AFPM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=3D115=
5482
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      0.75 seconds
> VerifyFixes                   PASS      0.10 seconds
> VerifySignedoff               PASS      0.08 seconds
> GitLint                       PASS      0.22 seconds
> SubjectPrefix                 PASS      0.07 seconds
> BuildKernel                   PASS      28.57 seconds
> CheckAllWarning               PASS      31.59 seconds
> CheckSparse                   PASS      29.62 seconds
> BuildKernel32                 PASS      27.44 seconds
> CheckKernelLLVM               SKIP      0.00 seconds
> TestRunnerSetup               PASS      510.88 seconds
> TestRunner_mgmt-tester        FAIL      233.06 seconds
> TestRunner_mesh-tester        FAIL      26.88 seconds
> IncrementalBuild              PASS      26.40 seconds
>
> Details
> ##############################
> Test: CheckKernelLLVM - SKIP
> Desc: Build kernel with LLVM + context analysis
> Output:
> Clang not found
> ##############################
> Test: TestRunner_mgmt-tester - FAIL
> Desc: Run mgmt-tester with test-runner
> Output:
> Total: 501, Passed: 496 (99.0%), Failed: 1, Not Run: 4
>
> Failed Test Cases
> Read Exp Feature - Success                           Failed       0.262 s=
econds
> ##############################
> Test: TestRunner_mesh-tester - FAIL
> Desc: Run mesh-tester with test-runner
> Output:
> Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0
>
> Failed Test Cases
> Mesh - Send cancel - 1                               Timed out    2.732 s=
econds
> Mesh - Send cancel - 2                               Timed out    1.986 s=
econds

These are preexisting errorrs but I was hoping your changes would address t=
hem.

>
> https://github.com/bluez/bluetooth-next/pull/681
>
> ---
> Regards,
> Linux Bluetooth
>


--=20
Luiz Augusto von Dentz
