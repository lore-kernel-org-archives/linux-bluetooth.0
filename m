Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E2A2A8C1
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Feb 2024 10:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709031452; cv=none; b=OgkfIBp8RVdDh2NZHx+2B02OtgD9VJYpPQaY7PjLJmuXD4QNNlFK3nIP+5L6KiWuFGPjpmY822s5ykLRlIbYBTBfL4FsoSJyC3wrwst4Q23HISoOUdz/ak7SOqG1rRlONsgxZ4ts3bJEOX9dipj6L3yZXBS1oPuDQL/BBQznZq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709031452; c=relaxed/simple;
	bh=feQ3QM0Y7oX2577xXz06Tm8pLz7gqYxJlvraOOPCRa0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=WAg7uwue3u5b4CNVv5Xz+1PIXtYCtlwwsONr/DDbai3+TQhEolH7kN0gDG1wGUXwBkAs3Nv2ykBmgq8vcNJfzQFY9aZXxOyhbpfluUQkuJ/Tc1BRRJx8L8qUCuc7n1L2Ne8uaPWwQ6ya1U6GSofKZA+7do4DkzcIXD0+FqHXTjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gk6QAwjE; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gk6QAwjE"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1dc0e5b223eso34016845ad.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Feb 2024 02:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709031450; x=1709636250; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=STe9lg1LCSoTkV+M00SI5kquFUoSOfLoXRlMTqPeY10=;
        b=Gk6QAwjEb9Ebn/1o1Kzl9/P66TQxJCFHJ3JHTqDN0dWtRDwvgxDDwerYn+3k8Dmo4X
         xOGQ66NMTbRY6bEr7ZmMhZazvWCN3pRUqEf4UAlGuM1H58V2TZSMTv1B+aT+yfviQg25
         rt6VqLfqrmiEId1lHI8Q/X4ZahWvUyv5D0KKviu9Nro8OSEK3cU5u3MoeKzDGDKMNOVa
         qOBEnSwWa+VhEVBg41zo/02UvWUb4lkkG0UbPMBNQixEuIiI20Q/vsSPiCiX43LwC1DG
         Y9zrDODlk/HRrzSz8ay4g4vQyZsghH1oNMlTbeu9W9tTMZUzlJJXXN7WEBs+HiaibYqb
         pW5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709031450; x=1709636250;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=STe9lg1LCSoTkV+M00SI5kquFUoSOfLoXRlMTqPeY10=;
        b=UrQV0WpV1aayCmN5zdY6sUeK6VQrFTbyF/sTbKbUFexPaZ2oVI9PVCYNEwMz214ZZC
         3VXOsAL36GsZIauklpIi0YHYhjxDHhaX55BbKH8VNRZ4EJ81aGyN5ltd15zfaPYSvWra
         ZIBvbwP4kZUOsNCoSsU9G9hWd9U37C+EIVeja+RRalE/qaQFlXo3ebcPGC2TQa2Fuwqs
         0Uh5QSyPGH0iYAlXO3eSPwFuskLwEvGstLLkZPe84yr76OBDrq+Br6nGCDfKZfAhAiX6
         gVf/LEn1X8T+ZVPTE81rFS8i3+jT5pKFrfYxlsuSGrzuUwfHUCY8woN0N2rmIZ7gWUZZ
         216g==
X-Gm-Message-State: AOJu0YyGLLoDALcu7Ut3xzINLNwvB1SONCPAtyK5BuHKyT/BBF9bgC5U
	oWg1a7KvRWB6SCEk/iQdpF10HBTo4p5n2kmsBSWPuolf/mnYhh7Qyj7XVpmo
X-Google-Smtp-Source: AGHT+IEhP9VonckAhMVlgYrsXdFSNfXi8le9g49SMFdDb1cmflqpU3SwRGASfHS2Dfp+L/x6b+Sggw==
X-Received: by 2002:a17:903:2285:b0:1dc:b30c:694c with SMTP id b5-20020a170903228500b001dcb30c694cmr3012784plh.41.1709031450304;
        Tue, 27 Feb 2024 02:57:30 -0800 (PST)
Received: from [172.17.0.2] ([52.238.27.64])
        by smtp.gmail.com with ESMTPSA id t13-20020a170902e84d00b001dc94fefb68sm1261184plg.43.2024.02.27.02.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 02:57:30 -0800 (PST)
Message-ID: <65ddc01a.170a0220.af3b1.3de6@mx.google.com>
Date: Tue, 27 Feb 2024 02:57:30 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5724319961831470125=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, tiwai@suse.de
Subject: RE: Bluetooth: btmtk: Add MODULE_FIRMWARE() for MT7922
In-Reply-To: <20240227102914.8341-1-tiwai@suse.de>
References: <20240227102914.8341-1-tiwai@suse.de>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5724319961831470125==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=830220

---Test result---

Test Summary:
CheckPatch                    PASS      0.63 seconds
GitLint                       PASS      0.18 seconds
SubjectPrefix                 PASS      0.28 seconds
BuildKernel                   PASS      27.40 seconds
CheckAllWarning               PASS      30.15 seconds
CheckSparse                   PASS      36.05 seconds
CheckSmatch                   PASS      97.54 seconds
BuildKernel32                 PASS      26.81 seconds
TestRunnerSetup               PASS      506.45 seconds
TestRunner_l2cap-tester       FAIL      22.37 seconds
TestRunner_iso-tester         FAIL      38.89 seconds
TestRunner_bnep-tester        PASS      4.69 seconds
TestRunner_mgmt-tester        PASS      113.32 seconds
TestRunner_rfcomm-tester      PASS      7.29 seconds
TestRunner_sco-tester         PASS      13.00 seconds
TestRunner_ioctl-tester       PASS      8.43 seconds
TestRunner_mesh-tester        PASS      5.90 seconds
TestRunner_smp-tester         PASS      6.75 seconds
TestRunner_userchan-tester    PASS      4.95 seconds
IncrementalBuild              PASS      25.78 seconds

Details
##############################
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Total: 51, Passed: 50 (98.0%), Failed: 1, Not Run: 0

Failed Test Cases
L2CAP LE Client - Close socket 2                     Timed out    2.167 seconds
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 117, Passed: 116 (99.1%), Failed: 1, Not Run: 0

Failed Test Cases
ISO Connect2 Suspend - Success                       Timed out   12.292 seconds


---
Regards,
Linux Bluetooth


--===============5724319961831470125==--
