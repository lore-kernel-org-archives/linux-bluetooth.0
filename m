Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853696A8DB
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jul 2024 19:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721332008; cv=none; b=Q1TmTB2pAlE9zEWB2lcEfcrm00rdEV87tN6KdByiXhxi759WHlKVPRBNjrBre7/MAjzN1GPsbE9WWF24tp8ouMc3fF2U+yOoPLLThRp4K4NJv27RU/N9BGGzsqkCjiC2NJ+PQfyQXO+dhMkwLK5mSOn2celqcE1HFxb3kpi/kNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721332008; c=relaxed/simple;
	bh=PYpJQhGF+KivuAGOapWe4J7alRLlOEwzIkmX17g9k7U=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=VKLdaXLDv6rTYhGeBS42BqSrvant0EaaGrLkVCUIcBpvtiTZ1GwpyoHTwg3DPNUKEBmJfbYvBBGosXvdNzwi0Fnf8e7GEBdzzGJ7A7UYCJCD/sO4Tv9PYpzunFoN8l5ngvqW+BPgZCb6bOsaU29/nJXqh5B1SlR+bRwIVx81iBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bc6ukO9Z; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bc6ukO9Z"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-79110d8e459so873470a12.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jul 2024 12:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721332006; x=1721936806; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ggr8PeJCjxG+IbIyNz8Ip1eaIrDo2amRu2Da5RydCig=;
        b=bc6ukO9ZooRc+iS+cgJOslgTEjeSqJx/1SEm5woIRppHeLzP6522ymkUbJjt5EtW4u
         YeCd9wdFZNuP5eZgC6/JEH28YGvqU6bIltYVE16E6NnjZI2VzkDZBobF/pG0AkbcAAU4
         qEs8XLA7BpEwGhadkGd043FVNeg+RhrYty2hroTB33+HJejDokEqaXRmaKsDFirv2vMa
         cDNDqZrrCStTO5jNi7vZxw5dPbE9gHiwD1a3QQ/UPzhuqMgAFPhJ0YggTobungoMBB+X
         /R7xHkkx0ueZbjxM/27iUeezQiTJ65jx1AVD8jDPV+u1WDVffiU0x6dahxD9T/4fKh26
         JjSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721332006; x=1721936806;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ggr8PeJCjxG+IbIyNz8Ip1eaIrDo2amRu2Da5RydCig=;
        b=S3FhUR3OH03/W6TqFeWCKTQqlJZ0qcAnxgYFWXqH72c/9/7mKiqrsHOnVrSZ+aKNS4
         igVbV+ysiihLX3cCisuFvvkRk8H/e+52OEdYFKInODmFNIXwDWfCscLCPt1eRte+7pKG
         m674vAMoCFOIk8xe0XE2vULtInSHmt2mx+/KYMJuq/rOsowItEOarFU8VNhdUyj+4MVt
         GwZXcsaCllJnjUSNTXkS4JLnazcOOjff1nKoajsBPpc1LTUFvXL4vPi5MmIWecg2WK+Y
         lxL0HtAOHzrzGq0ne3rWWW/9nEFYoWy9pFByeJX2uMC3PANTQ+ST52FCelJJQqI82DCw
         464w==
X-Gm-Message-State: AOJu0Ywor9ClWsdG5TJGLWN1YjureRA8J+hbZTp8WdQXnd9DhQkSBhgv
	coZLJQ2X2UPrRyN6Z7ByYNEdoVorPIwTBUlXrtjDwfjHN9xjXUUVZRYjKA==
X-Google-Smtp-Source: AGHT+IHoWpXFnpDutjA5m55K76edjiRqGHhwNLGRD4HIEt237cdJaKpby06VqA4M5HEYdcfKSiv52Q==
X-Received: by 2002:a17:902:e801:b0:1f4:977e:bf with SMTP id d9443c01a7336-1fc4e16d44dmr46084265ad.19.1721332006519;
        Thu, 18 Jul 2024 12:46:46 -0700 (PDT)
Received: from [172.17.0.2] ([13.91.68.94])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bb6ffd3sm97148815ad.55.2024.07.18.12.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 12:46:46 -0700 (PDT)
Message-ID: <66997126.170a0220.ea4e2.7582@mx.google.com>
Date: Thu, 18 Jul 2024 12:46:46 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6958359535831907658=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] client/player: Fix printing errors when transport->filename is not set
In-Reply-To: <20240718180059.1159551-2-luiz.dentz@gmail.com>
References: <20240718180059.1159551-2-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6958359535831907658==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=872320

---Test result---

Test Summary:
CheckPatch                    PASS      0.28 seconds
GitLint                       FAIL      0.45 seconds
BuildEll                      PASS      24.53 seconds
BluezMake                     PASS      1714.39 seconds
MakeCheck                     PASS      13.34 seconds
MakeDistcheck                 PASS      177.16 seconds
CheckValgrind                 PASS      251.47 seconds
CheckSmatch                   PASS      352.97 seconds
bluezmakeextell               PASS      119.81 seconds
IncrementalBuild              PASS      1489.81 seconds
ScanBuild                     PASS      999.96 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v1] client/player: Fix printing errors when transport->filename is not set

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (81>80): "[BlueZ,v1] client/player: Fix printing errors when transport->filename is not set"


---
Regards,
Linux Bluetooth


--===============6958359535831907658==--
