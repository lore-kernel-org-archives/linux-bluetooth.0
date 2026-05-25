Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBA033F5AF
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 May 2026 16:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779725398; cv=none; b=WAfBqqYphRQocujgvLlUAZY5oT5mpLpDuh7YTkS5zg6g8Lm024wYRQuSA1oJkvEZ6vSSvrIbe+tmbmLnOyx0FOhhrHtQ3+Mri259iTQWemKrStVMTrluyFWTzok8maTrgAi+sRVN6lQ7Z0HxrJBQpXjISHyG8Cy87D5aBkWt9z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779725398; c=relaxed/simple;
	bh=AtZL2aI9bgFt7NHS1MFO9LUrpHfmEOCi1v502o+WK+w=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=lpHvGBIUaO1JosQdbpwrBijsC/HHXGZoVBCKhwpc+COHTYFC2a53bBzeRGNOiSG9CXy2dQ3lB5ZI5HqVFOvAT9aZKehGqmnCaUdCL2yZ6a6bzXzeP/aFbdfVyp1q8XAxOWz+UtujifQJNQFS09n9pWoWjOtDwxnshITYQarCvKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=CvJpUPcN; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="CvJpUPcN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1779725396;
	bh=2OMFcrE30yGAtHe3rcpJQjvDsRRCFlEjGdsGusWvy64=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=CvJpUPcNe5ZV4SYn/5ej5niJLUFhPz1j1EIsaumxBxQv6DY8MJ17HnosNxrLEIb4F
	 1VeAUajLKzPvDZhVizQSYHoyhK0Bw4M11c9P9RTv9q2x1P5Bj7jsD6KOFsaKmB1CVA
	 Nlv73W8iFE8bjuwcSerRCCjqqycId3fX+BhJSako=
Received: from github.com (hubbernetes-node-a33d287.va3-iad.github.net [10.48.183.53])
	by smtp.github.com (Postfix) with ESMTPA id 82C5A501099
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 May 2026 09:09:56 -0700 (PDT)
Date: Mon, 25 May 2026 09:09:56 -0700
From: Tarjei <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1100512/000000-c3044c@github.com>
Subject: [bluez/bluez] c3044c: adapter: Add configurable default LE PHYs
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/1100512
  Home:   https://github.com/bluez/bluez
  Commit: c3044c94775a69cedf42fe5b0dd5887941c5b8c1
      https://github.com/bluez/bluez/commit/c3044c94775a69cedf42fe5b0dd58=
87941c5b8c1
  Author: Tarjei Bitust=C3=B8yl <tarjeib@gmail.com>
  Date:   2026-05-25 (Mon, 25 May 2026)

  Changed paths:
    M src/adapter.c
    M src/btd.h
    M src/main.c
    M src/main.conf

  Log Message:
  -----------
  adapter: Add configurable default LE PHYs

Some controllers mis-handle LE procedures on specific PHYs with
certain peers. On an Intel AX210-class controller, connecting to a
Frostbay BLE device can fail during early ATT/GATT setup unless the
adapter is limited to LE 1M TX/RX.

Add an opt-in [LE] DefaultPHYs setting to bluetoothd and apply it at
adapter startup using MGMT_OP_GET/SET_PHY_CONFIGURATION while
preserving non-configurable PHY bits.

This provides a generic, adapter-wide workaround for controller-
specific LE PHY interoperability problems affecting scanning and
connection establishment, without adding device-specific quirks.

v4:
- Replace the hard tabs in the changelog continuation lines with spaces
  to satisfy GitLint.

v3:
- Match the queue header include spelling in main.c with device.h to
  avoid the Sparse redefinition warning seen in CI.

v2:
- Check MGMT_SETTING_PHY_CONFIGURATION before sending PHY
  configuration commands.



To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
