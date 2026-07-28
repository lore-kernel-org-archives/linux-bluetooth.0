Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFB8380FD7
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jul 2026 04:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785211477; cv=none; b=aXpnaSVNabfAc6/NUOK+33wnYFwgpp7f1EHw8yw1lsUD0CBzZk3i0HPdfi44sEAAwZK7I+v3n/JwAUcFce0r2dRjLxoWXrkLzeMnEU5o58Q2g/P1GxTgtICN6Gv03EJAtcOQZndZAGrPq4jZ2gx2notA96/C40wqobLi9+U3mUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785211477; c=relaxed/simple;
	bh=mMrJIUswcX9njGt9CfueLbenN5qr2Dm58Vg7xjgleEE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=sjqS99jIfcVBP48QRTrF41ska1WM+BQrkT8uoieoNc6M/6adnn1QIAPHAYLfYs7uV5Wpudn+rHaWTKmkgIFvx848FVeyCP8cgEjPh4b8lXaOCGBKIacUP0JHYZHzQbuDnID9o322uwVMjsUUbBjYFaC/EVflfjGdAXjpSiRSnok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LpRa8hW9; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LpRa8hW9"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38e58034d05so3713809a91.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jul 2026 21:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785211475; x=1785816275; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=QajOqoUfkyS1fpS4z8JLz1I0aUDZoX2q65CE8LcTxiw=;
        b=LpRa8hW9mKSqebGcvtGCSHxO7x0kB+Ozu/GbU4o7EAi1ESzHFHhNJGqZqFcjaD/4b1
         YbJiM6+792KIl95BUOPSJEcygVGeFU/TuB/EDfEtwi6MW8gNcKucQeLXhNp3tW0vhNfi
         unjUW6eUj1w11S7E3ffWduc9vaiWyi64uO6jbnZMuIplbfW3zkOK9xs/CvRTgeVMq0qA
         r1v0l9wco5e6BHTRddX0H2cqPqdyjaB6LZ5Z67n54e/UKNSbwBTWkDJgtx+RW0ouUMZx
         wzrplgn9x7G/qxhQBAPPiYNDpyprlojcAHGWF3hX63xMq0xVnSEX+ngPVTdrAfyd0vps
         n1HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785211475; x=1785816275;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QajOqoUfkyS1fpS4z8JLz1I0aUDZoX2q65CE8LcTxiw=;
        b=dplej4WiO9j/Ye0nYGBv00/Rpxk58r9ZtZGKx1vzvo0CKe/DyorWVmVKOERhuDv/mJ
         PgNUh0rwzojl0CoeyXkMyyLec8lCar+7VFtrseNTwafCFLHF9uU0Lmlt+GPvCyX/Ncoj
         k7SDgSxHzTd3/2CZ2IdtjFRKi0OvcCXcXfZj+83o7aYV1qTLTree+czvtRWBeBcmXEpU
         hKYOI1pTjpztPDyuSEb5AXSR68nDp+7F4zcwR44bfV4TGC6PpKeOYE92P3yBrFObqkcj
         1TldJ6pAkitHi5hmbPBaGqzAYBSwoDpbkRrngabQFv90abR+1JymmZ6gOcEl9PZo1fqO
         QyYA==
X-Gm-Message-State: AOJu0YwbIqFh3Id5vmmz+7GDWgHyGqg33Dg7UvK94i1/uz6lSFab+JB4
	bptKvwlDx720ioa4ZTRKN5/AEovgrtjxEgmD4QS/PU8WbPVNiSK4YVhOKH5WmA==
X-Gm-Gg: AR+sD13yCpU3YlSx8JpH8I2dIrnnauCFWz0cNUeEi+K/kji1y0gUqOL1xId2LvQ0Qzh
	Nl1Q/FKFystliLFAjnXTr2u6sPObMVlxw8hSlpOZP8QHEZALcNmDUgCOmTVjMQtmpe0GdLmZv6z
	LpYeg1frezoP9LBmkDZTRfGPvANwBSzgO4n76bpiTOHpUJjP3VF7HZLD/GikPOn1Gczs3FRo0tA
	A4CdpXCwbrNIjijzR1sd95+jYrPi4qjsuuNmzYXoSFue5Lxi3IYmOkI8pZcC4w5jmntv0b3EnnB
	e1mCQXyNxkpg0lnGXAUzp/UCQnvQQrVBSmZ8nBGoSbIAEwtr1bf++2rssGShtLbaH+ITFOPtlHo
	3GzHZ9LxSQDJ3fGjL13/3/qtPGynPS53rpRgaXkKvplJ67TnRyNJRzKl2ogCmgJQ3g5E3pvMyxU
	1aM+J/b21tN+Hrwe3dEhQvrXNQjnTf0tg7ytb4+RwHnIcKdrXgHsNSh3RqVd49I/7/7/+ExXwLo
	A==
X-Received: by 2002:a05:6a20:e20f:b0:3c3:834e:89bc with SMTP id adf61e73a8af0-3c8ba662be2mr779578637.50.1785211475330;
        Mon, 27 Jul 2026 21:04:35 -0700 (PDT)
Received: from [172.17.0.2] ([4.154.40.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbbb66c80a7sm3938548a12.25.2026.07.27.21.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 21:04:34 -0700 (PDT)
Message-ID: <6a682a52.49a3bc26.e2211.abf8@mx.google.com>
Date: Mon, 27 Jul 2026 21:04:34 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1582950187068092058=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, qwe.aldo@gmail.com
Subject: RE: Bluetooth: SCO: serialise sco_conn lifetime against sco_recv_scodata()
In-Reply-To: <20260728001654.965175-1-qwe.aldo@gmail.com>
References: <20260728001654.965175-1-qwe.aldo@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1582950187068092058==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1135493

---Test result---

Test Summary:
CheckPatch                    PASS      0.59 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.10 seconds
GitLint                       FAIL      0.20 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      27.52 seconds
CheckAllWarning               PASS      30.22 seconds
CheckSparse                   PASS      28.79 seconds
BuildKernel32                 PASS      26.82 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      507.27 seconds
TestRunner_sco-tester         PASS      32.47 seconds
IncrementalBuild              PASS      26.15 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: SCO: serialise sco_conn lifetime against sco_recv_scodata()

6: B3 Line contains hard tab characters (\t): "	hci_dev_lock(hdev);"
7: B3 Line contains hard tab characters (\t): "	hcon = hci_conn_hash_lookup_handle(hdev, handle);"
8: B3 Line contains hard tab characters (\t): "	..."
9: B3 Line contains hard tab characters (\t): "	conn = sco_conn_hold_unless_zero(hcon->sco_data);"
10: B3 Line contains hard tab characters (\t): "	hci_dev_unlock(hdev);"
15: B3 Line contains hard tab characters (\t): "	conn->hcon->sco_data = NULL;"
20: B3 Line contains hard tab characters (\t): "	BUG: KASAN: slab-use-after-free in sco_conn_hold_unless_zero+0xbe/0x160"
21: B3 Line contains hard tab characters (\t): "	Write of size 4 by task kworker/u17:0"
22: B3 Line contains hard tab characters (\t): "	Workqueue: hci0 hci_rx_work"
23: B3 Line contains hard tab characters (\t): "	Call Trace:"
24: B3 Line contains hard tab characters (\t): "	 sco_conn_hold_unless_zero+0xbe/0x160"
25: B3 Line contains hard tab characters (\t): "	 sco_recv_scodata+0x13f/0x490"
26: B3 Line contains hard tab characters (\t): "	 hci_rx_work+0x3af/0x730"
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/502

---
Regards,
Linux Bluetooth


--===============1582950187068092058==--
