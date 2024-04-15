Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55F47828B
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Apr 2024 14:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713191534; cv=none; b=oSqUbJVbZ1+FxEU9zb2yOlT/uWV1VC6MbI86tMVjvpjPM57RzdmpIaqjp+aCizy6cEVUaX/yj1v33gVlX9mmaLt7H4L7X2rm+pRlIjWIRO98GtnFucZN30564rMZrWIfnFobSgz8ova+Ae7S0qIj8oW4/aGOjakgVKIRO1MN4YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713191534; c=relaxed/simple;
	bh=1VT+nwAKpF8i3XL4QGrDRJ5EqRw/hhVZyp5ucsX8I98=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=JrmzChDpxyMevQ8jrSYPTsuk21Kov583mVAYXJUC9G+hgGljWDKDL1ag0KbAhLemc+woyERhyjZqaOlEi771m0LILql+jcxlMV4PbSkgnYCpBa1aFbn6C3cpIS7j1U1w54TN8dL2op3hWxbRJqV4eN5nK9WN01u1KMO9cyYQ4pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=MlluiLjP; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="MlluiLjP"
Received: from github.com (hubbernetes-node-50bb8f4.ac4-iad.github.net [10.52.138.36])
	by smtp.github.com (Postfix) with ESMTPA id BEFCA5E10FA
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Apr 2024 07:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1713191531;
	bh=aqDSYjNiX15xMvQyY4aiXobOlCtBcXBfUWN9n4yk6qo=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=MlluiLjPFLHII8WbA914id9Ou44+3PiPXnBeJ4wvpv7WMD2jAzSHPRGWD+8uPqxDo
	 HpvB8Aj6MW+nH5LGixpTFtKMQGhMhMKgJ+d4LODhgyx0EcSsG/vQt5fyia3XH/BWzK
	 B74yGR3JRNhRNsXx+P+9l7q9qWxjanvTo+ZgDojU=
Date: Mon, 15 Apr 2024 07:32:11 -0700
From: Jan Palus <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/f1a7ab-1955b8@github.com>
Subject: [bluez/bluez] 1955b8: build: list new tools/tester.h header in
 sources
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
  Commit: 1955b833c7a790b1f97000773a7aa985dd84a73d
      https://github.com/bluez/bluez/commit/1955b833c7a790b1f97000773a7aa985dd84a73d
  Author: Jan Palus <jpalus@fastmail.com>
  Date:   2024-04-15 (Mon, 15 Apr 2024)

  Changed paths:
    M Makefile.tools

  Log Message:
  -----------
  build: list new tools/tester.h header in sources

This fixes dist tarballs missing the header.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
