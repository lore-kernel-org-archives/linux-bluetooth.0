Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D250E37CD2E
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2026 19:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781206867; cv=pass; b=WIybifr1Y+EerIuVvKAQVobhgu06KgPXBWMN5fHQzbHVtQgp41qUxE7OXm3R1T0KimhcQRkemcUgq5fWjMbJTpRAONu+ftEY2f0znpDY+QQjBQYre/ndN0XZaGf0EwGHu78wyfV7ibYtAARSNr1CePR+t7D56p+5qF/AeXn+Bgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781206867; c=relaxed/simple;
	bh=Mcp80uOw1dd0YI9uKJiGAaMsMuUXVPPjwpue79fkLZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IeQIv7hAlNd0z+ze6YElVzgJGvRy6eewqXmm9JiiVz05MVP1kHswqhuR1cNK3SqD308nW0/GdYw/vR2JJZJitH/XGjhpQ4wstzQe9kjmkLpd3AqgFsF7tI3dU4aoUoL9RA27r4XpoyNg9l2BI6aRjwzChbGqudFeuC6wyRLTK3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oP+apO77; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oP+apO77"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-660ea43107fso273670d50.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2026 12:41:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781206861; cv=none;
        d=google.com; s=arc-20240605;
        b=V8ZUB8OgJBYfM2R0VAXpYgdaa/NXmNDqIOY+0c9b85Q7S0DcvVGecYtJgnjMyy7Ohd
         sLB3JDkUjkLZ1GpCv7/ydhEfZaGGh3NM4zpg96bsBX9cnJiUfzNynp9YreACZTxVHxHM
         /kzpTwwjzOGymbySARzs5y8LHydv4NrS5juo5pqplW1pCjHuYdbaTBLoS7lngOHKv14H
         tus8diJfXqPUx20g+BT7UVbbyJmvqcxWZtRItPqwVyoP0+Z39twBAT7It4Fd1GUFQeTD
         Px+X6g0TY50ovUMWUuzc4eKhUVziPONTaVuVfKsz/B1B1xa91ISyOP+uNhylL2E61ctg
         czjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=I+S550aKktfXx3+V9vEkAnyEgEKxjd7fbqZV1JNkoVc=;
        fh=xabQmkgoc1hk01hwdaExVTneHK4+BY30dJS2XiCP004=;
        b=MQQgOZ6sbwXPjhuWVV2DD8I+iDlPUgcBEkaGZUZDPbvhMB7roVvpqgqp8u3bH6btml
         w4M4qN5akXWygiQWSLokOAnqd82svmiRzNjsApKxBniB9wKWPCWNCBz1pcyP2c6I1Ss2
         30M/SOFAWQf0z6JwublZ6KMQ+YrS4fx+/3VN2kFTUalPcR3K/hBMObQcBXWuE2kyfZPe
         kplxFPODKXkpXd2E1FUcgM1gXWxtzdIz0jCdDsLcREJIkUps2lxsAqCECeFV4owY/zEb
         +F6bt3Jep2tbNP2Z0mTFJhO2bTIIJz78yOaiQgiVdHr5ZnlMd/oOCqOhl+yoNir4UiMk
         4YWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781206861; x=1781811661; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I+S550aKktfXx3+V9vEkAnyEgEKxjd7fbqZV1JNkoVc=;
        b=oP+apO77kq3RzGgbnoc68j1lbFazNSgE3k7MumJqovlsBiazYzpevGv9TJAjYpwN6z
         WLQ1ZAUu29vZEG0hvnZRYFVjEiz7p3WU/n/vXInCAJtU02U/DRNWNiB2o76od7mgj0Uv
         juAp/0g10bwq2XtfYWDmJ1IiYG8tB4cO7XHGozDGXBiGCWmx8hTPQpz+g1cZe8HakdDy
         SyUUpZQhdssIype4mLkoghfYZwNj/y77Or7AGSwgvlls+IYyMWaFwUf/VJvF2mA8RGBJ
         WtWZ+V6cFlBAa7re7xIdcGhelY437fSsJLFVRI7xOIVOYpvHXXYYTfUtJ0RI35mU6c9M
         OAkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781206861; x=1781811661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I+S550aKktfXx3+V9vEkAnyEgEKxjd7fbqZV1JNkoVc=;
        b=ErUYxBb4LUn/G6f1C+Eat98E/Eq+BfQusP/Q7Cl6GEEcXWdTniEf7sm9hUq0l4II8l
         D3K+Rlp9JE5ZKrfgdFSU9fRWzRAeQAKzi4ytYbe7z33m1DFS+du2d+9FdBnSFp279TZ3
         DlApkwWZOAjPbS0PdwvYx+I7glfnz5RPHVDo4TiN8yXf5XPyzD38A14jdAgsxYyDbReb
         HMcX670tCj1j0BvhOC7rVMJ/cJdnSRNA7QXmsGSix5EFfgKTTZ/GGTQ10fhMVTXAq0f1
         PQAsnGFjtLDEhOEYmx4auLSFuj6zvsZP0dxpYjhk1aD6KlskY8GU1mIi7SB4YscVGHeP
         JY9g==
X-Gm-Message-State: AOJu0Ywl8cotEXUbkoqTVWfLm7seS292q+1B4n6hWX8tQ2ikvH0eRzDz
	TXTEzSMhanrMje/4qsGyOn8phQEc14DhDlsXe6703RyB6RZhjnhrl3lYp+WmSLwYgzUCpHJOKzm
	FBQbM6jX/eMg4FmhIhRRjhgpj9zYVZSv3GBLr1o4=
X-Gm-Gg: Acq92OGkS/+JBnam6e2kpGQlBMSK7XyBlNOCkprQ1loTFcaJROZozAzXZSE7V1SJL8Z
	IAFdCALIvnsehXtmu4DrABFUInI69xZ1JbyC6kLWaaTTncoZASCq3ehvsRQYnDsye8KemUEByFx
	ITofqSTmmE5x66PYOH2vFtov3DnOlS1CMaQukkJOSOdfySP8JzBXu5MnQ31TE41dbE1Osjl0M0I
	+j61SLxYFmfrHH9W4tolAKWPwQRgxmuA5kN+uuePYq4x5QAmGnNYz4tXCJa0ruO+TNvADBBALKL
	qKrZ0o0/yXKq08d5CBZc6jm4b1FZ1w19UpkVeZX7M4sP+rNNXnfD1yCW9VOkYEaXyZc=
X-Received: by 2002:a05:690e:12c8:b0:662:5e4d:2bb9 with SMTP id
 956f58d0204a3-662696799efmr3662565d50.16.1781206861483; Thu, 11 Jun 2026
 12:41:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611152039.2176565-1-oss@fourdim.xyz> <6a2b0a77.58f6a988.156c41.2a93@mx.google.com>
In-Reply-To: <6a2b0a77.58f6a988.156c41.2a93@mx.google.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 11 Jun 2026 15:40:50 -0400
X-Gm-Features: AVVi8CcjpFpogHS02Yr0jpAJNUfMcuhLODdYn5KDCVSAZ-SufytBCE9llFVFwCE
Message-ID: <CABBYNZLbp3nkPpWhc6b6PE-vdE9mw6YB9hiysF1KYsg+-MBUnQ@mail.gmail.com>
Subject: Re: [v3] Bluetooth: hci_conn: Fix null ptr deref in hci_abort_conn()
To: linux-bluetooth@vger.kernel.org
Cc: oss@fourdim.xyz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi @Pauli Virtanen

On Thu, Jun 11, 2026 at 3:20=E2=80=AFPM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=3D111=
0143
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      1.03 seconds
> VerifyFixes                   PASS      0.10 seconds
> VerifySignedoff               PASS      0.10 seconds
> GitLint                       PASS      0.26 seconds
> SubjectPrefix                 PASS      0.09 seconds
> BuildKernel                   PASS      25.18 seconds
> CheckAllWarning               PASS      27.48 seconds
> CheckSparse                   PASS      26.19 seconds
> BuildKernel32                 PASS      24.16 seconds
> TestRunnerSetup               PASS      531.43 seconds
> TestRunner_l2cap-tester       PASS      59.98 seconds
> TestRunner_iso-tester         PASS      77.10 seconds
> TestRunner_bnep-tester        PASS      18.80 seconds
> TestRunner_mgmt-tester        FAIL      216.57 seconds
> TestRunner_rfcomm-tester      PASS      25.55 seconds
> TestRunner_sco-tester         PASS      32.10 seconds
> TestRunner_ioctl-tester       PASS      25.34 seconds
> TestRunner_mesh-tester        FAIL      25.86 seconds
> TestRunner_smp-tester         PASS      23.11 seconds
> TestRunner_userchan-tester    PASS      19.69 seconds
> TestRunner_6lowpan-tester     FAIL      45.82 seconds
> IncrementalBuild              PASS      24.08 seconds
>
> Details
> ##############################
> Test: TestRunner_mgmt-tester - FAIL
> Desc: Run mgmt-tester with test-runner
> Output:
> Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4
>
> Failed Test Cases
> Read Exp Feature - Success                           Failed       0.239 s=
econds
> ##############################
> Test: TestRunner_mesh-tester - FAIL
> Desc: Run mesh-tester with test-runner
> Output:
> Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0
>
> Failed Test Cases
> Mesh - Send cancel - 1                               Timed out    2.495 s=
econds
> Mesh - Send cancel - 2                               Timed out    1.994 s=
econds
> ##############################
> Test: TestRunner_6lowpan-tester - FAIL
> Desc: Run 6lowpan-tester with test-runner
> Output:
> Total: 8, Passed: 3 (37.5%), Failed: 5, Not Run: 0
>
> Failed Test Cases
> Client Connect - Disconnect                          Timed out    5.057 s=
econds
> Client Recv Dgram - Success                          Timed out    4.985 s=
econds
> Client Recv Raw - Success                            Timed out    4.996 s=
econds
> Client Recv IPHC Dgram - Success                     Timed out    4.997 s=
econds
> Client Recv IPHC Raw - Success                       Timed out    4.998 s=
econds

This seems unrelated to the changes, is this something Bluetooth:
6lowpan: fix cyclic locking warning on netdev unregister would cause
though or perhaps is due some other changes to 6lowpan core?

>
> https://github.com/bluez/bluetooth-next/pull/305
>
> ---
> Regards,
> Linux Bluetooth
>


--=20
Luiz Augusto von Dentz
