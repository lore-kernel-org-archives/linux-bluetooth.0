Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793724532;
	b=VHR5d7NYJw+hR/yo7SMJnDzJJn9rNT5VKwI5W/ET3eUmFnBcqgiqVbafh+/DC/wmayl9
	 uhvHTttd/nLE7RiQgKcM1xVhOMeATnPx0lJUPdUcvFjV0kraudgXQWG3tGoo/otD34uNP
	 Ilys12VuiUH+D0OS+cF08rHgbF5CiwKrP+OEAz84Ch3mYZCXOjKK3IZRd2/pzn2pP6Q2Z
	 ml3880q4pLoL44xBnvIS25C3ZVcqt1Z6+IZ1agZ2lfHGsxqNRQdCWUNzJcwMfqn74CiL+
	 jZwwd+27CcUaK6RsX3huj8IZvexqVvTUZy7colUTUhZ9M4KKoQ4cpW6sUhUfEVRnIUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793724532;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=C9Nq9O3qNSzl+R19C1RhgsxTyE9/PRc+dkNJ4HJu0FI=;
	b=cMhPJzPnxiXoA6k6bjOolrGZGDy8NmbUgxQ+WZpAj5v28l5eF6RjCdBNfhDmYzkToloK
	 tWvg6HaKzWkq6bbpHnpFjEKr+/7PFKc2DT2HoIGC7pgZCVK3Ym85JP4h2XkpU1yAOh2tW
	 ulGTr05KXlir2GbKTNJBviyaNcAmCRzUNB0WzETT7D8cqlysShhjnn4tKNIWLpqPt0Y0c
	 U4DzKTFrjc1vzXmYytZEcyr82DPfjsOMhBADtGXQPgSZyT61O1DKiR0gV8Ml7KAFdkzLx
	 jz34EL+3FbquX1euJz+ZvHkrldEYWq12KSTmVsbepm3QB+ZfjkyQtiR4Ob6QcKBBxgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UsAcy1m0;
	arc=none smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECE3606A324
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Nov 2026 16:48:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0ECE3606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UsAcy1m0
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1a8cc11ac42so4318099c88.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Nov 2026 08:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793724531; x=1794329331; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=C9Nq9O3qNSzl+R19C1RhgsxTyE9/PRc+dkNJ4HJu0FI=;
        b=UsAcy1m0d9kddMxFEA9jIBte9aA06Bo+CsCjU+/7WBf6Aq9SkfqwfK6qHxaF8albY3
         r+/mxS+JU9PlhY5rWCIV+pGUsmOYpJ4YPx/J0JRnghUojYNGhAPA9+Hps6+xVEZK1Mz1
         Ig7vmn07zt+6/N1mnS5+vVJIeit5p9JS8XwIWqYfpDiqDdf177fJSH9+ORgpKCPtjpfR
         SOHFTQPIngxoldaDUwq+/Y853YoRN+fZ+2tiAN6KC8dUufqaHXi7QPjKrcxfZNaWYQ0+
         iK9OocwLwucqjs5oRWRTi87MuECONcKH3DvI4Q2KzUK6DjIOoJ8JlcmxegWy5/rJVeYu
         iF8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793724531; x=1794329331;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=C9Nq9O3qNSzl+R19C1RhgsxTyE9/PRc+dkNJ4HJu0FI=;
        b=qg0RLk2ZKnw7CVd+w4hN28xvDGRYJv/pB1rdSfuqykTmAL9+U+J3qBcXpa9kJa6BdG
         uWP76jdkZvwPH4p8C29Vd6n9l/1cG6Ljck+6F8DqGYdQ13OVZJHH7hRZ0LcNVqSarnJs
         K2YOl8PvtXiqUCXO6QmvEEhrQVDtPzjF1BweMAJ/hj+TtmOpEpyXuDKvCy57s1S9y8SK
         MF+O+R4qyB38VRMWhL7dpfzpFOgbkq+nFwk75nRJFPPsR6HFDr6SzVUf3ddLe4a85Asu
         F0CbP1wIG/yk1G9RntDkMosPbKu4EZ2Vltmrgag/6gnuOOakSkXSElu3HL0FBwZ3QWIZ
         iQRQ==
X-Gm-Message-State: APuU4Z8LgAcnDmC6SBJuwzrZ6BNNgfAhbT3o1nhLjEfOjCb1f4Q4CzrG
	ogxDuHV/0eAxNUqa4/QKetd8JSufq/sPIXttQUKvdqVUElbrwPM8xOg4CHfHCg==
X-Gm-Gg: AYBFou0btR9nJDwvZlI/+aiQBABlxm/fpSkc2LU10keJJVhP3buj7Kl204qnkHowSBU
	mJgPjyMJRCVPeTsBDPfb8ek653pZmYlPLXQwfXm4xxrqLkwo6JDs2iUSJpW3YKyRNhMBvsWnLTp
	XB57c0psx6L15QeHDjaRVWkjKS2LnDMkLCVroHN7gSYHbg9U2a8/4rREQmeqdilwTxBTC1+aMo0
	WSboJ9Gm71sgUSAI9bQpSCC+3/HaaOSPm7DKrJKY8YcYeOl07wQnfukggAgdGm/4Y6jgNi5TAgf
	x6e/ouku688YiYdUmBMOlMTcQY25JO+9sERnhyrwpk7oDSCg+2e3R6uZ1Gw5rc0dJarKG4qmFZh
	DuUpbGLlt0z3jpooX7FK41JY/pa1gz0weezBzERl74m6Q3grOgmYszRKQzk5KZSxAWyOMu7XLB/
	r1zAipebOis2aE/2duEQjGl6U1Vplgvrfl0a/ZiVCXX/c+jZSTf0JXKpIvXsPd678UsOAxSi17V
	PIrOyWQoJ7Rh4IoXYhUerzRwi0jARghsCjTJPqrAQXV5yliu31Vg2ARCEggFPeW88YM8J+rZNlm
	n0c7y1Bu4A==
X-Received: by 2002:a05:701b:4590:20b0:193:5449:b889 with SMTP id a92af1059eb24-1ac6088a33amr18924835c88.45.1793724530706;
        Tue, 03 Nov 2026 08:48:50 -0800 (PST)
Received: from [172.17.0.2] ([52.159.229.161])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c1c290sm111605c88.5.2026.11.03.08.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 08:48:49 -0800 (PST)
Message-ID: <6aea1071.c02443da.b0a20.8803@mx.google.com>
Date: Tue, 03 Nov 2026 08:48:49 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6173335369595374186=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, k.chen@smail.nju.edu.cn
Subject: RE: Bluetooth: btintel: validate the BRDS domain packages
In-Reply-To: <20261103114127.75143-1-k.chen@smail.nju.edu.cn>
References: <20261103114127.75143-1-k.chen@smail.nju.edu.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6173335369595374186==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1200286/

---Test result---

Test Summary:
CheckPatch                    PASS      11.04 seconds
VerifyFixes                   PASS      8.99 seconds
VerifySignedoff               PASS      0.52 seconds
GitLint                       PASS      0.48 seconds
SubjectPrefix                 PASS      0.20 seconds
BuildKernel                   PASS      32.56 seconds
CheckAllWarning               PASS      36.83 seconds
CheckSparse                   PASS      38.97 seconds
BuildKernel32                 PASS      32.01 seconds
CheckKernelLLVM               PASS      35.78 seconds
TestRunnerSetup               PASS      764.36 seconds
IncrementalBuild              PASS      29.45 seconds



https://github.com/bluez/bluetooth-next/pull/1053

---
Regards,
Linux Bluetooth


--===============6173335369595374186==--
