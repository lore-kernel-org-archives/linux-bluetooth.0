Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5D0208D0
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2026 06:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779085035; cv=none; b=XRsbhQOpUXT47vs0E75J5BXS77c6sRzc/Q3eftaxHSdSESUhoCc5Pv2Y+AGQ/0fveqzdOE1s/W1gE65VKOuyme5CwR8CEaqOyF3b9e5NGzCm8ZM57F3oW8y8zfP9/DRkAXmRSV6KXf4b9Ab4zlTEZ0sZcpgjigbZbrLdq8pCvtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779085035; c=relaxed/simple;
	bh=4X3awtay4qrziubhWHvF0C2mYTG/RlpS1RpVt7cEs5g=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=mIPH0pjH1cN9xqFElazulK8RsWw4togYDTMieNrgAa89wBz4NWaSmH2bbA+QbiJTKXU88B3xCPA8vHJoKE6/lgxEo56hLrjerkULJLJhAdkbzwGtp9Lr0Qt/Mu8IGlUGN/514Wlitr7ltdRE1V8UJ6zoICwZQBoowsA2BjSxRR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VvzkMMrr; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VvzkMMrr"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7bd5dde63dbso12098787b3.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 17 May 2026 23:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779085026; x=1779689826; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xiewKTP7EPRDBiRvJSTr7gD7JrrAUH72CS2jwJyGNLk=;
        b=VvzkMMrrXdgtw+uTNG0x3l5ARbxiwCG+q+2joFwapg4GO3fi1l8ZfhV5U+IfeXYhDA
         hOElUP4O3uIW3sJH0aGJDoUTFTMlVQIaahsKmKxQm3JX5xBqq8SNfV/ozHxeXUTE3H40
         xyJVfQ1LqXY5by8C8REciQkH4AFUcc8lXgO1u6ppqrp+PiX4gRbeDdgPdS8gWF+UFjCJ
         yTBiTpyJyyNQ72Jkm1NNxPqaBUU4OcllH5uNvUqie1Zb6Wz7NG0KAAnIrFN28fVCyT2/
         dDihr4zm4fiziSsrdHMaMQPQL+e/+8XKuFmLbVAybIhjeb2ZvbZDsYtgabcpXrOe6Tln
         hfIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779085026; x=1779689826;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xiewKTP7EPRDBiRvJSTr7gD7JrrAUH72CS2jwJyGNLk=;
        b=YzKDD3SoktojsFryQJxQS6JAi8RAomk9qPUPPeHhA/QOFOdioxojgE/+btRkYlUoFh
         tNg9MhcfGH5NF99XEkkJ+JTaIeNQSIYwQSQ9RnpkOayoiIVmB2Mayhl7wOjHevzUx6aP
         5BmqTXzzrsHh2KKhDoSKE+6eKOTuD8MskoA2ckww1IGKbR7ln+9PGCX5o97sYgmWCIiq
         ZX+XCUEbGKXrqhFmZUo4TKI1Q4l/QXUAoT0WX0A36mHNTCpZZTaHDK25SpMD1dYZzqFD
         j5Y9ur67K2XyCDuEVbHVL9YTf+ItH6WVnpSUD+9/hBb2SeiVQsNUoP07i+ZKt77HvevB
         42Ew==
X-Gm-Message-State: AOJu0YzmgrGXl79brcHSaKda1Dxb/cQrDc9Fd0kYGiJAKYD5wPT8vyys
	jVbsPJyq3oUJRBYjLAd2FH6+DE2n4Q1mcXKd65cs1TeT5PENMyhLu0SYRKhkpg==
X-Gm-Gg: Acq92OEc5ZHtmVthSUyym9HF731TFi4t2d8tAVJiIBedTEMFApShf4S/Q5Z+qvsAHJw
	Gn2d/WmEibaGazfjGMHwg0Ry0Li3Pqqt/7X6pCotWmOWD09Cpu2mVgFSoZhco7rbRngijFgfa0z
	fG3FgWb/jz1QbcS7QYoQHf5bpGYXxil3FCdkWjLSWx9V3Ged9wUQ39G76CgZekH780sSYEJub2f
	TbSCoUro4t6AW3Skm9BPsYRIIQoy0OprGwEv5Yr+eEPxSiTW/5EEt/QTn/WfSpuiJB6hc7h3ZXe
	XriXGu8MQ5B5IgHo1Am/ejqWOsG/FWL1ZS1P0F2OP5Rk71kOYl515rRh6353opN0+0I14S30lBK
	AYU62OWkfbGldDkpFB3c54jK5B+usm4N9EXpb4KaojuRjf7JMpZ53/op5kCmA5g9rSQjZ7qgOSw
	jlOJqy3GQeOPcXxAkC8guYKo2XHFZHocw=
X-Received: by 2002:a05:690c:3705:b0:7c0:4f0:883d with SMTP id 00721157ae682-7c95d1d977cmr150287197b3.44.1779085026210;
        Sun, 17 May 2026 23:17:06 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.160.195])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7cc991c939asm17390487b3.6.2026.05.17.23.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 23:17:05 -0700 (PDT)
Message-ID: <6a0aaee1.5f9e0b67.37c16d.4034@mx.google.com>
Date: Sun, 17 May 2026 23:17:05 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6853909805113928754=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, liujiajia@kylinos.cn
Subject: RE: Bluetooth: btmtk: fix urb->setup_packet leak in error paths
In-Reply-To: <20260518022402.20398-1-liujiajia@kylinos.cn>
References: <20260518022402.20398-1-liujiajia@kylinos.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6853909805113928754==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1096249

---Test result---

Test Summary:
CheckPatch                    PASS      0.68 seconds
GitLint                       PASS      0.30 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      27.15 seconds
CheckAllWarning               PASS      29.85 seconds
CheckSparse                   PASS      28.26 seconds
BuildKernel32                 PASS      26.02 seconds
TestRunnerSetup               PASS      574.83 seconds
IncrementalBuild              PASS      25.59 seconds



https://github.com/bluez/bluetooth-next/pull/208

---
Regards,
Linux Bluetooth


--===============6853909805113928754==--
