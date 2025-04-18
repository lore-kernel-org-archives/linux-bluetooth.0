Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24D745009
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Apr 2025 14:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744985614; cv=none; b=URiMFvm3olRqcbDXyiPjIbR9YinLfFlyZN3jpi0TaBTFKRF2FMtbwinXs0HtnjZojklUseKm+3jlf/u2akGpaiR3xojY4YoJRgMJkaD4/sUMh6TEmZnyw3ru58gvy+0JPPYUsCAv+EFsDzZ41O6aMupQPkYMZ+drkbhHvILcB/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744985614; c=relaxed/simple;
	bh=u2T4IXx34pO0DNac8ziaGs3avKomFZYGehi2H0pxxHk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=j7UEcs4fnjCuLFKqT4s3Ik5I2PWIeouwIQRy7VcaTo6yLn/D51LhfMBcXF2qqfIa1ho+HWyy3TSy2ZUo1YkUt3YJt6l191o02XhH8gROi7q8P9ZDEciD3e4GlbC0Aaw02ROq6pJpTsgTV3QJ0TnE/uiT8vdEYenk2HXIdhC0tP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=XeO6lNce; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="XeO6lNce"
Received: from github.com (hubbernetes-node-4618ac8.va3-iad.github.net [10.48.15.72])
	by smtp.github.com (Postfix) with ESMTPA id ECADFE08AE
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Apr 2025 07:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1744985612;
	bh=DXucQp+VGO1mwrqlyUxa672ddlDXeBDeTJ6j3xjfd30=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=XeO6lNceh4/9XuJOiOzczoaKjYljbN76Nyux1mggudjGV1dhnhxy6YnGsNBx0ez5+
	 1yYAUAnCeJI8TCreVCZea4cbFVeWzOIGBzYeRq7SNlc5fA0bY3+wgBI7/pnE8MV/E9
	 HrTIzfyQN5dzWkYBDRd1Al+gEyTsP6rij6P7WNNg=
Date: Fri, 18 Apr 2025 07:13:31 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/aedd7b-2a569e@github.com>
Subject: [bluez/bluez] e501c8: shared/shell: Fix build errors in fc42
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: e501c8ab3023155700bc752d318b1ba3480311da
      https://github.com/bluez/bluez/commit/e501c8ab3023155700bc752d318b1=
ba3480311da
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-04-17 (Thu, 17 Apr 2025)

  Changed paths:
    M src/shared/shell.c

  Log Message:
  -----------
  shared/shell: Fix build errors in fc42

This fixes the following errors:

src/shared/shell.c: In function 'rl_cleanup':
src/shared/shell.c:1429:20: error: zero-length gnu_printf format string [=
-Werror=3Dformat-zero-length]
 1429 |         rl_message("");
      |                    ^~


  Commit: 2a569ec80ffb4ea7a7dc1651b6befb51f2d34cd7
      https://github.com/bluez/bluez/commit/2a569ec80ffb4ea7a7dc1651b6bef=
b51f2d34cd7
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-04-17 (Thu, 17 Apr 2025)

  Changed paths:
    M mesh/crypto.c
    M tools/mesh-gatt/crypto.c

  Log Message:
  -----------
  mesh: Fix build errors when compiling on fc42

./mesh/crypto.c: In function =E2=80=98mesh_crypto_device_key=E2=80=99:
./mesh/crypto.c:436:33: error: initializer-string for array of =E2=80=98u=
nsigned char=E2=80=99 truncates NUL terminator but destination lacks =E2=80=
=98nonstring=E2=80=99 attribute (5 chars into 4 available) [-Werror=3Dunt=
erminated-string-initialization]
  436 |         const uint8_t prdk[4] =3D "prdk";
      |                                 ^~~~~~


Compare: https://github.com/bluez/bluez/compare/aedd7b936b72...2a569ec80f=
fb

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
