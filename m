Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A87D3B47D7
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 08:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781081897; cv=none; b=RWmTbA5hjb5ZI6/WVBZ9+MPRXDBjrL59ZwBa8Yphwnto43VmDS8ZjOcQffv7yGYz3EE4XW5ygkF/PVYSyI6wjtUMOWzgWvmq5WV3auXJh5kIBN6o6ig72YaUuI9Z8qdMqc3RQmmWtq+urQlGDkDlG2sTVOKelP3jexQb1Y33Wak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781081897; c=relaxed/simple;
	bh=LGWtFg94Pf2tx+M7wifXtgVIczG+fgpgXtUqzSHeG18=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=FzU0cmhoKI6c9aVynJrV73XPCI1/by5bB0C/TNfKLAw1DK8YLmfuqwC4r38neqKEmHLglnefUfzhGGpjfdHIhlebPPBQgjuqalyYWbbNShNnwZC33A2czS7tAIyBTX+pWxgNYp4jOF6a3Clg6ck93rAlNbW96KocxtX4WvHSFDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FJoMOjm2; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJoMOjm2"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-307263ad0cbso8943818eec.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 01:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781081894; x=1781686694; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lsuwShka5hj7JZyTTeD4SH6PSuO/WCKyb+L8yAvpu6s=;
        b=FJoMOjm2EFvIppqqZKJb9+0nLtwObHmM/okFhvTvwGhDLfSSKWQ/+2LtY4kfgUde04
         hPkkDqljzMSEUx21BseO+emI104EUaANbElyP4sEGdYmPi9scZVdEzSAz2mJBzaPX9oV
         Zq2nvu8a3toa5bclf41JjKbrSKiM/lPSoSlZIyLN8vzPz+h3KGXklFn2gleS+NbxHyV0
         MOFHlgCovBO2Z57R0XX/RiZzxPdEnp8eIiatdpNwHtcXslotUTXIrLA/LC3Zs7T+eg0o
         rBhPVOW2+QMw7TyNdAiIh9jfMjCYqkJz+tGlRROd9yRwcurOnYMC3vwYKkkFKTODrqtO
         oxXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781081894; x=1781686694;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lsuwShka5hj7JZyTTeD4SH6PSuO/WCKyb+L8yAvpu6s=;
        b=RYsYuTP9INdc2XRc/xrrr6WdN9afQTfpFMaMMpd+BVqzuwU3JOlpIH7fT95Pa7oW/g
         c/BpzDJ2q4JaCOzNMhau99PKjCnzcKfikKsZH9DwcGc1EnQ4eUT8FZfY56kLCtgMJjao
         GwXHa7laaP27mewz68ntLmcfeXvTEMXQoEsM6PcyFNHss0J+KDW6gVBNs2tpNbL7yoks
         ZnuVM6TlWyf8Bk2WkjuuLu4t5zjczH97DLdD2GATkxkNvqPw8z+vvQCb75H0sKvEX1Hu
         CGeu9Ptu6wJPIEMsbRPkp+w7w18LOmfzjHrtwBKsv+NBbx51IMp6qtr11vBYDX7Mk2rp
         1oTQ==
X-Gm-Message-State: AOJu0Yyfx3mBPXF2GC/AR9I/66kvnppEvjnn37rLpoiE+K1Rf2hdU8wd
	i3O7wHcV4rBCLIJ7KDsmy9pyeWiUgFj7fs6dcGmhv+g4iWUxOEUgh6AcYBCXjQ==
X-Gm-Gg: Acq92OG3INA344l14H3pwUWIADGbKnTWMtwaXSsmBrXiIB3pJ8VP0Osv3eRsZXTvO5u
	n38X6Wo1wivnFObXZ/fJyTewK/pu6nQHWsALQrH024JEt/G3Qk5GI2qojQJIa24WsygZELJKjDL
	1lSTzf2NTedOBhEWSDtg4v1cw4lk/Dv6dFmOpD5lJYa0GOsfadn+6kvQobc/9CtNhov/E/0qijt
	TJqiNWGNHaOCqWLcBA2yXAqbRyfgoLN3h/m2+FDYGT7/E5TUKSlRWLAaBoONzCA9J7pMKRmE/u2
	bD5/68pKl5fPSrVymSwmA10oCDCIzcNKJqHxxHXgDpWjVFx9tGD09pgz8WI7lsbDH+ukRzqk4ek
	YdGm7ty5zcWaSIRJAiloeF6C5i1Ys8iMh7VWDXJESqY64xmZFYV+p+RU8nOfZk9OLYD6MnUuTrX
	y7fCfLSOfHsqjrr+3z31GH6KJfKpMvMB/m9m6uBecw6EpV83sDdwMBNg==
X-Received: by 2002:a05:7301:9bca:b0:2be:1f58:32a3 with SMTP id 5a478bee46e88-3077b2bd9f1mr13357257eec.29.1781081893722;
        Wed, 10 Jun 2026 01:58:13 -0700 (PDT)
Received: from [172.17.0.2] ([172.184.219.209])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074dea8e8csm24726274eec.16.2026.06.10.01.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 01:58:13 -0700 (PDT)
Message-ID: <6a292725.965034cc.1d2e75.1b57@mx.google.com>
Date: Wed, 10 Jun 2026 01:58:13 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8600476200946995203=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, xiuzhuo.shang@oss.qualcomm.com
Subject: RE: [v2] Bluetooth: qca: Add BT FW build version to kernel log
In-Reply-To: <20260610064232.2385866-1-xiuzhuo.shang@oss.qualcomm.com>
References: <20260610064232.2385866-1-xiuzhuo.shang@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8600476200946995203==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1109012

---Test result---

Test Summary:
CheckPatch                    PASS      0.53 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       PASS      0.20 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      26.56 seconds
CheckAllWarning               PASS      29.70 seconds
CheckSparse                   PASS      27.92 seconds
BuildKernel32                 PASS      26.02 seconds
TestRunnerSetup               PASS      573.52 seconds
IncrementalBuild              PASS      25.70 seconds



https://github.com/bluez/bluetooth-next/pull/301

---
Regards,
Linux Bluetooth


--===============8600476200946995203==--
