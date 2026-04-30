Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E970221721
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Apr 2026 15:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777562909; cv=none; b=FhrDMuJ1/+MMeZOPe1gh4LWb1JHyZ8KNBVHLjn3UrPj6D9/bdZFSU95JzWMlQGaoRZmpR2U8a8ntYL8/6/LT4ZzCj1c9ZbRRHiaVEpL0b4P3JkFubE13fS022gvoXwQ8oIrjgUABt4APduNAo2JHMy1vWczk6U1qwAKjtXndmV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777562909; c=relaxed/simple;
	bh=YAgoho6+6cjhlts890bLQ6R6aeMk+3uqB6ileo8FT9s=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Y8co9aM5EJTQ5kQ79vj272ObujCMmbx4bqQhlDv7z+YtB2JuAL3vgNTR6sQzyR0neopOUuhfiFHqdx1YHE1st+sbCy0idfJ31LJZzhl+py54b3JjfSkyzhGnF69IwGDdtSZci+SUlqsu3UeUGAc3dEVNw5CN3SpWrGaJDobZ9u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=EyV/bwD/; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="EyV/bwD/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1777562907;
	bh=BRpvdaEVOJY7Lw15lEsyZHIg9xcYIJxqsrM+so5oZps=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=EyV/bwD/IBVWKtug/Ebh3FeSM+6cZTBzX6s9l3WVaoptXMW70Bn4pBtYk+arlvdgQ
	 FlQrnWx3kUPydr83hGm10FSXnsOs61PBDWEfod9fI8eTHj9OO920QEklia6r+/5s7l
	 9X/gm4U/e2rp44ys2oLA3wVmQav0bPaU0LQRJnT0=
Received: from github.com (hubbernetes-node-39ad0d2.va3-iad.github.net [10.48.125.30])
	by smtp.github.com (Postfix) with ESMTPA id 40A19501118
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Apr 2026 08:28:27 -0700 (PDT)
Date: Thu, 30 Apr 2026 08:28:27 -0700
From: prathibhamadugonde <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/304bc5-303ea3@github.com>
Subject: [bluez/bluez] a9b39d: src/shared: Add RAS packet format and
 notification...
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: a9b39d71597dd28f9339bee4548b537c6749d384
      https://github.com/bluez/bluez/commit/a9b39d71597dd28f9339bee4548b537c6749d384
  Author: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
  Date:   2026-04-30 (Thu, 30 Apr 2026)

  Changed paths:
    M src/shared/rap.c
    M src/shared/rap.h

  Log Message:
  -----------
  src/shared: Add RAS packet format and notification support

Implement complete RAS data pipeline:
 - Handle HCI CS subevent result/continuation events
 - Serialize ranging/subevent headers per spec
 - GATT notifications for real-time ranging data


  Commit: 5d4792dc2a2088e7355e19b5fa763159f2a8231d
      https://github.com/bluez/bluez/commit/5d4792dc2a2088e7355e19b5fa763159f2a8231d
  Author: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
  Date:   2026-04-30 (Thu, 30 Apr 2026)

  Changed paths:
    M profiles/ranging/rap_hci.c

  Log Message:
  -----------
  profiles/ranging: Read cs_mode_one_data members

Rearrage reading of cs_mode_one_data struct members as per spec.


  Commit: 303ea3c539b80778eaea68900c9ea9bb421a97c0
      https://github.com/bluez/bluez/commit/303ea3c539b80778eaea68900c9ea9bb421a97c0
  Author: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
  Date:   2026-04-30 (Thu, 30 Apr 2026)

  Changed paths:
    M unit/test-rap.c

  Log Message:
  -----------
  unit/test-rap: Add PTS tests for CS reflector

Added below RAS - Real time Ranging PTS testcases:
RAS/SR/RCO/BV-01-C [Characteristic Read - RAS Features]
RAS/SR/RRD/BV-01-C [Real-time Ranging Data]
RAS/SR/RRD/BV-03-C [Real-time Ranging Data notifications and indications]
RAS/SR/RRD/BV-05-C [Real-Time Ranging Data disconnection]
RAS/SR/SPE/BI-11-C [Client enables both Real-time and On-demand]


Compare: https://github.com/bluez/bluez/compare/304bc5b78a3c...303ea3c539b8

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
