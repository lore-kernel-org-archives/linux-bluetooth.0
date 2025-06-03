Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C920B2C3244
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Jun 2025 05:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748927420; cv=none; b=rBx0Jbop1smOjVnweqKtniEIGlqTGXUlUBb6+0iejjp4U16Q/tsFgN5d13qAOq06Bd6cLpIwRyXZjc6I8FjmJY6B9uW405NshXXaDIKjVZ2d+KnsY5ihtDkriQ2ScmzIBkkcKbGCp3GgnLfdd77oloeu8wnD8O29Pq79w//Jno0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748927420; c=relaxed/simple;
	bh=cPnhdvOx30gSD3rI0ydJgy1GeRyEoR/Ti4q2CTYaYuk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=teYKa/wGo66FDabnL2TSspAUmgpwpBcV+s874dHfjM0XHcsfKfjFKHQoAel67HKfdJULwsD6TyZVGYjSi97T44vrxDjxzK8GLGOqPdRw17szR+tPLx+ro6djiF89S2bg6fZ0r0OYEICwlAY60iN4oqelDhAI0Fo233qIux6ggMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZcNzFJ4r; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZcNzFJ4r"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7d2107eb668so96650185a.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Jun 2025 22:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748927417; x=1749532217; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HYQIY8lIK42xS/L8Q9XcNAK4r3SkeLLidaJ0qUvDkcs=;
        b=ZcNzFJ4rzNyjZ8C9IX56wX6HQcr0HBlpomO2Zo6/ji73bg3QBWXNKYm+o+RsqpBw3c
         AeVq7BmktPb4WRCD5E0ZO0PDG+fRRLTyXZICMJ1ncOxEI4UBrVt3gOT1vYGlquiJHChR
         VIFbeIckXMA5pdBXv2AKhWLKpvLWQ3MaMGHQ+D4Y2zTdm4Aovh1mnj+44aPZ8gUMjHCe
         fLvYT/1oziU6h1Ikam6qaF56noFN/nFv9x+nSbIBM3TdXUimlsTYwVwpR+tCO+/WHa8W
         pFgYPdIGBZkdIj3IIC9SPJk4mlRdUsjEfe9hen/5Kj5KiT5vX0GOiqg/SP2nKYGUbOMj
         ESSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748927417; x=1749532217;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HYQIY8lIK42xS/L8Q9XcNAK4r3SkeLLidaJ0qUvDkcs=;
        b=UMTN1wk6FfKxpfHYQUXfbWSCGHkfLbvqPiP6fpSDJCKzqa+h+zjEpAf6BjO06mbS0T
         f+JH858qCayYiH0BjWB6vZtZbbdjHlA5ue2ANGzgeqoOzMAKrBrZ6AF+h4IIoifiAF+H
         hT7r5GjO4r3nph+HKi1R5Rnnp4Kl8IRMdV/JU9Nk1HLXr/YCbVWUPnZDnGqAoWlQlrFw
         HFML+TLJIiHn0j4TMmkS2hi2Ru1tog8JgXD9SCD5/6OA3USBE5sqhZlkR+Hi7NzZkA5n
         gU0jR1RH9Y8UWF7Oam9p+S+RcrYxcs74nGHl/OC4R0/7KApsBOXPNokUSN1dPuRFHmSn
         AMrg==
X-Gm-Message-State: AOJu0YzvaXzeY1Xyvd+nPOHPelQZZoE52pFVAhw+MB4qNo1u/mR6lMuW
	2iSUI0VLlEGJbbYAJyGBJXarV0VxoWykp0GF6p392O3/+mQH5F20Ah+zmW0rIRW4
X-Gm-Gg: ASbGncvibJjF79wXRGHHqFlH0sOWnpW5f7Ns0Z/qGQHLm/ou7urraO6blOVlaufOzsU
	GEuAvPbMRninrxfqX6rinld6J/Vpl5b5HTMHM77jYHuRfHtWjVUFOVgDpoy8cILUpnkGPxpXpD8
	21SO2yjH2zLfBebeYFkef5bCGuIb1Fr8mvUrmOhDk3K0N95zjuFAMUahefpHSUNodLVvWjSP9Ke
	+Xv+7CD4cfBtcbjjecyZkjgK3mYrR8Xd67TmRYswAvZXG69eOcknZnv1Z0AKD4dxLL2BrpXHmPR
	qzmIZ+M3PkkTYX7Ns77huO2CfuUlX9PGzSYux92GNuLrWWVrHLPCSq2if8HWnwILZmcY9GC2xOQ
	mnw==
X-Google-Smtp-Source: AGHT+IHxfSC/5JlcrUJjg1rVEDinlskMRSe+TEfny8UlJlat7q94T/yff36CSKrdS9nZV0FEtZlaWg==
X-Received: by 2002:a05:620a:248b:b0:7c3:c9f4:522 with SMTP id af79cd13be357-7d0a4af5fcemr2045529485a.14.1748927417144;
        Mon, 02 Jun 2025 22:10:17 -0700 (PDT)
Received: from [172.17.0.2] ([52.179.127.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d09a0e59b0sm775580785a.23.2025.06.02.22.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 22:10:16 -0700 (PDT)
Message-ID: <683e83b8.050a0220.1d7745.9686@mx.google.com>
Date: Mon, 02 Jun 2025 22:10:16 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5586947650042459737=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, aerusso@aerusso.net
Subject: RE: Do not start mpris-proxy for system users
In-Reply-To: <9d7984b8-79c6-478e-95c8-28a6d4a7ba9b@aerusso.net>
References: <9d7984b8-79c6-478e-95c8-28a6d4a7ba9b@aerusso.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5586947650042459737==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=968153

---Test result---

Test Summary:
CheckPatch                    PENDING   0.26 seconds
GitLint                       PENDING   0.22 seconds
BuildEll                      PASS      20.39 seconds
BluezMake                     PASS      2746.97 seconds
MakeCheck                     PASS      20.67 seconds
MakeDistcheck                 PASS      198.66 seconds
CheckValgrind                 PASS      275.81 seconds
CheckSmatch                   PASS      302.33 seconds
bluezmakeextell               PASS      127.98 seconds
IncrementalBuild              PENDING   0.26 seconds
ScanBuild                     PASS      906.58 seconds

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


--===============5586947650042459737==--
