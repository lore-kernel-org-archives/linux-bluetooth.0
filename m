Received: from out-31.smtp.github.com (out-31.smtp.github.com [192.30.252.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D493D9DAF
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 May 2026 20:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778270403; cv=none; b=dh+B5G50nXsZVX/cmKRC82bjrOgjF1M6RIdYziqyvxhMjTnCa53FLvX5Uc37zGc5EQO3Pmhyc9mzbh6+pbAuMY/0FuPsCvVahIwqXANIB8t9yxghqjKTdfMHdlyh8SfpchO/MLzWDkiS/P7xX+gcTsRTapSp/cjsbg6FltrFmys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778270403; c=relaxed/simple;
	bh=E15fHOGdQb8wT8vomaaB1Wf+cPQCzNoVYihJMBgECCo=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=glOb2WkjgRt8dpr9/atELh9a09nY7JzieaybmtH7mIGyM81XBVUbiWxXWd6TmOBIuF1PMmwe7QbXujOhVEEBBGDO+ESTkulk1VNUxHy+SxeE/vz3ZlMPsK1VmJ4F1uj+2cvE+c+27ylm2htRIQS5pD0geV3O9g1iLsveW5nMI5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=AuVdbz8n; arc=none smtp.client-ip=192.30.252.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="AuVdbz8n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1778270401;
	bh=UZc1Xu80+hQMDr22kMbQEv5wQWYDNInb4inLWGV4NZA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=AuVdbz8nyENPQfgPK/rD6hvWv6oqGfdLm9H8uXrJuxWLuCepbPpcgBx3lercxrttf
	 r9kxGkG09tGOJUgpMLTq8NMo4adlPn07vsvrrCrwSdPfTH4JA2wt3LVdGKSYNYnBy3
	 S8eVUFVXvmj9HQNHFgjsSDY/7VqjbPeqy8koF2u0=
Received: from github.com (hubbernetes-node-219ce85.ac4-iad.github.net [10.52.141.22])
	by smtp.github.com (Postfix) with ESMTPA id 525B8320C83
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 May 2026 13:00:01 -0700 (PDT)
Date: Fri, 08 May 2026 13:00:01 -0700
From: prathibhamadugonde <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/d45fd4-7cd27f@github.com>
Subject: [bluez/bluez] 7cd27f: monitor: Parsing of cs step mode data in RAS
 Notif...
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
  Commit: 7cd27f4f66aa88194fbc1565bc13f24405acacd8
      https://github.com/bluez/bluez/commit/7cd27f4f66aa88194fbc1565bc13f24405acacd8
  Author: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
  Date:   2026-05-08 (Fri, 08 May 2026)

  Changed paths:
    M monitor/att.c

  Log Message:
  -----------
  monitor: Parsing of cs step mode data in RAS Notifications

Sample Decoding Example:
            Subevent #0:
              Start ACL Connection Event: 406
              Frequency Compensation: -16384 (0.01 ppm)
              Ranging Done Status: Partial results, more to follow (0x1)
              Subevent Done Status: All results complete (0x0)
              Ranging Abort Reason: No abort (0x0)
              Subevent Abort Reason: No abort (0x0)
              Reference Power Level: -14 dBm
              Number of Steps Reported: 58
                Step 0
                  Mode Type: 0
                  Aborted: No
                  Packet Quality: 0x00
                    CS Access Address check is successful
                    Bit errors: 0
                  Packet RSSI: -52
                  Packet Antenna: 1
                Step 1
                  Mode Type: 0
                  Aborted: No
                  Packet Quality: 0x00
                    CS Access Address check is successful
                    Bit errors: 0
                  Packet RSSI: -48
                  Packet Antenna: 1
                Step 2
                  Mode Type: 1
                  Aborted: No
                  Packet Quality: 0x00
                    CS Access Address check is successful
                    Bit errors: 0
                  Packet NADM: Unknown NADM (0xff)
                  Packet RSSI: -60
                  ToA_ToD: 0xffffff45
                  Packet Antenna: 1
                Step 3
                  Mode Type: 1
                  Aborted: No
                  Packet Quality: 0x00
                    CS Access Address check is successful
                    Bit errors: 0
                  Packet NADM: Unknown NADM (0xff)
                  Packet RSSI: -54
                  ToA_ToD: 0xffffff53
                  Packet Antenna: 1



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
