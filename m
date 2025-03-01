Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E9F1E2614
	for <linux-bluetooth@vger.kernel.org>; Sat,  1 Mar 2025 17:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740849123; cv=none; b=N6x7syBe7Sc7wOzza0QnFMyYwX7eFhYNWKisawF3RKaCLrk/etFyZFtkvx6A+L0DjpCJVrdTWVy515lxHr9rFD1qXYjWitQTXEmhgmCZE3OqRNte6iS2YkGFsPE5MuQvu8YVytmh3TJg4+P07wzuEr+0t1NfhDclJq2nfRgwWZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740849123; c=relaxed/simple;
	bh=GJPp2q7NVxbIIhNQxaUrAWdsLhRA1RGKruVRVI2clt8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=lAkYXID9HSC1/QWuxQq7yTFvCau/F4HfX3oVELmXx1MDOw24rIBZq81o/SWKRobCFU6f6kdITdy0vJboLH2KB1X3fItIwaygyz6W0YY6v/tLkeG2nygWgirR2ztUZq98G1ZCobm/MEQDc0NGhbLrW3egouxmg157o9ebRG2aqNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mQfDUhmI; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQfDUhmI"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2232aead377so60093365ad.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 01 Mar 2025 09:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740849121; x=1741453921; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AeQ+GIVZSXGzmf7F9eBvIHdokQZYBDotDJUQnQ3JWSo=;
        b=mQfDUhmItKZAmHC/NsjNoIbBW3VxwPJyGPZSb8m5pIxLVgwCeOWWVrQOlhxUMqp0C4
         Z/McpKYcxcXgAeHTNULwWI72fYo3FwBhRI7dDUdQs8MQ5xpcIhb4WOXrskDBy9E/SR/s
         ecmySX9K1CGMqfwH+hidqtxLwyuqTRTH/2gfB/2iyPgDRuyXAn97zmQIX3C/KF1lOBAD
         agLYfIHiKBOouEmEbRpjAGvHJ+EwP0tpYTuy6ZkvgT13sMTDoau+fg3vLUUIbLYB/U0J
         /3+M2FmKsUwRfAqPwI7gxguU+SIecreVWJlbp8kbgDm17NT+TTjjVuM/e2vRgGVYfizK
         WdfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740849121; x=1741453921;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AeQ+GIVZSXGzmf7F9eBvIHdokQZYBDotDJUQnQ3JWSo=;
        b=pC+P82Io2Geg8Y0D3ZMZyc5Fp0a6R6UgawzFurAJniCRfhGvttFRb5fJiX6oDMcrfv
         j9QD/rRe4WLDa4vVi+UFDaW2b5BqaW2i3dnB/iej1izxf6uhc2f6i/BiRBE6+qC/nhmH
         f23CeB9v3YoDoOHXikuWzh+5VlBGSA9w+VVgyLXg0POiY0F72wkUWd/rKSltu/5P+94q
         O94jctsvOvthc/0a2+d3YcBDYMaVxgyeUX9HE5JnHH4K1ibvRVETkYBYhh7S4wQt/aJg
         gMCBtuDFTSFI+jrvydMAN6r/k4w09B+TM9u/t2l4CKLiaLMNWpc6MbbiGAiYQVf/mSo7
         vQIw==
X-Gm-Message-State: AOJu0Yxnvh3nNt9mjIWfKxgWAZjaBpOu95Lvg1ZRGDA37hc85zlWa11e
	F/W43nxfl5EqNfurOmnwYf0PYPyUKVqgqgN+vMcGW1+CuhQJ36IhZIpMbg==
X-Gm-Gg: ASbGnctM22zCLtcZ3rthq4zU4rY8OCxhxgul8+yOVeR78LTPKa0i11Pa5fTPeWQ1RrZ
	4FvuE8Gzw8GBnfnmDlw2ibDXnzApARgSUVxe78N/0OWz79eCn4nlUUqaYI5xeYN4UkyxZsZXJ55
	OwXha5C6mWT3NMNUotQUwpFxDnZ/DyrszI0BKBeMpFsT75GD9xHylTDh+z/J/G2AeoUBbgurGVs
	e5t40yYqFAIkY8D3bKNP4znuxZRmFIh8Kj2/0PSvVflkTVkHi7ODSzTAzluWaVpCxHl4eTBvotv
	bdGukOSEmsoPFe6oU+oikSIihfAJHtrICOdzCskB9ZtInHHV4w==
X-Google-Smtp-Source: AGHT+IEcmkj4fN38tC2a5zfv+WgcyRKbEpPbTgKLDzB/3ueVpodt9itioN4HfdwGpwyqjYT2KySzbQ==
X-Received: by 2002:a05:6a20:914f:b0:1ee:d664:179e with SMTP id adf61e73a8af0-1f2f4e4c875mr10232748637.37.1740849121371;
        Sat, 01 Mar 2025 09:12:01 -0800 (PST)
Received: from [172.17.0.2] ([20.169.15.28])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736343fa0f9sm1688175b3a.117.2025.03.01.09.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 09:12:00 -0800 (PST)
Message-ID: <67c33fe0.a70a0220.b0141.53c1@mx.google.com>
Date: Sat, 01 Mar 2025 09:12:00 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2705678418721114769=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: BAP stream reconfiguration
In-Reply-To: <a0a8eb4d51a35f3181617303aa8f6ad8227b2bca.1740844616.git.pav@iki.fi>
References: <a0a8eb4d51a35f3181617303aa8f6ad8227b2bca.1740844616.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2705678418721114769==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=939281

---Test result---

Test Summary:
CheckPatch                    PENDING   0.24 seconds
GitLint                       PENDING   0.24 seconds
BuildEll                      PASS      20.51 seconds
BluezMake                     PASS      1476.20 seconds
MakeCheck                     PASS      13.02 seconds
MakeDistcheck                 PASS      160.25 seconds
CheckValgrind                 PASS      215.99 seconds
CheckSmatch                   WARNING   299.79 seconds
bluezmakeextell               PASS      98.83 seconds
IncrementalBuild              PENDING   0.30 seconds
ScanBuild                     PASS      883.73 seconds

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
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/bap.c:305:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:305:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:305:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:305:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:305:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:305:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2705678418721114769==--
