Received: from out-35.smtp.github.com (out-35.smtp.github.com [192.30.252.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02DF30AAB8
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jul 2026 15:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785252618; cv=none; b=HdwvhLQUOLkRKSuT1FLI5MyNW7T6loTSDFuhMazdVGQXBOQmAXA0sU1Ze8DR/qzpZiihS/lpMhHj/dXdeghKG/YBwM6NwXEjNbE0B+E+Lu2wM28oz3iU7stqqnXhyseUMU4QxU1W83ry+2qzQlFv5CmrmLd5ovQpDcnF2yA5Dng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785252618; c=relaxed/simple;
	bh=Hdkk/5HZqkvaiSnnSbKfLP0frC66GXUjVESr0rEEwvw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=cNo4tIIiClMnq+hekB0x1hMm5EOhkCVbAUPvySr04rhtvWG1wjWzFM9dgYsEoQPzOsX9aLtE7DIGP2n0aG99T5wjC0Sw8AF0fmm/EC5n3PWEg8PWFu1I1vEaY1DKAM5wJEZMTOAUwaAeiFrt6Agtxk3EZHiwn+OBfurmj4JxfyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=gkzR1XBW; arc=none smtp.client-ip=192.30.252.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="gkzR1XBW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1785252615;
	bh=qWIQy/KmJfjv6+DwRd/nxrmZ/NM1I3UIvbX2KKxKds0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=gkzR1XBW+DhlkAHo/dKwTojGZtY/a5DoycEX2dPsKQvapvS5fR+RTJfhXZ4ULIx+q
	 Df0hblQhHe+TG6Tb38xEAz+KGaw9J38uXL6uTDT+KC0HPwE/moYrKn7NcUdVbEtNpi
	 ra+ikp9lKkaufO/vmNfbC48GZc1H9MEYTa9x/k/g=
Received: from github.com (hubbernetes-node-c304087.ac4-iad.github.net [10.52.148.30])
	by smtp.github.com (Postfix) with ESMTPA id DD8F4741606
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jul 2026 08:30:15 -0700 (PDT)
Date: Tue, 28 Jul 2026 08:30:15 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1134824/f6b70a-000000@github.com>
Subject: [bluez/bluez]
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

  Branch: refs/heads/1134824
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
