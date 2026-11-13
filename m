Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794594183;
	b=o3rSq++9lcPPMMLLY+ARLiDbcaLBtYbvsgvd2MwbYJk/4zhBqunw6Ypx60raIb/Hd/9V
	 eXQoHavwSiOYnEA7PPMtQKaalLDOsi/2heRauMEOQeK22hym6NAYHKy3S+ziCkFUJJuZC
	 0Ua3QlJXbN3Sq/CB0o/byYSICHSCNQfhcy7cFQzlR/SjSO95CKO/T3ZfIfpaJVpUbiquM
	 IBZ5w1hAWmezAabWo2c6+oUDBETUWuon1qdUo3Y+ProhEkoWQK4ILdgIBVXg9UY4DcDLi
	 rVAmyaCl3wlbj2t5lWmBLg1uPqhO/nnU9pz9ZE9OC0dCJIOiI4+HTa2TlmJnCKADxNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794594183;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=lGyNEBiZVB6TL11B8Pbe7exuIwKAlvs778Az/0MET/c=;
	b=r/QCI+dywQa0TPFXgUKszfG07QM5a2RMvVWFCSe6QvH0tSwJ4eN+I1RoLCcDd4RDT0pf
	 CLs9ehEZQS4Hz4F+57wwMZBNvB/3u+FDdNands7T2KW5z1y9+cq936LfZ43hA6HDWB20/
	 esAh2+/AcL08lBWcPOxge+cbsvq706FsyXbFxttVemaU3D98I198ezTxMmFMsis3lOYXD
	 f96OvUOlEUJr0R1z5v5314SKX3wwi6L3Nbj5U5nkBsjm7FSrwu62Tz4ib6z2EAqMmUg3E
	 6CXtWVk6F846mfADtLPEc3Mb7H3flhqQEUUESZ7uWGQTrZmlzsnEpMQU7G62uCIeqkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ROiR+MOc;
	arc=none smtp.remote-ip=209.85.215.179
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96746606A32D
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2026 18:23:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96746606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ROiR+MOc
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cc4c02ddd62so639789a12.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2026 10:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794594182; x=1795198982; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=lGyNEBiZVB6TL11B8Pbe7exuIwKAlvs778Az/0MET/c=;
        b=ROiR+MOc1pQZ77hQ+wzMHDyzbfR4R1U2lR9+6ECz55XFfZEnWx09YEj6CfcTBH/yDg
         puCnoiYPbOf3Q9qYNNJW+a6uKOuGeKd9X41SaohdRmWtgnTz4VKk3e07p4JB6IrEDR3j
         VMLgR2lte6tyoroD7qfmT9HiLjpwU5vL5uVDGd4zgKyrDEEy4uT4NdrPazvcUymAjqje
         cJm3zqb/KYvDC+1tpTPSocfvXX0DAame0khJgLRnG7hdZ9B+M9y5lv2B4Y/grvaysh1+
         YMrh5B/L5TW1J6S9BFx+DEvUB/0CSw4vWXfiE2gxv/AzN0sQlaEOzCD+Eu/T2cjNhHRA
         gR5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794594182; x=1795198982;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lGyNEBiZVB6TL11B8Pbe7exuIwKAlvs778Az/0MET/c=;
        b=1WC5OtVW009a8czfZH3EfiSDIa8rr3sFnyJiFs0v8dTOR5hZaBnIcnis5Q8uQSQ26o
         YqIsvc1gusW2OwR7edlQEEKsVfOz5XGrlhtA8fit+RcCylNGqSRNRuXckikGQ2ZsvuPL
         quHGj8PswqWj6zyJxqBjf10mxS76pIwlk4merufqwzi3pDpuo8sKyBvL3zSECfASoCLR
         pz4xGRBIC17bETvEd4V0XVD6yV0ULMFSmbMhRPvBk/eDllR9j+zd9JwJCSdJBZVM34gp
         j1UVHojjPvf8r6PwHi863UMr44SihR4YD8vXehyerfNvci+qpDM8vm8F2iKHzS//m+yp
         LoeQ==
X-Gm-Message-State: APuU4Z+cEG+9zElRxtRv2nhMErJ4vF1sFum4GiVhaglpv8H03gL5nFD0
	N8OtnWrnbxJQIzMcy50Jnzr8vGrzwzx+80Nwh1jJjiKj55CPmjEqPzapcwyuLblZ
X-Gm-Gg: AYBFou3cIm3DSq7fahUSNIFktglSsk8OdpI7zFpuRmqhuDWzANz8j7XuBCy9WkMXeeF
	VKFDPdSinkSdciMh3KSoLmdChr2xKM6F0g6aSEfnTbqlHbRbfV8qzoUzaUJTMcqR24GyRObKSME
	B92A/JTwGth8HQxluNSE2mock3NUgdtl1+tOt+0NIrHhNFDcPhw+2t1y0rYXIz291dfxi4q4YhG
	jg6QYXsDCDN6V0xMaJtTUFBqhQl6AA0MM5MAPGkg9sffa7xJ3gaJCaHrQOXDPgkEWx6Z8m8dWuK
	dCL80NsFM5mYKhiIwTlNp6ZFkqdClYFsvKRlT2CY8l88PKfNKpJLOV3BjRdK3E45hMXEv6IiYxN
	a3099QoHCRCZfkNt49TcB7oakYDCWJX6GJjIDGIN5qjw4dseavEcYM+oqVe+UK1P8ow7/JGKLQ+
	2mxqAvYqy07pp0rwqeXplry/nz9sj4deTIMBrMn6/LsSZkrx02wqEN1v0XoQDZmC+4I6aM7sCpi
	mqRRePKxI1gMFkkT8by5JUh5TzV/bWDE4tKgnXjFR2Zkcdk1IgKakt73fYFOuw=
X-Received: by 2002:a17:90b:5806:b0:3a7:db88:3491 with SMTP id 98e67ed59e1d1-3b1b0a4cf70mr2742682a91.33.1794594181816;
        Fri, 13 Nov 2026 10:23:01 -0800 (PST)
Received: from [172.17.0.2] ([4.149.244.192])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d35525sm10662266a91.16.2026.11.13.10.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 10:23:01 -0800 (PST)
Message-ID: <6af75585.b6e5c729.dc4d3.e998@mx.google.com>
Date: Fri, 13 Nov 2026 10:23:01 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4799479557603617817=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kevin@simpleble.org
Subject: RE: Bearer.LE1: Add ReadRSSI
In-Reply-To: <20261113172339.54683-2-kevin@simpleble.org>
References: <20261113172339.54683-2-kevin@simpleble.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4799479557603617817==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1210812/

---Test result---

Test Summary:
CheckPatch                    PASS      0.98 seconds
GitLint                       PASS      0.70 seconds
BuildEll                      PASS      13.68 seconds
BluezMake                     PASS      179.60 seconds
MakeCheck                     PASS      12.59 seconds
MakeDistcheck                 PASS      98.84 seconds
CheckValgrind                 PASS      229.13 seconds
CheckSmatch                   PASS      186.13 seconds
bluezmakeextell               PASS      64.20 seconds
TestFunctional                PASS      892.06 seconds
IncrementalBuild              PASS      203.31 seconds
ScanBuild                     PASS      614.72 seconds



https://github.com/bluez/bluez/pull/2825

---
Regards,
Linux Bluetooth


--===============4799479557603617817==--
