Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com [209.85.222.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378EB2F3C02
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jan 2026 16:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769618829; cv=none; b=QGI8RK7NePNxaZ0nD1TMCWNZtZIcSUq5cWb8S+kWe0dWEI7L6KtuPp+jHrMKwTSoHCc52BmgRsI404029G5S5OJtZXvnBGxvdkr4f80JNWbS4nsHK4PffK6SxS7XvTlVRdNeFq7Y23nEDek0Vx+OyqyDpqC2IVJiHAyeFR1fIGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769618829; c=relaxed/simple;
	bh=hnd/wGDkipw7kjxmC2k4jP/efvwx9SF1VtND31f25Bk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=tJ2Co9tUKojuced8CH1DXcfmJ2iusI4bRdY6+fWhgkfSIXnU0gbv3tlyZ0Mm6ZfR+T92QYaU+0zX8jrLP/R6Fpk6LpyGTYVlpK4BAe28dTgy7qeTD45UpdWp3rFz3XkilQU/pBRUr4g7AXXfggjYpy/xm975K4rOmjs2/0GeWqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MOSU0/LN; arc=none smtp.client-ip=209.85.222.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MOSU0/LN"
Received: by mail-qk1-f196.google.com with SMTP id af79cd13be357-8c70ab3b5fcso9879485a.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jan 2026 08:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769618827; x=1770223627; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nJe4isZGc9aUdC5y+Gj1VLBDDZsgWQlqf5f1vu42RIo=;
        b=MOSU0/LNB6E6v27XMQX//LYexCBhPH6ShQ1rEAL7utpYxFlLyZ5MLl38ey8j8EEG5e
         FkdQOM7gTHeC1YFuvo7NBDc6S8NF3IHIuYUGQ0xjKOgsVc3sHtzNVAqJEL3DSNU80z/g
         9lJPcDpz42F0f6VbokK46hOfe7jnyouLy1GjaIC3cMgmbX6jtBy0r8JaZu9MMpTzsHV6
         uvvKP6epiCFo4DmT5wxK93qoyL7OHXIqxUfZ/548D0EJ8XMH0L1EmslrOBsgBDxZsgS6
         28dxyDUxbkJOZwEBp8N1srFijgOttN0chvx/LvT3x+SZpGJlxnuG7DKrLhnnFRPklsgl
         4GVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769618827; x=1770223627;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nJe4isZGc9aUdC5y+Gj1VLBDDZsgWQlqf5f1vu42RIo=;
        b=TRZvECyOe34LNzAtVBwSFsRv5m0M4nesDrjq2jMDLBMOP8XLUlbYjjLfYYYyaCqelg
         VNdBav4FcDABWw5AWq+dPURoOxmLjUKVVTwUA+m39w96/gGhEFLxUP3eL1pV15vAl00K
         aru9cWmh18NfNc9OqvV7lxRiAp2WgXQ2ryn49/d7hQLoEJVhC5rimzVpZBy8bAcxYji3
         S5KPk10V9NDOkJR5Jp4hLv/bF4lNSN6w5Fsfea6WQka+IdiDPdid/MK0VPczfIPocRjI
         zo9CdpD00PQYFLMNSMyFm/e/Ht0Jn9SpDRFdC0K63esmDw62MwO4zo0GwE0okMWX/DLq
         aE0g==
X-Gm-Message-State: AOJu0YyBA+UYkyEvgmnPyJFLdJi94IfFUgxooVvjdmoHD6306KlE2WH+
	CcJcaUVSLVfPRCM6rZ46RRoJ1kxfh6VNlPaho6zAgRPFdM95IaRa7AfxdDS2DzWn
X-Gm-Gg: AZuq6aJ2LXyQQUTONIQTz5GEE34QlfiDHBLmPNyf/WMjaxR3ehTyzylV5pBP6DZ2ggB
	kZz0yjf68do3ZRCaHks/qmaOB1FK8nRNwGUAYIRL0YHk3IblexSYURVb/mUcNHjVMv22Ijs1i+N
	ec5P6cSgT7p8sEr+KLwrDftT7pDoOV4fSsw33ToSW4eQfDXqzAJap+46eqFH42mqKoWKXju8dlC
	XzglVN8xX7EOweq9VCweiXh9yz6/Fhp8PCmLQpiqHAfdrgApLWXVPvPsjSe8pjzdN48Ilz0FNk/
	NmCe5GBS7p67zhs2hlc7euSUesH5VnIv9qZzV4UlzyVra5g1gv5xDvdrXQe8YQssjgkG0dIcFC6
	SSNPtN58el76IculBv7x2aAaTL1QMfs0qkiXZcRAoia9LVWLHwHvg6rghupacsPU8T8kSk4CtNk
	FQunfBpziWUDNCnsl2Ww==
X-Received: by 2002:a05:620a:bcb:b0:8c6:a539:55d4 with SMTP id af79cd13be357-8c70b8fb2c0mr738533485a.48.1769618826833;
        Wed, 28 Jan 2026 08:47:06 -0800 (PST)
Received: from [172.17.0.2] ([64.236.142.131])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d3740d3esm20116796d6.29.2026.01.28.08.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 08:47:06 -0800 (PST)
Message-ID: <697a3d8a.d40a0220.1a3272.f307@mx.google.com>
Date: Wed, 28 Jan 2026 08:47:06 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8629025643571931620=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, trivin2024@gmail.com
Subject: RE: tools/sdptool: report error when local SDP server is not found
In-Reply-To: <20260128153905.163137-1-trivin2024@gmail.com>
References: <20260128153905.163137-1-trivin2024@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8629025643571931620==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1048150

---Test result---

Test Summary:
CheckPatch                    PENDING   0.31 seconds
GitLint                       PENDING   0.43 seconds
BuildEll                      PASS      19.95 seconds
BluezMake                     PASS      635.71 seconds
MakeCheck                     PASS      18.34 seconds
MakeDistcheck                 PASS      243.44 seconds
CheckValgrind                 PASS      294.09 seconds
CheckSmatch                   PASS      349.52 seconds
bluezmakeextell               PASS      183.15 seconds
IncrementalBuild              PENDING   0.40 seconds
ScanBuild                     PASS      1024.20 seconds

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


--===============8629025643571931620==--
