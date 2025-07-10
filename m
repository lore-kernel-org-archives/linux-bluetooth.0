Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E152EFD80
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Jul 2025 16:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752164341; cv=none; b=MjZTdFeURbma1WmkGccoB9KuxgoJHUEIbdB2wN6p6KxsNv+rkSKnOXD56UDBwo4AlZeF56IB2za71ZaFdCzGZfBIGN2F7SNQGl7tdghj43XxTr4xMrOINAIOSXt0JYQ6owMw+l1nxyxquGRBZYe7gb5zG6aMmQir3wKO2jYi2Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752164341; c=relaxed/simple;
	bh=dKlmT66/WkbHoIYlAsPy+9Lj65cl8M6avY11CXgQH44=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=WL/Hn/qdZ8jVRjVWHI/1jfaaf2XEvofV6ptte8f5Sbrj9Fy19UT0bOmiGXcvDiLdvIZSVdr+UA5OdQ/BW/aVqDXWPom/SlGGCwTBH6tCsJVf0jEhsHGyA1UsPvJqBdcSX11UM6MYNTl/ptHa1G6xD7GeOiGE9eUwOcQzOs2nqAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Lkaaay0E; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Lkaaay0E"
Received: from github.com (hubbernetes-node-77e82f2.va3-iad.github.net [10.48.181.33])
	by smtp.github.com (Postfix) with ESMTPA id C4B17E07D6
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Jul 2025 09:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1752164338;
	bh=btNU7kzsQEgw4cPAaoA/n/HCAnZDt0CqMZu3hFP2QNc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Lkaaay0E4zSahQVQ+nhMMCQZa51BHuNgd8q0UHd0NPlMapAMLb81fHcqLuTRir6+l
	 ORj2nDKSnk7SFrMqH7iEzOicllrk8a9FRDzmVMZ7y4Cx848a+08bHdYHwEJ6FrSDvW
	 /Qe2l4aUNYV8id41K54a8E4lmoA6Hxyts/3sPQnU=
Date: Thu, 10 Jul 2025 09:18:58 -0700
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/981119/000000-85e1c4@github.com>
Subject: [bluez/bluez] 85e1c4: doc: Add new telephony related profiles
 interfaces
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

  Branch: refs/heads/981119
  Home:   https://github.com/bluez/bluez
  Commit: 85e1c4dd6d7003a857e86bc73926b3794720fff9
      https://github.com/bluez/bluez/commit/85e1c4dd6d7003a857e86bc73926b=
3794720fff9
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-07-10 (Thu, 10 Jul 2025)

  Changed paths:
    M Makefile.am
    A doc/org.bluez.Call.rst
    A doc/org.bluez.Telephony.rst

  Log Message:
  -----------
  doc: Add new telephony related profiles interfaces

These are interfaces are meant to be generic to the telephony related
"headset" profiles like HSP HS, HFP HF, and CCP.



To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
