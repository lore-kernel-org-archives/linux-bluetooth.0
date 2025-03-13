Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C32264A74
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Mar 2025 09:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741856586; cv=none; b=PIy1B0aHzSfj3yaOolz/cFDiz1ccxsuB5T6ZaPaJVxZXzbv1DxxAGQ04rhZwmdf9em6TOxidknpwH+/D7bl/31uksaUZsTc0x64B6/agERGmB8aKtT/ZdZxOuOfKOGwp+nhYwwpydLHeDi2VyE5y2fokHB5Vv62aJekQSdhJLbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741856586; c=relaxed/simple;
	bh=Y4VBnRCieldgjMDteLHnMjH8KbQNUCv2yVDtvggFH9M=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=KcaAFfE7nfFAuCbQJ3na/2HIwnYsQTZdEevbksf/kc8XviO0WLGW0pMTyD4sfVJtt8vkDM6HOYpTEcGtEBiAfJ5F2N7tLPTy28491arO63p0kTl6lYLJkX9RMuFZbCJKunuR32FGaJxDmZoLXMy4bDKDXpYv1QaWy2wapP8KvBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UOOaOlhA; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UOOaOlhA"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6e91d323346so8403486d6.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Mar 2025 02:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741856583; x=1742461383; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=e6NSkGwMtDJEjtasyAaE0Qa6E+npE/l2orMxcrNV3MQ=;
        b=UOOaOlhAUX7ZcNzVnYj9PNXM8rKXH14Qw3iX5dzyehZARpuF1w5TYk0FKlhz8P+1iz
         97d0CAdwpP/dtegDL8I6DcPOFpQAtz7Gdp4ahaLjxx6df974pQmeCAp8sncmVSj51iyS
         i4QDE+IWw9nGinOilazWT0kZ5BfyGi5B2soU9PfOz1PF6beUH4sG9BwezVUWwdz6d0KC
         BfCbiCpJc2nzqooA0DULCyDkipKMOR7zVMT2ASKHmEd0aiu40XunOhwe7hwdS3CdI6K9
         r6eUA0jxzUzUG6syo4c/CQWtbFiEIexqg0XFehDI1pHXo9CsoZBWpCART3ky3wVSgtSb
         HazA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741856583; x=1742461383;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e6NSkGwMtDJEjtasyAaE0Qa6E+npE/l2orMxcrNV3MQ=;
        b=jB3DMJNUg/v2rkHCLdSg9ubZHjmV1F3KiYZpfWC2/Zo56766RpKeDGd3ITZAr9G05A
         +rjU1nlt4pzk7JjOluQCkURYuY+H5PAl2c/C2XNFyDi4TRMgLIjU/Jjpj5imWZ8DJeF8
         y/tJ8EYurdtpeUEkOjx1nZdQVIWEJeXFF1PrYL8Nj0RdZoT+STlN2OhxsEo1mtyIo5B9
         SvnIBpajf6ufoO+roU5OVsWy1z+2nTeeEO3q3w9/qGMv8VT0CwbIQ+Tl2WDzrcZtDbSv
         EViPVNgHnqfgnzeF4OOUmS38Sdgd7iQGHYWhckwMrrAjhhCffXuBRX2lyOzg6Tuu4gzV
         rEeg==
X-Gm-Message-State: AOJu0YxfkXK++KfB+WDWvhP16WaUUDCblaWGKjgpZLd5CGnifwtUrm1R
	LzlfBC/UsfV8bvnC/2r7tx+bdZnbD6OcH5/f2SIr+IRlalT8inN6Vjcapw==
X-Gm-Gg: ASbGncuVDJZ7nvdIcvPGFjW7z22u33v4U9ZJQ4A+wy4NpgoTG0hymbqzrQLrsv9ipff
	aDiVxucam/TW/2WZTtuuYxmmT7jjwmM8PChxHSXRJ+iN56E3QeqfOW4o+fyvwf8lP9sLbqhX7sm
	6EWL//8f5t80U/jZ2MlFiNqnjDQ8CySaOSd8NdiXwSyDFje/OsVv0lqAyVtxzibjV/3IUX27bwt
	9eF+dn4dL9qPbtgRvA/ETZeB8ofS1mAbDqoTOIGV/aTPwNHotW5blOe73nj+z4lsYUir3wf0OjO
	0z2Da66k7R8bTi7Y+TA5WnndPK9BhEe0b1C2HIHD3++R+ZO0
X-Google-Smtp-Source: AGHT+IGsKTyBgjp+veIP6Nd30N1SPDKC1WF8fL7EW+BPzIDrp2T/7snfngJRpkYOWy8x1G/F21kklQ==
X-Received: by 2002:a05:6214:20ad:b0:6e2:383f:4acd with SMTP id 6a1803df08f44-6eaddf12b89mr29785546d6.7.1741856582704;
        Thu, 13 Mar 2025 02:03:02 -0700 (PDT)
Received: from [172.17.0.2] ([20.42.48.77])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eade235431sm7388626d6.48.2025.03.13.02.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 02:03:01 -0700 (PDT)
Message-ID: <67d29f45.050a0220.151c45.13fe@mx.google.com>
Date: Thu, 13 Mar 2025 02:03:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0482396218918800332=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, make24@iscas.ac.cn
Subject: RE: Bluetooth: fix error handling in hci_register_dev()
In-Reply-To: <20250313083135.307357-1-make24@iscas.ac.cn>
References: <20250313083135.307357-1-make24@iscas.ac.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0482396218918800332==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=943428

---Test result---

Test Summary:
CheckPatch                    PENDING   0.21 seconds
GitLint                       PENDING   0.20 seconds
SubjectPrefix                 PASS      0.16 seconds
BuildKernel                   PASS      24.50 seconds
CheckAllWarning               PASS      26.75 seconds
CheckSparse                   PASS      30.48 seconds
BuildKernel32                 PASS      24.14 seconds
TestRunnerSetup               PASS      430.89 seconds
TestRunner_l2cap-tester       PASS      20.89 seconds
TestRunner_iso-tester         PASS      30.42 seconds
TestRunner_bnep-tester        PASS      4.76 seconds
TestRunner_mgmt-tester        FAIL      121.30 seconds
TestRunner_rfcomm-tester      PASS      7.86 seconds
TestRunner_sco-tester         PASS      12.20 seconds
TestRunner_ioctl-tester       PASS      8.50 seconds
TestRunner_mesh-tester        PASS      5.98 seconds
TestRunner_smp-tester         PASS      8.92 seconds
TestRunner_userchan-tester    PASS      5.03 seconds
IncrementalBuild              PENDING   0.76 seconds

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
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
LL Privacy - Start Discovery 2 (Disable RL)          Failed       0.184 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0482396218918800332==--
