Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C5928C5CB
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2026 11:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779364551; cv=none; b=iqsyLXUBOFtckWg9fp1MCJ0FL7RV7lkwxScFK/fBJRFLf4CFD3J2uELdOMgTnnf+ux+hhvc2oWht3ZesohkfdlAXDiRCyMD9hwwhYt6zCBrGc/GkuykmsQ9/WYo06JGvS3nAid4hxaPiVmIDwz/E1hrXRkrLDbLKIriisH3OEP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779364551; c=relaxed/simple;
	bh=rN8nO0x1CoUTHhXsPdAL45wznwjH/PHajCSNvth9CjQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=bVzwpQlwBhMJSQTTpQndmuvkWzMwt6EuGJsE5+WDWceLSMBOwsx5sk4cZsbrQgqE8Bec7BtfUSo2Ek1dpe04aDqVFrHcKRigNuSWj64XOi3toojREESXI6S1zP0VEhFwKSL9CZ3WnbfClKyKnF6R2NOuUgCOHL77+yZGpQX2q8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=GDazR7w9; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="GDazR7w9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1779364548;
	bh=cbX2lsSX8oJp4LrBUyuRc3WbwOLTKWvSuYlIgpF7iSg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=GDazR7w92oTNPTXVkaxdkwi+uKQrE/pIAHESbQApR0oqJihgRngOUGXROTv8hR8F+
	 jUhdrKAxPalc9MrUXm9YMG76y+LYSCWwDHrbX1AKNFTgITgjaiyEQJxVFCbiLlAO+A
	 xTOc+7gutyRueVkvMw09AOEJzWHecB9uaeNbW/s8=
Received: from github.com (hubbernetes-node-5ec9431.ash1-iad.github.net [10.56.179.30])
	by smtp.github.com (Postfix) with ESMTPA id E21EB520AA8
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2026 04:55:48 -0700 (PDT)
Date: Thu, 21 May 2026 04:55:48 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1098497/75a3ce-000000@github.com>
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

  Branch: refs/heads/1098497
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
