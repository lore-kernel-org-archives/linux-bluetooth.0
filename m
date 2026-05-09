Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A616C2FD
	for <linux-bluetooth@vger.kernel.org>; Sat,  9 May 2026 00:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778286224; cv=none; b=nvmrKT07/y96+UHm3xmjimw+LEc6D9/L26nPV+Tp9W6ycSjuH70y0ksli0K1PpB7T7Q+USuVmcHr1KVwJ5wAuR6FxQIilmI5kJEgZtFRoo5+863UWwni2Oz+xv0vy5gTk4hZzR35o6Xv/x+NdAXBbW6aSPMocFdbhgJtb8g2Eh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778286224; c=relaxed/simple;
	bh=4L9njLwPt+x0tmfyQ4Be5amfxyUivUCP/lPUSH9BiPE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HZe7K6aVNlV7sI6Fzb4FEwBIZ3X46+vRoDnM0agxZxPbW/YMVR93dU9DLN9vw/PcoVtyS1qwkYx4oQMBNS/RJdZ+wL3DZQ32SLNShk6PQ1A7If0UbEQohm4mhvAlWavuqMxKkcwh0YF15ZAR3mCKrUl1apx7eHFJ+h/mubfKDIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=prestonhunt.com; spf=pass smtp.mailfrom=prestonhunt.com; dkim=pass (2048-bit key) header.d=prestonhunt-com.20251104.gappssmtp.com header.i=@prestonhunt-com.20251104.gappssmtp.com header.b=p9sa6bvK; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=prestonhunt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prestonhunt.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=prestonhunt-com.20251104.gappssmtp.com header.i=@prestonhunt-com.20251104.gappssmtp.com header.b="p9sa6bvK"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-83d31ac4017so581606b3a.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 08 May 2026 17:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=prestonhunt-com.20251104.gappssmtp.com; s=20251104; t=1778286222; x=1778891022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iStTXFvvTn1nIhG8KX3xrMWXt1lscjm0GW28X2wP9y0=;
        b=p9sa6bvKLO7RsBEEwHnV0Bjy+KvQOj2Xko+Hl+4jimgGvnGG5ccnLdcI6u/4r64ZFn
         6+z8BCNt8esTrS4ONyXg0KF9Xw7wJGqsOLGagRGjCxBxAG6Mw/aEBADXhr68RVPryviv
         qMcLkeKlrbw5tWqRg8Fa6A4gUNKe2cmEyqYmYwHOZa8ci3M5v09EceoeQDnl25m3GrGf
         SxtjofwG+nDO3f/Eg9WnmWsWZTh6iKPyWyA4M3er/uqYDWO0z3mYzbbFGpwGnQngsAvT
         6fIx5xcqNZQTQ8SakDYvH4k0wThpkBPNw6UuMB1gC8rPcJm/JO/3SFeEv5PrKFyyM2Tm
         92VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778286222; x=1778891022;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iStTXFvvTn1nIhG8KX3xrMWXt1lscjm0GW28X2wP9y0=;
        b=GRrzpfpkO7nuelzHYNx9snM5Za59xbbhFFGU4zRcwRWxG6JI+5VENIaYgf/EVoj7VN
         31dGaCDsQtGNUXIGvzlrj07/L3Lo+8OWE9SEr7eIRKNp6Ov39ADPJhuDjbucRNH7GoEC
         NpqS6fFhGz6KTwRP+YONIePV6aY3QKIsBervYuA2rXul+NU0+W96p1RGvTXU7ZR9H8pG
         ZYzpm7QdAyAUHufGFzZzzShnvT9wJh0ruYkpNi30BXGws6EQqBRXy4zeO50J6DGzfLE4
         BN3RZZZd/kySgE6gWezHE3spjfCFrbzQXFPMUWh+6yWIkQM8XI2LFJLLCzoHrqbsItRD
         N8dw==
X-Gm-Message-State: AOJu0YzeJTqxs2Bb51s1RaeADVuhLF6r/wJdCtNKVeWnq8dlx5p4xfEI
	Tl8+LxhghEy7MxFig93KrdaKiuB36FvMHvoE7frVXGCoB5EQvh6BEDspSbThEfEuvWWLgmlCvzq
	5GmTA
X-Gm-Gg: Acq92OEk11GA89iCSgFW17kJ/xbk7WNmSQQKcs2vxBA4fzmoJgXcv5IJEsMG0broNkW
	mAsWurNJuiYQOtybGDooE1jFY7CEHKJ+p4kRFsES2sC9YHMFjURoU/CcT8EWgROrpNakVubwNSE
	5SdLg7ozv2HZihSbO+VUFF+eFiXJ4HjKq8Pr6ROaDQ4vyVxNb4B7r89L/fQelpxF2BgtX/2bO4T
	zWlT3C84GRsz1nanO/+3quLx7TgfjqtBrU9Qd6zEobbQ+CfVWw5kMlGnuZCDJ33t6XbU1RQgKG+
	3EVetldKWV6O5VHuX+6dz8Bzhwctzf7CNVfb8ndiIbat+l3Ge0UQB2RPM8+y9/kkzqqh6yzL2jX
	QkBkV0B2HZDrKq5GcWnkdeNFGq9OaUP2xO/GXAczjKJvnTmiO4XoAep+igVOG68fWvUgB+fXnG8
	zyqc9RnyQjai2jxJvxMBdnPGVmJHdActKSc6DaYfugMTzaHDLDB5tiDjZhgB0vuE5C4SVAUGF67
	K3DZjM40w==
X-Received: by 2002:a05:6a00:4193:b0:781:2291:1045 with SMTP id d2e1a72fcca58-83a5b2d34damr15144301b3a.8.1778286222368;
        Fri, 08 May 2026 17:23:42 -0700 (PDT)
Received: from tars (97-115-124-22.ptld.qwest.net. [97.115.124.22])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83967dbdda0sm13765615b3a.44.2026.05.08.17.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 17:23:42 -0700 (PDT)
From: Preston Hunt <me@prestonhunt.com>
To: linux-bluetooth@vger.kernel.org
Cc: Preston Hunt <me@prestonhunt.com>
Subject: [PATCH BlueZ 0/1] btmon/TDS: decode org 0x02 as Wi-Fi Alliance
Date: Fri,  8 May 2026 17:22:48 -0700
Message-ID: <20260509002249.2771777-1-me@prestonhunt.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding support to show Wi-Fi Alliance when decoding TDS frames in btmon.
AFAIK, this code has been assigned to WFA.

Preston Hunt (1):
  btmon: decode 0x02 as Wi-Fi Alliance

 monitor/packet.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

-- 
2.51.2

