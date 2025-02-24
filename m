Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F151B8632B
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Feb 2025 05:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740375132; cv=none; b=mHEaFlMzNRxPfteK43wRoV1C0tv5QwXMIbLNMRxvx+Q4XmOgcf1rp6ZrPgnbyztOBBw88DpCWQ++VeiE0bo2/IoUCy4Qr1Q+8Fa0eKATJatdj8VSF5apbahm07x2I2VLP1I7onfrpm/wHjsmd+FuEbaeXsY78mrpbDll8M0cDrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740375132; c=relaxed/simple;
	bh=BAKou3ddc/D6yfEDhP/0FTcP372ckV6DhBxjeFKyZ3o=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=n2kxRdOv49Yu1szubgNQKarz2EOEJ4PnuBnkWCxk7Ql65RfzcgfGQfsS0D/UJUui6hr2dk54UHIZ82DTeHp8rv+9d4DY242oh09NIHZFw4ATpunjMZYXVkE6nlS90UGHwykREOd7sbr1CIKxRHuJcAlSxez0ZjFgpZsyk1FM3Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gi/YaZZK; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gi/YaZZK"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-471f7261f65so40930861cf.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 23 Feb 2025 21:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740375129; x=1740979929; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=w8VU6P/TWoRI5elK/e3fbf8Z2CpQOIE1zC1nr2XAbdQ=;
        b=Gi/YaZZKdOPspYOwRDtI7OBs4J2cK52d4xcR/zvgJoRG5UREzsqZ6jqlWxFmpbrOuP
         4Kmb9Fvgv621/PyfIN3Wi6eAUihGTv0liBtoJoPfk/iPZ9rWd1KNok/WJiHKYA+29j0H
         t6A4U9xZ+aXXZoh7n7fF7sQ7F3jPpPQ/lcntFTOCqqZZ9ypS9NSn/jUIztqsQJh1kVN2
         A+eN2gERBRjY8d6r79qltE9MsTOlNPvJluasoj6ehzKoj4ZVKu8DfHE2nk1UYziIyvrI
         eitU7X+3NzV2ph1ccIw0+T0zlFJBOy0hoG7VjMaIMeBKWcz3YcDTAR22igGSnGG9KmF6
         vuig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740375129; x=1740979929;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w8VU6P/TWoRI5elK/e3fbf8Z2CpQOIE1zC1nr2XAbdQ=;
        b=h1Q9AD9A+SFcB4pKsezei5DNbMAfU1qZpJJO+24Xe1/gUZwkMwuuvpZwCQBfoNNosy
         pWJFkxNsvxz3EwCdb2o1BJ4xWvRZYEK9LdC9Gn+9mkvHGzgLfOA4Dn85btvlotgb47fc
         Ev/n9IEhRBhtIVfTjIrZ71pGyp4YSH7fXpyuzQ1SZRlWh99K4Ubj1zcpywlnvD31oPm8
         XyywGffmRhoaxkLVDTTv5ADqFnSRsDc1UHvlB4tj3DmHA/5SQb9Te1Z1QmnVV0awgGBG
         itF6aUmUY6RgGEHt+DgqtsXsctgyppoyWSkldLD9yBxNgDS4bIhnR3ordBgk2XDl53CY
         CtgQ==
X-Gm-Message-State: AOJu0YxlleUMN3FGvKiNXQTivGebewc7Q2WnnQMhawnQi12UztrV/ggD
	cAcZ9eViATkuxgfBZr51/4KnViCTwqp15to9sA8VBbkB9vRnMUUoF+3DmA==
X-Gm-Gg: ASbGncuXp42FzvSUM4Tl3RPSpyzzRB0ZPcnyy7eKMyH5wQqsMXMMM36F+sM9KQxBJps
	IwkF6BhKIwsUW+SLUJPExn+cJLE6NkB3EQ+tv8Q1Ev3uuc+rw1gc01X1ZuPpbXAYnJvgZ8ImrEy
	xcQHNVmuNX/rtRJXo/x2o8vDdIN22xvR929AB4YhbkEze+plFksruS1tC9ncjhky7hAH+Bc3Zbq
	AJJ5Tby5rXBLZBPYu6nlj35bm5nwOidh/xE9bozf6v3OLDwoBRJgWXb6Ag9ZLJqLZcd8G/2l0kJ
	Zp3nMsdtWp9KxvF0H8xXZwiZX2Tol6+i
X-Google-Smtp-Source: AGHT+IH81mGXc1Px7K6IVm1AAJpLsmCVizbffZnzsB4x28MRWJBHO08oi9ZYs5+jm0kanA4ijQ5CLw==
X-Received: by 2002:ac8:5e50:0:b0:471:8a10:63c0 with SMTP id d75a77b69052e-47222bb69damr159261991cf.10.1740375128714;
        Sun, 23 Feb 2025 21:32:08 -0800 (PST)
Received: from [172.17.0.2] ([20.25.205.240])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47200649214sm74385711cf.74.2025.02.23.21.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 21:32:08 -0800 (PST)
Message-ID: <67bc0458.c80a0220.2bece3.f158@mx.google.com>
Date: Sun, 23 Feb 2025 21:32:08 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8375082417784738553=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chharry@google.com
Subject: RE: [v2] Bluetooth: btusb: Configure altsetting for USER_CHANNEL
In-Reply-To: <20250224045237.1290971-1-chharry@google.com>
References: <20250224045237.1290971-1-chharry@google.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8375082417784738553==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=936884

---Test result---

Test Summary:
CheckPatch                    PENDING   0.31 seconds
GitLint                       PENDING   0.19 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      23.90 seconds
CheckAllWarning               PASS      26.56 seconds
CheckSparse                   PASS      31.56 seconds
BuildKernel32                 PASS      23.64 seconds
TestRunnerSetup               PASS      426.38 seconds
TestRunner_l2cap-tester       PASS      20.56 seconds
TestRunner_iso-tester         PASS      37.10 seconds
TestRunner_bnep-tester        PASS      4.74 seconds
TestRunner_mgmt-tester        FAIL      119.03 seconds
TestRunner_rfcomm-tester      PASS      7.90 seconds
TestRunner_sco-tester         PASS      9.50 seconds
TestRunner_ioctl-tester       PASS      8.51 seconds
TestRunner_mesh-tester        PASS      5.80 seconds
TestRunner_smp-tester         PASS      7.12 seconds
TestRunner_userchan-tester    PASS      4.91 seconds
IncrementalBuild              PENDING   0.37 seconds

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
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 3 (AL is full)               Failed       0.200 seconds
LL Privacy - Set Flags 2 (Enable RL)                 Failed       0.146 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8375082417784738553==--
