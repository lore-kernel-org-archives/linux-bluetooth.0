Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2447284A35
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Jan 2026 22:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767650677; cv=none; b=Q+uMQnArE4t2ZE2MVlbjuTWkuxnFHSOkZnZQODQaFbDLU1BkFfDWi7yNJVe2Wi8hYJKpB9AQ68dbkqw74bzfTeWJzrMnq++ckLAtc1ZqCCx6nBhGfnPLk9ZAtAVKnyMQS0kLkWqRdebv9ShUfl0pjvzwMy66y3gUEFnEh5EkzrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767650677; c=relaxed/simple;
	bh=DyyF0m+qK0pYFSeS6aNHkK9z5jjpsplDEfKhgTgyQu8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=A39xr0cwDKwRB3zYokSEm7ojB7LM2Xan0g91q3fw9M0GUClJ2rH9DPnXuStEuPDupuF4H1cssOB3LgDGJUZ00hA2BNs5jPr1MtWznMqlLT9EEuAYyfkcmwWRoGcnLKyd/q9823vXtwiA2pYvXGxBDeI7+gUUFXozmm3sznF/Q3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hvEL6oGF; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hvEL6oGF"
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-7bb710d1d1dso587839b3a.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Jan 2026 14:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767650675; x=1768255475; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hG0SrmcUIWotE1zj1DRsd86zZKs51C00qUeJ8pTIi0k=;
        b=hvEL6oGFF0Q9PJZKaJ0z0WFaByATbljd0m4iUKQ+f+ScK3SoJwv6AalVsCMZNS6w0/
         s0TJ+3CpLq0vE3HzlVx9YKDiip5614FNPswnksmisAmpkyyV+TsduWhX7oWxyybDNcw0
         Vrbq6tlE7SDVwRgXILlLiAHfAXFXPwyjaQuT3bglg3LJftdARUicSx+S3z8THuSF3Uc3
         QFxwZvrBmqjhi8HXseZIJA3YdvZIYOr4SOvG8NNpUvhzczoKyaLU1xxXel9H+bS3IlH1
         UlCZceGwJwD6BXAryf+8lgiRSFsmwD4kfNEA/14rZmbu2wMVneA94BIaDHYS0nTx4mJ9
         oKaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767650675; x=1768255475;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hG0SrmcUIWotE1zj1DRsd86zZKs51C00qUeJ8pTIi0k=;
        b=v2xzK4160rDgvItaR4GgsQM4IY0eE9+CAcyCBW02o/ipYLG3sJHliu5GXfzPD/J+2X
         ePF9LNT3nHvdv4VEultK6Ji0QztK9rZ9Tqvc9ZJR5RQRlGW2UI48gWFerOiMHrAFu6AI
         jdBw0Hek43AnusZ6O0I3Uls9ScAYzot0KDSorS0Cx0rBMyH423WTSIyzy2O+t4uTZJ6y
         NXpz0YymPGQB+F2qpWyCA+IDV6guT+BK1qI1E0wupZ9I28y4fkKpczz99fibkWngWF9r
         eldRTP4r3vCgwbgHSojfahGQ7VJzsPNFVPK9n40T2kRtnryKqVrmHjXjKdJ+prgkQbU0
         +b9w==
X-Gm-Message-State: AOJu0YwRetg+119BrYNw+CLCo3Z/kvQAqncPRHn3rh5nFsHFm+dNhxv1
	uovb6ZXf40gCE1Dqy2K5D5FYvkzTVcBSKkuw29kcGRDf6hz6ysqBz8aZoww8TmAb
X-Gm-Gg: AY/fxX7z3MC0QZiunudU/SbC74VBqWnSN/72ZG6caSXTYYHu5s4o9nL5He2u7kQLgAZ
	/xdMmu/lsEGNC23OhiLYaJ0VZE5DFcrg4C7l3QYx+QlMd8zTIQVhLymPCf8ivY1/pGrUc2ZUbQT
	Og10xx6BCabNkVv6Wss50OCWU24TmwykLrpp5xnEC4cEAx5tH28fcLBtg6wuQ+20SpRtxbdzy18
	QhXvDC9X7tv621UhPzyhVkd9rWWtKZQb94eSpvH56SaUaGFFUsgHIQyK42ltOrA/af4MWpOk8cV
	6kz1XO7gseEhx5NvdWs2t7H7kZLS4XsLRghLPR5wqzSzB67YKoufcgFJpStQlb+Xc/IhyRpyo1w
	Fv1KEG41j4vzMLvu1MBnngMvrAgfYQPxh1R/G8vJ0CxOaCCKNV692D3Qk84HtcUNne+/ZLFin9c
	Ubo3W0OB4UumcpY7wi6g==
X-Google-Smtp-Source: AGHT+IFqryQ3i6E5ssEphLWTu8YA4JRCH6DYQMD2iqVaaQnb4pRRCZ6IeyIoFYSlrjP0fWENteUxGQ==
X-Received: by 2002:a05:7022:fa03:b0:11a:4525:5361 with SMTP id a92af1059eb24-121f18a3333mr783823c88.6.1767650674968;
        Mon, 05 Jan 2026 14:04:34 -0800 (PST)
Received: from [172.17.0.2] ([172.182.226.65])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f243ed62sm576775c88.5.2026.01.05.14.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 14:04:34 -0800 (PST)
Message-ID: <695c3572.050a0220.8943.570f@mx.google.com>
Date: Mon, 05 Jan 2026 14:04:34 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1524016790600668320=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: transport: distinguish BAP mic and playback volumes
In-Reply-To: <77d193dcca6bfec367876a4f9dda3caabb34e11a.1767647222.git.pav@iki.fi>
References: <77d193dcca6bfec367876a4f9dda3caabb34e11a.1767647222.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1524016790600668320==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1038698

---Test result---

Test Summary:
CheckPatch                    PENDING   0.31 seconds
GitLint                       PENDING   0.36 seconds
BuildEll                      PASS      20.04 seconds
BluezMake                     PASS      650.83 seconds
MakeCheck                     PASS      22.16 seconds
MakeDistcheck                 PASS      242.80 seconds
CheckValgrind                 PASS      303.58 seconds
CheckSmatch                   PASS      350.55 seconds
bluezmakeextell               PASS      183.02 seconds
IncrementalBuild              PENDING   0.34 seconds
ScanBuild                     PASS      1025.29 seconds

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


--===============1524016790600668320==--
