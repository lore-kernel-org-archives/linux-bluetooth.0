Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897F33C2782
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Aug 2026 05:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787896135; cv=pass; b=kY0rk6XkIdmJ3g90VE4VCuricEaCh8ycMryuAiv2b/PBMUwOx6mhEHlivRKxnNhB0ZeoZHFYKlYihOOhWMiTGqoHKNFxGtjefFuKQDPR9oV/efXimdFZEST1PtLdYqdBPwPlgIcN73YRE4eK4CVOLJBTlG5Z691TYQ59JiXSI7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787896135; c=relaxed/simple;
	bh=QZcZIYCT+Re7sKM4Gb3CgS7BkE6WBbGG4LvAQn5P0Gc=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Cc:Content-Type; b=ABM7dXxJ7pjVFFklot8INiRc5b50svmMbLzrkHRBsPWJtTTFmCg+cguc6KqMIx9xbDj7mZPsH7gM53po0ocwFBiLfTe6vfm4rn7F+mcTwm31JHqZHWgSSbEdNYPa+S18gh0ZIuhcXPCnPXQwcrZPnIxXYKnChB16JdideDzOaaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu; spf=pass smtp.mailfrom=berkeley.edu; dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b=B5GAk/Ag; arc=pass smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b="B5GAk/Ag"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cbb8b54fcf8so785256a12.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2026 22:48:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787896134; cv=none;
        d=google.com; s=arc-20260327;
        b=SpdeqKWJzFUHcSEVZ8r5TCz6pN2rEecIxsFXTVN4ij54Odq3WZy0GYg3ubi/4pK1+V
         oaiKY/A/566jBp+HR3Fs64qZrGbFHHjyl4zQwhBibIGZsHBw97fZhIzOQ2R/y3uvai+S
         +wMXCmrJJuKnEU8gUYKV32+tgZx4tBtXtN0oS60X1UzBtE1/W3C4g4j0ronix+H9t95r
         aM99HWXji0SSyy09WDvdR393nA6l9XSxC6nVYdwKiDRB7n0DoSUoM+WgN+eJFfjURA82
         KdwHowEE26KAnhVWJ1SX5FgrIuQM/apmVGKvnUJOOEsc2Ntf6EZ6gfn5zAx31c7wQjHC
         otuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=XGiqvAKih07txWqwNMygIXFEXpvBV7V29xEbvP7fW4M=;
        fh=NBCU8gOigzNyRK12Q7Wuy8FsvA+rSmXBuwrW0a96HP8=;
        b=Q9KOP3JNX+D8yEu03vaeKS8EhR+pOw2sewBVIArsayhjf1kKKQ0Jr7rS4eEdAUf0RA
         UcMybX0faWUfkw/dZrmFF3o4iZNNCIkY3Do94wa/MnB8Pdqrg+9ODSrZSa4wc+qP8CVN
         JlENapgvuC7SStW5sIA8frJ/8w1eS4I+fLzxO9dVPD1kS3isph8GjneG3NKN5YYymfL3
         2DkHEBQVwXDEmw1r+uPAg7E3a1y/jggeXttpq7+clAJbQWH9g98pQLsB/VDnjDt0a3ap
         xC8s81kRPzXAdQCDCqMxXzDuG97OqUedXKHQsFDjr392GPpoIRqukQLPFmemMtkbKLyn
         hrxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=berkeley.edu; s=google; t=1787896134; x=1788500934; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XGiqvAKih07txWqwNMygIXFEXpvBV7V29xEbvP7fW4M=;
        b=B5GAk/AgOD0afKqNPo5cOtmJZV9fnElf2Xj1vYu/c5YYjmE8QqyKDd3j1mRJSHFcYA
         tncqfyrzy9NElyTwYzQUMk6BGccXT4jHtAUUtnL63GKAsDdLDuPvfSJtzPXcvREWEYIr
         uFa8BHTA2rvuk1A/nZ16uf76bOAQ3Up33eeZg53INi4ibcxK8oCGNZYa5/EkN9Z4uHZO
         zdWpF7S7v4NZSirTWtRfMdUU6hQCGN7YHZV1G9kJoN7JCW82NkdzLMgxHWVRtihe02Po
         gJSh/ey6ocZIxcdN/oE3x2zOA3ABb5FF/o0Y3Zr+9tOY/7FjDqP9bwVNNXRvd6xP3pXB
         x3dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787896134; x=1788500934;
        h=content-type:cc:to:subject:message-id:date:mime-version:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=XGiqvAKih07txWqwNMygIXFEXpvBV7V29xEbvP7fW4M=;
        b=ePm+jWShhaaAIHp4B5sIvqiwujiHqz9vkkdmPPjU5YvItBkusjpo9sYUiktqH9tUBK
         oRKXJtWisUo0Hr9Z3nVBufSQxSt5jD48RbQO18PixaaiySZnwUyu7shQmP9pCHufGrl+
         /K6ElbGDOtNrM8TeY6QGLsTk7mgA59usKs5CUh9Jl41SBv3acPtTRgdFkkVRPMc6ZqTg
         BsnbtPxVzTGjJ/ZIrrl5kUNV0k/DPXOkm/n8Sp8UsaEVibSpqru2LcQKSfkVBfuDop6G
         fTOIMRkKTxDlgNw0F7BiG8ex97fmBZTDRXGO9ER2NYpvwpXciUFrb4b4eJNSjkslbzjN
         sm7Q==
X-Forwarded-Encrypted: i=1; AHgh+RqiJ80GzZGGW4+QxVdVGsGWQ2xYh+rmKen5YscK6a9zFhKK1XqVoVmOtfFhdkwa95FDfNB8nfwqXHT/XSJvCV4=@vger.kernel.org
X-Gm-Message-State: AFuF++n6VjW2Lmnklh/3bX2G0e2Fl3oKu/KrKGBXpcwkPbgmFtfXtdh/
	UlR27N7dac2JMbTcN0xEtB95q0lqLdxkjVDR4WlF69VLj/8yQbfobqlNHp9qSZO2hY/ZxEca8wH
	nqeU/1YUrdGvifztjO8xA037SDwn7+NFOTVZ2wZpb
X-Gm-Gg: AR+sD13D8vKtfhDYAyub1gMdaklAODGKFgjwEZY9QIHOiw/LzxubwSjvGi8FeIKZTMs
	KDKDC0Qu0nSbSsDZiz9XcKD70SU/uU6Tz2lVsmiOhIcu41/5J40p9zQ/wEdRMvfswJZQ63Ckgyb
	eoV+GOKpYvcShGOzYHycIgCDJUXffKQacRQm5+ttg3ut9rYHIvS97YQqc4Vzg56X5HXS50FjCs6
	SrhWYe6rx2DEIHBouXwKw06gIj57o0Nf4Cj9EFjdhgGgXm75naP7fPb3jyfj5Nfx7HtFGdNwSz0
	FP6WOlJFCiZgcud4DzIZz9ETX3RGOcTmiHM5vV0TGOCsJczGpf9psJJIfFmHFur50hefXOsqIJW
	xSr7Wgz79ipxkyNzoSp7iS0v9/ZvGWi9QwA==
X-Received: by 2002:a17:90b:1d04:b0:38e:4cb:51f with SMTP id
 98e67ed59e1d1-396d0f75f2fmr9434380a91.11.1787896132569; Thu, 27 Aug 2026
 22:48:52 -0700 (PDT)
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 28 Aug 2026 05:48:52 +0000
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 28 Aug 2026 05:48:52 +0000
From: Farhad Alemi <farhad.alemi@berkeley.edu>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 28 Aug 2026 05:48:52 +0000
X-Gm-Features: AcwNN1VegKfxy6tXl_M334rwOdANRXO1AtXiatObd5RyLQjD6NlT09EXgv8WeTo
Message-ID: <CA+0ovChS18paCd=ZE-7j_M-JtFF-N6+A75deKUqJ0Yy7ux=h2Q@mail.gmail.com>
Subject: [BUG] WARNING in lowpan_compress_addr_64
To: Alexander Aring <alex.aring@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: falemi@asu.edu, linux-bluetooth@vger.kernel.org, 
	linux-wpan@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

As part of the kernel research at ASU's SEFCOM
lab, we hit the crash below. Crash reports can be found here:

  https://github.com/farhad-alemi/public_bug_reports/tree/main/182-warning-in-lowpan-compress-addr-64/

  WARNING: net/6lowpan/iphc.c:937 at
lowpan_iphc_compress_802154_lladdr net/6lowpan/iphc.c:937 [inline],
CPU#0: syz.9.76/13660
  WARNING: net/6lowpan/iphc.c:937 at
lowpan_compress_addr_64+0x4be/0x9c0 net/6lowpan/iphc.c:952, CPU#0:
syz.9.76/13660
  RIP: 0010:lowpan_compress_addr_64+0x4be/0x9c0 net/6lowpan/iphc.c:952
  Call Trace:
   lowpan_compress_addr_64+0x4be/0x9c0 net/6lowpan/iphc.c:952
   lowpan_header_compress+0xeef/0x1ef0 net/6lowpan/iphc.c:1242
   lowpan_header net/ieee802154/6lowpan/tx.c:234 [inline]
   lowpan_xmit+0x4c6/0x1420 net/ieee802154/6lowpan/tx.c:282
   dev_hard_start_xmit+0x23b/0x620 net/core/dev.c:3904
   __dev_queue_xmit+0x11e7/0x3250 net/core/dev.c:4870
   packet_snd net/packet/af_packet.c:3082 [inline]
   packet_sendmsg+0x3d9b/0x5150 net/packet/af_packet.c:3114
  Kernel panic - not syncing: kernel: panic_on_warn set ...

Our reproducer.c is available upon request.

Happy to test a patch if that would help.

Regards,
