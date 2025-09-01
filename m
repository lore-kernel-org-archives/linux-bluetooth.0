Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083E332F742
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Sep 2025 15:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756742172; cv=none; b=LEr+5HTDANpn6gb9q8YQifvSuj5t1N6yXiglmw4Jfnu6lNG8s7tpDRiBhc2DfQxHdfDHdI0K4qRVG/kebfH/y/+cLencoRGN5MBGa72bkF+zbLMo6pG8y38voWcwccDsqLKaKPF10huZXoSX+HGvVnhrY05Q4vvJTdEQrEyswls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756742172; c=relaxed/simple;
	bh=HP3Y3Kup8Axa+gRL5yH95LkPJ3OzadfChDbvxS+nh1k=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=DGqZulw/aJT1cVQePfADeSMFDDkXFmk9mLRTDpl8vb2bHvHrvo7pob1hVUa/QVL+04AQSkbyJ5Agqt3Mj92HdSO6Vt1ym+oBOXfiKm5vYoOZtVlKYaosv5OazXUXV1ByUNChDt1lVIYHfmg4/YwnuQkNWs2aP43Ej6CBTCtEeE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Eb41FLan; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Eb41FLan"
Received: from github.com (hubbernetes-node-51c029e.ash1-iad.github.net [10.56.160.40])
	by smtp.github.com (Postfix) with ESMTPA id 1B318920C5E
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Sep 2025 08:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1756742170;
	bh=uFjo8ORuG+qjGouKHnPOUD/1tYtc25uuZYMemRJn3BI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Eb41FLansCASjcxxWWXQeVIdmgmSCEDN65JbLYcWdwRGpanDH3PYXOnAST8DUFO7c
	 Lierl6ebsyNEWSPcu21OEoxdgAF/vN51GR5nro3efHKBx9PZUAQRhbXOLIYd8Dc/Tn
	 cX64J+L1SiXMrGTDqwaOkDPwYo9ADVf7Xwk3snXA=
Date: Mon, 01 Sep 2025 08:56:10 -0700
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/997681/000000-29795b@github.com>
Subject: [bluez/bluez] 847323: unit/test-hfp: Re-order TS tests in
 alphabetical o...
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

  Branch: refs/heads/997681
  Home:   https://github.com/bluez/bluez
  Commit: 847323f70e29504e86033868817be706bfaa3101
      https://github.com/bluez/bluez/commit/847323f70e29504e86033868817be=
706bfaa3101
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-09-01 (Mon, 01 Sep 2025)

  Changed paths:
    M unit/test-hfp.c

  Log Message:
  -----------
  unit/test-hfp: Re-order TS tests in alphabetical order

This will simplify when looking for a test.


  Commit: a562adcb7fd8d22b877eb8ee8fcb9b3e3beedef3
      https://github.com/bluez/bluez/commit/a562adcb7fd8d22b877eb8ee8fcb9=
b3e3beedef3
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-09-01 (Mon, 01 Sep 2025)

  Changed paths:
    M src/shared/hfp.c
    M src/shared/hfp.h

  Log Message:
  -----------
  shared/hfp: Fix typos


  Commit: 29795be67c8a5511fb8eff1f40ce18d8c531554f
      https://github.com/bluez/bluez/commit/29795be67c8a5511fb8eff1f40ce1=
8d8c531554f
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-09-01 (Mon, 01 Sep 2025)

  Changed paths:
    M unit/test-hfp.c

  Log Message:
  -----------
  unit/test-hfp: Play PDUs up to the last one for HF tests

This will allows to create PDU set for TS tests which may end with
events not triggering actions, e.g. when receiving +CIEV:<callsetup>,0
where call status has already been updated by +CIEV:<call>,1

Free context->data only after completing hfp_*_unref calls.


Compare: https://github.com/bluez/bluez/compare/847323f70e29%5E...29795be=
67c8a

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
