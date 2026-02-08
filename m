Received: from 10.mo533.mail-out.ovh.net (10.mo533.mail-out.ovh.net [46.105.72.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C12022156C
	for <linux-bluetooth@vger.kernel.org>; Sun,  8 Feb 2026 20:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.105.72.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770582665; cv=none; b=Sk8LhHD3uVsIdV+Y7NdjHgSZ9Xx156GxFDnFAIuEsiNzmmexxaAWb+u/mTjhKt4yVAW1yJ7JgPbmZr/Xr6eRIAanKZNtiD4plMjUP9QH2i9Z3ngaqJwMw2anVxEhpXt5zqAUyrb3du9VcG+lRovzs3h2sjNwNLXv6XZz2JFdYSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770582665; c=relaxed/simple;
	bh=Ir6jGC5ZTpof8bAFpvJ7tbopcztLzMi5ZOYusBgbx9U=;
	h=Message-ID:Subject:From:To:CC:Date:Content-Type:MIME-Version; b=DM8mgZNht5eVaYIeguGdumqyHRJhkEWGizPIWHsItpcH+2Fe+LXOQpkBW+feG1tlKqhG6m67XfLTnmp3o1F/isrBJAtRJb2PqIxtn3hm4d5nrr6EqsVO+C3wdIDHVAb8PEEou46ozeq0JtTpl95zdX4grLbLQibiSqV5Mm/qCXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.fr; spf=pass smtp.mailfrom=marliere.fr; dkim=pass (2048-bit key) header.d=marliere.fr header.i=@marliere.fr header.b=iYm5TbNg; arc=none smtp.client-ip=46.105.72.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marliere.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.fr header.i=@marliere.fr header.b="iYm5TbNg"
Received: from director2.derp.mail-out.ovh.net (director2.derp.mail-out.ovh.net [79.137.60.36])
	by mo533.mail-out.ovh.net (Postfix) with ESMTPS id 4f8JQ33x35z5vSr;
	Sun,  8 Feb 2026 19:52:27 +0000 (UTC)
Received: from director2.derp.mail-out.ovh.net (director2.derp.mail-out.ovh.net. [127.0.0.1])
        by director2.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
        for <linux-bluetooth@vger.kernel.org>; Sun,  8 Feb 2026 19:52:27 +0000 (UTC)
Received: from DAG2EX2.emp3.local (unknown [10.108.54.195])
	by director2.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4f8JQ31wx4z20bK;
	Sun,  8 Feb 2026 19:52:27 +0000 (UTC)
Received: from [192.168.1.205] (90.55.234.88) by DAG2EX2.emp3.local
 (172.16.2.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Sun, 8 Feb
 2026 20:52:26 +0100
Message-ID: <496b0f8505eb6ffb19fdbee6f963c62aa6790fba.camel@marliere.fr>
Subject: [PATCH bluetooth] btmtk: fix MT7927 / MT6639 firmware loading and
 section filtering
From: =?ISO-8859-1?Q?Marli=E9re_?= =?ISO-8859-1?Q?Jean-Fran=E7ois?=
	<freelance@marliere.fr>
To: <linux-bluetooth@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>
Date: Sun, 8 Feb 2026 20:52:25 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: CAS1.emp3.local (172.16.1.1) To DAG2EX2.emp3.local
 (172.16.2.22)
DKIM-Signature: v=1; a=rsa-sha256; d=marliere.fr; s=ovhemp1140077-selector1;
 c=relaxed/relaxed; t=1770580347; h=from:to:subject:date;
 bh=Ir6jGC5ZTpof8bAFpvJ7tbopcztLzMi5ZOYusBgbx9U=;
 b=iYm5TbNgVAVdzV79ZFqPpAC62pmb47HVQxi3R5VprTc/jIWCzvtCheWF0x3hdmyvTGDOX1PtxYxhOe6H6TW4127lgBOgU4EPX/r/W69+9hC0eWMrG9YRFyZQpBdowVv45SHCAIBf0QlZmMGhVRcwi00GFYDsOYzVeuUV1NZ8Zz7eQWkKXAc/SOD3/71pFJRFwHZAWEkRJUoeiymCrdE9+j1ymV7MmW+eKQc3iOn3+W6NqPLC7wCI2gR/kAC0+0lJq0Rd/Xp+dsQN7/CVrbGSNee4xwLpavGcqRiFoSzY6QIyW5Sbf0Gdi5WtkUbSectBjF+HkUkivmhc7atMsHj9DA==
X-Ovh-Tracer-Id: 16824040834501611483
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: dmFkZTEAuLgS5eAkBjgZVj/FKUA/TUZaLbOvOgz3rvhuxHtdRGLF9XLOXOrRkIA80/p2mARdpzh87RwtX4vmEuFPGaf46zNye8jabkt+udROkGZDBv/hqD0fSKm4Zy+WuE54hxVOcPDU6zG8WA2HANi9L8f8Pk89+zt0jbcd6D7q5G4jP/zwS8lD6mkD0z0ILChVJi3o2+HVTPQwL06wX9tnP84N2ghPSG2d1JrxNHw6uzcgUnJpCteJi5pemCyKhpQlW434l4XRiszQ0to03rR5PU7xmMWdMiWKCg8C3CG6P4QE33ihOmDpG3nw+8zL8ANiJwkqEPtDgN6tJrUEXdFbb3NUe2NMZao2tLAkicwlIjlWjaHUOCrnW+XOvi67i1zEzhCGNwTMhIabcIRKVsz1HgIE0UWQSKUC/xO94ymE/CjMhYb1h1onRS+1GYcv9jKnfdOqr94h0cxnKqhOlEWnS2sQwFfMpvJbFKYnHeXzpTJzYXmMXX/Cl0OSwYDZvBwH/nnBzjAMrYyYFjxzIKra1+iJtkHVCBdq/uSrUL2sQu83kvRsouPBikzczGIXgvhgLfm3g6n6vGcIUfa+bMzj9OcO3EFWKx33KGZy8BeIEfXSeyunDR0IvFUclX4628KQJRyO+uJAmBz3A1TnYWmQCDfqERUyPU9ghpnQOd+3e36YAw

Hi,

Bluetooth on MediaTek MT7927 (hardware variant 0x6639) is currently
broken on Linux.
The device is detected (USB VID:PID 0489:e13a, Foxconn/Hon Hai), but
initialization
fails with "Unsupported hardware variant (00006639)" or the chip hangs
during
firmware download.

I investigated this issue by comparing Linux behavior with USB captures
from the
Windows driver and identified three root causes in btmtk:

1. Hardware variant 0x6639 is missing from btmtk switch/case handling
2. Incorrect firmware naming is used (_1_1_hdr.bin instead of
_2_1_hdr.bin)
3. Critical issue: non-Bluetooth firmware sections are sent to the
chip, which
=C2=A0=C2=A0 causes an irreversible BT subsystem hang (requires full power =
cycle)

The Windows driver only downloads firmware sections where
(dlmodecrctype & 0xff) =3D=3D 0x01. The MT6639 firmware contains 9
sections, but only
the first 5 are Bluetooth-related. Sending the remaining sections
(WiFi/other)
causes the failure observed on Linux.

This patch:

- Adds support for hardware variant 0x6639
- Uses the correct firmware naming format for MT6639
- Filters firmware sections to only download Bluetooth sections
=C2=A0 (dlmodecrctype & 0xff =3D=3D 0x01), matching Windows driver behavior

Tested on:

- Debian 13 (Trixie)
- Kernel 6.12.63
- ASUS ProArt X870E-CREATOR-WIFI motherboard
- MediaTek MT7927 / MT6639 Bluetooth

A full technical analysis, reproduction steps, and testing details are
available here:
https://gitlab.com/jfmarliere/linux-driver-mediatek-mt7927-bluetooth

Please let me know if you would prefer this split into multiple patches
or if
additional testing/logs are required.

Best regards,
Jean-Fran=C3=A7ois Marli=C3=A8re
