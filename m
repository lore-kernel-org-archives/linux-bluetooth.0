Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3FB47A0C7
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Sep 2026 11:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788260452; cv=none; b=DIjsyvh+V5pycqB5JijIlrFsv0TX+KAL/mOuvrSP49X47sSXz+IwQWdOsfXNNZX2TIIZJ+Dkv/amMH8FwD9SDFqxcmEHe6NfNG5i7bM1vLj+bkcUH5X7jBO5dIIk53il0Bno5DrmcrSdz3MiwV50BZyw/rSxoUx7m9j+Nil5ItI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788260452; c=relaxed/simple;
	bh=ZSNtgLnqj7yCZ9IVfEDOtv57ABA5afUyh+BQ2GbE+j8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZxjBmtZuaOkXtr+4QBDSpyppoNRV3weA1yF+5c5fQkxYQk6jbnak5PTk8GcYmFSYTd2ZctfdferssFyZZ/+dfYtg46z/YPfuWKAWwTuNQ+ZSEPd80/HBKHd2vSaJlqtWAvbBlIh0jVDrK+1bYYW/lT0XcpPOpVfn4venvZH0P9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=H3CyCZzC; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="H3CyCZzC"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-395cf2535acso1036396a91.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Sep 2026 04:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1788260450; x=1788865250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7H+0enYBY2wXPZSc/uyeVXByB0vOHBLdS6OdHDM8C4Y=;
        b=H3CyCZzCcCm02AQfSxkdxQf3rVg9UNen+DISU3m9Nz98ixRb2CAQJtRvvPubspPbVF
         IaoSYYOwK4kDjW6Es8f5iDJzkKdRwHKx7CqAyivzQOV9Wg3fp4QeI3Hmvtjk5VhqZv9w
         OCiV+7lr8B2+AvmjvwUCAH60O7bfRRY2NCYZ7tJo2svORtRgD70mj0/1gzkKqwFmBG5b
         4PMq0fNnS/6nNx+zl6eca9FBj5vWkiNsw2IwK3/2S3CMuNowi4VlddohzjSUaracOWvm
         rF1s7oXkeuyds7cp7K/hzMQH6npyZG8hsEWsx3i2+kD/Ngh4qyxy4rwEYyGDNtC+yg+x
         6a/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788260450; x=1788865250;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7H+0enYBY2wXPZSc/uyeVXByB0vOHBLdS6OdHDM8C4Y=;
        b=rGMaVMi4RZR8TA1ecfD9YiXi4W50qFrahR+UcAdjZlgIWxEuJJ1gi+NuK1BM5S/f6C
         EycHrZhhJ4paJ/QCFQIrN2v7Vct8aRaHM/bGOHekSpasnXN4s3odexSmdtP9sTtieHCj
         hMerj+EOK8vvDlMxEWwFE+RFX7HTrvVg80vd1RZDEzaSzedGXCldCHMv4ZHr+QH9tIoD
         AQGUPvcMwmVTR+F4t7C/k36qolmzK5cO+rHrQjiHpecyD7Lw+dkNu0jRQyaya9ipnzrl
         uFHFW9sknfTkSHSOUniN78fOoQzg4DsBsPJRxnWFuV+PhbWHe24zl1KL9BfUvq1qmYXy
         9cAw==
X-Gm-Message-State: AFuF++kkL492juzwCPW+I0U49o7GbfmNd3K1wk+veCFf2d2o2tT3DHEj
	wR13QbDrqoFimaskaopE2nr/8dcsIxI4/R1lPJwGgy2H7nQ6zTQkuIfXF3OA+8KqwlXmGDnnbmo
	HWSHB8A==
X-Gm-Gg: AYBFou0/dBFaUt77C/kSC0jHepYmomdq8nY/ZnjiAx1ugP2l39OKRSudEL/ypgZXTSV
	9Ic9lxXGdUlScaB5SKnf2eR0AMZNHxeO+adCgrrGtKMuMON0CMp2aXhUqxk0hal894uVzSJmBEB
	5XynrVO1vYwOE63cDa1i74i5VMW1ikvddhIY0a9o5iZIwcm1K0PKjFVY/B4zWYIamwxSx3LvkRB
	/fUO1MPhPiwsovhepMqL5su9FHNuO6VqoFp590xfRsdUo+gkfKL0keTxcwftQoHPfLTsmsdXb8l
	oYpc+aGX+yfks/dldyVyYG/8/Ce6g7pmL8gHkyySgkVXW64Zq8HdTYmWrZyRsZhT+y+K0u34LzN
	MtVdXbthCm3Rr1kn4QJbS7yF9Ad5KMDKHRTBLLF6xUvXtqBJd5ze5eOLFHvjfAMLUrly2nSX9fj
	J+tEykMVBXwsfKVybhDAmm8aQ47qTHtViht0QsutpFLxv2JQ8iA3mogd8Rxq/P9BvFiGHUMAQ=
X-Received: by 2002:a17:90b:1d02:b0:398:9bd3:d6d1 with SMTP id 98e67ed59e1d1-3990f835cd7mr3679962a91.11.1788260450049;
        Tue, 01 Sep 2026 04:00:50 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([167.71.204.91])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3990d75fc49sm5472245a91.12.2026.09.01.04.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 04:00:49 -0700 (PDT)
From: Ren Wei <weir@nebusec.ai>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	mcchou@chromium.org,
	mmandlik@google.com,
	alainm@chromium.org,
	abhishekpandit@chromium.org,
	edragain@163.com,
	weir@nebusec.ai
Subject: [PATCH v3 0/1] Bluetooth: msft: fix vendor event use-after-free during open
Date: Tue,  1 Sep 2026 19:00:38 +0800
Message-ID: <20260901110039.2399040-1-weir@nebusec.ai>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yong Wang <edragain@163.com>

Hi Linux maintainers,

This patch fixes a race between `msft_do_open()` and `msft_vendor_evt()`.

Commit 5031ffcc79b8 ("Bluetooth: Keep MSFT ext info throughout a
hci_dev's life cycle") changed the open path to reuse the live
`hdev->msft_data` object across power cycles. As a result,
`msft_do_open()` may replace `msft->evt_prefix` while vendor events are
still being processed during device initialization.

At the same time, `msft_vendor_evt()` reads `hdev->msft_data` and checks
the event prefix before taking `hci_dev_lock()`. This can race with the
open path and lead to a use-after-free on the prefix buffer, and on the
failure path it can also observe stale `msft_data` state.

Fix this by reading the supported feature data into temporary storage
first and only publishing the updated MSFT state while holding
`hci_dev_lock()`. Also make `msft_vendor_evt()` take `hci_dev_lock()`
before inspecting the published MSFT state.

We tested the fix and verified that the crash no longer occurs. We also
verified that the existing MSFT monitor functionality still works.

Thanks,
Yong

Changes in v2:
- Rework the cover letter to present this as a race/UAF fix rather than
  a security issue.
- Trim reproducer details that are not needed for patch review.
- No functional code changes.
v1 Link: https://lore.kernel.org/all/ea4efa51cc3be16d3eb7726fe5486f0be6c47907.1786092373.git.edragain@163.com/

Changes in v3:
- Rebase onto the current net tree after 0079e1a94463
  ("Bluetooth: MSFT: validate evt_prefix_len against the response length")
- No functional code changes
v2 Link: https://lore.kernel.org/all/cover.1787048594.git.edragain@163.com/

Yong Wang (1):
  Bluetooth: msft: fix vendor event use-after-free during open

 net/bluetooth/msft.c | 70 +++++++++++++++++++++++++++-----------------
 1 file changed, 43 insertions(+), 27 deletions(-)

-- 
2.53.0
