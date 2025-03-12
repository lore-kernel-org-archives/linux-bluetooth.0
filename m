Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85372528F0
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Mar 2025 14:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741790492; cv=none; b=STyXSRy+fWyN9nq1biK3+HBO+iQ+TbQ2ThuQlPa6eMxoX5uHSNEWjmfwiSxYEhVzFJiu5vso0qSHLOzsY6yGsmDdVOmknpr4lsqTk35UYejIGeSXwtP9CmwWl9WdFesm57BWwBPgAiu8/XaCb+H15fpAKMuWx+c9zte3x3mCzLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741790492; c=relaxed/simple;
	bh=Fo4ggadfT8NINI2KHmaMh9TauLerqhz9J2O5u1OS994=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=h1aGkxKy2bCYj1jegiOU0xYpT386yVtBs8BxqPxsYQNll9LYZ0iE+67ChlvKaobw26bNMU0uAHo6zKfcNWx7jN3X+ZzywnpeNspu8zxe5pKyJWN/+FwkFDM9BSzNstPgp3Sl/QFwcKbr04UKE0Wy/CFF6qb4nyAHL4G3EJv7soY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=fyQsbj5V; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="fyQsbj5V"
Received: from github.com (hubbernetes-node-fce1076.ac4-iad.github.net [10.52.161.36])
	by smtp.github.com (Postfix) with ESMTPA id B6DF121C06
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Mar 2025 07:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1741790489;
	bh=ZKeqqEjgCmeitYldfnYvhxGQaDsFmzyWxUR4kRXOWC0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=fyQsbj5V9ETOWPfyCgThH3VXsq594mN1f8hBZEoltM/f/PyJkVQrN5Brq3UQi8TUz
	 2BkLWl3xq57QvCtGKP4DOlIvtKpOrIjHkUnvZgF1AEgRNcZVvIQc3xlDauh7qUwHWs
	 /UH4GbwUkqS3JkNxtQtJplpqCNOp4/yhxWZz3fsE=
Date: Wed, 12 Mar 2025 07:41:29 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/95055d-adcd73@github.com>
Subject: [bluez/bluez] df891f: sco-tester: Fix closing the socket
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
  Commit: df891f0ff44e0d67c4e60bd6f9e03b89a316164e
      https://github.com/bluez/bluez/commit/df891f0ff44e0d67c4e60bd6f9e03b89a316164e
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-03-11 (Tue, 11 Mar 2025)

  Changed paths:
    M tools/sco-tester.c

  Log Message:
  -----------
  sco-tester: Fix closing the socket

When writting data the socket shall not be closed until all the data
could be transmitted or the test times out.


  Commit: adcd73901831c0a4e2469ab3705608745af259f6
      https://github.com/bluez/bluez/commit/adcd73901831c0a4e2469ab3705608745af259f6
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-03-11 (Tue, 11 Mar 2025)

  Changed paths:
    M emulator/btdev.c

  Log Message:
  -----------
  btdev: Fix double lookup

This fixes the existing double lookup when calling
num_completed_packets but passing the conn->handle instead of passing
the conn pointer directly since num_completed_packets would then attempt
to do another lookup by handle to resolve the conn pointer again.


Compare: https://github.com/bluez/bluez/compare/95055def8cd2...adcd73901831

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
