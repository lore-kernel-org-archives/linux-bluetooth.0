Received: from out-44.smtp.github.com (out-44.smtp.github.com [192.30.252.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CF74399C6
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Sep 2026 11:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788434000; cv=none; b=gjOIJTX6NmCyrE2WINasGHKtDl4MgVvp2VcqXX/IoAoj8OSrzcGLfg+qGtUxqByt2WwH3tk6utqgo73/aoI+KDlulm/zyDt0Vk+MFDE318BFk15nTjt2av/lpZ58EMT/bGiP92nx9HiIP+ViWiuGWsUyf7N9Jwo8nX03VNb3CNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788434000; c=relaxed/simple;
	bh=XNyWQXlP9fGBE7hUu8nc3iXRXWYWcef7Br9NBRoty60=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=MGIasv2F67tkqnURwDR3/HmLoFHcHMjDMxUDUmAT63MUQalmuAW80od1hzI8WcC8zl+Ei71kecSdtI0e+Rvg7DE1sr8OtGaKC6DXKxG0uZd8cnicZ0RDESrjrfDIhSjcUfROHB7AGFUgsa6CV+5Q+M2qdcw+iJwXn2gIFGuUbS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=QBO0Z4xL; arc=none smtp.client-ip=192.30.252.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="QBO0Z4xL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1788433997;
	bh=iSmQO8RbLgWm8ihiqdy+abGxRCYV4Ha5aFrD4B9RL8U=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=QBO0Z4xLvJM3SxB/1dyM4VL9jw8UmzI0C4bk+DpWKvaS94eh5jYmPsXoszZYokDXF
	 gREHUhdTuPh05YbXCBBJOSwAvVRCqw5gELtW+u3WeBTlYfnaPEdthS5cgUY1JeU8cQ
	 Ic/YK+ZahG0y90iO5QzPL0uNFUU2J1fEzzwUS8Zg=
Received: from github.com (hubbernetes-node-a6e7b9c.ash1-iad.github.net [10.56.144.37])
	by smtp.github.com (Postfix) with ESMTPA id 5416B84155C
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Sep 2026 04:13:17 -0700 (PDT)
Date: Thu, 03 Sep 2026 04:13:17 -0700
From: raghava447 <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1156893/000000-f9929a@github.com>
Subject: [bluez/bluez] 98bd20: doc/qualification: Add PICS and howto for the
 BAP ...
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

  Branch: refs/heads/1156893
  Home:   https://github.com/bluez/bluez
  Commit: 98bd20a52922c93ad5671db772a51873c3ef5c30
      https://github.com/bluez/bluez/commit/98bd20a52922c93ad5671db772a51=
873c3ef5c30
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-09-03 (Thu, 03 Sep 2026)

  Changed paths:
    A doc/qualification/bap-pics.rst
    A doc/qualification/bap-pts.rst

  Log Message:
  -----------
  doc/qualification: Add PICS and howto for the BAP qualification


  Commit: 57c45ae936fb948f8fc9c721437fa7dd936a5d41
      https://github.com/bluez/bluez/commit/57c45ae936fb948f8fc9c721437fa=
7dd936a5d41
  Author: Raghavendra Rao Sidlagatta <raghavendra.rao@collabora.com>
  Date:   2026-09-03 (Thu, 03 Sep 2026)

  Changed paths:
    M doc/qualification/bap-pts.rst

  Log Message:
  -----------
  doc/qualification: Add BAP/UCL tests


  Commit: f9929a8e6ef6ece2551a93e64c3c2083ecf6ced9
      https://github.com/bluez/bluez/commit/f9929a8e6ef6ece2551a93e64c3c2=
083ecf6ced9
  Author: Raghavendra Rao Sidlagatta <raghavendra.rao@collabora.com>
  Date:   2026-09-03 (Thu, 03 Sep 2026)

  Changed paths:
    M doc/qualification/bap-pts.rst

  Log Message:
  -----------
  doc/qualification: Add BAP/USR tests


Compare: https://github.com/bluez/bluez/compare/98bd20a52922%5E...f9929a8=
e6ef6

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
