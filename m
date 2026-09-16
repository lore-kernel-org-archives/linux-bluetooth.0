Received: from mail-yx2-f43.google.com (mail-yx2-f43.google.com [74.125.224.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C884A7C82
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2026 17:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789578077; cv=pass; b=C4QiOAYM7LoUSlwN+PDm6x2LyJhHEIXGimKqDi7i9R5G0DYNTOl0XBXrM5SfwesN0Ra3aJY8/gHlu7R8Jp02efnfJWNEvR9bJVLF4lV16FoKeYUSH17bKNhPomUM8MGgXOEQl9593v0PQgjN6YJ9eqJkQBwMzKRbty6DYRklUQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789578077; c=relaxed/simple;
	bh=PAAvapCtGiSE1WDDWarXGQyi7MXj7LEUFFeI9iSboqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o/Qib2Aqbqiolqc1afptD0f1xPy9sjSlcHQ3vzKLoICHtuEhT2PIvJSklfgRwfFxxNQCpwAOV8feS1p6b6muxECkPoLKVFexoqDU6RKOE9b75o3jIHeLEQLY9ZFRS936hycpMoPJfCRPCijiZ4rAEHGQQgf0+tyOVgqv8Gj4y6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j4HSFDsj; arc=pass smtp.client-ip=74.125.224.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j4HSFDsj"
Received: by mail-yx2-f43.google.com with SMTP id 00721157ae682-85d43f9b120so13283867b3.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2026 10:01:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789578069; cv=none;
        d=google.com; s=arc-20260327;
        b=Xaaw5Y+7Zl0fF87FGCXhpnCxIIenZ96p55S1KWfYoI9o7NTED8RFG4IEI40ev8tsdW
         hGkmCoP1dB0Ih4R4/Qdo6rZy7XfmUesmD9daJ5c7CQh3gVfIk22g9U+F4mB6QqJecIBD
         feQLhNbrwrxbCLpS7ErQT4GJ/92YTjLPrl9xNJJUV95boV77k/cviMGJPk1m9svWM9vB
         Zq2kl5upsillWijm5PSzaqQr0hJaFcZp49RXR/MhqMkq4qk7yIzK+IcCnmapLcGMcZ10
         7LHecTpwRTItOJT2JO9i4ZGuzeBWtkKiYNnzH5mBd5JsFVExBssqJCUcisBUccibQIPX
         qv5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=b7CDerk9Kv6Wt48CRQ26z/u0LA4JNke+gmOl8Aq5Yh4=;
        fh=m5gim8lSaS/PeVFtnntMCecCNRHtsmZ38RKVZ6SyAGo=;
        b=I7m8hwKcqu7PXTD7IRTA2R6y5GRclYtryHgu1P+k5Xq3aXe2hYAwbIv3RO+z5Q6jED
         FR4OJ4iu9CKwXNQSrStQPlvqCZVjN5WgaR4knWY8dEBGgwSNquNgjXQCh9YzciLAXYGm
         TScUQzRk1v6+aIyJpciWExbqNjodCIx+K5mmDXL5OY2H5CfaGVhQOUS4Snu+DWUYJfT+
         lrqkGr2nRlx8a6ifVf3LE4RTscRm1ET6BLR+G8raMS3fVdW9k+g6bT4iJFKeDqJMEvNi
         o3CApthAs0Aj4FU9a3ApjtwvxdspmN/dHE2VUwVHkg5PJ2+rBxCC0fzCnW6JF93wHsF3
         C6Bg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789578069; x=1790182869; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=b7CDerk9Kv6Wt48CRQ26z/u0LA4JNke+gmOl8Aq5Yh4=;
        b=j4HSFDsjDkzjICBRk6NkjWqX/wMe6BvqY/fVTiP8aH5MP3o4BjP+PnscA8UWcvLNeg
         9WVJCA70gRVgmYf85+8gPys+UG70Rp1NDEg3c6uBjJ2H1rY+rPZQq1Yhhre5MUK1z0EG
         swZGlq18tMrPsS/CBtHVFF4fzLoYSRA1GqQm8sVfDlp2mFHcW7Vh8wUprX0RxeNgXarj
         Haak8KT16MPpW3etG/JHq7WFm4Zc22NDk/ckKLWZwZ0u8SmLGzauXGbuZPYBGcv+kFgt
         sl+dvqH5NKhzXMSGD5PKVhyA/Tb+6oCf22BzY7jZBXULZvzY6XC3iXnO/9R2lAz5Gs8y
         ozrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789578069; x=1790182869;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b7CDerk9Kv6Wt48CRQ26z/u0LA4JNke+gmOl8Aq5Yh4=;
        b=tm2wv/u8uBmH4v/U8WzanQHcJ0mDVdOTDUYjfj/6l2FqVn3tE3eelyEWMmQHdnd9/H
         jRxNp5qy1u+Y+y+zjJLU6xeI136RXl0LQP2W24Uq4LZTLw/xHYwK/DEpWmhj9Vms5hd9
         P1sXAs4yhWQrasGagJtedct+chTbQhS0eZoRHP7+PsVVa00p1DTN2lawuY5r7ZbpYo70
         u/5pdfBrb+30IBVxL+kVLc5VceEjqlhFyYNw2pTCODg9LJmYJHXq67KS8Qe7Vt0NXbaO
         NiqgAI/hdwsF7/TZhI0LrtHA8QH/Lxi9BrxImyfxGR2uMcduycrnp+LRs+zRsf5Ssu/l
         gcEQ==
X-Gm-Message-State: AFuF++k3AxZ/rTGYZQcd0cRFlXF9BEPeAUJ9KOxlisMCLhV80awYFpp7
	I0uKTyCEGifURqdLr0tIa0LlB80qgQC4Z+B8yqBkI+hXwIWO3WWS9C45ni6Jn74XjOnKedYrVVS
	QZ6GAic7DfdjIQG2QQYRfWJlMWfZRo6fLTbbXT84=
X-Gm-Gg: AYBFou27cuurenZzkDTcbiJ/ohIY6s7try8iLX4z34XzkTfLIh+gSKO49tKSj/Qbg5c
	pieX1JfT9ZONDhe7vMP02gQDZZ99ERpifbaAPgzt5w2GwNGBj6I7HkGSXI1qsQR5j8A0ni4Amgn
	XsSP/3og8mbVF8MWqvyXAuApSf3tweJvZOOiaW89obymwCE1SFdsNeccNi9AoeomrIYlP8aCzpM
	3GcqT5ja3nDIUuOT2/k6o1TioPRBKDsFf5+VUVyoxZyloumDKZBSAkhoqMdAi8/xzXwWoJ9SC2L
	rvXmWtCs0hqBNSLvTeb2hhcjkyCn/14H/WZgmn9D6cEU1OzP4Rvo2yzI20bE81g1F+oEEQne/fR
	kMPcFQmzLvwT3PNuW/epo8uVTpHTJ9fqyjKO81Ew=
X-Received: by 2002:a05:690e:809:10b0:66f:c1be:3186 with SMTP id
 956f58d0204a3-671632d8d21mr921471d50.93.1789578062479; Wed, 16 Sep 2026
 10:01:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916100206.3062073-1-valentin.kindschi@fiveco.ch> <6aaa7552.8a922079.27013f.aa03@mx.google.com>
In-Reply-To: <6aaa7552.8a922079.27013f.aa03@mx.google.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 16 Sep 2026 13:00:51 -0400
X-Gm-Features: AcwNN1UZMooI5FcFINBxnpmniGZU7npLwECBCOtMurEe9uB6NwUnFdQZFQHg4TM
Message-ID: <CABBYNZJajx60mY+Fx9PPMSxhkaug_+3hY5L6C6aXeQoM=NSAFA@mail.gmail.com>
Subject: Re: [v4] Bluetooth: hci_sync: pause advertising for the scan address update
To: linux-bluetooth@vger.kernel.org
Cc: valentin.kindschi@fiveco.ch
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Valentin,

On Wed, Sep 16, 2026 at 7:18=E2=80=AFAM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/series/1166333/
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      0.75 seconds
> VerifyFixes                   PASS      0.10 seconds
> VerifySignedoff               PASS      0.10 seconds
> GitLint                       PASS      0.37 seconds
> SubjectPrefix                 PASS      0.10 seconds
> BuildKernel                   PASS      27.71 seconds
> CheckAllWarning               PASS      31.65 seconds
> CheckSparse                   PASS      34.36 seconds
> BuildKernel32                 PASS      27.89 seconds
> CheckKernelLLVM               PASS      33.42 seconds
> TestRunnerSetup               PASS      726.62 seconds
> TestRunner_l2cap-tester       PASS      16.64 seconds
> TestRunner_iso-tester         PASS      44.72 seconds
> TestRunner_bnep-tester        PASS      3.09 seconds
> TestRunner_mgmt-tester        FAIL      60.30 seconds
> TestRunner_rfcomm-tester      PASS      4.40 seconds
> TestRunner_sco-tester         PASS      7.56 seconds
> TestRunner_ioctl-tester       PASS      4.63 seconds
> TestRunner_mesh-tester        FAIL      7.81 seconds
> TestRunner_smp-tester         PASS      4.30 seconds
> TestRunner_userchan-tester    PASS      3.14 seconds
> TestRunner_6lowpan-tester     PASS      4.36 seconds
> IncrementalBuild              PASS      26.44 seconds
>
> Details
> ##############################
> Test: TestRunner_mgmt-tester - FAIL
> Desc: Run mgmt-tester with test-runner
> Output:
> Total: 501, Passed: 496 (99.0%), Failed: 1, Not Run: 4
>
> Failed Test Cases
> Read Exp Feature - Success                           Failed       0.019 s=
econds
> ##############################
> Test: TestRunner_mesh-tester - FAIL
> Desc: Run mesh-tester with test-runner
> Output:
> Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0
>
> Failed Test Cases
> Mesh - Send cancel - 1                               Timed out    2.462 s=
econds
> Mesh - Send cancel - 2                               Timed out    1.998 s=
econds
>
>
> https://github.com/bluez/bluetooth-next/pull/781
>
> ---
> Regards,
> Linux Bluetooth

Looks like sashiko found a problem:

https://sashiko.dev/#/patchset/20260916100206.3062073-1-valentin.kindschi%4=
0fiveco.ch


--=20
Luiz Augusto von Dentz
