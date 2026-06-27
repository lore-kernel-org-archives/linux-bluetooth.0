Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59B12F5A13
	for <linux-bluetooth@vger.kernel.org>; Sat, 27 Jun 2026 23:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782603772; cv=none; b=czjrDStSprOse6XEnVld072WwqeRi1DoQTNYnTkBhZWD7N7DrQgDVHiaRgpLo01ExcsK3b5e+m+6W1cL94BnlCeCQzDx4kv98S+ee0NNycYZ7lnGXvkCvctOl4bf2TyKe2cRxHnCn2ZN9ItH2EafZiHQ055MWQw6Skmxp+2k1ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782603772; c=relaxed/simple;
	bh=m/4veAR4CHQq2FbMdbLYrEYpRebrMVTuyNM2tvQUii8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ihBidQTYBRR1e0h3hU/W8O7/MLOYCmr8KGtiSp4P8hOm9lyDlcyCZc4tO/GcOLIeUKi6KEA6yQFp5X0dOPHjwxpkXLkIyT/dQHR6PVIDqnIBrRztbeUQxR2rWafqPGZmAW4SJZKM7+XXQgwWl4UbGWz723iZzgv5sbJhPWrfiSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=GCm4Kcuo; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="GCm4Kcuo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1782603770;
	bh=fBB7zOlxRyaeO3NrXosCeBof8an8zFsxKvmIX+HeTe4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=GCm4KcuomPkyqj0qRPzCHc4iHxiExMWxbNulsRzvwrx+9UOQAC1KL4R+/ZG+aE78s
	 UyAzqttVtS3m9PqbtRlkAunYu+s89thd7O3j71HqWwKtHBBL8iugnEBJoo4Hb0rcMt
	 sgRzm8NrorQDxiEHr0e3Y39fS3nCwm5ohrDREFkw=
Received: from github.com (hubbernetes-node-8c07bf7.va3-iad.github.net [10.48.153.34])
	by smtp.github.com (Postfix) with ESMTPA id 05C7D28B36D
	for <linux-bluetooth@vger.kernel.org>; Sat, 27 Jun 2026 16:42:50 -0700 (PDT)
Date: Sat, 27 Jun 2026 16:42:50 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1117512/059aa4-000000@github.com>
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

  Branch: refs/heads/1117512
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
