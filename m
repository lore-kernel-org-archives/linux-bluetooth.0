Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38C32FE074
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 17:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769534808; cv=none; b=tLEFST3k5wwscmJTBvDf+g3Me/PqrxDOoYfTdaZfuQeGjtPVvQ7NvnMR3sPAaZboArHl4BgApqbodn2AjecMLRn+ueQGynKw0/0C2wMoOhmztSe4wFYI01whj8a81pqr0RgnlRIzLkKAYgl0jtF1Bu9N/MhFL6KOj/LAd9B6Y7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769534808; c=relaxed/simple;
	bh=CYl49kkj8kXXFhLzEjNx8zReaeF2Pa6curTH2J6PjEQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Epy0f/3TNRUd7+LhzpJGeAQtTYcPj/S1NSfbOJBsuLu0Q0ZUR5eNKyLFveoQJdXtCSTwXhlN/0Amg7V/ONuxEYAIzZ2kELuX3L4t4LLAEaLHY/tbNZO45WeSwYZLV8vRzA0t8tE+6it8Nj1zhfULARwCQqNZiOaMdCgyzJhwk7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=gQpJmRh8; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="gQpJmRh8"
Received: from github.com (hubbernetes-node-9093575.ash1-iad.github.net [10.56.201.93])
	by smtp.github.com (Postfix) with ESMTPA id 7FB2D1403BD
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 09:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1769534797;
	bh=F5XZ1qpj75jkO6X0JRnqxRA4ZSF1noFGwKh/OotZPNc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=gQpJmRh8dB1sIstawQTH7DAukS/OVbywQa6HHTH5WlqHbr6WytOhOnx5W4NXIWHv2
	 ksG/ANap6UYuKQA1Y73O7Yn4+pIYlhNBvs20p71KGQXXCUvYNRqPS1x2d+fT0uEwQt
	 IAMxGYU1Gh1OIoNl46HyyyNKDSgS20j/0rpqwyds=
Date: Tue, 27 Jan 2026 09:26:37 -0800
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1047702/000000-3d7d42@github.com>
Subject: [bluez/bluez] 3d7d42: doc/qualification: Add PICS and howto for the
 IOPT...
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

  Branch: refs/heads/1047702
  Home:   https://github.com/bluez/bluez
  Commit: 3d7d4272df209fdf124636c237cfd66b6f9f2e78
      https://github.com/bluez/bluez/commit/3d7d4272df209fdf124636c237cfd=
66b6f9f2e78
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-01-27 (Tue, 27 Jan 2026)

  Changed paths:
    A doc/qualification/iopt-pics.rst
    A doc/qualification/iopt-pts.rst

  Log Message:
  -----------
  doc/qualification: Add PICS and howto for the IOPT qualification



To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
