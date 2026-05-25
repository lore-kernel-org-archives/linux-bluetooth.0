Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F293ED127
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 May 2026 14:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779718884; cv=none; b=d4JXVfdMeN2CQ60aWShBmMUk8RkWj6yOZvXejACulQyq8oi2H3grEL2jtZXXUumF0+cb5oviSQXNk3gQTghJ5J5lgkT7dwU0X/DcSdBMNywdVJmn1mBDgsvM1tbhj6+X4fpPLVn3cAjrKMqmsqMbf+eR+hnyT3yY/POg6sPECeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779718884; c=relaxed/simple;
	bh=qQej/vjN2nySfsj5ojH2mdwcZ+2AS0mEK9Rq21/8jSk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=FKUhynS1Us1S5JdNicWAtj5X7gjL03x2iiYCC+8ljyruJk4yOkQNB7U6IUJwLj7WCFK82WOU0ebBjy+RLY0FxYcJKVRZWKgmClIsIFpdQFU7Ok7qmrjgJL79CROVeC2f5K5jwqB1Gg+M60sRgKliVwZZ86XkdAXhSokLmkkKFZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NtWq0Kl8; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NtWq0Kl8"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-3045c195251so2638559eec.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 May 2026 07:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779718881; x=1780323681; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XrN532ajGkDa1wGJieC/zS3Z65oGErY3Jave9Myqb90=;
        b=NtWq0Kl8qWpnz6VlUVGvuDEjrtE2CIY8oz32Ktf9y91/6PJU+jDas2PGLM0awDGa8a
         +vluONgcjljwJiibF4eoDWZg1m67BRR1J/OPrIVjzPjRIE6sMs4ILeiQqqnnJuN7zYA1
         zvVPObraXGRbFZ7q/hihikkPzzObPJ0Bj5TYtJy+cUfN6bjaYLBQQ29YsqOtJOMKqOeE
         n3zag1TMVc02RrKiz5be+Yt3jdZiHsp7ySDc7UkYFseuav//pbb+PwsiqrLbD8AC2GgG
         4aM4xCaN6aNTyqkmGNb+/lAwQDaiwJHSYEGKe/kJtXGBxm4ChVWJdgVcQ0AGG6OpwV4v
         Y98w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779718881; x=1780323681;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XrN532ajGkDa1wGJieC/zS3Z65oGErY3Jave9Myqb90=;
        b=hm9LW7z466ogAbBwojiWKEHtFIkhD/Od8aDfK8ID3xoQGtXu5gKyY1wUZwUMTLWsZN
         s8pXaGU56NufJneTn8UX4GabGt5PxvbSzPYNO3vxg+Q+jzu7oJztSLHZr2jgQqJh6UQU
         J19wD6rcsd2B5forl5G+3ibioD4vJqBESrW5B2R2iOqMqoDs4x1TBStRf8i90M/RfiXH
         XH3Zem0pEK0MyxnYejPfxx3YhljblX++Z80HFZEVO2hve2agF4EGMhiIeJwPQTpuKlaP
         GF6j327ROWMqFLrWPT2v1bfH9oarT3sJz2wgqhFGULPU+T+9V9/1HyiBrl/2lweiXHzx
         Ubzg==
X-Gm-Message-State: AOJu0YysaJwW78t8WsIEPW2UR5/LmbXfK+GCC4xhtNQUk9ioITEce25Y
	YKx1aMZD029lq6UTSuSAZwR4tbG7gO61Fcv6QQVgNHYlREPMmlmi8QJnzi54smQ9
X-Gm-Gg: Acq92OGtFWPxn6uPFbEH1I9Aqb2PE9kyP0lz5lNafC0z5JH9eq4mJzUdIyT9oVmFPVZ
	KsEX9/uqGrDS8XbNkyUw3Ws0vXPkk7p8NgXv6w0XRqBb0uQlLFee0tds5n8i0zlFSXXJntk0HKD
	Y47c5ynK9CLut7r4tFExQUscEalBYNOf3/YwIZyGT9BXFyEYizYBpZw6HheZNPZ2fBZllJBS4uk
	fQw0B4lUaHV8zW50SI8DDeSbBO9EHTBmDiCGFk0Tyk4VhnSPmQrnXVeYBaYcPLTdgILtvsjKtl+
	NLFqIgJSjtk9UerkaDtvwHg6uaoJSb9EFgyqfdaRbaJLAn43JPwp3xyFzCgAHY8RlzL/G98bc0P
	2kt3WitFG5+hxGlihz53bZXFXXn2G9CcIdNOnE6GHCgTQV6IM0b6RkbOHvtVNn6pjZHZPmoe3W+
	6e1X/wy2NBeTX59G/8fhi0r0pB7BGqUOMGXjYQ2w==
X-Received: by 2002:a05:7022:1284:b0:134:7497:2153 with SMTP id a92af1059eb24-1365fa42d73mr4983953c88.20.1779718880504;
        Mon, 25 May 2026 07:21:20 -0700 (PDT)
Received: from [172.17.0.2] ([40.65.61.42])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1366a4011d9sm6429729c88.6.2026.05.25.07.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 07:21:19 -0700 (PDT)
Message-ID: <6a145adf.396644cf.22259f.7075@mx.google.com>
Date: Mon, 25 May 2026 07:21:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2086898801061662074=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, suunj1331@gmail.com
Subject: RE: [v3] Bluetooth: RFCOMM: validate skb length in MCC handlers
In-Reply-To: <20260525110443.139485-1-suunj1331@gmail.com>
References: <20260525110443.139485-1-suunj1331@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2086898801061662074==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1100421

---Test result---

Test Summary:
CheckPatch                    PASS      0.59 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       PASS      1.31 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      26.59 seconds
CheckAllWarning               PASS      29.34 seconds
CheckSparse                   PASS      28.00 seconds
BuildKernel32                 PASS      25.80 seconds
TestRunnerSetup               PASS      573.06 seconds
TestRunner_rfcomm-tester      PASS      25.38 seconds
IncrementalBuild              PASS      25.10 seconds



https://github.com/bluez/bluetooth-next/pull/236

---
Regards,
Linux Bluetooth


--===============2086898801061662074==--
