Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F299A15ECE9
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Aug 2024 14:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723214092; cv=none; b=dF9tJzzQm2Ic90XzEB2SfGq6NTr93DWWfMVV8h3XJ6KQHxyn2XdRRRJBH1VLLAyJx5tjIr67H4dySEx9vtc5PKj/bZLW8M8T1x89m4KCOFlNQrTFTlW1Zi4RrS2yimxSX5FN4eNBCQp/i2ud3aUkShooqU3BA5nUQfTvNGEWQuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723214092; c=relaxed/simple;
	bh=Py9Y0LrKhGmAxo/qrIlfK5jO79/63IWHBfSN+HjHU+0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=uGSKKFazTPQYEet/y7Oum/zIn43z6rjIIZpaq1Oxxr14cW5+dI7qL4VfBp/vfU4cJoYgCh5u9fkt2tqaRS0C/2q1iwxh2zM7kbbEtR0DxZ/JAXWk8JJoEhZmLfQCupf74bzq5H69+Y5sCZuHBxf54d0cd9jVptPrPndqtNAGwFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=a3m8ygw/; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="a3m8ygw/"
Received: from github.com (hubbernetes-node-917772a.ash1-iad.github.net [10.56.179.25])
	by smtp.github.com (Postfix) with ESMTPA id DB72E6C10EE
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Aug 2024 07:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1723214089;
	bh=1XEz1luWSi9ZLnOztgwOzH4S37aioXpIVhYoZZ2AONs=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=a3m8ygw/AlfIiNOWnphsAJx16jHC4o3O+TlvPKxWNTsr/L9xpGEuQi8tDm89GMG1d
	 HxNm4BTpUKePrej88j4Qh2/STojLxb+dELdP6eaFcjs1tTPqk2GS1Ezed/7u76Bg/G
	 xi+r16MYBxFyk79Slj6Xlw4z0Pelss2mSgaszp4E=
Date: Fri, 09 Aug 2024 07:34:49 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/e1aa24-40621e@github.com>
Subject: [bluez/bluez] 66044e: shared/shell: Add support for comments on
 scripts
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
  Commit: 66044ecd8dd95f684a8759358312f9f985fb8893
      https://github.com/bluez/bluez/commit/66044ecd8dd95f684a8759358312f9f985fb8893
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-08-07 (Wed, 07 Aug 2024)

  Changed paths:
    M src/shared/shell.c

  Log Message:
  -----------
  shared/shell: Add support for comments on scripts

This adds support for entering comments onscripts by starting the line
'#'.


  Commit: 40621e269287d6c5de8fd653df0c49b7907c2c17
      https://github.com/bluez/bluez/commit/40621e269287d6c5de8fd653df0c49b7907c2c17
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-08-09 (Fri, 09 Aug 2024)

  Changed paths:
    M src/shared/shell.c

  Log Message:
  -----------
  shared/shell: Add support for running script command as part of script

This allows running script command as part of another script.


Compare: https://github.com/bluez/bluez/compare/e1aa24a43949...40621e269287

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
