Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20EF12877DC
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Jun 2025 13:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750082295; cv=none; b=WXrySNUAfju4Wf2FmIXbrT2R9X2uqY9GslHwUZqTdvXMeQzPgh7BOMYbnjQY4Llcbft6PsPZnQOV65eM4c3qrGYWguCd+7l7ZJKyajlZwKMaEgSfaPwKWjDCQPmXxCYdYNXRpFTr1ZZAAKovf68eRAU250nCbkNf9RWIL3tmrps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750082295; c=relaxed/simple;
	bh=n+brlKn4f0b2bcfsw2HiEhgARDV8CrueLFxCZbDFVJM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=NpikG+WUdZZ9brY048r4ZCg+zgP+TYaPo+AxbjXR3P18Mirl2WkhiYJZ+7yNqrPnOfTGxY6+sfdtsTeROx8YwNjpuL69fswAPmfRzrzNlNzVGU+49QG1IMJQo+4VFzizViuon+94GqJzpGnO8qtGcnHaTIidVnc01v52dNWsew8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=J5pKbZpk; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="J5pKbZpk"
Received: from github.com (hubbernetes-node-c4b9b7d.ash1-iad.github.net [10.56.144.37])
	by smtp.github.com (Postfix) with ESMTPA id B379F1413F7
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Jun 2025 06:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1750082292;
	bh=5H91Gd6HWC8h/wP3Rfb8K1qVA/8kHkjpxTnpIySgLvA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=J5pKbZpkDBwzwqo4QqEh8sGyH+Ne5W/IEBCK4IQEAWpIJkTiVu2pnRPCF5hXRFIrT
	 JW5Qbv8qJwRxXWXpVHutlTchJxym0WCJR7sB+/c7QaCC+kXkTk5GN0vbVrxTiJOU46
	 doA9KUYFKVvKbD5OaCbo1kL6tEs9o0t7t5fdKE+g=
Date: Mon, 16 Jun 2025 06:58:12 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/972538/000000-a6939d@github.com>
Subject: [bluez/bluez] a6939d: shared/bap: Fix not using metadata set on
 stream->...
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

  Branch: refs/heads/972538
  Home:   https://github.com/bluez/bluez
  Commit: a6939d8c69b1639f516d9faea1e9cc4b05294244
      https://github.com/bluez/bluez/commit/a6939d8c69b1639f516d9faea1e9cc4b05294244
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-06-16 (Mon, 16 Jun 2025)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Fix not using metadata set on stream->meta

bt_bap_stream_metadata maybe used before enabling state in which case it
will be store in the stream->meta so when processing
bt_bap_stream_enable if there is no metadata set use the existing one
set in stream->meta.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
