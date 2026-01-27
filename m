Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679AD2EB84E
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 17:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769534783; cv=none; b=Fsg6XuOPDwt8IKtlf+FzR6sIRFkNriP8vP0BaBsRQ3woUA61ywgi0QEVN+bxbRMqAjXHe3n8+I+VRVSIo3ON6ajjEmef9kQYArJqmyNErO/QKdVo9TlPyYAIySs6Avstz+syOQWzYz4ytJYUKE+2aiknlLiQqoyzpfwN+U9JjVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769534783; c=relaxed/simple;
	bh=omb7mZw2taudGjBJgTLHNWMKEn1W4MK//wJEbGsZBqE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=rc5zFusCNBJtjuHu5bPYL+j/C3/WH7oD4wKE5xanW2eELNZz7PsDcUQwHW1Ea9SD5OnuP+4sdagCDj9cBioqc97H86Plk5HJ09pTgQXm2UNfdP8MgLDAIJB3uDDGhbGVcp7mGrxXIPEWNsmTUn0aY8pn5AYKl5usfKzp+qFf1Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Wm4xVbLw; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Wm4xVbLw"
Received: from github.com (hubbernetes-node-fb7c32e.ac4-iad.github.net [10.52.130.37])
	by smtp.github.com (Postfix) with ESMTPA id 44BEB2137C
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 09:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1769534781;
	bh=SS5XzsGoSwh6Q/gTyo6E4B5pCuLalkGZF3xwGHJekZY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Wm4xVbLw7CXS00UCzj+NpjHcWEnTJ61osACFMk6Sesx1h1RG31f4/oX2VAxGh9j3K
	 jHFC9WnegrU62hSHO07Z/knq8mM7Gsxq3otoKme36FfUM4KBX8BadnayKF9tB/qnfi
	 PULYHqeMjRUEZoeRldBQ2n5rboZkTr1ljIumbl54=
Date: Tue, 27 Jan 2026 09:26:21 -0800
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1047694/000000-b609db@github.com>
Subject: [bluez/bluez] b609db: doc/qualification: Add PICS and howto for the
 GAVD...
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

  Branch: refs/heads/1047694
  Home:   https://github.com/bluez/bluez
  Commit: b609dbc253b328d793edbececfe97efe1409ba1d
      https://github.com/bluez/bluez/commit/b609dbc253b328d793edbececfe97=
efe1409ba1d
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-01-27 (Tue, 27 Jan 2026)

  Changed paths:
    A doc/qualification/gavdp-pics.rst
    A doc/qualification/gavdp-pts.rst

  Log Message:
  -----------
  doc/qualification: Add PICS and howto for the GAVDP qualification



To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
