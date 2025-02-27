Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B5C1B4155
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Feb 2025 21:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740690911; cv=none; b=m2llSPBGXOUy1/HDepJBk4AG8lpgjRZvKXNVcnaVfOxySieUfKwGZTDDQbb72CZTQ8uw4h08ASWGq9cUZzsTdH2oiL//F8R7QNMYBLE+9r0g2Qkp8T3J4qsMgf2WiL4FoGNHE/nuOxaufdBXTAlBeoaGWv9AWpIcc9pRZcFAhYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740690911; c=relaxed/simple;
	bh=pWpbV0TS/tCNqr8HF/LQ7b6PywbjxtaLnMJgHOjBEEc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=rtCwhQ5+pMBpRQymgjnlMZ4BubJQgItrzKfcp1oCnrneP+p2wUUeVsZ6ud9Ba13u/ZWZxQvjr6H9l/vj7i0ieF0sfTG8Q5Wx0ZMQ8HUgOoVAQaT8TIDPPrPCdNZYFprT5iG95fsOu0ccvRSf5PIuV7p45lffCdMSqq+EbEGb8Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A7Fmg0MO; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A7Fmg0MO"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7be49f6b331so151920285a.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Feb 2025 13:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740690908; x=1741295708; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CA7h42uuUg2ruVJlvKa/7LvJbBNTaaulsO6+ZKr0h6E=;
        b=A7Fmg0MOJ0fpTG8Dk64dVKArYgIwR4BELipgyJ3ARtK3ko11803qiUv4MSGEzsGXTr
         IaK+1EnHJ4O/x64R+jXBbGFHqpSnnLwjas0ZX7JXcSYAyikqPGubM5L2M6kH6QQJ9yia
         JBmGsIBrqc4b4YT3b2oMHD7nZIyftwQRmNojaA+OQ44Y0IbD6LDeSWFtpQqYYmOWRm8r
         T4/zm6RrodXVPWgm+7dKOQY+A8+l7GL3JfSGoYMV5ylgJutDvJIuXo6kPnRYu3mPl5rI
         FTdVXkJ7oUMUojwCW+iMp/vSKQdYYsGcSJYyaJXbTdkM9qt0GZsLNQ4zHLhRxYrcVC/A
         kpdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740690908; x=1741295708;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CA7h42uuUg2ruVJlvKa/7LvJbBNTaaulsO6+ZKr0h6E=;
        b=IFBJGcE9zgZmxVmH4rufDtHteapsV/u9vB49DizKmgEFiCbyGULD4bx2/ANHwt92Mk
         RSkwXSwSmTTuxIoOcyVZtl3iyh/+s5rdGmPHjaPSBRkld83X0M7ygIAhsMqE27TXTTa+
         2D1yVBDiBHzmDC15L8nGyNam99c/NfB/3WSqvChL2qej9SXhICt/pQ3OqoNwt5N5k8Ju
         oTx/h448YXunVS8H7dKYTL7ukBAascXyEku3kWV9IAJl+wytYEKtn0QvX9h8zZp9uEdm
         qBzpnvpYN3NGBOK3a0z9DYcCH+1WMbfeUwIT85m+ISGyLZERY2O5kRmIWuvmALzQ55uG
         VmnA==
X-Gm-Message-State: AOJu0Yz9OnzkpXbdbum4OI8qUwKq17oCs2JXjzhmAWqfxA7hKLPjhfAm
	k0hrBKMkPzr/zI8sQHYX3XSSGRcXfIz+KwT4cS1tMXokvJJBKBVgyXdjSA==
X-Gm-Gg: ASbGnct25LVkrX+3n42qhKu1t4CRKgwPFSb4YZdkidm3jVRYuWycM26mO+L3V6idk20
	w7VLQdYQESGzJ8qCczVQRUaTrCIbz5AHOllwq55AgOCqCi5CIgkS6no20ar7Z9xJT3I7Z+PzsF7
	y9GOqx6LL4JZBvh1rAB+RZhK4QrUkuhWyPhMcte/EBQkd+NUNrT07I+yk3hfN9zt70kgWZrq9Kn
	jtk5XPDZqD53zoCsYeD7Tee44X/2RE4soBMVdURfXdZYa18BbtJh5kyQvxwKBjsQMO3tZTiLcCs
	CHmxwv63bYKKiP3UOAqS0JjlTW18C5xe
X-Google-Smtp-Source: AGHT+IFtPILfndIH1Euipl34oLjsjdmh1MSfEAAaNAoHYH6NxTzMvqHiWQDFzBSlK7KUNKkyulOsJQ==
X-Received: by 2002:a05:620a:424e:b0:7c0:c1d0:d0b4 with SMTP id af79cd13be357-7c39c60ea81mr128349285a.40.1740690908086;
        Thu, 27 Feb 2025 13:15:08 -0800 (PST)
Received: from [172.17.0.2] ([172.183.77.32])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c36ff0f3b3sm152831485a.59.2025.02.27.13.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 13:15:07 -0800 (PST)
Message-ID: <67c0d5db.050a0220.24efc7.6aa4@mx.google.com>
Date: Thu, 27 Feb 2025 13:15:07 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7927511775383090171=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ] sco-tester: add test for disconnecting SCO
In-Reply-To: <b3bf384b8e710156dd2a0f7ee2c21b98da9f4c79.1740684902.git.pav@iki.fi>
References: <b3bf384b8e710156dd2a0f7ee2c21b98da9f4c79.1740684902.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7927511775383090171==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=938658

---Test result---

Test Summary:
CheckPatch                    PENDING   0.20 seconds
GitLint                       PENDING   0.22 seconds
BuildEll                      PASS      21.15 seconds
BluezMake                     PASS      1610.57 seconds
MakeCheck                     PASS      13.42 seconds
MakeDistcheck                 PASS      163.53 seconds
CheckValgrind                 PASS      220.02 seconds
CheckSmatch                   WARNING   293.41 seconds
bluezmakeextell               PASS      103.51 seconds
IncrementalBuild              PENDING   0.24 seconds
ScanBuild                     PASS      936.72 seconds

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
tools/sco-tester.c: note: in included file:./lib/bluetooth.h:232:15: warning: array of flexible structures./lib/bluetooth.h:237:31: warning: array of flexible structures
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7927511775383090171==--
