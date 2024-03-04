Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E563FB02
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 Mar 2024 15:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709567928; cv=none; b=bxZv5EFcEB7Bt6zA7marbyYpgg7DOLF94mT7DQ9QUGEHRJEDwQy68F8yDrp7sscAGpOIKBNHe+xNmjDWbITEP8EGa1DqKU/nlwBeFgkDit80yAK992RkTK0Dq3H8jRyHI1DG2/K4KErQLQi6JyBguTXDqJ6L3H95dcbLutx8obk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709567928; c=relaxed/simple;
	bh=vmnFinifS68K0q1xbtucvwslmqYerFjzg8LaboEGsqQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Type; b=CcyF+H/5+JwCcKKa8m+2w4BQnPOTdHGTM0Fo3NAtZ819ZhcgewLnBqfr+mJcREyMZLaLnBADPgXK/e3wchO521XZeiqDhdeOGiVSrQtiwgwW+ITWB2phHxPVouKh8VBgmhFzhmp392fypbyLhch0pfS65BQwpdl1aBX/zkr2oOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Fu2EttXe; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Fu2EttXe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709567925;
	bh=vmnFinifS68K0q1xbtucvwslmqYerFjzg8LaboEGsqQ=;
	h=From:To:Subject:Date:From;
	b=Fu2EttXe4Klwsfk/h61D0WSZmUT9VSbA+V/FZBnWYcWIn09MlFrniX2moohFF54ME
	 wtsdYv05zgR32onwvSL3/uu0ttFqDAHneKuEjPCrh1WqApnil3r2rmyilxyUsREcJG
	 UorSESX+/X62Rs/PoGOgrBq7tHdnk9/0Pd5RdCCNlyVq2OgozGW1DpvxLj9fdDT5Y3
	 E7fpY0RUgA7RRdwg4RFzGPuiNC/md6T5SQ1uC94V5tk2a8onbU5xhplakIBivt2dDj
	 nTB46uYYidYywRklUW+4IBNnCW1Rax9MnX1ieJ4DFOucru5fYK1clOSk9TFvyszFTR
	 LCfiIQ24Xxb8g==
Received: from fdanis-XPS-13-9370.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5ACC537820C6
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 Mar 2024 15:58:45 +0000 (UTC)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RESEND PATCH BlueZ v2 0/2] Add support for signed write command
Date: Mon,  4 Mar 2024 16:58:37 +0100
Message-Id: <20240304155839.48888-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

GAP/SEC/CSIGN/BV-02-C request the ability to check that signed write has
been performed successfully.

Move the storage of local and remote CSRK keys to the device object.
This allow to pass GAP/SEC/CSIGN/BV-01-C and GAP/SEC/CSIGN/BV-02-C tests.

v1 -> v2: Move CSRK keys storage to device object only

Frédéric Danis (2):
  gatt-server: Add support for signed write command
  device: Update local and remote CSRK on management event

 src/adapter.c            | 77 +---------------------------------------
 src/device.c             | 48 +++++++++++++++++++++++++
 src/device.h             |  3 ++
 src/shared/gatt-server.c | 13 ++++++-
 4 files changed, 64 insertions(+), 77 deletions(-)

-- 
2.34.1

