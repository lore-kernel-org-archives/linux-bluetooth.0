Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEC8483811
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Sep 2026 17:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788283354; cv=pass; b=EOt84VsXgz8QDHIyVDCA1GKf2plKITzBXN7ACGLcBbu060c/MkJtYrF8iCp38LUFvYaYeoF2PtZXZZ20xSNZZEYpKydsPORZWiiigIQzjWxsKwZhz+fe9C19/sFLUIqOl3ShWvzo6nAp7ego/2JlxwpX0yBnVPOGQ7Vpc3Cmrwg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788283354; c=relaxed/simple;
	bh=t3L6+sgvc68lSehPoJkP/bQTxbVlimvzBSkF53faGmY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I47pfwMIfzhLQKl2D0XWc/WPT9q9tpyN95lm9Gw0Bi+xe3LKKKCjOAw8jNWujB+SYchLLLwiEAXEP4J/kPgGWMPqH0ZRNnS1qzsfVva45DVREuZX1PQhsS9XYgpKBVhz53H7NMeNzMki/4KR25Bww6e9/pqFCZEaXYIRVJ4e6f0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YLrct1b1; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YLrct1b1"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-856114a8247so3067637b3.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Sep 2026 10:22:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788283352; cv=none;
        d=google.com; s=arc-20260327;
        b=cfRun6J2IRvNZGMUAI+UA5Rnpk76G8nOz5ok/xzSoCHemDbRERZjFb/lZUsQbxdtua
         dwhS83OHnBrjv5yKVLR6DjqvBhotBRzoxXlor1xxGHEw3TnVji9bMr5aJNl16eTA8UT0
         mUVXl9r1ILRYHC0a2XPPFdd53nuDnh7yKj260n/QxY80GDW1zsYmBT3d2r8Lv2TSH7U4
         BwcvJKfP0C0SuWA1O2HhebKMm9RAcujXLEQYPcWcNgP6Axf3tB88ofgmyg5LE83xxeo9
         RjbuhJluPsUQWUfpCahLmMf13id7puucLNG0k7Xc0J1BARnPhe98OVC65AO6lcz0LEhk
         fQxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PuFrwn+0NXtxQrXaNS8HFIK02IDkFVwqqR3XwW7rixo=;
        fh=/+cLqUpL6pLfEHh869xT3PIhol8pgGf5DY4o3DLUNw0=;
        b=i3zWMV8oe0EdhHPgjDcBAAWdWScPyd0bK6BrXGNVJ3lONXCVI8uOqVouaxbwaZ2JZU
         0vdHPwoRW61j09S+Ue/0wa1dzr4kt1b9nIiPe6NmHVIDnlbeRiEe02fXdSFTi09gCKOL
         kLJFxX6DWX//v0YRKi7OS8gr+W95GBPLh5Z9LLs770Swdu2BDc8XcGqpURUkZLmHgCUH
         hTHCzHOHi15clT8h8JK71Iiuwu3ghi6h8qMgNYxJiGUoAmPJNNqW8opzrSyDO9/3N68R
         UlrB+FsybuDyz4veJuB9zh/0AGrR+L3KROs+F+w97Xhefm0SGNglmsz5mZvODEA/jWPt
         NKDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788283352; x=1788888152; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PuFrwn+0NXtxQrXaNS8HFIK02IDkFVwqqR3XwW7rixo=;
        b=YLrct1b1QDZIPT0qJ7WMD3aDsBYTBruslz1G5uXoFz1oDc+utlIHE1GeTe4RkDIcC+
         6maSjUXBjTU4Ypzclxpe3+/elfO+bVKKt7+Y0kDz9Z7Qx3QJDNRYqoB+M6IqxC7Wk7Po
         qRUA3mYAJ8hzyPRQ/HddfadKtsP9penrOtrn1JS8TtPOJFGT9dDL+P2PJRjulXEcW2hG
         VYbQfWkL5gFIQY8lmS1hxtXbcnFejJ5DXe/l1lj9C0MwLQjDjf3AdLAGuEA4v7IN0MDk
         f1dndsCyTm47onxY/x/oBpvqLVO6OMfApKotEfDZC0NctVSb0P0ZrmTfVI0wWhhbFfLV
         up8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788283352; x=1788888152;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PuFrwn+0NXtxQrXaNS8HFIK02IDkFVwqqR3XwW7rixo=;
        b=LyOznNhNmuo0dcgtI70r/fhG9+gk/tPV9ZTwAXxKXumEOwI+PtD4uux4qucD6Yf41F
         f7rNuok4fgjrju3jzoPWvJWZsOrgx80nl2dC7U9uVE8cpqmTiekaMSC7b/ubZP4gV63k
         NRmkASMwuQWU7dALm/6DXJLkosLqNAL4fj6ChfCrzpmUfQvtU5j4RgZ8wDujg8JSABBG
         gU76IG8P6Cj+HtSLCH+c45zam+qvUPNnyXbCgxSOcsrEX1kkpDP01eLLD7TSBXxDarbn
         tFqxIxC/CuV/RznuXENHYTTD0PfBsWPti84cgUiTCBJvCc9Ersma4vMc0m+xZe2pa9AS
         pTmw==
X-Gm-Message-State: AFuF++kA6UGa04p73ntpKFGgZHn/KxAvT4w+BqrEWH12BGfVNSLsL2qY
	7FdO/j5vC9SQ7YekPpPGXr0Ll3elY4GvKeYFcD9920sMM9WgrPj0RK9cEh/RDPqYkViY/nFoNy1
	ouXyoWM7dpYtJ58+0bMz5oOEwTvKC3V+qyAwY2Zc=
X-Gm-Gg: AYBFou3rgfHfO+8ch/TTjRKy4PuNNKlomeKAgm7JhpnZZT/WGN8y4RD8W8UGzyDgKBf
	Ci4T+BUXRnT2LzKFWs7bv2KoRaJPZlyXPw7+DJRTVvnv6JRrKZzAFKVhC/JOx/fEaPdUfH/n/rI
	EUcrVEZZq9z2HQYfuUhlui2aFYyCV4vdLAIIeZ3uqk+vNFsktjE8qP7SXjcqJe0gI7t45kJCWAR
	PYc3OjUyqLGbP7wqMeoD/wJ3pAC6r20zC+GLKwglf8n7Pzmf+mNlfbSqNEU1ocvyW8BcwfZtWCY
	t30zeAO6h+nmllHZPrRxN/w1jmpLD8knWvRAZ/4vE9B1LhRArn6tcUqxbKLv8QCloLDjUHZCEXc
	47AoSM8CWmhjoHgsLBQqH7RqVOCc8xi8=
X-Received: by 2002:a05:690c:319:b0:80f:8faa:b8e0 with SMTP id
 00721157ae682-85d69e009femr159297577b3.8.1788283351614; Tue, 01 Sep 2026
 10:22:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260901154427.3991920-1-lee@kernel.org> <6a970648.557772ff.f1661.edb2@mx.google.com>
 <CABBYNZK8yPR=abu6xmnfL-XQA+3CRYH22TJZOScG=1MEZpJH4g@mail.gmail.com>
In-Reply-To: <CABBYNZK8yPR=abu6xmnfL-XQA+3CRYH22TJZOScG=1MEZpJH4g@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 1 Sep 2026 13:22:18 -0400
X-Gm-Features: AcwNN1VS6LDavyEllog_IEFsedegyqfaIlfyTxeJbCXyFrJmnm_i0CQJaIEVDgk
Message-ID: <CABBYNZJ9PLqVhDKUtGEpsfgK9WOeKynVR6EFmen3s97+J-OWxA@mail.gmail.com>
Subject: Re: [v2,1/1] Bluetooth: mgmt: Dequeue pending mesh_send_sync entries
 on cancel
To: linux-bluetooth@vger.kernel.org
Cc: lee@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lee,

On Tue, Sep 1, 2026 at 1:10=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Lee,
>
> On Tue, Sep 1, 2026 at 1:07=E2=80=AFPM <bluez.test.bot@gmail.com> wrote:
> >
> > This is automated email and please do not reply to this email!
> >
> > Dear submitter,
> >
> > Thank you for submitting the patches to the linux bluetooth mailing lis=
t.
> > This is a CI test results with your patch series:
> > PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=3D1=
155482
> >
> > ---Test result---
> >
> > Test Summary:
> > CheckPatch                    PASS      0.75 seconds
> > VerifyFixes                   PASS      0.10 seconds
> > VerifySignedoff               PASS      0.08 seconds
> > GitLint                       PASS      0.22 seconds
> > SubjectPrefix                 PASS      0.07 seconds
> > BuildKernel                   PASS      28.57 seconds
> > CheckAllWarning               PASS      31.59 seconds
> > CheckSparse                   PASS      29.62 seconds
> > BuildKernel32                 PASS      27.44 seconds
> > CheckKernelLLVM               SKIP      0.00 seconds
> > TestRunnerSetup               PASS      510.88 seconds
> > TestRunner_mgmt-tester        FAIL      233.06 seconds
> > TestRunner_mesh-tester        FAIL      26.88 seconds
> > IncrementalBuild              PASS      26.40 seconds
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
> > Read Exp Feature - Success                           Failed       0.262=
 seconds
> > ##############################
> > Test: TestRunner_mesh-tester - FAIL
> > Desc: Run mesh-tester with test-runner
> > Output:
> > Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0
> >
> > Failed Test Cases
> > Mesh - Send cancel - 1                               Timed out    2.732=
 seconds
> > Mesh - Send cancel - 2                               Timed out    1.986=
 seconds
>
> These are preexisting errorrs but I was hoping your changes would address=
 them.

Looks like there are more problems:

https://sashiko.dev/#/patchset/20260901154427.3991920-1-lee%40kernel.org

> >
> > https://github.com/bluez/bluetooth-next/pull/681
> >
> > ---
> > Regards,
> > Linux Bluetooth
> >
>
>
> --
> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
