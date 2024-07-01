Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC80916B3A3
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Jul 2024 14:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719844606; cv=none; b=j6KFZQXMvTe5a2q0a/KYROLzjii3WsTX7iINQs0VtyWR2mrDfOZOoOCdxlvr/xM8rSgLA+a6nILnoWgatB6+BhGrx50dK0I0ibQA8DCHeCP74dKZ9DkYG9negfNrILipib44zNY19/iCG6BRsghvjwW3G7j+4zqK0XwLCGhiCZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719844606; c=relaxed/simple;
	bh=HhkYXXUmOfLBygg959yWNE5evwnOx4yXEnl7nJI0Sjk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=OgGtvYfEiSDXWlq67tmFGmevh7/BhR8qMZkvhBrepdZGNKNWbk3zwMb7K+9XTTtMjbVkAtdXUddB8o5dILmmj/65ZEYKQ2NB3gHeL1fwc1snBSglavdadiKuNHrYd+I+58mmN4XJwlkI0TDDQI8YMgexSgFAylKFTY/I14VAYVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=VPAWIF1d; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="VPAWIF1d"
Received: from github.com (hubbernetes-node-70352fc.va3-iad.github.net [10.48.140.32])
	by smtp.github.com (Postfix) with ESMTPA id C1900E03F4
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Jul 2024 07:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1719844603;
	bh=LME3BzzW5NL0QMDX1P62musB+OUch23c4mPHPFueWiU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=VPAWIF1dWnI1TgCw/kIDYih5NBO33MMNac+C90Ioup6kXLIQ4ZnXZHRtWmDfM35Ir
	 tYVcoIu74IbUiWRAwQ3VFfELgDlbP45Gsrc3ebU/JncZ0qNYuhOeTCwx9sI2vZxadS
	 se7Z7TraLx6Apt3zDHh5HlhWtMql79M8FYznKjYQ=
Date: Mon, 01 Jul 2024 07:36:43 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/7e0282-be0b08@github.com>
Subject: [bluez/bluez] 6f40e8: policy: Fix AutoEnable default when main.conf
 does...
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
  Commit: 6f40e88d0bd52d5b25f869d536996f9e462f1643
      https://github.com/bluez/bluez/commit/6f40e88d0bd52d5b25f869d536996f9e462f1643
  Author: Arnav Singh <me@arnavion.dev>
  Date:   2024-07-01 (Mon, 01 Jul 2024)

  Changed paths:
    M plugins/policy.c

  Log Message:
  -----------
  policy: Fix AutoEnable default when main.conf doesn't exist

180cf09933b2d8eb03972c8638063429fe5fece5 changed the default to true
if the config file did not set it, but it still remained false if
the config file did not exist at all. This change fixes that.

Fixes: https://github.com/bluez/bluez/issues/886


  Commit: 55f561a9cd0be9f939eaa6804b30fa67b3005002
      https://github.com/bluez/bluez/commit/55f561a9cd0be9f939eaa6804b30fa67b3005002
  Author: Roman Smirnov <r.smirnov@omp.ru>
  Date:   2024-07-01 (Mon, 01 Jul 2024)

  Changed paths:
    M src/shared/shell.c

  Log Message:
  -----------
  shared/shell: add a check for NULL in bt_shell_init()

The opt variable is checked for NULL at the beginning of
the function. It is necessary to add a check to prevent null
pointer dereferencing.

Found with the SVACE static analysis tool.


  Commit: be0b08770e9214592e89589b2dc069426c0d9b91
      https://github.com/bluez/bluez/commit/be0b08770e9214592e89589b2dc069426c0d9b91
  Author: Roman Smirnov <r.smirnov@omp.ru>
  Date:   2024-07-01 (Mon, 01 Jul 2024)

  Changed paths:
    M profiles/audio/avdtp.c

  Log Message:
  -----------
  avdtp: add NULL checks to avdtp_has_stream()

Make avdtp_has_stream() safe for passing NULL pointers.

Found with the SVACE static analysis tool.


Compare: https://github.com/bluez/bluez/compare/7e028287ae1a...be0b08770e92

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
