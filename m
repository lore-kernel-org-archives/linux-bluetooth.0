Received: from out-4.smtp.github.com (out-4.smtp.github.com [192.30.252.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0A851616F
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Sep 2026 14:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790777417; cv=none; b=XZiroQYn6enVwyP+K6reYk3p1q/j/RiDjsuipK0Tf1YZc4jtEVVTIBl9dyXfQHNYJIy/qZA1fzbXkc+jayo9pbxFnSjv7Uf3j9k5wNX0uJ7Rg9exDnUSzyKhA08cgN91KdBGBEGyp9jh0pcA1Fkj7qY3BICJkkTEwbJWzdsCzBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790777417; c=relaxed/simple;
	bh=akueMhihzDGA61WXDddt1CZF/sBOrStg4N7Hu0SvGuY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=PcG6r+qGYZzNzDwOJA9N5GfnGAz3XxVrD6rMx4/2EIe2sP5w3kMZoZlXXV11bpCw35n9Rn6GvelY7cxREOxmrwrAWDmENDYVmeWQJsIDX2S5dFDpfudjU0iXEfQoF73aA/KwLmyaqcDPGlEJdrbJIVgrh03YxeKtmuQ/svLAz4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=KWp+AchM; arc=none smtp.client-ip=192.30.252.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="KWp+AchM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1790777412;
	bh=y7Cg2hof+G6wFk8BGO6Oxh+mVhZPg7o8CQhsAGjYHD0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=KWp+AchMIY1lPK1MI4rfxhu53/BSFp2wINTf01jpx9MaQmh00JubEigpw+FrwfFMV
	 rdZtPakQod2dVMZ8jSNrw6TaPC1u5coJL61qTzTe0hPhSqamZhl8vXb3k6+ARhFknJ
	 spCl8A90kuyDbS1JvBYv6VlabPHkLXWZEyTawopJ19F9aai+0rTiDucDNWnl3R0ddh
	 T/2ey38TGnYM9DF0/3x24OQr5Jsw0QlAb8aFZI/BxEUy4Id2mKUFDVc8krcyJzd3Nm
	 m133q2q0W8IivFHQcelIxdi0zeLNGsCUyNKV9tIfswHUPQtrCafceXc0QbOcoCIrNT
	 NoJyINT81XJqg==
Received: from github.com (hubbernetes-node-53d2209.va3-iad.github.net [10.48.75.77])
	by smtp.github.com (Postfix) with ESMTPA id 7E7673402C2
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Sep 2026 07:10:12 -0700 (PDT)
Date: Wed, 30 Sep 2026 07:10:12 -0700
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1176647/000000-b80c26@github.com>
Subject: [bluez/bluez] b80c26: obexd: Fix FILE* leak in phonebook-dummy
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/1176647
  Home:   https://github.com/bluez/bluez
  Commit: b80c2670c8dcdc0abcc2d39eb7aca889abeecb2b
      https://github.com/bluez/bluez/commit/b80c2670c8dcdc0abcc2d39eb7aca889abeecb2b
  Author: Jinwang Li <jinwang.li@oss.qualcomm.com>
  Date:   2026-09-30 (Wed, 30 Sep 2026)

  Changed paths:
    M obexd/plugins/phonebook-dummy.c

  Log Message:
  -----------
  obexd: Fix FILE* leak in phonebook-dummy

fdopen(fd, "r") transfers ownership of fd to the FILE stream, but the
loop was calling close(fd) directly instead of fclose(fp), leaking the
FILE structure and its stdio buffer on every vCard read. Also handle
fdopen() failure, which was previously unchecked.

Signed-off-by: Jinwang Li <jinwang.li@oss.qualcomm.com>



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
