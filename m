Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1E4253B4C
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 May 2025 15:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748359743; cv=none; b=ierju3maMP2O02xLa8PjSmyhgrxQ2rgecKhwGgP5Sz8vh+tqY1rPBBal297mrqE6Pbfx+FnR9KlUHdWK1JMDQ8cYtUL8QR9qjZiYDQp7HRsvRZ0Ux3hAjUUCPhV+Rp1xQEkqXllRYu9bYRZ9YLZ7GySpuTRVNC8mIAAfaNkSmGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748359743; c=relaxed/simple;
	bh=T5qYRy+g2ivzV9T8LDXlW7yBwnG5Xi1ZrssW+NpAXaI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=vAvsU73V09yDU4RtckpCLRhHU7I77S9Ap3kXn2C/IR91CV9oLKF6yR1ACiw8QNnZPwNCBkhVKMVmXZtnHbxrO9FhpLgflipjF/OZ1bAzMfxNsVHOXCoMz1u32T46VNa5xq1fo+ZToa3DbJa+Z5qlhdvGAFC+l0YhQKsoWcwEIqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ja2I8eH1; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ja2I8eH1"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-476ac73c76fso43765871cf.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 May 2025 08:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748359739; x=1748964539; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eMlzJMDfGgH0B4BJa8hDqs08xI1LG+BO0pBwoPtDbKQ=;
        b=ja2I8eH1VuP4VOmWdQxVG7OKHKCgj1Ap5UZXWYJbA6jCP9nApAGhctpS20BsvYl09i
         +qd3MYPWvj7zEv+qf0J/eCrK40k6i39WDeSuYDUn5qr8pvkVC19XLvc0elwc0cwcVBUu
         dARE+iB8X3+PF3i9CSih23VeU4X+FTwosj0Jr9uEv+kpakNXw29yPga9NNlpcd+d/ruw
         DQwTTyJVZrDXnMGrS0hw/JkYgJJw5oqvTbr1RVwkcavB940TySps5JGTSVWenr/DzhFZ
         i/k1myCuhK47ZCYmm8mobIpTnx5WEbG3uSSC7Ed+qaBk9m7/sLVEYaAuU/InuEbzQjIf
         ujMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748359739; x=1748964539;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eMlzJMDfGgH0B4BJa8hDqs08xI1LG+BO0pBwoPtDbKQ=;
        b=Co0/bTOuJqv1+9YaburFT05Yife2PCzg+e4h08C6gSFmvHVa4WaYaMrAI9GiVLDdgS
         qPU3D4R6CZwr6EPNQOFRLwESykMM8r7vI4p8jHCxaxJNtIi3WKF8AAHYsZUOhsOzepno
         fpyybnYu+0+J58cXIhwV6lhv8L8OrZNxlQACIfv8aYO1N4fkWmSLQ3sNBxO5YuuVw3hh
         rFQIjQXwUGCIrK6HZkCPz5HzrF2zabcmMusDhZJMqwW4cwQ1tmjuJshjbM5sTtgn77a7
         t0lK2bAbNspHcHnHsVxQ61SYe1NWISHuB43R4aMWCZnKpDxAUm99j6vCro0g3G857yB+
         Z69w==
X-Gm-Message-State: AOJu0YxpoM4Z27vUp7aV54uT9RcpttLhdppBWd0D6WAc7MsEdt04gPDv
	FeU07CSd59OkswRAiiCphSOLLieJKVyt/ETVMF3G0H79J56k93XaTfB/jJ+qjQ==
X-Gm-Gg: ASbGncs06ha2Hv1/MVRBOX4K2GCeifZnRxtpGicqfolNOTuydfE91S+WN2Ts23ZuTGI
	fmZv4gZxEUzUtSC+x/FCr0bBDDY6oMWWcClwWoGRcjGcbeJXsUL2BkvBysyje87Rhmilb/QOH6f
	OnLMBp0TxdDnN8Lh5aZivGiQxg35ikNBsNPFDu+LnInG+Ye8cCJVSynRLSJEIPnPT/UYKKkL7oU
	8dVBmOOzZiwYyBlgrLMn4lXp9JBDsfejvYFv6iCRgL4KRt9aR1ZF8liBNVYoygh7rx5LfGWeksd
	BCpOBI+0Ernz4RsTuDfC8BN2Aue6CW55qsaJLEkk2gIF+zwnuGDFhxtuWiE34PkpFTSF
X-Google-Smtp-Source: AGHT+IH90HR1PlAQFEXN1griPic5f0CuK6pFi2w7qzHEbS8EtIYx5/u6NAsEauM8xvm7E1DgD8J70A==
X-Received: by 2002:a05:622a:4812:b0:476:add4:d2b7 with SMTP id d75a77b69052e-49f47fd2483mr197106381cf.51.1748359739529;
        Tue, 27 May 2025 08:28:59 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.85.89])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f8b097c3d9sm170491046d6.117.2025.05.27.08.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 08:28:59 -0700 (PDT)
Message-ID: <6835da3b.0c0a0220.28593.c495@mx.google.com>
Date: Tue, 27 May 2025 08:28:59 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3841306401784490534=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, repk@triplefau.lt
Subject: RE: [BlueZ,v2] policy: Fix service retry counters reset
In-Reply-To: <20250527134521.4942-1-repk@triplefau.lt>
References: <20250527134521.4942-1-repk@triplefau.lt>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3841306401784490534==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=966680

---Test result---

Test Summary:
CheckPatch                    PENDING   0.24 seconds
GitLint                       PENDING   0.25 seconds
BuildEll                      PASS      20.09 seconds
BluezMake                     PASS      2671.38 seconds
MakeCheck                     PASS      19.82 seconds
MakeDistcheck                 PASS      197.54 seconds
CheckValgrind                 PASS      272.85 seconds
CheckSmatch                   PASS      301.32 seconds
bluezmakeextell               PASS      126.57 seconds
IncrementalBuild              PENDING   0.37 seconds
ScanBuild                     PASS      895.61 seconds

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
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3841306401784490534==--
