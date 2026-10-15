Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC7B53D9DF
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 17:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792086785; cv=none; b=jBnSDE+3WC5JWgfgLcE6PbapaGiEqHt3WlbcqYZyGn81WnXqBV1UPBrFF44s19F6CaRZucLlMo3kohLsE2GU6TXsO+wD4EWW94e849cFvVIvL6dIJEQL1CI52Jp5hRyw/zyX0XuCNIRPUHF6vQy1vOjwh/stgTQbxQfrtTry9OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792086785; c=relaxed/simple;
	bh=44+0cNlUQV06OBmxqkJRUW+Yl3osnPcb+YR3SmiSQSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RVavedtcp83Mbf+1MVZUaWNskuAnuXfA82+GXKC3jkYdF2BVXm8RAeZMPblRt09f9dyNG7J/+P4q1FMLC0v3DddIl5tjcwdobpbvbWXd9pwlEEK3KbsiSMPhRMLEj4ar5UakNKEGW5ylgjhwf6gvPDhIOOX1SAssAS6pkC+DzF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X+YUHTH0; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X+YUHTH0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792086779; x=1823622779;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=44+0cNlUQV06OBmxqkJRUW+Yl3osnPcb+YR3SmiSQSc=;
  b=X+YUHTH01VZvYVVQ58h7+iiVDd8sLAL7EMdiB60E1vPBpOKlpvVXeFb8
   w5izkVYCgxSt880t5IoXPPx4KGNzOIix2r+qUBm4gmB+f9hh1LpFATfGa
   +aLqRy5MZuBhr67KDTyHJALPSwmT35v97G4PpKuR7x28wzOPCSBg1GTkb
   E/I0JW5Meh8/P9LGSMFOQrlaDRkRDHi6yimgGLyipBE/sSmVr0aoLaQhX
   dG+4DNSozzInrB7no+BigNsYfMkEWng0kq9W6gr4ALy+woZRHC13YUMcL
   S8FEAS5cQDMWlJf4llGbX71cQaiDbUN5KKVCm6+IQRfMi/n3xDKXX+wOw
   g==;
X-CSE-ConnectionGUID: ZIUINSvRRmWB4MLqn1kzxw==
X-CSE-MsgGUID: Dk7x0fy4SVu9F4EfA1rwxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="897769"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="897769"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 10:52:57 -0700
X-CSE-ConnectionGUID: ZuyHVv12R96AxlObSERX8w==
X-CSE-MsgGUID: 8ec7oKnRTNmI6L5nYcCt4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="2215376"
Received: from weba0534.iind.intel.com ([10.66.226.131])
  by fmviesa010.fm.intel.com with ESMTP; 15 Oct 2026 10:52:56 -0700
From: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Cc: Sai Teja Aluvala <aluvala.sai.teja@intel.com>,
	kiran.k@intel.com,
	chethan.tumkur.narayan@intel.com
Subject: Re: [PATCH v7 2/2] Bluetooth: btintel_pcie: add HW rfkill interrupt/doorbell flow
Date: Thu, 15 Oct 2026 23:14:29 +0530
Message-ID: <20261015174429.1689128-1-aluvala.sai.teja@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015160215.1658054-3-aluvala.sai.teja@intel.com>
References: <20261015160215.1658054-1-aluvala.sai.teja@intel.com> <20261015160215.1658054-3-aluvala.sai.teja@intel.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Replying to the Sashiko review of v7:
https://sashiko.dev/#/patchset/20261015160215.1658054-1-aluvala.sai.teja%40intel.com

> +	WRITE_ONCE(data->rfkill_wait_done, false);
> +	WRITE_ONCE(data->rfkill_wait_state, state);
>
> Could this lockless initialization create a race window with the GP2
> MSI-X interrupt handler?
[...]
> If the handler reads the old wait_state, matches the old hardware
> registers, and sets wait_done to true, wouldn't it incorrectly
> satisfy the wait condition for the new doorbell operation?

Valid. It needs a previous doorbell to have timed out, but a late GP2
acknowledgment can then complete the next doorbell. Will fix in v8:
rfkill_wait_state/rfkill_wait_done will be set under ipc_lock together
with the IPC_CONTROL write, and the GP2 handler will take the same
lock, so it always checks the registers against the current request.

> +	mutex_lock(&data->rfkill_doorbell_lock);
> +	if (test_bit(BTINTEL_PCIE_HWRFKILL_ON, &data->flags))
>
> Is there a time-of-check to time-of-use (TOCTOU) race here since this
> relies on the cached software flag rather than reading the hardware
> CSR register directly or flushing the delayed worker?
[...]
> If that happens, would the driver proceed to send HCI_OP_RESET to the
> firmware while it is still asserted in rfkill?

This is not an issue. Firmware accepts HCI reset in any HW rfkill
state, so an HCI reset in the middle of the HW rfkill doorbell flow
is always possible and does not cause a command timeout. If shutdown
runs before the worker, the assertion is handled like one while HCI
is down: the worker still reports the block to the stack and handles
the release with the doorbell. No change is planned for this.

Thanks,
Sai Teja
