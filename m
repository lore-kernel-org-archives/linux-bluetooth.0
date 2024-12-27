Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB5D1292CE
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Dec 2024 04:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735274447; cv=none; b=RZbE+6U3fkZ9bthoAta6iecmXn4djKGmHUd7Z+gKP4ryr3DieGHgiyy8eJsogbBHWfhQyZZvQq0N4/mo2pK10Sh9SH0hmr1yW1/d+VQtWDwKTiH1nZV5b/O4TgVl3FPO1n98ghaz3zTzVh92AyCDknUJk7PdcSw92cI8xq3b5z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735274447; c=relaxed/simple;
	bh=fltG6HENSYfbAprq0XWmF+VdsMiZUlavpYqXPP49iyw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=MMbufK/ILxbV/+32m4u2rsTbuE2E5c9b9zYcsvr/S4QO8q9w1MdMCUoGlAKioKQyv4st9A7UNXpS43iS+0ZGBBNBc5gP1RxayASMhOL10KOQ+TreBpR8dtC6tDylxitoBr54DXslPmZCkxEl30LQNHnMhRI9YuNrsltCvwxHOEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=c2eawpKh; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c2eawpKh"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6d8f75b31bfso61212606d6.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Dec 2024 20:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1735274444; x=1735879244; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bWK0rTMkvNbFv/AHVuKBS6ZrQVOSGLQ72OIKJj/90j4=;
        b=c2eawpKh8TSa5rMxvItEOOUOiAu8O0F5tpHov8XV7hClyW9HBe0Ik8Ewz70tLdg8xs
         LNC0US2IYlXoSqUDkwJrm1fhlSWyPlzG9IomZB6joiSLX/GaKW1oNzcvNuGI3lhyqmrX
         Q0eigwWU6U1eXokYtFPSd1LkVVKJDxnTO4lhI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735274444; x=1735879244;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bWK0rTMkvNbFv/AHVuKBS6ZrQVOSGLQ72OIKJj/90j4=;
        b=b9i+IMA+Ecu8rSgJTW/xUZSrADWBD6P9RekTdS6Y5MZFtMMTpJAXO/FIcZEo2g7kJj
         oxQ/zCs9RHHelJwfxLZP/ZzSYftjNN9pleLsRiVW91ExoyzOgiF41zWV5EPV3HKbyEq7
         MQwVUuMJ3aYlny4cU0X6VIuGSqTA8l8D3KPRaD79ryv0aNAFcLuHjx7AuzWC3wp61NJT
         Cd+8k3uEub8nMe0HTYF0Mg2YfOlToprZskPzMrtO1frqqhKWmoTFGU8dkZI6xtmide97
         XPoe3jF+RL/W/8jkc9e2h3u9NVFbKz/fmDGFb+zAcf+QVSZQs5E4Kdp7ZCDnW4OHWN+U
         W5Mg==
X-Gm-Message-State: AOJu0Yx38r2G4FNSssVkQMH7AjjbIwBm6sphDZuEi/nTa0ns8y3kPC7Z
	JBBlwjgXIOb1pdzG6yiB/ZvFM7vdbmUD1OwOeTfylfH25GHenNRENZp4PCZcCSUP83D4Yo4r0k4
	=
X-Gm-Gg: ASbGncuAHJLzAxdtYydvYiEdHCbb+WjM59PWuvZDjA5MhqsrQCxFaSwUAQ+ZQ7FDn+I
	IIG5bpjNl2BQmzuR0ZmupbDlVivBOtTPu3Iycb+IvP52WrF6L0LiPDzXnQGm3qe/9eBm1cXmHzD
	wqlToaI5UyX+X//sJXpc1+8nMRGxaGO4fIiS0QVnlLnXbBldaDxec0bK9irIHug3JiCFzGMTsv/
	P6INFXMKs6vMQMZELYDcqXE3Zf+D1Eoy+vorFkL0hMP65Gw0jwLXW70+fvgYgZV//75taii4PzY
	hEZcn+Bw1DO5YrXnYxQn0xg=
X-Google-Smtp-Source: AGHT+IHyngT4UKwOmXjw/ol0YI9+kDcaAz5xke17R92LUitq5iGd12JJACyghGJmzD06siF9BPzrJA==
X-Received: by 2002:a05:6214:238c:b0:6d4:243f:6c9c with SMTP id 6a1803df08f44-6dd2330c5aamr468012556d6.9.1735274444184;
        Thu, 26 Dec 2024 20:40:44 -0800 (PST)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com. [209.85.160.180])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd1810cfd7sm76663366d6.30.2024.12.26.20.40.43
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Dec 2024 20:40:43 -0800 (PST)
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4679b5c66d0so1720081cf.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Dec 2024 20:40:43 -0800 (PST)
X-Received: by 2002:ac8:7dc2:0:b0:466:97d6:b245 with SMTP id
 d75a77b69052e-46a4a9bf122mr20241911cf.22.1735274442419; Thu, 26 Dec 2024
 20:40:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241213120420.v2.1.Ifc708cc471a8834b344c26fce1ce2fe3e5992cad@changeid>
 <675bb989.c80a0220.55725.032f@mx.google.com> <CAAa9mD16+vYKhWz=C=h+9cvo88HuzDoO-+eF55+Me25TbrgLTw@mail.gmail.com>
In-Reply-To: <CAAa9mD16+vYKhWz=C=h+9cvo88HuzDoO-+eF55+Me25TbrgLTw@mail.gmail.com>
From: Ying Hsu <yinghsu@chromium.org>
Date: Fri, 27 Dec 2024 12:40:05 +0800
X-Gmail-Original-Message-ID: <CAAa9mD0XEC8Q-bPvc+DJS8TLNBeWL49utUzgtmvWiCAxFEZuvg@mail.gmail.com>
X-Gm-Features: AbW1kvbFmmcXxasnjmQBlvALH7tNqcZD8Buhfl4kUlLb4eXp9Z3N5X9nvlpryTk
Message-ID: <CAAa9mD0XEC8Q-bPvc+DJS8TLNBeWL49utUzgtmvWiCAxFEZuvg@mail.gmail.com>
Subject: Re: [v2] Bluetooth: btusb: add sysfs attribute to control USB alt setting
To: linux-bluetooth@vger.kernel.org, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, chromeos-bluetooth-upstreaming@chromium.org, 
	"chharry@chromium.org" <chharry@chromium.org>, Zhengping Jiang <jiangzp@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Looping in chharry@ who will be taking over this patch. Thank you for
the review, Luiz.


On Wed, Dec 18, 2024 at 9:30=E2=80=AFAM Ying Hsu <yinghsu@chromium.org> wro=
te:
>
> Hi Luiz,
>
> I've addressed the feedback in v1 and passed the series through our inter=
nal CI.
> For two LLPrivacy test failures in the `mgmt-tester, I'm wondering if
> these failures might be unrelated to this patch.
> Could you please take a look at the updated patch set when you have a cha=
nce?
>
> Best regards,
> Ying
>
> On Fri, Dec 13, 2024 at 12:35=E2=80=AFPM <bluez.test.bot@gmail.com> wrote=
:
> >
> > This is automated email and please do not reply to this email!
> >
> > Dear submitter,
> >
> > Thank you for submitting the patches to the linux bluetooth mailing lis=
t.
> > This is a CI test results with your patch series:
> > PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=3D9=
17446
> >
> > ---Test result---
> >
> > Test Summary:
> > CheckPatch                    PENDING   0.24 seconds
> > GitLint                       PENDING   0.24 seconds
> > SubjectPrefix                 PASS      0.09 seconds
> > BuildKernel                   PASS      24.52 seconds
> > CheckAllWarning               PASS      28.65 seconds
> > CheckSparse                   PASS      30.25 seconds
> > BuildKernel32                 PASS      24.18 seconds
> > TestRunnerSetup               PASS      430.44 seconds
> > TestRunner_l2cap-tester       PASS      20.19 seconds
> > TestRunner_iso-tester         PASS      29.42 seconds
> > TestRunner_bnep-tester        PASS      4.76 seconds
> > TestRunner_mgmt-tester        FAIL      119.16 seconds
> > TestRunner_rfcomm-tester      PASS      7.52 seconds
> > TestRunner_sco-tester         PASS      9.32 seconds
> > TestRunner_ioctl-tester       PASS      8.02 seconds
> > TestRunner_mesh-tester        PASS      5.86 seconds
> > TestRunner_smp-tester         PASS      6.91 seconds
> > TestRunner_userchan-tester    PASS      5.02 seconds
> > IncrementalBuild              PENDING   0.61 seconds
> >
> > Details
> > ##############################
> > Test: CheckPatch - PENDING
> > Desc: Run checkpatch.pl script
> > Output:
> >
> > ##############################
> > Test: GitLint - PENDING
> > Desc: Run gitlint
> > Output:
> >
> > ##############################
> > Test: TestRunner_mgmt-tester - FAIL
> > Desc: Run mgmt-tester with test-runner
> > Output:
> > Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4
> >
> > Failed Test Cases
> > LL Privacy - Start Discovery 2 (Disable RL)          Failed       0.190=
 seconds
> > LL Privacy - Set Device Flag 1 (Device Privacy)      Failed       0.153=
 seconds
> > ##############################
> > Test: IncrementalBuild - PENDING
> > Desc: Incremental build with the patches in the series
> > Output:
> >
> >
> >
> > ---
> > Regards,
> > Linux Bluetooth
> >
