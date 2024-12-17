Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F9814A0A3
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Dec 2024 21:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734472472; cv=none; b=j5HXEeRObQBueueK+Xrhl+V75/gVvo7mnLChn2ET7rygQ4G1llVCzLVtsbZvsYI78pXQdMnTSWLLdK9lyzjZaAjApDGqBLp4MSgVSCzNuV5CG6wH+oAfg2ny0gnw+WGWIRH1GXcpdzW0q/AvNSlLI3GxUae7/p2SfsvpstiNF8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734472472; c=relaxed/simple;
	bh=IAaMXjVyngnAZ2Q6smNvEFPA3xria4U3xgZZULwYN5U=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=BJvSISr0TCTa3X7TKRmIDBuGjrJIjsLrQUTNceuBqdZ1ryYQoFtptLWVfAFjVZTmbC3AYmVL5A4OhfZE9WOuRQM7EaxnbDx2+h3HHecM6rkgrMRWEMzJhv94tMsn9B9UIaa88aBttm9VZLQT7qURGzwFDxjiI3qoYW4bGVpiZB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zv2h6qJ/; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zv2h6qJ/"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-467a1ee7ff2so45705281cf.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Dec 2024 13:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734472470; x=1735077270; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jcP8Sz88xTiIoJRu8g9+hvohZoMAsOf4DSoD3sSDGFY=;
        b=Zv2h6qJ/iglyOFjH2jzll9kV/4DXegKybUDL7O0Me9HkwC3EC3ZZYMzbB3jwL1sq/P
         NtpDSPmYVAIX1sFQzmQXQQdAA5KNzd8TDzclDscCfcCGbK+T0lAilmYXI0pPT6j654m0
         UGZLpHXCWkHCoJnI5DCQF9fXIVIdHyD/hQfBNfWZbg0gy/EDm0Jzm1XH7DIJDLR/tP5G
         tlVOFHBuSenvTyAm0m6oU1/NiPz+F0uwWNFmCVwoBsvKXF8oac3PhS40KsT7y6Aj8vTm
         vOxwXZAr2VoF48ZZEUXWp1/FUvNjXj7DNe18NfMKUGA2cdmmJY3wb/rcauEbIOj1TZ5M
         WK3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734472470; x=1735077270;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jcP8Sz88xTiIoJRu8g9+hvohZoMAsOf4DSoD3sSDGFY=;
        b=MbHA+Ozf0/Or5q96fN8PWqQlI+UvhURYWNud+vzLRaLtzVMHU05MN5lvQT596YKUcW
         7aNLvDrj7C8ci0IUKVTJBkCq14yH3wdCYcbel2JSAqc9R+mb06V+lVzJVu28oO7n8tWU
         kvDw5JwGDyI+oFYjfpXk2z+YULiir62LjwQ1smL7q7yz8SjzpPA7oKZXsyeuWZ2AqoB8
         Mg/C7QnLVoEmnojCfVUMNwJ6H4FhnC49qPQ3x/Ft03yfV5mutSWTQbvn+FcMZLNQd3Iz
         GGgZUBFScEuM6j/Q/bGd4D91DBsVuB12nv4ottMDEOvavtQWvknmC49+MWRZFGZHEZZ8
         I+FA==
X-Gm-Message-State: AOJu0Ywkbs6rewfxEiD2tqUIXVba1xxQ1HYNkECahdL6R6V4/MILmIeH
	3AIs2qgvosCfh8ppNGe+zhIqGWVrZ4ceaxUwfvWS9Sz0bm9HbUj6f6dL3Q==
X-Gm-Gg: ASbGncvI0wrsas78tzXPgTFwYR965NdBy77BQC+JnkDZYGrXMfX6klSfh+hNCPCnXBH
	VM0FeAmYY92BYwI8sMvaB6PP2kAGI0CiF1NXoensTZt8J1ptJI53W0w4xVtliTz5cHUY0ZQ2RTO
	aTq0G29qslzqRDS31oYlXuxnpCZZltq93d+tgkmAXxX93i5TM9d1X9dbQBa/OAfrSEgqVh4lUqj
	G6iW1Lj+Wzb05mz6Tac1vLR0h0UcURYqXvP7chjc0ovkcpU9xOMCngwO8nNElM=
X-Google-Smtp-Source: AGHT+IElsWE8K5M8kbeyaJdR48l5z1JxJoiinKy8xtHSxIuwqziNJ3976ydesOLRAWmwaEt2yC0DtA==
X-Received: by 2002:a05:622a:1a17:b0:467:4f9a:6511 with SMTP id d75a77b69052e-46908e03f61mr7937281cf.30.1734472469621;
        Tue, 17 Dec 2024 13:54:29 -0800 (PST)
Received: from [172.17.0.2] ([74.249.14.242])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-467b2e99c02sm43739281cf.67.2024.12.17.13.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 13:54:29 -0800 (PST)
Message-ID: <6761f315.c80a0220.a1580.f736@mx.google.com>
Date: Tue, 17 Dec 2024 13:54:29 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7015376016874563407=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pchelkin@ispras.ru
Subject: RE: Bluetooth: L2CAP: handle NULL sock pointer in l2cap_sock_alloc
In-Reply-To: <20241217211959.279881-1-pchelkin@ispras.ru>
References: <20241217211959.279881-1-pchelkin@ispras.ru>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7015376016874563407==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=918835

---Test result---

Test Summary:
CheckPatch                    PENDING   0.25 seconds
GitLint                       PENDING   0.21 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      25.34 seconds
CheckAllWarning               PASS      27.79 seconds
CheckSparse                   PASS      31.50 seconds
BuildKernel32                 PASS      25.09 seconds
TestRunnerSetup               PASS      443.75 seconds
TestRunner_l2cap-tester       PASS      22.67 seconds
TestRunner_iso-tester         PASS      36.70 seconds
TestRunner_bnep-tester        PASS      4.95 seconds
TestRunner_mgmt-tester        FAIL      121.07 seconds
TestRunner_rfcomm-tester      PASS      7.69 seconds
TestRunner_sco-tester         PASS      11.44 seconds
TestRunner_ioctl-tester       PASS      8.20 seconds
TestRunner_mesh-tester        FAIL      6.61 seconds
TestRunner_smp-tester         PASS      7.08 seconds
TestRunner_userchan-tester    PASS      5.19 seconds
IncrementalBuild              PENDING   0.83 seconds

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
LL Privacy - Start Discovery 1 (Disable RL)          Failed       0.173 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 2                               Failed       0.116 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7015376016874563407==--
