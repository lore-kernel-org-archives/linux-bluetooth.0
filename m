Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54305560AD6
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Sep 2026 16:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788972524; cv=none; b=ZlRSX8WaLyzZPhRbXuvhVFfngY6kfyUjNEqeIQPrTaMy+d9O7b3z6dSiAf3AxuzBOEenEg7+Y7GhfmoWQ567jq48oWQqq9v48nIMFYjzPCOK66tAVAnLTSJpKi8dT7Rvj01JQVOSt644OHFDSHrdURZLjj3HRoz1zYdzixQzvhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788972524; c=relaxed/simple;
	bh=ZJSwavMFN8RIu37BhUh87Dzlb/xT/ycRDNZQsO5GRz0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Rbl7AlRWKv4zuQqSeJzBxk/ruYCBnaPfe3vJKBQM1uVEL5tPPRweHlBCAn+EM/b1+MSojrsl2Q7nWolonNlBmranUPCpMdEhh9kBOgwmHB9+dzO0bv2otBCV77AAJJ/JxiW6W9Dbgy7fzymlSnyoDFZka2ilLvtgeP3Ag7+V+qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=O/azdx5l; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="O/azdx5l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1788972522;
	bh=wQS/t1VUB/Tj/3yDZkUtsIJ5J+V7jy+i6vGTIndTMVI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=O/azdx5lsgQiFQnNROwzWpLcOjC21qNqnD2OvMDWkOXhTt2ES7tpFbbWlfRleGzId
	 O0ukdyqtGR+jhUMJ5wSwVTMzV5W6nYvkSUN6+S9Ejo4SouV36MhvKtID3uT+oKIQ99
	 iWwmdMXJHlwSB709RHoG4PRHfJNw15mwHhQz+X0M=
Received: from github.com (hubbernetes-node-7447944.ac4-iad.github.net [10.52.82.25])
	by smtp.github.com (Postfix) with ESMTPA id 01F3D9405F4
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Sep 2026 09:48:42 -0700 (PDT)
Date: Wed, 09 Sep 2026 09:48:41 -0700
From: Marcel Holtmann <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/875012-293eb9@github.com>
Subject: [bluez/bluez] 293eb9: monitor: Fix the LE features decoding to
 include B...
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 293eb98b4403ffd280b2572c8cedf4f0f21485c4
      https://github.com/bluez/bluez/commit/293eb98b4403ffd280b2572c8cedf4f0f21485c4
  Author: Marcel Holtmann <marcel@holtmann.org>
  Date:   2026-09-09 (Wed, 09 Sep 2026)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Fix the LE features decoding to include Bluetooth 6.3



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
