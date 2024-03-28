Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509F73BBC5
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 Mar 2024 18:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711649106; cv=none; b=rF4Gv/KT1ncj6v8oLknb6lHIpever/zXOj8nZj7xd8D7oW+jNe8J53fm41J0IE0RYqBhLgoSkFojmrnko4m8bDmX6AB267y4MoVrcSeypVsKQng6b6N7Pmy8XmpBc1Ap8kMO3qYuCnddm8Sk8w2htoi2qwHCsxyPgg99t4c3KB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711649106; c=relaxed/simple;
	bh=2a79i+PoGTgTvbvmFxY0lKQox/kVLsT7zkDRhyh/MDc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=LkmM+ZlUBaS18g2G+ELnVRd1Jwik4tOLJDiY03Wi/1yW1rShjRR1T9CyqEwgTM2OvEsoEM13nY0i9zympUXNMTHk93DD9ArS1fOD8hrfq/XLUeqW8pvf/X6CvrwgivnpuQ2NkffoyKHiDd+Ey5kJgs7s1oXlAZcAkn3UwYjKIk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mz8ITmJ8; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mz8ITmJ8"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-430ddb1a227so7368351cf.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Mar 2024 11:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711649104; x=1712253904; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eWXerRw57tAZbINoK0yKCIhTwRzLsQP/48rA7k2Yx8s=;
        b=mz8ITmJ8CwrhehQ1b4pLHLZ8+OH+Y61BpbPoJuZLAQs5BOBydz0wdJLIMVgKIzTqvh
         ZpwIuSOJhtboIENKPRtPqvMgp3YCiyCVi5J91Y2rIjmfOJcVNy1jtxTP3SAUmYm32rGf
         BMvvII8ewkuoHIt5mO/0InB5vZdOVJfyZzosBKJ2+d59xnc+KmLyqicleor0Kst3OwQj
         yAJn2AnUOCOgfZ/K8A6EmkHWNbJPi+ZU4qCQgM/4I8Qke475rKzZgkx1Ib+ZnCJUdiV6
         I+BQtgwJ5O25pos8pYHY+IUdnlYdPGkWNyf/lBdrR7OIQOoxoss2EWfqimkfq157jkHP
         mcIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711649104; x=1712253904;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eWXerRw57tAZbINoK0yKCIhTwRzLsQP/48rA7k2Yx8s=;
        b=oNwNgyjfgt6WtgZ8r7DACRBqMjsFEp2NUwQ3liezvX3u2JnFy72nDskYsfbqDoP7ch
         tzrPi8tSWaLDBgm0lFzXxd/uYCvss+TOL8sZdiKZ9037fGJnxvP9xxtMPsW0DKLa4CGb
         s7BSii4+IvdglcyAD7Dcbj9G9usbz7ht5anviWGAq2GNij8G/8DsvO3v3RsI1FLvqhUF
         tL8h0zLIXLhJNBby05zFprnhCSkn3osR1MP85uTyQRkl3h4keYHFi/2Efw+MeSXkYNIz
         nDlpFA8cp6ZwNYzDHOR0NIV3SwCZ2UUaDBPhQNLd24qhdKrf88ttxI/JZOgrCC79DQbv
         OqHw==
X-Gm-Message-State: AOJu0Yz9ztqBegi/voSz2BAFRlY9h/nqrsrDEXLwoaWlhbBl97ecqgzg
	qElIl9Wejal6BYK22z2S8zzld+L6+xQucOktrdsaGGxV8M1VmcCAerTEfzWG
X-Google-Smtp-Source: AGHT+IGcFRvDJkScmR8yD/+hIlRpqyxKNETz3Dj4xMOgSMoTBCD3GozqG56xLKWWd1jcV/oom3QCdA==
X-Received: by 2002:ac8:7f4b:0:b0:430:be66:50a4 with SMTP id g11-20020ac87f4b000000b00430be6650a4mr34647qtk.63.1711649104145;
        Thu, 28 Mar 2024 11:05:04 -0700 (PDT)
Received: from [172.17.0.2] ([20.109.39.247])
        by smtp.gmail.com with ESMTPSA id cr7-20020a05622a428700b004313f54aaa9sm819260qtb.5.2024.03.28.11.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 11:05:03 -0700 (PDT)
Message-ID: <6605b14f.050a0220.3089a.4c4b@mx.google.com>
Date: Thu, 28 Mar 2024 11:05:03 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1062295982931557922=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v3,1/2] input/device: Fix not handling IdleTimeout when uhid is in use
In-Reply-To: <20240328153252.1752439-1-luiz.dentz@gmail.com>
References: <20240328153252.1752439-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1062295982931557922==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=839408

---Test result---

Test Summary:
CheckPatch                    PASS      1.50 seconds
GitLint                       PASS      0.72 seconds
BuildEll                      PASS      23.76 seconds
BluezMake                     PASS      1635.96 seconds
MakeCheck                     PASS      13.39 seconds
MakeDistcheck                 PASS      173.91 seconds
CheckValgrind                 PASS      243.57 seconds
CheckSmatch                   PASS      343.80 seconds
bluezmakeextell               PASS      116.95 seconds
IncrementalBuild              PASS      2937.28 seconds
ScanBuild                     PASS      983.30 seconds



---
Regards,
Linux Bluetooth


--===============1062295982931557922==--
