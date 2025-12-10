Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F1829BDBD
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Dec 2025 15:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765382382; cv=none; b=XpIl2dxlCAmD26XIioF6Dn1Fj1AOIQiDN8lga5DbYumCwI/zuUeRekLz2hb7hU9osu3lLbZkYYQXEphZv/6PrSdi1Zh17shHFA/TYQwxyj4Ba0GR6hWzJP59LNTtdvCdKl6BusQYSkZ6LEjlTa67bXxH65kTNY46i0D4XhGffX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765382382; c=relaxed/simple;
	bh=o0/lHYAQ5nzZdiJG2EQ00t2F74U0st8B74Yz77Z6Je4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=kNfqbGKr8xubsMJTsMxyJzWkVU5wVGF26MDkcRY9g5T0rGQky/3Gj9dc0CARXaFODrSGM/JLWGb14tXlONepRDWhKfblELSKYcvC0jZAb7oD8b0Yc1s94Z64pjDgC6sWDGcBy5wpNOGypaEvQ/EAP1zbuh9+cvcrvn/2Z9tlnag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=kFxZ/zEd; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="kFxZ/zEd"
Received: from github.com (hubbernetes-node-d13eba4.ac4-iad.github.net [10.52.202.97])
	by smtp.github.com (Postfix) with ESMTPA id 46A5421488
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Dec 2025 07:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1765382371;
	bh=3rxSA95dv/OWKUSVET3r2Ib/fSW70LaLHvrYXXwhQiI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=kFxZ/zEdJVxU/FH6N7ufpuU0kjYBUOEXPxiG+vVI6RF/oSbjnByXzaU9MU1hUGtpv
	 EAhdKEYZrnnu+v+KENEa3/fKkVq6rZB1z7SSdWel25/geiys9+k929vu/TjxrE7CQy
	 JJwoWhXBxUpBwCPTfJjN9p4+wD29J8hAzpqtFkvM=
Date: Wed, 10 Dec 2025 07:59:31 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1031829/c626e4-000000@github.com>
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

  Branch: refs/heads/1031829
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
