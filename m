Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDF12561A7
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 00:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789689767; cv=pass; b=sSzhMRaBYr/4THX9mSuu53FCgZoGaq9UIwwlqgAHk6P6yJXrt8JPronpwflryw9sRl/cybVHzG1t9aJ9wnMbP1PQAWhDxBoWrSCpFPYMt2McHeevYuTNK2DfUEfGyYdRsy+z1LXvdNMD6eOO8oMkhPvRkEUhaa7vv7Kn5ntKvCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789689767; c=relaxed/simple;
	bh=i2+//srnHrdi2hkp6e5HGsmav5MkgKWviwuMouI1HjA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=imVmPMnAEgd8HR0eFozgpxL2a46+9D1qsrlpuwsxUz/jVMoYAHjxVZAjDI3gILRpgxoVorhTxhIcvv8f/emtlt35Wfm7oCY9OvCm/cbE30GSgl98ktLVvH0svWZhKdMz+sDuiPTf6EoMI6arBpZoCAxeT+hINQQin59O7IEtQBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=NbUs1YHn; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="NbUs1YHn"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:1:f410::dc01])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4hmCVc2XllzyQ6;
	Fri, 18 Sep 2026 03:02:32 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1789689752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Cm1Y4b6xLDlUqqsXF9gOIJANWmKXi9UBsTJYsFViUXs=;
	b=NbUs1YHnxLn1bu4S/LNTT0R/3s4v3rXM4ns/ILsrzSnNkU6QuynZHHqXO4IoRw3bB3KWnd
	P6ScqcIsKSQIaoOkwnddh7wA209TBcpiD8Es0kA+NLIudmjRVkYrtWcLufMi0d1P1nDx8t
	YAmnhXpa1G4F/h3UgpEmA2nPG3dlRX8=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1789689752;
	b=AajDWd0ksdw5AOzSN/0tvNr1i8LMI/ryVLP14tqBj4XQOiheIK6zJJhUxDdr6pOduROc8k
	45H6PR90SvmQ7bNHq3q7U7svsZKIKfE8SnkSLwmo7dBHDazst4ahYdztOBU2BrL70RnyaK
	HcKlJEiOK0wfvRe1dc5lp9ywcqAIyuo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1789689752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Cm1Y4b6xLDlUqqsXF9gOIJANWmKXi9UBsTJYsFViUXs=;
	b=kWQLKqUbrA6oj8ucOD4qz3d3HB0vlRZhlpI/7xc1LEzA5ZOKM0H+xqYcie4lUracvqt4md
	bL4MEcv8ff6605nNOH9W2oBsM98cD1K9IRQqFFOeGbHLCgABMnBCDsTZICZGM8a9qkDYo3
	7Lvp+GrxnxUm5KDnG+DOUWqjn4Vo2n0=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 0/4] device: Fix resolving a coordinated set over Secure Connections
Date: Fri, 18 Sep 2026 03:02:25 +0300
Message-ID: <cover.1789689632.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CSIP coordinator was not finding its LTKs with Secure Connections, as
the fix in 9251e630efdd to make legacy pairing to work doesn't work with
SC.

Fix by keeping track of what kind of LTK we have, and not distinguishing
between central/peripheral key slots for SC, which kernel doesn't do and
AFAIK the role difference doesn't exist in SC.

LLM was used for bug triage and write initial version, but these are now
almost manually done.

Assisted-by: opencode:qwen3.8-flash-next

Pauli Virtanen (4):
  mgmt: Add defines for the long term key types
  device: Remove unused central field from struct ltk_info
  device: Fix resolving a coordinated set over Secure Connections
  test: functional: run CSIP test for Secure Connections & Legacy
    Pairing

 lib/bluetooth/mgmt.h        |  6 ++++++
 profiles/audio/csip.c       |  2 +-
 src/adapter.c               |  5 +++--
 src/device.c                | 39 ++++++++++++++++++++++++++-----------
 src/device.h                |  4 ++--
 test/functional/test_bap.py | 21 +++++++++++++++++---
 6 files changed, 58 insertions(+), 19 deletions(-)

-- 
2.55.0

