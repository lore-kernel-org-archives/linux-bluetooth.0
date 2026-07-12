Received: from out-31.smtp.github.com (out-31.smtp.github.com [192.30.252.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D753A1E1E12
	for <linux-bluetooth@vger.kernel.org>; Sun, 12 Jul 2026 14:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783865259; cv=none; b=gPIBDkrlkaFZnsYTGl7MnblK7xeg5cqe5f5hDYqepThNWS7N/6don9lAg8ZrxoyPfcdF3ZeDwJvhpg/lOfoDpLXI2jzPl0yfhEFAxd6SbPOcMsmhpufDayzXvwdCw0NNS8nPzde0vAZ5Tfz9255RkjayCAK+o1SwHM4fEIsLxm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783865259; c=relaxed/simple;
	bh=6o5e09+y6BG1mfCtckAkVJTpKQQ7cR6o2BUtS2DAtjY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=saguOAlQLnHaejRxe+aZOZtz04ntDNU1zITIv2O59uQSi6s4xnppIPBkhGfuezZEX9PUamwkIS8gzKup2W9SZ7OsOt65uNT1LtiBHZHoDIWgtRc6iPZu49yrC+jSbYW/gh98u5mhHuYTGnvKR3ovnRM+RUzuYTSxkWQKLq/S/Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=mjiHv7sS; arc=none smtp.client-ip=192.30.252.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="mjiHv7sS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1783865258;
	bh=jpH983qfWzZY+Z0f2aq9bNv8V86jB8qYODq+QNZ2k88=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=mjiHv7sSRBuXifo65xZWAC0t7Ly7CmXajj4Ck3aijwofpGs6685jHbTCp0Ky0+Eqq
	 yJ/3I6x7b5GKimv4NL7f3sYSxJyWhdYyNCOICi3g5bY07kVuijwdzpfPlrutuPftog
	 ekVWsj0ZNBpSCt/vybe/jl/hcVaVwTkjwuj6WhJ0=
Received: from github.com (hubbernetes-node-041a368.ac4-iad.github.net [10.52.135.23])
	by smtp.github.com (Postfix) with ESMTPA id 1DEC8320747
	for <linux-bluetooth@vger.kernel.org>; Sun, 12 Jul 2026 07:07:38 -0700 (PDT)
Date: Sun, 12 Jul 2026 07:07:38 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1125291/1bbf7d-000000@github.com>
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

  Branch: refs/heads/1125291
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
