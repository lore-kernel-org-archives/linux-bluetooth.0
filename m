Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012BA3D9E
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 May 2024 16:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715961810; cv=none; b=dv8FYDlsgW0wu9iLwg4bfA5x9+fuHQQ74vzqKaLU/FkadoX2PdQ8YklBPpzIEzLD1egx+wPmT1c2yo0Gy2IcZuzdYzLvagaOXBzRZtVSgF4BffvUJTTTqkSJiMO/MGzw8ZbHL2WTRaaAWLQF9TJgNNO+gDyj0o5K/eCR/dtro7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715961810; c=relaxed/simple;
	bh=eu6LnRhRBNb7OJoVxcvrPWrFfl0TYugdYLS1XDkqOPE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=OFUbGT44Bc+Ed9ewZdu6n/qor3u4+iuxj6q3RGGgfl1g6wvrLTF/JTh/pJs7dOMTtZ0KPXjk0Dz+0sySS2noNrOi8QukMckvtwAfV9oXKCDEbyQakAoBvZ/EwcPfpbeXC5J0E9ZxEG0iQumnuVoW6L7hgNURvihVYDQfvYEK90w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ftVOn/ZK; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ftVOn/ZK"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-792bd1f5b38so59960685a.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 May 2024 09:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715961808; x=1716566608; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wQeEuZxlTQOCEEP2yclJPiw43S4i5ioSQHIYWWG2TEQ=;
        b=ftVOn/ZKybSNeU2hplzidZjfQwIiyqHKRAz8Fj8j+SkjwONifmq2j0IXFeum+wghQh
         +q7zTe04LKk/mVwG9jE8bufhOwwTfKfsfu5Q1/wWd4+OdhNwmSJibIlzNzgFBW4SUofP
         azPQProBtLD6T/Wuor4gwq8AD5mktDLC0tHe1IavQubK7YZBssi1kUumOHQG7rIl6VL1
         SHlhlUBor6BTidxW443dB8lYmpImditG8uHBzW12f3/SOmpRtKG4OJMg+Tt+cc+QpUpo
         h6dOC7ZPXNoIWrdRFUwZbHp9wvU2Ifx6B7iRH1AA459Wnw7Yp+Fb/KfNspUNzlpSyAXW
         jVyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715961808; x=1716566608;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wQeEuZxlTQOCEEP2yclJPiw43S4i5ioSQHIYWWG2TEQ=;
        b=UBgUehVGHvrqovZyEkmZoW77BzLLLa4ccY1crjAmF6TxCPMWY2sxMFs0e8rzWE1yOt
         FE1c4bSKQ6VkMPAtzg+rX1a0KVlmnmdTKkNBEcxXY9eCThx2aEe8OmDdOum8pUWVY1R4
         ysRxIBJMnF+/iuQIgD26v10AqZAqQaO07s3poq9K+aTsTuIb/+0KC9Oetbu7ZJRw/gKV
         9T/eaNaGNxCsuhtc+CbILJWbrajWP8zz0YOe5klV7pUSwXTboognPtubJq/L15891IVp
         NFOHmZIaqKg/ljEuZG8FB0h8Y5Zni4rMZNxXJ7LG7Cq19DYTd7bXU7MHu60nlxyfrcJf
         bu0g==
X-Gm-Message-State: AOJu0Yzw4F827YH0UoxnaWK8eG9Bpmx0x43HHoEVfSM7Jj2oDBjTn6ev
	ANThXb1XV4jNTfjRCeUtmR55UQjEbbIz/sVR2WTtRRypZh5P49fftHSneg==
X-Google-Smtp-Source: AGHT+IE6VD6YTF+265dgdWvz/MyM2fCTFKsA8BGcKSyFoEMXopcfbP8zus6DWRYT1k267so/V0bl2w==
X-Received: by 2002:ae9:f801:0:b0:792:f698:3053 with SMTP id af79cd13be357-792f698328fmr858735185a.68.1715961807790;
        Fri, 17 May 2024 09:03:27 -0700 (PDT)
Received: from [172.17.0.2] ([40.79.247.110])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf2fc466sm910623585a.77.2024.05.17.09.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 09:03:26 -0700 (PDT)
Message-ID: <66477fce.050a0220.a4ab3.ec2c@mx.google.com>
Date: Fri, 17 May 2024 09:03:26 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7415255443609716576=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: test-bap: Add Broadcast Sink SCC tests
In-Reply-To: <20240517123436.146332-2-iulia.tanasescu@nxp.com>
References: <20240517123436.146332-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7415255443609716576==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=853984

---Test result---

Test Summary:
CheckPatch                    PASS      3.36 seconds
GitLint                       PASS      1.73 seconds
BuildEll                      PASS      24.25 seconds
BluezMake                     PASS      1748.84 seconds
MakeCheck                     PASS      13.18 seconds
MakeDistcheck                 PASS      181.70 seconds
CheckValgrind                 PASS      254.18 seconds
CheckSmatch                   WARNING   353.25 seconds
bluezmakeextell               PASS      122.98 seconds
IncrementalBuild              PASS      7837.32 seconds
ScanBuild                     PASS      998.38 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/bap.c:286:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:286:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:286:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:286:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:286:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:286:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures


---
Regards,
Linux Bluetooth


--===============7415255443609716576==--
