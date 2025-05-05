Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8241A3169
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 May 2025 20:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746477869; cv=none; b=oC/a+TyCmPB16RPB6S+eZ13EW27n/4Tzat/o5QecHJGGTQ6+pnodmsf/lSaX4VczkrO7qO5rlZSQQC6/wP1vIzzxI3BU/TJ71RMgHhb6gvSB+fUfRr1QjaeGJPTDug2cpouvhCmRiVRybUgnqMeHWkx1EHf9NQE+QYLTfneCTaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746477869; c=relaxed/simple;
	bh=EH/KAroF97+k5q3WFPt+p+h/l7N7Tw0YYdyQu/MJk4E=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Y7V6dMr5sPiu0HXE0MYOvWT2+mM1mZHu8EtSqd2AdCQJRWCgLot/T6nVeUxvvFAmDaYixT719bJF7+T+4t6vDaFCj3TMMEHYzWSbXwfoc0iEk7xEp4zHWrjjuIP0q+lJ1ADeOIUbmfi6ssgHyG96b7Cf2lzdXjMdoKvrrBf46iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=FV7Unv0x; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="FV7Unv0x"
Received: from github.com (hubbernetes-node-3a09a16.ac4-iad.github.net [10.52.11.65])
	by smtp.github.com (Postfix) with ESMTPA id 49DAF7006E6
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 May 2025 13:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1746477867;
	bh=4NAJsyFjaE7momBbE6me0LLCMUs82UwRBIQ2R073dYw=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=FV7Unv0xh6UYDZ0t6yU5DT5vboxJFFMOykub8J+u+0sjoup3VWLP4CcHcn17cNurN
	 Uww+gnNURZTGhuY4NJOYsMITy4JQaxzMS5HxkN2j4YPLyqTCKbxMqt5zLGzKh6IAGt
	 aW62xeqzTtoKSfSvM7JmO0xza1c9LsKILKSdrzf8=
Date: Mon, 05 May 2025 13:44:27 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/959621/edb889-000000@github.com>
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

  Branch: refs/heads/959621
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
