Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAC12D9785
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Jul 2025 15:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751901629; cv=none; b=MIPejrdmgxkbasJyTq8WVIYlt1FbZanoL7kPOmrHwTUTpleUGiSLnXVG0VeEQUdQgnhtL//wyJpZ7OHsKzLzJlpao4hmIOzKXZp/GixRgBrPy1SycZXFUzt6KhG505WcQTkwL/2WG0BTCWmMdMXwq7/V4H5skXvT0sxu6vHx4fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751901629; c=relaxed/simple;
	bh=pC2zTzRbaGKXi3WJzBMcv7DHnnZ2+yDbyawJt677Tq0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=MnBTW27pxtMnsEtqovRMfRkezqNT2awBldqGS/weE6o/3nQqn/9ELxEnVjr4CoIkrR5yfCULULlerpWbQqD3myYG6P6ijs7AZzHdqZJsuO/0gf9+jet3KhdLK1EE/IoVtn0Xsh/czLYPXO2ROmAFta0QrREr5bVJggS6hwCyywE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=aIW7XfFC; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="aIW7XfFC"
Received: from github.com (hubbernetes-node-cd81d1c.va3-iad.github.net [10.48.134.32])
	by smtp.github.com (Postfix) with ESMTPA id 2CB978C0CBE
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Jul 2025 08:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1751901627;
	bh=gHVA8JHP32M/8ie1P4XlGnGBTdh9m5aXC76Gvm5eGMI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=aIW7XfFCxiIPJXHacOVXVpYIaj6n5HYJeMF0HAT4Nufg6G4oWaALt9X6dnWXpLKEZ
	 LJgdVrP6sIs8AgBKm5YGW17zM0qqG7c+71i8JfUIWYZAiWlK7IyDz4JpyEo9INNEE+
	 nMWVPSwCKXz4X3CYIWNBkNjNQBvmFzEW4+RfdXNk=
Date: Mon, 07 Jul 2025 08:20:27 -0700
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/979723/000000-022fee@github.com>
Subject: [bluez/bluez] 022fee: obexd/client: prevent double freeing
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

  Branch: refs/heads/979723
  Home:   https://github.com/bluez/bluez
  Commit: 022fee27ef2db82bbebb8053446df8d75a6ff47a
      https://github.com/bluez/bluez/commit/022fee27ef2db82bbebb8053446df8d75a6ff47a
  Author: Ismagil Iskakov <i.iskakov@omp.ru>
  Date:   2025-07-07 (Mon, 07 Jul 2025)

  Changed paths:
    M obexd/client/transfer.c

  Log Message:
  -----------
  obexd/client: prevent double freeing

image_properties_complete_cb frees 'contents' after a failure.
However obc_transfer_get_contents does it beforehand.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
