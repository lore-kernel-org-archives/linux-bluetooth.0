Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B7325F994
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Mar 2026 13:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773409347; cv=none; b=la46A1grB6ZDfTva8S90lURtRRb6M+TpACe9yw373IdzijV1D09xJIesI8uLAAqwtTRddnjl1Qtv4km56IefwCosbMr32JMWy5LWQXzH0UZTyTtU8+9OQD5SwgqiZm87mmkckQKsFEgJc4etJcFkv2AOw+ExJZOE50OrfCa+Qio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773409347; c=relaxed/simple;
	bh=1uW1IsEfd1cGz0H5wWZmJupGUVpk9N9hrXNTT3AacRg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ncSr58fJvq3q5ZBNPV+NUXVx7VWfJ5mql9+JBLMgnV4pwmmWDXfWHYw9BKx0oZZ3KuZm3japckSA1S3NPPtvCb5y766gdKSTNYp8s20fRgy5uKYqCY+qL8amCKyIR28GGqWac/Xm7U01NEKo4Hi166ctGol1kcZ3H8cM70W/GrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=fPnZHxm9; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="fPnZHxm9"
Received: from github.com (hubbernetes-node-be1a7c6.ash1-iad.github.net [10.56.173.48])
	by smtp.github.com (Postfix) with ESMTPA id BC6DC1405FC
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Mar 2026 06:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1773409345;
	bh=MXRW6O1XnHjfLs6ioDIKujiPiUpW0cG/Yy1dgh/ZpP8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=fPnZHxm9QWcz/ULAlbXVUXNIEpUrI4avA4WHajV3qo/eZ14FRVBQF/SUUBh3kYMP1
	 vNjsgTht6iVbJKbUNitRI5+jYRXldznhjEJPLcHWOQjXXFRe2brPhcS074AKPEHSas
	 aMMXZAxXdatfDQlHa0CHB4WrIH/vb+1mcz5rYXg8=
Date: Fri, 13 Mar 2026 06:42:25 -0700
From: Marcel Holtmann <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/948d90-a035be@github.com>
Subject: [bluez/bluez] a035be: build: Remove legacy hcidump utility
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
  Commit: a035be775703bba1fa92b25769191ffb37ae4c76
      https://github.com/bluez/bluez/commit/a035be775703bba1fa92b25769191ffb37ae4c76
  Author: Marcel Holtmann <marcel@holtmann.org>
  Date:   2026-03-13 (Fri, 13 Mar 2026)

  Changed paths:
    M .gitignore
    M Makefile.tools
    R doc/hcidump.rst
    R tools/hcidump.c

  Log Message:
  -----------
  build: Remove legacy hcidump utility



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
