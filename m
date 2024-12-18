Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4DA8488
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Dec 2024 01:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734485454; cv=none; b=amBG131Y5lY8m7iYzXrQPnzOAaaYSxTPl9DbD3l75HI1UZl2aNGGQMVPX7adB3sxOrDfpXuTR0mAp+OkhgujP44NvMIMl5xUHgsBPtP5vbLc4rOcRMFOrGLu/+rFU1ORe6MQb38ysV4k/wd0KL4dNVrUAKGotMagbxws/S1jHKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734485454; c=relaxed/simple;
	bh=mK/HQu8Y5toB17nem1YkL+61dC++OncbKiUKdkfo6QQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=S7YqG3awInhohaMYr2OAd//HwBjPEAQSZ0pZb8+kiU2s2wpL6b8q81fObKLMqMTY+IrSd3nvJuiyNI3+hDSHDbAhGmd7/OM4NJqMPJLZQ1eKNFJUvWn5V4DNaGKtzPw48wDXUKG6yqdDWp+T3M7Ru7OreYa4m7Lkqsd9weyoNqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DfLJhhhz; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DfLJhhhz"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4678664e22fso53481141cf.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Dec 2024 17:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734485451; x=1735090251; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pkJnmd0zsVbvAGNuPTDaQnEdm05n19yLCHw7VnJgksc=;
        b=DfLJhhhzlxVH0q1Hui9O9s28iFvrMcPChJ1uEueEPdNsp1x5j/Y8fPN7GLFvVEkdWZ
         yPtbE0cFegTMed20ueCdm3PKne5Tqa9u3I+wtbNIyeWwdOcdhne8hAROK/idi+E2PqJS
         ELjTlMMYknin39gQ4cR7Tc9j7zcnzv9soxZO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734485451; x=1735090251;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pkJnmd0zsVbvAGNuPTDaQnEdm05n19yLCHw7VnJgksc=;
        b=alfltrtT9MBuIiCvvr2o6BeWN2uCZ1aco+BLou/N5RxlgQh51Sirs2Yc7BzCvigiM/
         ZMdzwjJjxeh/7ldS/1CKDhtydb3ynEau9UArz4eKSBvP6HqFN1NT5IBKDxT6f/W4GQNR
         BN9M4C7kXmHYarPnaeZpimnUCTjc49klNbeRskspIswgqhOSzIx6UI9MHxVd0cTW44h/
         KFJLuHJD83Fg+x2hqMfulGjI/eZfFIB5sl9qAXY/L/UiRt/pOuby/wY5oFalGRnqywi3
         O1SAXz2zex7hnUTGpPlIMBJrO3GtkiwFVqUnOj9PrUoAxc0QtfCyuw9bkGINRbVzLW/g
         nanw==
X-Gm-Message-State: AOJu0YxqL9YMIU1l0b88IyXwDoxaEYlqJDPc5ptwzndYzRgvFYYucbNL
	s/C60QdQqH276okJ3ISSvg+P0BYVGePFFnvj+hSGeiqQrAh6jqpA7OqV40x665pvXRdu/2EN+Aw
	RdA==
X-Gm-Gg: ASbGncuvsJH+cWhxcf52Uvg5P6b6xhRIMbQVfcsTL0iq1BL0PK9izfRm8nyPeNXyuis
	PwDMi/RoXHCwedj7z3g62LD14pSO76RM5pM/DMbQjHcoqxesAycXOE+YXCBqt4KhpVzsZfGFaMa
	BfHs6XsXDFLGWtL4bMu0So7+ITmBbTjlRGZoVtHBT+2r57cFzCVNMdAstOosbHpBLzwAlxcEGBO
	XR/yCJpspaT92mWAgAXxEAwjWYc5UKSLgZD+R3vzAE0QNOPMxszd9c6MBeRxvtj979N+nNiyuG6
	+EJDNuaySgpO0UoRQcsudNM=
X-Google-Smtp-Source: AGHT+IEGWnQNWKOlL4ihox/H0QaUglaWe8NvjOhH21LHPxqCPrTOEYASXMQ311WhhbARq85mM2IL3Q==
X-Received: by 2002:a05:622a:19a5:b0:467:5531:cc62 with SMTP id d75a77b69052e-46908de3201mr20704581cf.18.1734485451092;
        Tue, 17 Dec 2024 17:30:51 -0800 (PST)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com. [209.85.160.175])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-467b2c6a211sm45485041cf.15.2024.12.17.17.30.49
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 17:30:50 -0800 (PST)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4678c9310afso69861cf.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Dec 2024 17:30:49 -0800 (PST)
X-Received: by 2002:a05:622a:1991:b0:467:82de:d949 with SMTP id
 d75a77b69052e-469090acc59mr1371211cf.12.1734485448538; Tue, 17 Dec 2024
 17:30:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241213120420.v2.1.Ifc708cc471a8834b344c26fce1ce2fe3e5992cad@changeid>
 <675bb989.c80a0220.55725.032f@mx.google.com>
In-Reply-To: <675bb989.c80a0220.55725.032f@mx.google.com>
From: Ying Hsu <yinghsu@chromium.org>
Date: Wed, 18 Dec 2024 09:30:11 +0800
X-Gmail-Original-Message-ID: <CAAa9mD16+vYKhWz=C=h+9cvo88HuzDoO-+eF55+Me25TbrgLTw@mail.gmail.com>
X-Gm-Features: AbW1kvbK5CsdVSk6fmCzVfx9p46AX3F9m2MaSxULootK_HBa6EP4ZjpRlf6ZAys
Message-ID: <CAAa9mD16+vYKhWz=C=h+9cvo88HuzDoO-+eF55+Me25TbrgLTw@mail.gmail.com>
Subject: Re: [v2] Bluetooth: btusb: add sysfs attribute to control USB alt setting
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

I've addressed the feedback in v1 and passed the series through our interna=
l CI.
For two LLPrivacy test failures in the `mgmt-tester, I'm wondering if
these failures might be unrelated to this patch.
Could you please take a look at the updated patch set when you have a chanc=
e?

Best regards,
Ying

On Fri, Dec 13, 2024 at 12:35=E2=80=AFPM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=3D917=
446
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PENDING   0.24 seconds
> GitLint                       PENDING   0.24 seconds
> SubjectPrefix                 PASS      0.09 seconds
> BuildKernel                   PASS      24.52 seconds
> CheckAllWarning               PASS      28.65 seconds
> CheckSparse                   PASS      30.25 seconds
> BuildKernel32                 PASS      24.18 seconds
> TestRunnerSetup               PASS      430.44 seconds
> TestRunner_l2cap-tester       PASS      20.19 seconds
> TestRunner_iso-tester         PASS      29.42 seconds
> TestRunner_bnep-tester        PASS      4.76 seconds
> TestRunner_mgmt-tester        FAIL      119.16 seconds
> TestRunner_rfcomm-tester      PASS      7.52 seconds
> TestRunner_sco-tester         PASS      9.32 seconds
> TestRunner_ioctl-tester       PASS      8.02 seconds
> TestRunner_mesh-tester        PASS      5.86 seconds
> TestRunner_smp-tester         PASS      6.91 seconds
> TestRunner_userchan-tester    PASS      5.02 seconds
> IncrementalBuild              PENDING   0.61 seconds
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
> Test: TestRunner_mgmt-tester - FAIL
> Desc: Run mgmt-tester with test-runner
> Output:
> Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4
>
> Failed Test Cases
> LL Privacy - Start Discovery 2 (Disable RL)          Failed       0.190 s=
econds
> LL Privacy - Set Device Flag 1 (Device Privacy)      Failed       0.153 s=
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
