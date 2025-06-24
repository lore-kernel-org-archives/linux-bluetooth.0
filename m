Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418A6200B9F
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Jun 2025 14:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750775802; cv=none; b=GzWSNJFksX6XWY68cS+1VLEmOkiAYXFtpHtyTQtQJLC6fR0ySRMigp7JO4zgSjMneSTBaf10/pXEbjtSdjbKWSJqU1FegWnEnsyVd9FECffqsCv2fb3lnFHBIx9Z3PmSLG3EM44UXsM2/iWm98tOqdxroIC/YYH7U+jrCAqd9uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750775802; c=relaxed/simple;
	bh=2qjdzgeLUdLb7TrWh5p8NMtD4H1Oc/M9ssHwMxtJipY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=NrFNnY2hx0MpO7yqBZs5zrCajrNKF+aRmJarCIYhHVDBWc4fMZz9HwjOPi9rz8/3wUHMggYtyBmrqjj52CePQuhvh2dsWArw1r/Xe1uGEmHCFje3cGUUFO396Jl7JDoTq0MiIIRQJ/D7HAOiYcQNUW5YDuUbhmfJ8/9Ym6WwrwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=iWCkqUMP; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="iWCkqUMP"
Received: from github.com (hubbernetes-node-b2574e3.va3-iad.github.net [10.48.220.15])
	by smtp.github.com (Postfix) with ESMTPA id 53C318C115B
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Jun 2025 07:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1750775800;
	bh=qpIKaNR9O01opL2KbmVwQ9ub/qICt2fxGlILGTXxa2w=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=iWCkqUMPTx44un8dXWXmpeMx0pH+1WjkxpifsR3pIExXgznjFkYDm+YpLXOlNVvrC
	 iMv9zri2v0xpXqnPD8D045tMLmc7cO1jyNmOfRsSDc6il2ITNkf8oE5uUCeRtRyIrK
	 2bumqhs3alaZcpYqKuixZQngfbTxNlelipdFCdKo=
Date: Tue, 24 Jun 2025 07:36:40 -0700
From: Pete Beardmore <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/975328/000000-ed17a5@github.com>
Subject: [bluez/bluez] ed17a5: obexd: Fix failure to register bt transport
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

  Branch: refs/heads/975328
  Home:   https://github.com/bluez/bluez
  Commit: ed17a58cd41fa35c6be4b8f10c575dc1f065c1b3
      https://github.com/bluez/bluez/commit/ed17a58cd41fa35c6be4b8f10c575dc1f065c1b3
  Author: Pete Beardmore <pete.beardmore@msn.com>
  Date:   2025-06-24 (Tue, 24 Jun 2025)

  Changed paths:
    M obexd/src/logind.c

  Log Message:
  -----------
  obexd: Fix failure to register bt transport

On initial logind update, the internal 'active' state is FALSE. Where
querying the current state (`sd_uid_get_state`) returns 'active' we do
NOT want to short-circuit the update to the internal state value and
ultimate transport initialisation.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
