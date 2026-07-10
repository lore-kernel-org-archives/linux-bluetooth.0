Received: from out-29.smtp.github.com (out-29.smtp.github.com [192.30.252.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE933E2745
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 08:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783672555; cv=none; b=szlgKWVDmvGgwlmIjWNTEGnaUkAWMWEcmFnscpssSCgkhAXjx3iF0yVCwcGQ2QEy+v024q8FcsQPxUoenVLl2oM46wwmStcl8c0IO20ZN2RTh+uj7Z8GTzmaEovOeNLZRG7eYhJQ5c2jH4GWqtlU3thjWqnzvDR4VzdfloludR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783672555; c=relaxed/simple;
	bh=Y/blJaOzRraTcNxSVdbx7MfevFkmutRw2iB9n2j0g10=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=BcJTP2/pmgsWbnvgHKlLvwYjKO0SQ3F2W3j2T+TihBoQnClOtYgs8nbGW+XXQQ07cQeZw0+DxcdItNJg0DUYUUfmjIRZ8HqTN1omM1FtEtNCq3vlyZdWhETXPBHDNyaN+M3DCIB8L4uT95TJMR0II+SpEraOa5OJ4R1PiU1llR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=hVOggaSB; arc=none smtp.client-ip=192.30.252.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="hVOggaSB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1783672553;
	bh=wmCEzEmAjUTUoYjPoDF/TijEVW+WravNwh5K1N9mfl0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=hVOggaSBqotLVUxhTT8QF+mnFqr0VcjlwWdzUptMd0X2VEjnAhWTvvwKe0ky2LovO
	 kg7C7q/yFnKeTfbE3N+oSAArTkEOv3qtPIq7CjT5+3plKu1kFnhDiPnJkGzOKsWHV3
	 K2asrI+XtbWx0ATTc9b/FEmkHSDT2w1FOudEzybo=
Received: from github.com (hubbernetes-node-52ddd2c.ac4-iad.github.net [10.52.221.82])
	by smtp.github.com (Postfix) with ESMTPA id A6E533212F4
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 01:35:53 -0700 (PDT)
Date: Fri, 10 Jul 2026 01:35:53 -0700
From: Bhavani <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1125144/000000-2c883e@github.com>
Subject: [bluez/bluez] f851eb: doc/org.bluez.ChannelSounding1:Add Used by
 referen...
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

  Branch: refs/heads/1125144
  Home:   https://github.com/bluez/bluez
  Commit: f851ebb27566df31850f3d695a8d6b837e5c5ddc
      https://github.com/bluez/bluez/commit/f851ebb27566df31850f3d695a8d6b837e5c5ddc
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-07-10 (Fri, 10 Jul 2026)

  Changed paths:
    A doc/org.bluez.ChannelSounding1.rst

  Log Message:
  -----------
  doc/org.bluez.ChannelSounding1:Add Used by reference and Examples

Add :Used by: field linking to bluetoothctl cs submenu and
Examples section showing corresponding bluetoothctl cs commands
for D-Bus methods


  Commit: 5d82c71db9c14ad8c0d94fc4105e413d3cf48d67
      https://github.com/bluez/bluez/commit/5d82c71db9c14ad8c0d94fc4105e413d3cf48d67
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-07-10 (Fri, 10 Jul 2026)

  Changed paths:
    M Makefile.am
    A doc/org.bluez.ChannelSoundingRanging1.rst

  Log Message:
  -----------
  doc/org.bluez.ChannelSoundingRanging1:Add references and examples

Add :Used by: field linking to bluetoothctl cs submenu and
Examples section showing the corresponding bluetoothctl output
for the RangeEstimate signal


  Commit: 2c883ed23ba17c2eecec2bb83be557c0a6b5aa6e
      https://github.com/bluez/bluez/commit/2c883ed23ba17c2eecec2bb83be557c0a6b5aa6e
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-07-10 (Fri, 10 Jul 2026)

  Changed paths:
    M Makefile.tools
    A doc/bluetoothctl-cs.rst

  Log Message:
  -----------
  doc/bluetoothctl-cs: Add :Uses: fields and document arguments

Add :Uses: fields to link commands to their corresponding D-Bus API
methods, and document command arguments with usage examples.


Compare: https://github.com/bluez/bluez/compare/f851ebb27566%5E...2c883ed23ba1

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
