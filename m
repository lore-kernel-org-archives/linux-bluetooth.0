Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D278F38C40A
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Mar 2026 10:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773312953; cv=none; b=ieSZkDrmPhmpfXxxbHinHQzPws1z4cb35rMhm9GiLtjRG40JkZnrMtu9yiLF4pouF0yXVrGtW4Kg7ULwk30N1mFnUPz64mzShaym9l78OWRX53U/7IdUN/QX/ogfztR8MUxfwEYwQLn/TTgUIMJKLv2DU5blMO1O1XTs/bUlvEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773312953; c=relaxed/simple;
	bh=7yg/gTddGcsY/xTga8IaTKYi9pNTsqsglc7Dp5yiTMQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=XDN/WOcmZUA6E1TDxIjwjGIuy77tpl6QPxHnJFH5pR2FPfQNYuRWT8gWcwX/Xf87PUJzOsumzi7XzvdvogrirXalxFM3h8utZcSi+gtjS3K0EybObJzbWyKw/xS+/5O+o8HZXr5Jl5HjLQ0L/NzOl3QxrVe3Cy+cpHTD9xK4EQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RxTXHa/U; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RxTXHa/U"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5090c48de85so10419011cf.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Mar 2026 03:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773312950; x=1773917750; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FWqfv/qx9iZnGxJ8RQvOfadv4LCKSpBOmqQyv9NQpNE=;
        b=RxTXHa/UriQLFBiZcz87Pc9YIXCRQEtTXwv2cOyTQ+iwkWvJrUUtfi+L2Zlw5KjqQA
         Rt9rbagw1VpfZ/XhDAgCsYgGGPR/LWciEXRYE+qIc7loVZxaP3+pXYTPwh3Q6orNQlPl
         OcC/UpFDQnPO9sVYcnQj95kd1nJF/F73mTdqflS80euln1WOFCwXNzrfgy2tg21HAbAM
         SVOqXTrMw/m+KyXbjyfjv7B8wgisywjEWd2cF2B0v683qtoEToCnB263FoEtbIjUQ1Qt
         okLKbMMhS48btFt61NdPa3pzErXnkx95vD2k94rm1AdLiCWyoFcioYDH9GtGmEJ8e3ES
         i4Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773312950; x=1773917750;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FWqfv/qx9iZnGxJ8RQvOfadv4LCKSpBOmqQyv9NQpNE=;
        b=dQBDnyzTV8SGsvqgF6NcXaNKbDDTicGx56NGwokJ2FIa9tYry9mOibw2YV43PhD+vF
         7UzRW+caIQBw9X41W0T7P37GJCxN/AU4VydCyOrDQiv2pC68maUsgNJdUXLM2uI0Oxfj
         rLZEJYcnvnImmNvVwfdlt5bWi8YN1pcSfkqcjftk2/kPW6ZkMNFJDCKYbsIC/S42IEkD
         BZ0wavXD9zI+/JIvPivqkHb/LlTGU8/AcOlG5yCxG7ZbyGH2e4QKXDR+77Ijep5QkfPt
         ql7TNn2iuF3xVvzU8g7RBiUkcUH+JS1vX/9LzGbWbnoLFaXTHjM9wweQBUmGWerUzFea
         T90g==
X-Gm-Message-State: AOJu0Yx+2Y44iQ9R8Pa8Rp7J2dH/aodRmnPs8+5yps1VTUpqvUEeWBXG
	ptijpAfrbOljURaCHwBNFjIJ8dMEpAUN7gkuBPpXIr2WjJ47gHEBDteYXYefrA==
X-Gm-Gg: ATEYQzwCJnuF1qAAqxJGMKQ/Of7395KSMyRqbzahNe+RRYFM3TOk8nI7L9miEWm5tAB
	Nm+NQgyOUE5hM29hySsbwp936ydwtXr5OVHTfVsl9COQYpNdudvN7uI/FR7qM2R18tLnHvNN56+
	0/03r6i9NNSpDHWyUaPMAfccIJWQqKLAtuXdIy2Q5hDUI8nXpgbqy1qTaZjOLwpH2THS/fc96Bf
	gzx+q/ZVntxle9vCbUXSGXJcgMosu4hUVMYSuvOa0OjtjvslHa5D+NZPs/gM3kBDeSKYRZO2aBj
	KM/8m018O4n0SriD0yLZ8TkmmLRpLrTAKEuwuXBIFJaHMcU6yxyG1m49PQDvR9toc1SbkIu43oG
	kvCpUAYLsjHriXBFVTNyiTizXgm0CCfJ9yfEBIQWpZ/TlgHREw4LIMgIvgw/uKAtCteMHhpdgle
	Q9Nqj28DgxFLCrbO0DqdgO6DHBrQ==
X-Received: by 2002:a05:622a:392:b0:509:2b02:c1bd with SMTP id d75a77b69052e-50939f6c301mr71603971cf.12.1773312950456;
        Thu, 12 Mar 2026 03:55:50 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.15.98])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5093a14d7a6sm29995301cf.33.2026.03.12.03.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 03:55:49 -0700 (PDT)
Message-ID: <69b29bb5.c80a0220.33451d.2c32@mx.google.com>
Date: Thu, 12 Mar 2026 03:55:49 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3355402793950460192=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: [[BlueZ,v2] ] mesh-gatt: Fix JSON files missing from dist
In-Reply-To: <20240214224955.405535-1-hadess@hadess.net>
References: <20240214224955.405535-1-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3355402793950460192==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=826174

---Test result---

Test Summary:
CheckPatch                    PENDING   0.31 seconds
GitLint                       PENDING   0.37 seconds
BuildEll                      PASS      21.07 seconds
BluezMake                     PASS      645.24 seconds
MakeCheck                     PASS      18.75 seconds
MakeDistcheck                 PASS      250.26 seconds
CheckValgrind                 PASS      299.92 seconds
CheckSmatch                   PASS      363.65 seconds
bluezmakeextell               PASS      185.23 seconds
IncrementalBuild              PENDING   0.34 seconds
ScanBuild                     PASS      1045.53 seconds

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



https://github.com/bluez/bluez/pull/1957/checks

---
Regards,
Linux Bluetooth


--===============3355402793950460192==--
