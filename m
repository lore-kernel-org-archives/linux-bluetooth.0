Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFAC134CCC
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Apr 2024 20:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712263646; cv=none; b=TSC0JlekgG4LvY3hrUD1xR0Qn0upIHguowhtxIDMc+F0zskPaJQtCiB2piUCFXrJDLM2In8P7MQjv3yUMw0UyPH95rEVaiGjeFyxFUQtVec2t1nGNEHXbvWf9mu9yXPIT6qC53QFH8jmSDWWZLFrH83JWDpC2NSA65UVCNIy0fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712263646; c=relaxed/simple;
	bh=LmtF7nec1zVTECGrjIdB3aEMerCK3T62ep2M3zlGQQY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=XNE2MrL2umIUO6mJH02hV/N3330XmBf48tYvvrm0ihOpjbJj47n+v58+k5EKDQ/x2JX2drO1AYjF5K+tnxHTYeryTFJngqDIdcP8mIkwZHQgkOg1O8sL4gHCZnYfIE1vb1PiC0P7xjozhw68Oe7zFp6hLJ8J8wHxXgRT98fNDTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ocmylgvc; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ocmylgvc"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6993bc144a4so2137806d6.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Apr 2024 13:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712263644; x=1712868444; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FtqWLXNllapPd0OSrwS+ct80xh93SFAdXSUrtqBZIsQ=;
        b=OcmylgvcOMJNpV0vV1CM+JgYUFxchrZkCR6mpp4wsBhN9rj2LaRb5JHyF2vaZwphsD
         REqCekw1JGE7C9dilAuKnnUWZPRO28cGbdE/cUR6O4HbVaTo1hKGD3gWN4EC9Sn8x2FN
         Rt2zPiDTL6ZzQ20ErQx1GS8+zH4udn8+g83uYJufA38L+U0zuo+6HvD4gzoc3/6PoLFg
         ivCor4sohzdD5lC+ExWb267Jk/bn2yuuvgl1Y63KSKCAjCOukqA9hCpuSIaEBV80FoFP
         F9onqRUFGM/KYTLMSmwnmtGS1jHuwKXufj6kdIEVRGa83jZIVv09sil+/qpxaDcCnp7k
         lB2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712263644; x=1712868444;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FtqWLXNllapPd0OSrwS+ct80xh93SFAdXSUrtqBZIsQ=;
        b=VUT9zelMcL1bMOSw3qkUPmbv8cB9oVHi+SjNtItneUg1/8PYmc80y2FiDwEMCl88nA
         FcGBA4uz3h8RtqIeNQ1E05Biv1tGdASt0AJvyq6WRNcCzZTPIpVOSddI7iNn6hbNmOBy
         zBTtrDEFWTvIg7HDjX40gAmUXOjz5mBgzQSEQzC9WYevAXqFqUXZuSf4CRXrSAOG0Me3
         xmljaAGfxmyFg0Pl2ce1J5Pi1RFUz78dAj8QpG8VVNAidtApfpx57Oc0FmF55vn2vBDM
         l6QxXIWQ82lMibu1lcHqEl1U/QdrOrXrPKUteQ6qXZrdUJoLcGrabAQSdTgHlCZEgW4z
         NjXw==
X-Gm-Message-State: AOJu0YydciwuNVGWGppIlevQV9gRsLSWpODsZpQQvQuTLK3gMuu7ZTzW
	xEeu6cpBTpqTqPSgiVtTz/B5ef1feiFCUf1iDUv4Buu8J0w6SRaw882p5ijRN+I=
X-Google-Smtp-Source: AGHT+IFmgXKaisKuxkyMsJYqpfYZgMd6avpUdcaR8Vs+YsMNQucFgtNEo8QWZJyWbVjsCWd+TaICJg==
X-Received: by 2002:a05:6214:2242:b0:696:46d3:4dfd with SMTP id c2-20020a056214224200b0069646d34dfdmr872892qvc.37.1712263643547;
        Thu, 04 Apr 2024 13:47:23 -0700 (PDT)
Received: from [172.17.0.2] ([20.102.210.222])
        by smtp.gmail.com with ESMTPSA id r8-20020a0ccc08000000b00698fcfb4474sm56779qvk.63.2024.04.04.13.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 13:47:23 -0700 (PDT)
Message-ID: <660f11db.0c0a0220.ae872.0891@mx.google.com>
Date: Thu, 04 Apr 2024 13:47:23 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5076046892071996358=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: tests: add TX timestamping tests
In-Reply-To: <231de55e44e48272c02dac8ee735af9316ec46e0.1712243675.git.pav@iki.fi>
References: <231de55e44e48272c02dac8ee735af9316ec46e0.1712243675.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5076046892071996358==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=841499

---Test result---

Test Summary:
CheckPatch                    PASS      3.60 seconds
GitLint                       PASS      2.18 seconds
BuildEll                      PASS      25.33 seconds
BluezMake                     PASS      1706.77 seconds
MakeCheck                     PASS      12.90 seconds
MakeDistcheck                 PASS      191.44 seconds
CheckValgrind                 PASS      258.09 seconds
CheckSmatch                   WARNING   360.78 seconds
bluezmakeextell               PASS      121.74 seconds
IncrementalBuild              PASS      11211.61 seconds
ScanBuild                     WARNING   978.10 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
emulator/btdev.c:436:29: warning: Variable length array is used.tools/sco-tester.c: note: in included file:./lib/bluetooth.h:219:15: warning: array of flexible structures./lib/bluetooth.h:224:31: warning: array of flexible structuresemulator/bthost.c:610:28: warning: Variable length array is used.emulator/bthost.c:784:28: warning: Variable length array is used.
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
emulator/btdev.c:1101:10: warning: Although the value stored to 'conn' is used in the enclosing expression, the value is never actually read from 'conn'
        while ((conn = queue_find(dev->conns, match_handle,
                ^      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
emulator/btdev.c:1388:24: warning: Access to field 'link' results in a dereference of a null pointer (loaded from variable 'conn')
        pending_conn_del(dev, conn->link->dev);
                              ^~~~~~~~~~
emulator/btdev.c:1510:13: warning: Access to field 'dev' results in a dereference of a null pointer (loaded from variable 'conn')
        send_event(conn->dev, BT_HCI_EVT_AUTH_COMPLETE, &ev, sizeof(ev));
                   ^~~~~~~~~
3 warnings generated.



---
Regards,
Linux Bluetooth


--===============5076046892071996358==--
