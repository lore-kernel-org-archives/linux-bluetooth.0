Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793687828;
	b=Nry1H4qXNym13Vlcyqy+Ztq9ZBPmP7c81Ief6vw//M2LsW53YpujmfDRxIOd5SlzpcmY
	 F8pXKLavhjqDehWyzGHrt5/Nab6qAE8wys05QEXNLmzHK2Z6G7B1YBq6YvrxAoFx8RRt2
	 CLYhaFx/kOnUbHcLXEKEDeJzmBtgA/4H0kycXc+6ggeuOo3H+G68i6Qn8sH9FOrl8Bd2p
	 BQlOvCHtd/lGYboCBw/5ejcPsszJ8qfZQEJp8TL0tvUdQmaBsRuyBDH1lgKVLkN3VGDcf
	 B1c0mTTa/G+AxgKpr1XaeMIpqI8ZDxtFmsrzjO3X66eZwi4blHGb+BlGnSjmFvW77bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793687828;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=4yH0PqSwiRtb0Y4Y1UKsVVUByt1uD2QBfBAn1b9bJCo=;
	b=gZXk9ccAdrMOl7sWhYo1+a17RoByI1+f5SoeB1zPEcaKa9se2mfrQrw2vOKjzHtub2uB
	 8v9BMtoqHV3NdcbivYgp4IYtul8BUMSEoHjJYQYecRJHjtEr2862++5bIkq0DpFjUkAW+
	 oA2TnFggzevVz5/9e72nool69Q8nIrOJSwNdU9hZlLonlpaTZJYqL/EM2LGpw4TeTpJfR
	 RZ+jPf8Mc5RUiej5NQa8q+brebd7/KIEYWri9m5FTeUWIl89Eq+ofyARKlwpWlywHMOOo
	 FhfuEclB8pO7ZHFPsTqiOSyBPPJeMTtHdWmiLgWhn57HzQxbwBjSl0t6PKnjA29eq8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UzHQQj0T;
	arc=none smtp.remote-ip=192.198.163.17
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743B1606A324
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Nov 2026 06:37:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 743B1606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UzHQQj0T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793687826; x=1825223826;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=U5WDc/c7OKva4qILuWv3ac3XwQWHTuyirD9955Gyoj4=;
  b=UzHQQj0TCYFBDIpqMiBuNqffS9fFawb9FnAHxiuKzNlGbwPx2t5G7h3L
   o6nAL1a88+2xluXCSVmpwmLlpa1pYl5CREite6d7t7lAlckI7P/nuECLM
   dxDpbDRf+5LSZJyCKqkcxxf0kzsSrh8vjQHH6ET7FsvFv0KRrTzpoUFdI
   tm1+k0OORbLx6nd9pQYjoOiyLrBExDmw+uoiB4J4s8gLKqz5oMylImVkW
   Fz/FF/BdVX/465FsfgNVgybnQq1HZYZy+7UD++eRMYcmFBpv0NaZG5B9A
   fR8DYFXD5JWd+Mq9HfIiUOMuHz2h3WFKjtdBeE6fE16ghHo4wGIIZU2Z4
   A==;
X-CSE-ConnectionGUID: i6CDoo/iR6ivG11msKygzQ==
X-CSE-MsgGUID: aTyy8D6wTbqtp9xBRVO/Rg==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2411552"
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="2411552"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 22:37:06 -0800
X-CSE-ConnectionGUID: EN+ZxwQxQiWEPvL9UwW/Zg==
X-CSE-MsgGUID: +HypWwYwQia3xlWcsKp3lQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="6720543"
Received: from weba0534.iind.intel.com ([10.66.226.131])
  by fmviesa007.fm.intel.com with ESMTP; 02 Nov 2026 22:37:05 -0800
From: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: kiran.k@intel.com,
	chethan.tumkur.narayan@intel.com,
	Sai Teja Aluvala <aluvala.sai.teja@intel.com>
Subject: [PATCH v4 0/2] Bluetooth: btintel_pcie: debug INI rework and fatal error injection
Date: Tue,  3 Nov 2026 11:58:30 +0530
Message-ID: <20261103062832.3083624-1-aluvala.sai.teja@intel.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series moves the btintel_pcie debug INI parsing into the debug
file and adds a test mode for injecting firmware exceptions.

Patch 1 moves the debug INI parser (DBG_PATH, ENABLE_INI, LOG_MASK)
from btintel_pcie.c to btintel_pcie_debug.c, so that all debug INI
handling lives in one file. The parsing behaviour is unchanged.

Patch 2 adds the FATAL_ERR_TESTMODE debug INI option. It injects a
firmware exception for testing. The INI value selects the exception
type and the injection context (thread, IRQ or rfkill). Whether the
exception is expected to trigger recovery depends on its type. The
test mode is disabled when the OPFW API lock is set, unless the
unlocker firmware was loaded.

v4:
 - In test mode, ignore an rfkill release only if the assertion was not
   handled by the normal path (HWRFKILL_ON clear), instead of testing
   HCI_UP without req_lock.

v3:
 - Fall back to the normal rfkill handling when HCI is down, so the
   test mode no longer suppresses it.
 - Send the deferred post-setup notification when HCI is opened again.

v2:
 - Drop the btintel "Zero-initialize new_ver" patch, as
   btintel_read_version_tlv() already clears the structure.
 - Arm the post-setup injection before setting SETUP_DONE, so the rfkill
   work cannot inject ahead of it.
 - Keep the post-setup injection pending if HCI is down when the rfkill
   work runs.
 - Document that the test mode intentionally injects on every rfkill
   assertion and skips the initial rfkill check after the post-setup
   injection, and that the api_lock check uses the operational firmware
   version.

Sai Teja Aluvala (2):
  Bluetooth: btintel_pcie: Move debug INI parsing to debug file
  Bluetooth: btintel_pcie: Add fatal error injection test mode

 drivers/bluetooth/btintel.c            |   5 +-
 drivers/bluetooth/btintel.h            |   1 +
 drivers/bluetooth/btintel_pcie.c       | 161 +++++-------------
 drivers/bluetooth/btintel_pcie.h       |   5 +-
 drivers/bluetooth/btintel_pcie_debug.c | 297 ++++++++++++++++++++++++-
 drivers/bluetooth/btintel_pcie_debug.h |  33 ++-
 6 files changed, 374 insertions(+), 128 deletions(-)

-- 
2.53.0

