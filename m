Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5B0156880
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 Nov 2024 19:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730489868; cv=none; b=c6g0Nj99U5rIL9VhNUeJgApfaMSyjMLzuFYD2yxWdNU/C5MJkV2SssIPp6K9zaKh5qsfwxto8uvkql7xBNvJgSO6OWm3FiN40cufST7eqphgRiZYywhfSs7pSDzEz7OleWcH346ZJCKXaVzOt4XnDldNIZ+3tjRQHbr/g5re+RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730489868; c=relaxed/simple;
	bh=bqzWMWH7EyXo3QOwrMoasXbUtyD+oEC7VX22IX25eyU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=g+n2paWAtoLv0XyvHac2Z3g7O1vcqW7U28/j6KmTomlrGj/Fkvix9B3sy5Q+3r17etfMr8a/ifVGWm7M35LMe9rjB8TEyFrtlW13ZgLCuJx+XrYjwD7SMzpRZrmxhLrCCz4tFN/8ksPXPFb8Wf6/vDcfmds+9Zod/sCXNm6iWjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=f7Uekr+O; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="f7Uekr+O"
Received: from github.com (hubbernetes-node-741e309.ac4-iad.github.net [10.52.132.30])
	by smtp.github.com (Postfix) with ESMTPA id 761B57013E3
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 Nov 2024 12:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1730489866;
	bh=+FFZoMow4aDoRlXcsvPzuNQQVOtnmF6ms9ZqPmYqBhY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=f7Uekr+OnA/ZXqiww4owB/g7fjk7DNie8lc117ub9eiTvamSiHeXgJtIX476zQkcf
	 2XRwRMzHfhyKNbWcj9NhuXUVYMoi1prprvUxMkCOB069t8Xv9w+iUEudKl/teOTJj4
	 3HGbHqDBbhT4joRz2vbu08SDOyIqK6XpAI4doucI=
Date: Fri, 01 Nov 2024 12:37:46 -0700
From: Marcel Holtmann <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/557366-0845b8@github.com>
Subject: [bluez/bluez] 665af5: build: Add tools/mpris-proxy.service to ignore
 list
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
  Commit: 665af5b7d1255a64ce414ca014e0a739a4849b25
      https://github.com/bluez/bluez/commit/665af5b7d1255a64ce414ca014e0a739a4849b25
  Author: Marcel Holtmann <marcel@holtmann.org>
  Date:   2024-11-01 (Fri, 01 Nov 2024)

  Changed paths:
    M .gitignore

  Log Message:
  -----------
  build: Add tools/mpris-proxy.service to ignore list


  Commit: 0845b8f6ef2ac004b1c953cf4fe4ca3458cd8e36
      https://github.com/bluez/bluez/commit/0845b8f6ef2ac004b1c953cf4fe4ca3458cd8e36
  Author: Marcel Holtmann <marcel@holtmann.org>
  Date:   2024-11-01 (Fri, 01 Nov 2024)

  Changed paths:
    M ChangeLog
    M configure.ac

  Log Message:
  -----------
  Release 5.79


Compare: https://github.com/bluez/bluez/compare/5573661fc2a3...0845b8f6ef2a

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
