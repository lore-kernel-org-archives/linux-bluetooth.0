Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9402D9ED1
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Apr 2026 13:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775482638; cv=none; b=i9U/eosUzQBOkcJ7bgEwjo6g67KWtQ80qvi5Q4Bs2hdqkU5P+IGw+19Ya/YhsXijyl2l4N2pfwJMI8E+xL79rL5ZhYmau5YVHRig8ZX2JHceJj/TPTKMdfGaIBP8VDcdN+WuNxItmvoCwiT5HDHzGKTSONqVzS+hXrTRRZdDrGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775482638; c=relaxed/simple;
	bh=A/jeWw/JQ9ppGR/DTri1jMqal2SQpL6M8vsux/aBq9Q=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=aG1q0i5+iX7LcaeA8b7s1OE3Nsi2ES23/RfvR205Cy6eVwpoDxACCfDPl8HCYaDMVerJF9ACz25qwNj4u4sB3DcVkiXPhKKEux1kDN0wB3K9hKvvN6LUG6K7Xg8o8FUnxqPlIJX1f8qlXVReJDtVWAMNPjr9DY8AH4XdJZteOg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YaXDSR3e; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YaXDSR3e"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2ce102afb0aso1855823eec.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Apr 2026 06:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775482636; x=1776087436; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DrCfkNzJZnNZcuPKMDZd47ZoPwSN53iHzv5tO4S7k6A=;
        b=YaXDSR3e475eEpXEYw3U37gSmHpto2uDwJ3AUhGG0ZW/KDLtw3uCXI5C/ZsYtW/V2l
         auR3+GSihWbycSjBjHtioT/cjKDK2CPCwiVmsgoal5qfMXhBvWnS1Pef+OOKTkDSnQOH
         lFaby20gPDQFLhC9inefYRsxgdNQWlEP9UM4O3cxVnVCzsAPyWkduYxz06wJVXfCyFEr
         QzG4nuNQC5ZMneNCw8nrtp6ZsTZOjWTiu6pzoWReokACQbwDmzEKknmEHNAgr9o0A0CK
         /NT4NdfRpGZElCNFPUTfmZTpN7EbxzNaaUbdzD9XeyrZxCapWK7QXMMmj6udj8W4nTFR
         o4Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775482636; x=1776087436;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DrCfkNzJZnNZcuPKMDZd47ZoPwSN53iHzv5tO4S7k6A=;
        b=UDdgqgg1/4ZHh48wNgGT0hM8hm0Ib/zIx4mPNdjRcWfXLSwTBYKwzpD8kkP4Hnc47u
         OYPKXUXhqGRDdKvqyiMMIfngZzOXrpWAjYz/vQChOJRsSHoBzcmoYRVq7MLQqEm0eCaQ
         Bt5Os+TDGeuSdE2hTErhNs1632/v7rEmJeAR4j33qh2lwbiU095doVdvwwn4YWvf+Raf
         PQM8BejXTmC/l+ks6aFuQXbBuZqgha5n7hCBShZ9+t81QnBOTnZm8V9fgOb+IC9F57RW
         RJHpDGDMrHOmv9v9P71ydIktOwY5MClamHFMJUIagPaL1KJIPu2g8FQHelVwndmQs2sK
         PbdQ==
X-Gm-Message-State: AOJu0YxCqbVeu549hkmPQlMbntE3fW9pd//7a/oTQsuHlJiLtMLnwbxA
	YcBXHPSK8UC/zs2qumNRzutZrE2p7sibAHKtmInV9on9w2pp6wzFwfgx5kLtfQ==
X-Gm-Gg: AeBDietTN/MyL79MuVEnrFRLfhaUqlbv+abVZL23MHRaJ7fZWRex6hfqD7n3cb5gJsG
	mEtyDQjaIQgqwb38ZF/tiYLCAQCSrS2kR5vAXoiyCzqqv/+i9KtghkhH5u9q9n588+VAXKQxWzs
	V6Yl/duw7mBOWcwMuljO6HJjDqsF4cH5FYeRd5CMlGs+LO8Xc1Q6J4R6VaKJvp0WoUTAtx2Dm0S
	cuFcRXdQLvek30aIf3/EOqioZr1WrAKmf4cn5Xfmi9fO9sWc9JPFj1bg9L1m+045plPK0rQOn0Z
	BMLCPro1H85FiKqFNYEGakKSNbZgk1vLSbPoAqx47oG3apXwOhuRUn4FHpccI96nJw2R9I6aEit
	9FPP56Q2qVsSQ/4QnSeZTyW1k4AQEncPmJY3WHgOWflOVtHGt+AeZTFhZ/anAWRVfYp9vb/CtjI
	xTuVPg1/hI8T2zh/rav+hwsQn9XLutt4YB
X-Received: by 2002:a05:7300:dc92:b0:2c0:f84b:2455 with SMTP id 5a478bee46e88-2cbfb4a7fd6mr6714207eec.19.1775482635940;
        Mon, 06 Apr 2026 06:37:15 -0700 (PDT)
Received: from [172.17.0.2] ([172.184.191.165])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2cb92ea0ef1sm10779808eec.21.2026.04.06.06.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 06:37:15 -0700 (PDT)
Message-ID: <69d3b70b.050a0220.3c3c60.8110@mx.google.com>
Date: Mon, 06 Apr 2026 06:37:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0239823341111620630=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ,1/2] tools/smp-tester: don't write array out of bounds
In-Reply-To: <2ea7fb22224bbe69de6bbbd93f9d18f0cf5045f5.1775477129.git.pav@iki.fi>
References: <2ea7fb22224bbe69de6bbbd93f9d18f0cf5045f5.1775477129.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0239823341111620630==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1077645

---Test result---

Test Summary:
CheckPatch                    PENDING   0.39 seconds
GitLint                       PENDING   0.37 seconds
BuildEll                      PASS      20.12 seconds
BluezMake                     PASS      668.43 seconds
MakeCheck                     PASS      18.88 seconds
MakeDistcheck                 PASS      245.81 seconds
CheckValgrind                 PASS      292.93 seconds
CheckSmatch                   PASS      347.66 seconds
bluezmakeextell               PASS      182.95 seconds
IncrementalBuild              PENDING   0.47 seconds
ScanBuild                     PASS      1043.08 seconds

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



https://github.com/bluez/bluez/pull/2019/checks

---
Regards,
Linux Bluetooth


--===============0239823341111620630==--
