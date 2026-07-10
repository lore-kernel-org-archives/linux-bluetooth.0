Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D853750BC
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 06:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783663425; cv=none; b=FvGklQTVQyoZvkUTe+h2cNIbsmIQGOB4zAN3ED++5UMs95zFlscqjuTKYorhOwkEn7DY91uhbEcpETo7Q0mmUBpIREXo0wDLq9HFpqvQvHDcZgMpzCuMqja/GEzU/If+m0kjD+gx4VaTR7lbVIce8AeET6U4ZAvd1RsFPKvPFEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783663425; c=relaxed/simple;
	bh=KhHHDAOTYZr9t13gx4YVukpxiVCL7JTAw3NnwbpE0jE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ss+EnuP6IsC/KSSy1AMBuia48dNgCOgRvBQ01eZY7Z/NGZT3HnrurL0Vfv62hr2WXe7/eoVQgGxwQBjZ9iWAHI2FI3Tac1WhMDwuN6pP24naub61Cb+a25LHLMqDVus4C/uoJm4fH+BgGxZ619pu1SP0MfdKn8CirbgBB7zgXgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=Kix/aeOo; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="Kix/aeOo"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cace91f112so4664625ad.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Jul 2026 23:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1783663422; x=1784268222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YslU2XdAYfGanbbwAxmZPfELhZDR7H4hE15o+cNrNs4=;
        b=Kix/aeOo3J4kczTOWiOGZbJUnF2YX1qdHLdUYhnJU0L0kadpaF5D+OFCBxDTcpxFsI
         66JV9A1DXaYB7PED4qNf+GKBkYJ/jef+kMm0sBuGnA13yui97XVRiRytz/5JWZdE8pdZ
         uRN/wQRgSs0mr7bnmsifR6QqArFAxjBz/h2yzC/5uIWsHvozl25XNjI0AkQU4YGG5EQJ
         XZctxlLYju6c19t8Fx8Xsjr1oLO//leEwU4vjmjydLnjCjCjaK5q0Jprr8oijrLBTh6H
         nclBtCrKB1jzb7tfmGYiRG2Edh8cGUoD0Clc7V5F/FqF+ZgAKKm0NWaUclKfq9Pnpnen
         f9Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783663422; x=1784268222;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YslU2XdAYfGanbbwAxmZPfELhZDR7H4hE15o+cNrNs4=;
        b=sCjTW//r8mpLLB0OMdELchb6GvEBApGbcZPKpW08mPaJpG0P062U3IlHxxQ/nWXCp7
         yn1bq1x7KAZl+9sjifgEUMVXonMiTWm9HsJ8eqxOMFMtSUWuN+JhU5OBg2Wwh7ZzWANm
         bIZPQYSwbLE9XMOs3DkArNkIsvfnKqR3PWlZiHL8pNniRLjSjmR7OMy7j+isH2cAuPJ2
         ovijYcALMHe64YQYq7YRCZIkvnqqG5qHqrItzes0D3z4IuIjdCHwuSqe8CTr3ijHKl+6
         uV+cSHO/IW3UAqCxlB3FgUJ4guxCsCLUqm+wEIBs2Ya4AKIukCKVPQxpywoApkfLjAlU
         WtCg==
X-Forwarded-Encrypted: i=1; AHgh+RqJeYvxZmbSVUd3xpEnaXYHrsO08fKFayDZd0hesf4rguGn+4orLBkdo48qiT0MU1McbqMM5Qr/Gw/Ll2ENP1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXMZifjpHKCD6vG4QxD+Q38ijY93jBGjY6SzTU+Jz+RBc58XdR
	dl58d7ea7hY6/yWoLz0xyD2QiuJ43hi4yOcWjDnfsqR7HmjwkPu70LfTcITI3t4Gm+E=
X-Gm-Gg: AfdE7cn7YYw2/AL2bheHNjavVquheYe/2ZWAqcsA3SGOpmIzSjmzplLJlhGKtqlMJ8p
	+CUDibSIsLArjdO3sIFEVj21+JBw9/pCPFbuSRrFJCkCG7OHaF2FkIrF62ZA+0fUHCnnlyvXc5f
	j4RynqcSK2re7wPpVN0jCriBDB6qjN0OUJkgGK46eMcd4yBrp9l/W0DWg+39QFBMxvxgMqbpPeW
	r+3JTtNEbdqRGAQdG3TqC+lTXp6aBb+NmAkRbtekt+DkoC4E/3elTBSI+twyMo9O5XKCxsF9IWJ
	CcEB7rZbFxmb7Ua80Xn6O47ymE4C8YzmfbpKVqnCeg0Lpq2djR51lCz2kyeDikTXdlAodyEttpA
	YwZXFlZ2kfkw1Pe0tfQcSFnky7r+0BLzbVCaPqg2opSvcFjGD0xL4gYlT/cszBBIIm/36YEnBrc
	zZPkQ4V5lTyNKMMlqM5weY5mEKL6aOJ10H5kExDuXHIANhkKzHZpt2JlLAfp2caa/KcyS0xtXbp
	3h46B0hj+LnjwDW4rkfaJngZUZmYQYbAsWGbcMsmeo=
X-Received: by 2002:a05:6a21:6b01:b0:3bf:baed:c797 with SMTP id adf61e73a8af0-3c0bd0fa3d7mr12173891637.49.1783663422438;
        Thu, 09 Jul 2026 23:03:42 -0700 (PDT)
Received: from Metius.iitm.ac.in ([103.158.43.43])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-13b659d8da9sm63639393c88.14.2026.07.09.23.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 23:03:41 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: marcel@holtmann.org
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: btintel_pcie: fix memory leak in btintel_pcie_probe()
Date: Fri, 10 Jul 2026 11:33:32 +0530
Message-ID: <20260710060334.136987-1-nihaal@cse.iitm.ac.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The memory allocated for data->workqueue is not free in some of the
error paths. Fix that by adding the corresponding free function.

Fixes: c2b636b3f788 ("Bluetooth: btintel_pcie: Add support for PCIe transport")
Cc: stable@vger.kernel.org
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
Compile tested only. Issue found using static analysis.

 drivers/bluetooth/btintel_pcie.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 7a87549f587d..870939d8450b 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -2988,6 +2988,7 @@ static int btintel_pcie_probe(struct pci_dev *pdev,
 	btintel_pcie_reset_bt(data);
 
 	destroy_workqueue(data->dump_workqueue);
+	destroy_workqueue(data->workqueue);
 
 	pci_clear_master(pdev);
 
-- 
2.43.0

