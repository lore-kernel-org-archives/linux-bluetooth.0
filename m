Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808D5155A4D
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Aug 2025 20:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754685886; cv=none; b=QqsgML92vhQzyuM/Ch6MckJ4AAC3q+vdtONeWft1gaPBpJnOMqEoocF593hA2q1rCR5TwMMS+pkriJwUvk0une6+LjaLwbuHPXFil5ZFoh6AN1GY51shd/3DWkXXvjFjnli7UgLXOh7RRdwl8kwlCq166j3eHjHrb6pJ1eQgez4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754685886; c=relaxed/simple;
	bh=ziluBLy5YdO/MSU0i52yr39bslrODfm3eVMP0GiYgak=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=dwPALPdlBr/wIeVEVWBQbusE2cwzbW8EjEF5cjkdDnA173gvbCrVK8SraQGVAwLkeaDDkCaR3RFNfQOQT+lhp++eqCp9MqU9/wdFxFRHtTtu5Yjcr6eNjGHbTLDNZ6tWJjGWw9VJzjTT/l2RbN6Ezl/pOM+pS1jqeh5GHHM+YqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FJrUiW3d; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJrUiW3d"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7e6696eb4bfso308963185a.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 08 Aug 2025 13:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754685884; x=1755290684; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NNoyBddlNeG9glNyJCKR01+BGIL38ekDjznl8og+05w=;
        b=FJrUiW3di3qIm/vYmxVRtAdNBrwvLuIdOyogPokkyapTo+pqIFVBTqAhRgucWQ0Pts
         EV8hF0eJrcImK75bNrAgGH7mP23cIWNaK2ctS/VClFecLSWOGJSQcmmEK0n2PXcvusH1
         8xFXXWf+UeSb/LW2m9sq5oi/ajVMjnroihvg/lbw5JkfPM7ASG4M9p7P6mt6Y2E+/fQJ
         HW4zmDr3tPhj+tcVEMVsCqCZleOjJQQb0NK4x2TxC+73DNlIOWCa/iG+2eqHgYs942xw
         W1S2AN/4T4k6fGH1pnMoHv8QiQK1ZP7D3HJJp2/X+qofaVj2KdBn2ocgWADtS5aYIGy8
         MHoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754685884; x=1755290684;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NNoyBddlNeG9glNyJCKR01+BGIL38ekDjznl8og+05w=;
        b=vgs0eJC5WG3E0qxSY2P3XcY627QymKLWNMsiUss5D0ma5OOdz1IYsHujfBEY048oMi
         q2s+o0fob3FINRada0E4roYRcrzC6Qc2UpT5JKstiO6Fdla80etQbFZiPzKSdofhkAI2
         tRkhvPxYyv0lOPwkgL9xLo6HYxczZ+fnKMhzcts5i1b6EHenERO8SsGDteVBt3sMiJSr
         q/EVNhmLtjhGtNX1g1gjOHWXnMSBb0hLmRo4incP3z0cBLDMECAvqlyCyXLJWOUmZT5f
         Rk8m3QHde8kG/WB8nxfi5ivWAkaz9jO8TJTJiwehK1/GKmV09bfB4ZtfL1r+k6XAA4CW
         cQ9A==
X-Gm-Message-State: AOJu0YzIlRuReSdEfN5G75SYJ3YnLh38BtZBqeRxSYAdoaCnaeqt11W2
	dlTwkZ0VCj/BttyTzZ3LG0g+4mzGpmarcbgjtzQZ9NqgVArlBgKVWa+G0mFxXg==
X-Gm-Gg: ASbGncsJTYAA7OXATvX0kzZs6rDI8L4y5CLYGTtdeCw9/Sw5joGxGxOv/ltdWBEJKIG
	ZFrCFB2kuVIZeUfEd/51GpnJmcAAis9QGIj6SkIVVw8Y2oQsweoxz08hddIvzG2AItsOQmG0npN
	ppRbPCg6+0pwpBuAjTOcXB/1sGA7nzWdcEGJzgxtgSmz/pav03W50t5P+DecWZKyCOMZT9HBBFT
	UI9x4kFnTiqYsS5jAGD90rIurqi6aj5Qa6+94h69EIt2So+BOw4Rj5NtOCImzdgjwOSwoZ+00og
	JpPSxR/rxPjd7zKCcY6N/6zNfPkg8ctn4Zq3ZrIw9sfycE73f68urJ08oMWPd4YAunqzAP+/KKp
	IrgjsKl7s4dLy9Wzgwx0d5EQXSA==
X-Google-Smtp-Source: AGHT+IFCV8qCaWM18b2PxLbp4H3iaY+bq/s85Yf47rNpuiVEf2WwnHYB+QPb8s0H//WLINOTJCoBQw==
X-Received: by 2002:a05:620a:bc1:b0:7e8:14c:d1a9 with SMTP id af79cd13be357-7e82c6bcb29mr723192285a.28.1754685883990;
        Fri, 08 Aug 2025 13:44:43 -0700 (PDT)
Received: from [172.17.0.2] ([20.49.61.50])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e806ad969dsm663572985a.78.2025.08.08.13.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 13:44:43 -0700 (PDT)
Message-ID: <689661bb.050a0220.5a1fc.0534@mx.google.com>
Date: Fri, 08 Aug 2025 13:44:43 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1268963197681516000=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] iso-tester: Add ISO Reconnect Send and Receive #16
In-Reply-To: <20250808191053.648211-1-luiz.dentz@gmail.com>
References: <20250808191053.648211-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1268963197681516000==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=989510

---Test result---

Test Summary:
CheckPatch                    PENDING   0.28 seconds
GitLint                       PENDING   0.32 seconds
BuildEll                      PASS      20.33 seconds
BluezMake                     PASS      2820.97 seconds
MakeCheck                     PASS      19.96 seconds
MakeDistcheck                 PASS      192.28 seconds
CheckValgrind                 PASS      243.96 seconds
CheckSmatch                   PASS      314.48 seconds
bluezmakeextell               PASS      132.17 seconds
IncrementalBuild              PENDING   0.19 seconds
ScanBuild                     PASS      957.75 seconds

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


--===============1268963197681516000==--
