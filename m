Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F74123774
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Jun 2025 02:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750732372; cv=none; b=LdQOigJ5rn5RNXYXtur3OKE5ZVuWm1h9OmOTgDGMkzUZqvr2SdUSSJb5HJvt8Zinqxl4JNYXne9nYiTMiwHZ+DAnKmhLdcaYXmZVimBqtQ53WAeV4DMOp4OQvP2HbY398Z3AIEXpaD7UoLHT66GGqc16I4l83vngstNogEzgB2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750732372; c=relaxed/simple;
	bh=ps1wQ9u9IzCYPzSE37n1DxW4OZu6r+5xSP+KBZNa8tM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Ovtq1EFkH2y4sWyxib4i12wzHu7TAvGKijiqSmjvXS3gh7Lo6E0ISCKfeFAQaSobXxgwnrHKnxvxyjCA4Ul6nqkhZGJgehFlaMAh+ZSNO/vdi3JkLWcptUd6PTWwKqT87elHQZR7dlywRcbMK0lEHIbV+bPVOgxER93gnMf2XMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LP7hqsPV; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LP7hqsPV"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3df2822c450so2095145ab.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Jun 2025 19:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750732370; x=1751337170; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BUKdfLqoQP4FKscHeJqgX1D5s70+L+wYnNtxE26PLis=;
        b=LP7hqsPVDnydyrPIIuMODPOl97VRz1ktb5AdVOH7Db0/LJynzfa8oHV9FzxSgp8qht
         aqB6+g9PYh5CzIGUIJq1TE/aTvqJQmujT2L7Dx3iOGAlfKPypjGDaxmJ2nt/Te0T04Jh
         064v9/sksZKII5dBj8SWtdtoeq1NSFHhHSEXc3SUrCxg5Nsj0xp5YvgqasC8BUGBQE4k
         6GnbtZJXImiCQo5pKpJ5it/OWkBX0l0WjULMUWJ6aeR27Ui7D4gqsUgKFL6qn6YJxi+V
         MGcQJrph8TILr8YU3YUTpQ0WBTyuadYHBYogBkVMvoqoBtxEPOcLzZY/n+nI7lTmISL9
         MQlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750732370; x=1751337170;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BUKdfLqoQP4FKscHeJqgX1D5s70+L+wYnNtxE26PLis=;
        b=EAnHT2nM5ZSnmmkOaVuzjtwXycvwbp+4np0uz6x0X+Gi1Mau04I2QMNa3BydhFlzY4
         hmByiUFyAMslgrnG2qnBRWqqIEJoZvconv5JaccuF02HWSLqPMggDElGUXFeXBQgB8j4
         ymDHdHtAmYSupg3EW3Qzb8O98wIK0wMH+2zyW/mtH149aFX0KxO3EG3BM4pCABi+YQAc
         kQva4qY031cyJU+xQBs4VE/BycCx/094JUKEIxOC+0VgMYhAxWuxBq25afefj6AviOoA
         bgG03phVSX1R5ACHHiccmy3IuE4e+5HiRgd4tQstBFrrMMui52O7Gx2T1tHkhBbwi2Vl
         iO+A==
X-Gm-Message-State: AOJu0YwSUEonh3WxtOA+k+ZvBhnobeym9pp6Kfn7eQmbIsaTlvztzanZ
	YcNaFdCh82sF5e0sULVh9lo5Ui+MKtbq14B/NirXGrVvz46dfQ2E+614+w9kQw==
X-Gm-Gg: ASbGncue/dGDqC5WPr+YGYAxBVlTgaddyddOYW1xt38ai98vLt0lPX0K/54c3wY/m/7
	HaoFNJeJfOQsnOk3JCj7bgdrvlbOKdT5NEGVe1I6OqieuNrf5cG9uIYKRjlImcYNDehtRLQSSQW
	Vw0yVmnMfuNCi2UrKIrcsp62YLaJ0Ra4CaEiNj8RLXpXI0QSsYeg+Ci+2f3IKsdIFa6KwkDRoNu
	pn+xZlzF88BeEig3UdPHBQju/6CXZkzJi/szn0QJWTIOnNl2AgvFMJBwbefeBg1C5khWOR1dP1r
	AKnVeBs2nbQlZg1O2WREOX0xamV40I1m75HYJg9l7b180XkEPN/G0IiIg5nwgWTk+7A=
X-Google-Smtp-Source: AGHT+IF+Pd5yb/TXhMf/8fn2Z1RtwWlDS3cmsLb8tbo9HNHj9pzGPxLkUBbAQI2ozpqiZIVK6BcPCg==
X-Received: by 2002:a05:6e02:1a61:b0:3dd:bb43:1fc0 with SMTP id e9e14a558f8ab-3df289a6c31mr19128225ab.11.1750732369714;
        Mon, 23 Jun 2025 19:32:49 -0700 (PDT)
Received: from [172.17.0.2] ([52.173.88.33])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5019e0cb7b6sm2072582173.135.2025.06.23.19.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 19:32:48 -0700 (PDT)
Message-ID: <685a0e50.050a0220.2a40d5.65cb@mx.google.com>
Date: Mon, 23 Jun 2025 19:32:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0292437200821224007=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ronan@rjp.ie
Subject: RE: [BlueZ] zsh: amend completions
In-Reply-To: <20250624003551.107489-1-ronan@rjp.ie>
References: <20250624003551.107489-1-ronan@rjp.ie>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0292437200821224007==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=975068

---Test result---

Test Summary:
CheckPatch                    PENDING   0.34 seconds
GitLint                       PENDING   0.28 seconds
BuildEll                      PASS      20.06 seconds
BluezMake                     PASS      2635.89 seconds
MakeCheck                     PASS      19.93 seconds
MakeDistcheck                 PASS      199.63 seconds
CheckValgrind                 PASS      276.63 seconds
CheckSmatch                   WARNING   305.31 seconds
bluezmakeextell               PASS      128.67 seconds
IncrementalBuild              PENDING   0.26 seconds
ScanBuild                     PASS      909.71 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0292437200821224007==--
