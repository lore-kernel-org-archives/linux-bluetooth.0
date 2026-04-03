Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E6535F16B
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Apr 2026 14:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775225253; cv=none; b=LuRDa/l9r4UpwJKt5twZSMiF6GuCxzZg+jIdRSo7zZoo/xpy5pYVOX9rg/GOqspA8a9lwUxN0qTulIth31zHx45EhIqq58MjiKYz8A7m1lWI5qUSnRE+clg374AcH2oA1XDSuNsQcpEsuaMr7Aj79lWSLWpHcGm5+/PhW0/aMXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775225253; c=relaxed/simple;
	bh=sqSAnAvMtGnlC89mQKg3FaJ4i1oyuaJAfjWc6mwdCXw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=NV2UoP1jl2goyaRTDnaQxZuZoQYWFO3KET9/sBcC0tRA8+Q4iWiRoGurqGYqtWQmEH/5YGYozDXh1pjl4PB9HL4OGnEUlFbdTZ72r+kSPfUogXzNopE/Igi5YM+4qfNn1lov8RGqxOEopC1aVS0O5D5WyV4GIhAlshvuf8DUjUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FSQPlBVi; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FSQPlBVi"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-506362ac5f7so16664021cf.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Apr 2026 07:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775225250; x=1775830050; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=I7LZvC0X+HjsDIw2JE9h0M3605MUosLxuhdXhgJccQM=;
        b=FSQPlBViUIHgriel7Sw11Lh1AFmOAnoDf3JTptZ88j9IYGM/uU/FrU//ZcTquBbHEe
         WKVczefYbjkAwGa3SDbhdJ3gHHIVv+bHILUAA4UbSZsi5wT62AOlvHhkuKAAu2jEjGc5
         1P0Mq8jqi9RgYwjhjQYAJosSVZY+qyUOIT9Q1vf1NsdyfjnNp8Rg96lVGYc7u4fYJ1Bq
         x0yU3KAqLk5vguWloVrFERUMp/UMvudLNwqV8rGw0pHdRZd6kDgiBsSa8CImzlzQvyz/
         qJveJfnIsRkNcpFuJO6n6GMLe1qNrT6Gg9nb/SNTvkQDtqllNPwwYFAYWWeBRjQ/KX0y
         RhWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775225250; x=1775830050;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I7LZvC0X+HjsDIw2JE9h0M3605MUosLxuhdXhgJccQM=;
        b=HkzyiAMHHslqAYU5U1fIIoRuS6KCiQBBZjEnATSgr5vaSj505/w6OYsRrYtAE8uCZx
         A1BC9NscUCtPULhs/pH7gKd3G70lA5kfUsU2IMpL2RLw4LjNmXpamFNKsPc3LqWmEq2c
         zwRtYeB9Qb9s0gE499QEwOeSRVBui6TXS9qLmWtSTo5isYE0n8QDKwsF/Iig7qUIZc9I
         bSJgFr5g2aQqniC3IVa4w7ihazE7Cyu611v1hss7xr+HeekfQdGBBM3oJO9r63Eg/gnm
         dJhMQfBamnfWEYvpCAsibGet+IpTUDr7o57ptclNNT46B4ie1e2OFu641/nR1gWz4b9K
         7y/g==
X-Gm-Message-State: AOJu0Yy3BlUPr3dzYTyKotofBKLqTZa44LFrw/R5fAt27vtCVZJlcpmB
	tDufg7X6myYb8zj9cwhRwvsej3WqtSFkCiyGYO4Wtzxay4CJ7aeSfzarhGd5CQ==
X-Gm-Gg: ATEYQzyT/1ZnIjL+oY6twVpbvODndZi53bXsCnV9qVQC4tVxTq85t70w0ZqGQBZlNrS
	MPGfn8eny0ruToABiJkZD7a5wn4iZTipySTuSAUVoC2/AwvOww/c2tqnD6dPLwVv22s25mteUC8
	q0XT19vCda7ZRSYGB+gvELASNwYJvmAKEWql1CZqPOPyf4x0QJWIS+wqDvrpS/sOHN58uxcehiB
	oFdHj5KW8SPR5TtHVE//tIrl0vkFyg1hxMbcqD/QN/Us/Uc91znKrwhbvtGqBcdpfMqKypWc/qe
	zFWgIJFI84Y1kYKtC72cDipHUiC7OVNEWbdYEOaJoTGEOMrIql/SEPEw8bqbTdZeoQo4sxR5Gvt
	0omAJoniAZSoDV1zY2OIe4w+YOYvjQ1ZLSK/olJNPYxbtCZRRR+UFhY+fotQkc6IU3+GCpODoeV
	SwaTGDKklE/BI5Rd1A7y23Rt66aEXrOb4=
X-Received: by 2002:ac8:5d52:0:b0:50b:31ad:32a2 with SMTP id d75a77b69052e-50d62b4e682mr44528051cf.65.1775225249739;
        Fri, 03 Apr 2026 07:07:29 -0700 (PDT)
Received: from [172.17.0.2] ([135.232.201.32])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50d4b93dd10sm45472121cf.7.2026.04.03.07.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 07:07:29 -0700 (PDT)
Message-ID: <69cfc9a1.050a0220.168328.fd58@mx.google.com>
Date: Fri, 03 Apr 2026 07:07:29 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9193180987466777590=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, k.samburskiy@omp.ru
Subject: RE: Fix unsolicited AVRCP RegisterNotification response
In-Reply-To: <20260403120339.873320-2-k.samburskiy@omp.ru>
References: <20260403120339.873320-2-k.samburskiy@omp.ru>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9193180987466777590==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1076973

---Test result---

Test Summary:
CheckPatch                    PENDING   0.38 seconds
GitLint                       PENDING   0.29 seconds
BuildEll                      PASS      20.47 seconds
BluezMake                     PASS      660.67 seconds
MakeCheck                     PASS      18.35 seconds
MakeDistcheck                 PASS      250.88 seconds
CheckValgrind                 PASS      297.67 seconds
CheckSmatch                   PASS      353.13 seconds
bluezmakeextell               PASS      186.55 seconds
IncrementalBuild              PENDING   0.32 seconds
ScanBuild                     PASS      1050.64 seconds

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



https://github.com/bluez/bluez/pull/2011/checks

---
Regards,
Linux Bluetooth


--===============9193180987466777590==--
