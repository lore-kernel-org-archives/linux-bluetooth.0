Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AEC2F0C7E
	for <linux-bluetooth@vger.kernel.org>; Sat,  8 Aug 2026 22:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786228769; cv=none; b=hC8pn4L+1Lnhv/vNTrK43cgKwltw8meh8OjE7rcyGz4XO6JkwBNkWZyEHKc0GNGt0h91rBLTn6zU2m6wezCZBrXgyPCcOt7CQbgZ61tBYiXyFbz4+Vv+lKiBA4jcQazzHCEVAzy449MEjUZoCzB9ZqqqC0FvfRJMfxatmnqn/yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786228769; c=relaxed/simple;
	bh=DXHXGyta7VKW9Ucgzu2dgXRlM6oU/wDdkibdAk88uUQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=PNsc00XJHbiGSAbrimhHCJ8DVp77Ad6ZXe5cbNKQyMgpIzwCVDydLOrhQpdm1ZxlegMREfvoLocK/Y8fFvj2piTV4KP/yKV8aahRRFQcsiWC8JCD05Ld35p+u8NrGbcyxtWC6dN2mONeRE+7L+Dkxt07c7E4WL9KugKkh84jj6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kyx+5jLn; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kyx+5jLn"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38125cebfdaso870730a91.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 08 Aug 2026 15:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786228767; x=1786833567; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NeF6BMC502teMOj0xuE47dqh91bN5TU5Gy1d5oL5zOE=;
        b=Kyx+5jLnomFgpB5Vs1NvDId+DWATV1J7sk8sM+WabRjfxS2Ve2RwBO+s3XYi4SCtTa
         bRCnEU1ZOoGpEyRRxKX+RKkoaBftjHDFZz4Tge/WoAkleQFawO2B4itZo5BUX1cjSedj
         0LntjJ6mijYmirxl0gXN92aGd9h/95/1BE00xp7GjFJ06+8lAAGT+Ew0Za08g5PPmz0+
         /Um9GN27p6emAjcuNQnKhhy8QvUyYU5+Gu/jq/+VdQuiza0agh4sPY7uqtQ9YpnyLxp0
         9xwehwD4hfYSRZ3TXTaW+ItUh+ShaxfqsMUJvGG1fBqFztZ4N5Bna9Miwrv71TToCakq
         JfVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786228767; x=1786833567;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NeF6BMC502teMOj0xuE47dqh91bN5TU5Gy1d5oL5zOE=;
        b=SfK44/DQaMfcx4y+Tj9u2vwtLovQKyrw5oTCG1K8lcCGSqs/pmrb9hKUAZKoWHJ0Uy
         sSGcyhGG/gFixI9/fbnxty5LHHLxQzQv8yIjzlGz1/M08WjAX7hB9eZjpNr/KrODR9+Y
         vsk1ALSPfDQbaJE3/ZvGr5ssBF3Z7DN8JZVCqsbT9jrAgW+krtA+dQ4XSeEUSET8+/J2
         /nFqWb+jNhbYDT9CzATqJbZdFTL0vxeeZI9kQU+HKfnr8sp7HauG7aqOE2aLleQZuQvj
         XQVC1vD3jzObRR8+S4brkLdE12loF7tDhMAVNdKzYI9YXsCOpSTAYAqimTSGcCHaSpMR
         Z0hg==
X-Gm-Message-State: AOJu0YyPatEytmBeA/9QQMEh9FrZXyTAhgWTFibnK/4Ho2pztX3XBS1L
	3vtlYUPfHdsJi51WAich9fUMM55xe7d+oZm2aNDTiZC3oEdfRvGT+cLf6UQU2g==
X-Gm-Gg: AR+sD104C3OBL+d3c53aOV6kHRB2eK5dYK/V3Ug7xKLUCepHyoOUaDSzIBk1fLwhIEt
	1NzJn5ubrXFlsjqsnmX4ZgEvRaAc65u5h0UUpAPfUQus9jOV8CLStDBpIRPTTT7JaMiv9qu5zOL
	GND/iqkERzLa0MVOVa5bKjADCZ6wAvkGvLzDcc1vVXjJbq0hzh4n4Mce7iGOMkzFzxLSEMtqTqc
	C4dcxgf5EySOMsM/TxoZNOthpxxigCt4m2F3IBQndciDGKbPwDeXNAOBZhm+LUAuqWAj0IGsbWd
	Gz9p/wj81rqNdY/pwvuePI6Gb0ptkul+mGOnGpN7/M/9kAkCTB/IYv/yJNStiJToIG7E7oraF4l
	Mdut9ru1/5KwmtB+7/KlCh/9qgdimhoFRf9LlRRkjajOHbJ+U88ddXyb4kn2w/B4UfCb4jl3f+X
	DYjNW3TTWRhMe4CEXvFw2Y42OgqMxd6pwjGy2IDJuAi9wea5uDSec7pFywlOUiFIld
X-Received: by 2002:a17:90b:53c6:b0:38e:101f:c867 with SMTP id 98e67ed59e1d1-392622eb744mr15487905a91.18.1786228767163;
        Sat, 08 Aug 2026 15:39:27 -0700 (PDT)
Received: from [172.17.0.2] ([20.3.215.34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39085c393d5sm9673884a91.0.2026.08.08.15.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 15:39:26 -0700 (PDT)
Message-ID: <6a77b01e.8f0cbdd2.40ecf.b59f@mx.google.com>
Date: Sat, 08 Aug 2026 15:39:26 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8742517604337682049=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: Bluetooth: L2CAP: reject accept queue add unless BT_LISTEN
In-Reply-To: <204b3dea7b0e001f64920ed1114d38c16afdb397.1786225848.git.pav@iki.fi>
References: <204b3dea7b0e001f64920ed1114d38c16afdb397.1786225848.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8742517604337682049==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1142792

---Test result---

Test Summary:
CheckPatch                    PASS      0.55 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.06 seconds
GitLint                       FAIL      0.19 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      27.48 seconds
CheckAllWarning               PASS      30.25 seconds
CheckSparse                   PASS      28.89 seconds
BuildKernel32                 PASS      26.78 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      504.75 seconds
TestRunner_l2cap-tester       PASS      64.78 seconds
IncrementalBuild              PASS      25.38 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: L2CAP: reject accept queue add unless BT_LISTEN

38: B2 Line has trailing whitespace: "    "
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/561

---
Regards,
Linux Bluetooth


--===============8742517604337682049==--
