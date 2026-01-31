Received: from cvsmtppost101.wmail.worksmobile.com (cvsmtppost101.wmail.worksmobile.com [125.209.209.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1576333EB18
	for <linux-bluetooth@vger.kernel.org>; Sat, 31 Jan 2026 16:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=125.209.209.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769877411; cv=none; b=QZfY+/ZVtkcuvehCLpgXcH6S17VQtrNzvvgZ6ev4wz/GUPtRuPHRrtjSg5tQ9pZTiRtJX//5hAEO4WWXKbQ1kdKLfqE+VAVS8/fTSMcldMaZj8AdiiNznu2Sj243FUjAeZQhu0lWZRTyLwgi3jCtZ6CLOxPBnk7YmLw0PkfhMek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769877411; c=relaxed/simple;
	bh=3mKH2J0734mpm7AqPQoZTpFJh4I580+PKSFCdcDWoI0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NzJXfXnCagRVtWVTcX4PqlNo+UewEScAf3javZAAKnSpPIXGCGNkIbWAS3Ax+x5n9yDeGaIATH3/tc25HYK3kpQid2QQUUYN5hikMQJvZoiscQEC4JKoynFsMUYQCrwn3KUSTgUHumeRlLvy7kKHZMGSLFtU6NgZoCZoVuYhJXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=korea.ac.kr; spf=pass smtp.mailfrom=korea.ac.kr; dkim=pass (2048-bit key) header.d=worksmobile.com header.i=@worksmobile.com header.b=mS96LBbH; dkim=pass (1024-bit key) header.d=korea.ac.kr header.i=@korea.ac.kr header.b=SiVThtRm; arc=none smtp.client-ip=125.209.209.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=worksmobile.com header.i=@worksmobile.com header.b="mS96LBbH";
	dkim=pass (1024-bit key) header.d=korea.ac.kr header.i=@korea.ac.kr header.b="SiVThtRm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=worksmobile.com;
	s=s20171120; t=1769876799;
	bh=3mKH2J0734mpm7AqPQoZTpFJh4I580+PKSFCdcDWoI0=;
	h=From:To:Subject:Date:Message-Id:From:Subject:Feedback-ID:
	 X-Works-Security;
	b=mS96LBbHWnTPlDWA9ileOKtXpQUBAmD5bxMJVtfR1yzzcRh+TowD5ruMBRxb2qDML
	 1iFIcxB8jkTQIlp+RM6SzRa4bAyv1yMBosUQuNO0rzi6j703TPOl9RGb+I9Gak/rL+
	 27aFwL2vFN0kWrg/UlPC/fxw2gfLzaIldHB6ddwD5CuKEiLXzqa5BzZzVOnDXrhgP2
	 xS25S/KTztF3hcQuAtUTMZDRgkD3O79vqUiWOIzF6dRypfob7ZLiy/7/+KvVUzZXv6
	 ePk9M7DiOhgLZiIPRpsttfVgEzNTpyzbAWzsiUFStsf1+VuZdYSC1spGsw+b80+bEo
	 zRlQhSbxG9+QQ==
Received: from cvsendbo003.wmail ([10.113.20.165])
  by cvsmtppost101.wmail.worksmobile.com with ESMTP id ztHuTmLUTNKJnA7wQAdbFQ
  for <linux-bluetooth@vger.kernel.org>;
  Sat, 31 Jan 2026 16:26:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=korea.ac.kr;
	s=naverworks; t=1769876799;
	bh=3mKH2J0734mpm7AqPQoZTpFJh4I580+PKSFCdcDWoI0=;
	h=From:To:Subject:Date:Message-Id:From:Subject:Feedback-ID:
	 X-Works-Security;
	b=SiVThtRmclsAq6fCfVPDTfBTWC+ncgT0bixx9U9m26fcdSF2uhU2zefI4l5NYb5Dx
	 /xWANSDvuCLdHjDKQz7UOBUFu2dNQBK8goHwXecuFJaaIvebQKGMC37XbB0IfWrEc3
	 b5Ic/ERAulV6bTYUyKjsCghbt6g4e8C5SMHiPveQ=
X-Session-ID: WiDvH+TtTuKrM-HgIB4cfQ
X-Works-Send-Opt: kendjAJYjHm/FqM9FqJYFxMqFNwYjAg=
X-Works-Smtp-Source: A9KdaAvrFqJZ+Hm/axKd+6E=
Received: from s2lab05.. ([163.152.163.130])
  by jvnsmtp402.gwmail.worksmobile.com with ESMTP id WiDvH+TtTuKrM-HgIB4cfQ
  for <multiple recipients>
  (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
  Sat, 31 Jan 2026 16:26:38 -0000
From: Ingyu Jang <ingyujang25@korea.ac.kr>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	Ingyu Jang <ingyujang25@korea.ac.kr>
Subject: [Question] Unnecessary negative check on unsigned variable in Bluetooth sockets?
Date: Sun,  1 Feb 2026 01:26:37 +0900
Message-Id: <20260131162637.3337555-1-ingyujang25@korea.ac.kr>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

I noticed that in the Bluetooth subsystem, there are multiple places
where an unsigned __u32 variable is checked with "<= 0", which makes
the negative check part unreachable.

The pattern appears in three files:

1. net/bluetooth/hidp/sock.c at line 163:
   if (cl.cnum <= 0)
       return -EINVAL;

2. net/bluetooth/cmtp/sock.c at line 159:
   if (cl.cnum <= 0)
       return -EINVAL;

3. net/bluetooth/bnep/sock.c at line 157:
   if (cl.cnum <= 0)
       return -EINVAL;

All three use the same structure pattern where cnum is defined as __u32
(unsigned 32-bit):

  struct hidp_connlist_req { __u32 cnum; ... };
  struct cmtp_connlist_req { __u32 cnum; ... };
  struct bnep_connlist_req { __u32 cnum; ... };

Since __u32 is unsigned, the "< 0" part of the condition is always
false. The checks could be simplified to just "== 0" or "!cl.cnum".

Is this intentional defensive coding, or would it be cleaner to
simplify these to "if (!cl.cnum)" or "if (cl.cnum == 0)"?

Thanks,
Ingyu Jang
