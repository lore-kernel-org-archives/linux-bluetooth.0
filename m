Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B067536999A
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Feb 2026 10:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770806103; cv=none; b=mXFaT4moi81++jmN/V14qMLmnf7YpRJPukm4h+NjlOaaVN1PTskiNiRxbDX1bFvkBxbXxWpbWc5E91TpbuCr0ADFIld+eOpQdXXvySV2ahpJX1dWWEVi2qh3W2XQaM8vVaNrL9xOd2u1S9yTeFUEv+TKl9lyi5Q4sBsF57FNBXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770806103; c=relaxed/simple;
	bh=un201yQaHuOQY/PuwCoOcQizB+MwcrV3z2pDZedT/a8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=pPLrE8SY104uu2if9pzLLV9sTyzb2Ux9fyFu4tyvCJZBitYf6BHlPrOt+S1HxBi6E3GRKjSXHnQdk0ZR4I5wrbo+k2PM1G1MAvGsGR+uWghnhMSligZJ/eCg+owz5Z2FyTdp1jo4OxS/00RgtSpzHP3N1IMnaW8DpTcFTaxlFRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=R9Lf1d2+; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="R9Lf1d2+"
Received: from github.com (hubbernetes-node-a4af42d.ac4-iad.github.net [10.52.13.31])
	by smtp.github.com (Postfix) with ESMTPA id E4F3220A16
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Feb 2026 02:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1770806101;
	bh=Q16BaSC5d3dzerMQigQcKHhQpKUIPX/lyDle0Dl4H4w=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=R9Lf1d2+rra/fB09xONzoRhipcPeMUD4kAXBu1k6Kf+q3pSYDOX3leAB3SrlL6HIB
	 k1DHPkMTgtnc5sx9tL7coak7c9e22L1JejDi0MmUwFdK8b4sjKXuchMmWGPIZUl5/Z
	 lTKTA2j2ePuy8dYawzgebN+GLQMElwkY+B+ndbOY=
Date: Wed, 11 Feb 2026 02:35:01 -0800
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1053057/000000-95aab8@github.com>
Subject: [bluez/bluez] 95aab8: tools/btpclient: Add GATT support to get Device
 name
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

  Branch: refs/heads/1053057
  Home:   https://github.com/bluez/bluez
  Commit: 95aab8d38ba11b73a5bcdf3173f5507bce43d8ff
      https://github.com/bluez/bluez/commit/95aab8d38ba11b73a5bcdf3173f55=
07bce43d8ff
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-02-11 (Wed, 11 Feb 2026)

  Changed paths:
    M src/shared/btp.h
    M tools/btpclient.c

  Log Message:
  -----------
  tools/btpclient: Add GATT support to get Device name

The device name is retrieved during GATT connection, so no need to
send a specific request, just need to send the name to PTS when the
property is updated.

This allows to pass GAP/IDLE/NAMP/BV-01-C.



To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
