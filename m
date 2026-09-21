Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40FD4B488E
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2026 15:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790005153; cv=none; b=IAUrA00bB4HKjpBeZZ2MhcvddkqNMXLmVbrGBC89DwQOIu+oSxreO0DJ8mKA2iMQOi//Ko0rsqQWjwycTRjX3yPQQrvx8VBt1QvUdgaEcWhSGuqj+upjf4Zns+AU6fzZ0oaJaVbaqlvfcR+NTRrgZ3Ssi2RrQGqf7we/zvcTcVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790005153; c=relaxed/simple;
	bh=NpBp5RM3QWRJ9dwHp+GlV61NTC65LnnbLZ3T/gon2ME=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DgnEXTrH+rpYynnwaxzjsn8IjqL1QlNEwmYQE+l4o6gLLTul7pN0sF8Yti0vA+aspUkrj2Oy7qRYstdiI95nrKV/UjyaIz3MobQntAZlgPjEhGdAsVgGBhLOPjNkS4nYt+lVLh6mvBLVEsfTHYuXBZGKrlvggRm8czFkBWzQY00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mw8m4woP; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mw8m4woP"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-85469a34907so3396333b3a.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2026 08:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790005151; x=1790609951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NpBp5RM3QWRJ9dwHp+GlV61NTC65LnnbLZ3T/gon2ME=;
        b=Mw8m4woPQR/iVt9n84Bopgd/F+EeMsNbzC4SX4efUtOZo1PBbgDfZybiPESC5WH7Yj
         DXsHoq+zmaURqLybkMP1+kwoMtMet5GIMZRTGWyZKgmQjw7pcufY28QvQMqLg+H4Cr/q
         DhGTt0HFSX4BOra072tpB0OSFPTpX74wRmigiDx8i0Th2bFE4eXdbq2VqRlY2TpvvWCC
         RD/kb1JyEy++cB8aESMULMlxtKDonsJa0K2Jz0tAXuGsrw0DgcJSZdm/m1rg8CPBoygI
         i6qJrJmVmci18kGPu1FopgMnUuGeVbj+cr0rcHan2sfky+dWhdj3bgaxl8ZqQiylTU41
         hDvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790005151; x=1790609951;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NpBp5RM3QWRJ9dwHp+GlV61NTC65LnnbLZ3T/gon2ME=;
        b=VBPQUHhuyseKBlbtn3NKMN3yDk4p1Mj3XKwGqF5jrVccl2C86FhaqgGDyumoCqfJIz
         MBgpUsWjLR/8u3KDUEu63f4Z2tFjyHl9tEs8pibhNuvKRChmZ8pv2VZG1+098YS1cEuD
         T+CmtL+FU7FBNgimF3Rn2IStSjlY12PkTzAAmXL9P/ErEuEOzpixYs2bsZCEMe+PlY/y
         bDIkp6jZ+ljDvvhR7mx7OSdazMRdFvJh98XApzDRNobsDabd5g43OvoU5o6Bre3CXJIC
         qRyQE22tj5go+YZQTdou54FmmYNh6z0YwD41w3GOHZPXdUvR7rco70MCkglZo9UxM8SU
         o/hQ==
X-Forwarded-Encrypted: i=1; AKwUvBy6MdnUNYUwU7qZ7BBHYnAnimIoSx25E7kK8514BlXpgVpcepH8zSh9h5DutIaoHIKNbnLPG6Ay9JMvKlkzmuI=@vger.kernel.org
X-Gm-Message-State: AFuF++kn4pJLZ/aJw5azV1NR4nZAVMAcXGU2oM5rKxezoSE9xf1MrccQ
	iGCuX/1TCrJVC/KyM3puwaE7fju5Z26rQOjrXi7AEXAxUJMjrw2u4r7W
X-Gm-Gg: AYBFou0T5ZpSgbTlay3re6qXYaFnAXXkoN0uqENYiM9w347wg5ivWtGXP0SelT3ild+
	4nC1N+ZEHVdV17LlWzMFEJKXS+yAoHPIk3Mm+hYmU6ez4PViv/FSWnngEYFa4+TYlz+90vn/fD1
	ISmNGXlfI02rds19e/oD0ScxpVI7AYD9QgXEITnqdVumhzCx8LiKPbz0fey1EgvAe1Swsn3N/mp
	f2y/ZycBKFxeDlxwtIs4OHy6FgG/ydroaggzuurHux/e1uDOr6yNBFFRaQ4u9/+PktxrKIxSKOQ
	AbL5KrKpcI2wyhRVT3+tjSry8A71vaX9/fnNx7TFsGsuOC9bm7V/vj0T/ksL4XzJfsrnIbxXvQt
	VAurx1ut6YaSWGMNk4WIiYvmmOuEFZ7BMDfh9POwZVRCUZQc0Ne0VIdq+kMKp+VtkKFS17Ergeq
	F/6Hj8enilggcmMa9lOTAb2LvtITk3RD4gew2Nliwx4jEQw3ym/je/o9FjH5KZ+inryw==
X-Received: by 2002:a05:6a00:2e20:b0:857:7337:5db8 with SMTP id d2e1a72fcca58-874dd9f1d6cmr15473443b3a.22.1790005151194;
        Mon, 21 Sep 2026 08:39:11 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-877a6ae7d71sm3448186b3a.2.2026.09.21.08.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 08:39:10 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marco Elver <elver@google.com>,
	Jukka Rissanen <jukka.rissanen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH 0/5] Bluetooth: 6LoWPAN lifecycle fixes
Date: Mon, 21 Sep 2026 23:38:57 +0800
Message-Id: <pm-series-6lowpan-lifecycle-82fab5876048c8c9503c-0@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6LoWPAN shares L2CAP channels between connection setup, published peers
and packet transmission, while teardown also schedules asynchronous
cleanup. These paths currently disagree on when channel ownership, peer
visibility and module lifetime end. The resulting failures range from
leaked or unusable connections and peers surviving disable to transmit
use-after-free and execution of unloaded module code.

This series establishes a consistent ownership and teardown order across
those paths. Shared L2CAP and workqueue changes provide the lifetime
guarantees needed by the following 6LoWPAN changes, which make failed setup
recoverable and stop users of a peer before releasing its resources.
Keeping the changes together avoids fixing one lifetime while shortening
another.

The timer support adds one ordered workqueue per L2CAP connection and
serializes that connection's channel timers.

Assisted-by: LLM
