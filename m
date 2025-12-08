Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288B423536B
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Dec 2025 15:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765208495; cv=none; b=dE75KubrPfB6VWAMoC5n4K+nK/wjnya8RyxYYn8r2UOxqzWG6CGJJKAuX704MKfY/ymjlCxCm+PnZ4flVOFrFANXww3Q3eOakciG/iPGvc8Ywhv6bM9BV/uj0RBOFwy9wNxIqoJg6wpc4YHy5WMm+H4ig31f45fGtzw1bfAhjN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765208495; c=relaxed/simple;
	bh=9jHgmnqnlWV2JYqFCDR57PXSAtsWgG84sOx7voZbGGg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KmowCRSGV9BvP+A9eS9JzPcUp9ANJDfiH1MQnKUGKKi/l+TCzT1XGM5WFTJ/7LBY1QiDEbH5SEWAPzz5MkLcZVDkPoIvCAd9qLq9I95uwTDC2W2VGsVdOn8duSvNxCN0idC9y8WqIXvVjuEFdQ8DgZhfElrY09ZJuCq8IZFRs2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kRp0sZuK; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kRp0sZuK"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-37a2dced861so46439801fa.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Dec 2025 07:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765208491; x=1765813291; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TdIxYHx8lXZJdczXuJZyC+LSIFRXQ29Bol9iUPCXQzs=;
        b=kRp0sZuKSv6Xdb5jIiwJs5xWHLMN2PKOCSxDWbNCwmgPq/oQ9NDCfNLCXj5PKKtuUF
         WItzbPPuL9nTDKkaLDKW0IHKxZJR0q7XVMWx2el2lQG8JAMMkbwc/qfBucP04dkErH9Y
         t5eaTBAYRhg0E5tIOi/dwV6iUK5Dj3tk7Nqtjc7TJ/BxwFmwkJf5tFQdIwCXOUGBRvis
         8+4RBnmjJBvuWzSW4rvex0pLt8Gu6KhUZzs/3xwl2tjVNBD6HiBRe2+R6yp/CC+FaLO1
         7jdx79Kfa9N5ovTMdUr8zA8bboQ/fcw+iO6TE08LdYlETajtbEZqzAwtAp/kqqapIzxo
         MmbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765208491; x=1765813291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TdIxYHx8lXZJdczXuJZyC+LSIFRXQ29Bol9iUPCXQzs=;
        b=Foa9KQ0lEPRIFywj9uDyioIPnSmXnaG3NIXNWWRvK72UyRn4gKSN8McPaXmxemJHnF
         gjsnGl8c6Ij9t6qkSx8LS7/9zgoBtaffNCknsdH75B2PIAw8pw4mu4Xb9vvsKuJ40zIY
         +BCxyZIsLPK+/B7jFCX8QMSfsgfNJflHMdHXcyDIqN/yFj/hQh8utPNuWt1vQ550puRH
         Zm7xlXE2MJ+SniUs4Zrhsn4DZmpUJCk/DMG/i2k98M/ihsMsXsuRzYNBBBuyz46DaKhx
         t7Z7+AEmUWXW8EVqKTZ/sHs3aP5l0qcz6ZPg6XxEkoSzdj45GN7aoWxZhu0oI7YlIvVc
         Zrrw==
X-Gm-Message-State: AOJu0YzThsUfsDkwNsRCorqOoeoWIHkVhkjnw3L8FBWkV8bvSPmzVZzr
	QMqURufnn2WXh96+BJtus8N9eM60vLawkAnWTHyazWI9T/5+e1ic0WePrNeOxmhdtRDGnZt2P3g
	KtUq5QTOuh93IoFvzoIgy/QlPgNGqF/aHihul
X-Gm-Gg: ASbGncuU+uKMfs6yWhihqZmAY1GiMHmv4OQHi29x5SYmyyRpcz53Pqr4Dq3mv7RkIve
	HbfyYiu7G+Jo6sLthOPhMQm4bwpl0K4bBq8vYN21C8HpD8ypuKYxtxQDeKqQInGTpUuaiTF7q6b
	jyXx65JsELPfpYcGtsdW6Ucria5gBgJgU21Vce93fTi6vcMzU5dKyvwxL5Bt4PWRoA6v3GZGUPB
	419qj5kSf1jliO0LxZ8NYk8yKArIAGp/qBH+PhqmDtZ6cy2mLM0I4Em52h6o3bukMBeew==
X-Google-Smtp-Source: AGHT+IHlnswypvpiQUHQDw7FSwD25P4ZofMC81E+Nu552DWP/mpIUQpmS4DMEJxsdSgi3NuQK5ULuvkp8yJfPRqJa5Y=
X-Received: by 2002:a05:651c:2222:b0:378:d020:b6b3 with SMTP id
 38308e7fff4ca-37e6cc0615amr41529181fa.7.1765208490281; Mon, 08 Dec 2025
 07:41:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251208095508.3481977-1-zzzccc427@gmail.com> <6936ab2d.0c0a0220.11bcee.8d68@mx.google.com>
In-Reply-To: <6936ab2d.0c0a0220.11bcee.8d68@mx.google.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 8 Dec 2025 10:41:17 -0500
X-Gm-Features: AQt7F2qvDH0fuVQtrnYOqxndM9l609zL_NDo2JsKg19NSDN9MwDV7nfNckOaY5g
Message-ID: <CABBYNZ+2PxLJvbW+HuoGMcjFBh+=riMRKBXisRrZMvQRMfC+xA@mail.gmail.com>
Subject: Re: [RESEND] Bluetooth: sco: Serialize state check in
 sco_sock_connect to fix UAF
To: linux-bluetooth@vger.kernel.org
Cc: zzzccc427@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Dec 8, 2025 at 5:40=E2=80=AFAM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=3D103=
1328
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PENDING   0.32 seconds
> GitLint                       PENDING   0.24 seconds
> SubjectPrefix                 PASS      0.11 seconds
> BuildKernel                   PASS      25.46 seconds
> CheckAllWarning               PASS      28.37 seconds
> CheckSparse                   WARNING   31.94 seconds
> BuildKernel32                 PASS      25.61 seconds
> TestRunnerSetup               PASS      558.74 seconds
> TestRunner_l2cap-tester       PASS      24.64 seconds
> TestRunner_iso-tester         PASS      88.68 seconds
> TestRunner_bnep-tester        PASS      6.29 seconds
> TestRunner_mgmt-tester        FAIL      125.65 seconds
> TestRunner_rfcomm-tester      PASS      9.38 seconds
> TestRunner_sco-tester         FAIL      14.61 seconds
> TestRunner_ioctl-tester       PASS      10.26 seconds
> TestRunner_mesh-tester        FAIL      11.58 seconds
> TestRunner_smp-tester         PASS      8.61 seconds
> TestRunner_userchan-tester    PASS      6.69 seconds
> IncrementalBuild              PENDING   0.70 seconds
>
> Details
> ##############################
> Test: CheckPatch - PENDING
> Desc: Run checkpatch.pl script
> Output:
>
> ##############################
> Test: GitLint - PENDING
> Desc: Run gitlint
> Output:
>
> ##############################
> Test: CheckSparse - WARNING
> Desc: Run sparse tool with linux kernel
> Output:
> net/bluetooth/sco.c: note: in included file:./include/net/bluetooth/hci_c=
ore.h:153:35: warning: array of flexible structures
> ##############################
> Test: TestRunner_mgmt-tester - FAIL
> Desc: Run mgmt-tester with test-runner
> Output:
> Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4
>
> Failed Test Cases
> Read Exp Feature - Success                           Failed       0.111 s=
econds
> ##############################
> Test: TestRunner_sco-tester - FAIL
> Desc: Run sco-tester with test-runner
> Output:
> WARNING: possible circular locking dependency detected
> BUG: sleeping function called from invalid context at net/core/sock.c:378=
2

The above seems new to me, might need to check with the likes of
sco-tester if you didn't already.

> Total: 30, Passed: 30 (100.0%), Failed: 0, Not Run: 0
> ##############################
> Test: TestRunner_mesh-tester - FAIL
> Desc: Run mesh-tester with test-runner
> Output:
> Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0
>
> Failed Test Cases
> Mesh - Send cancel - 1                               Timed out    1.792 s=
econds
> Mesh - Send cancel - 2                               Timed out    1.997 s=
econds
> ##############################
> Test: IncrementalBuild - PENDING
> Desc: Incremental build with the patches in the series
> Output:
>
>
>
> ---
> Regards,
> Linux Bluetooth
>


--=20
Luiz Augusto von Dentz
