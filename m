Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652D92B9BA
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Feb 2026 20:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771012834; cv=none; b=gWsv9aKx2GwK7jDOHIKBijflcl6DHokRJXnxyTQdNLeyuDRGhjGMY79kAV40e8AUMx3tElYg9+7Dys4Vl54Qa7Pip8olAVFexuWPRaWoe9psBEsffTwrezRyLNRu4gcx5uxn3PaJTzz5GC1HvUjqbhEuFY7IJIK8X7UcqyY9w90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771012834; c=relaxed/simple;
	bh=a/C0mrKzXCkVc0yWaKqGruyUk262eGJdkQEYYyPTv4Q=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=CUkXEHdbj4xgwIf1kdLjFd/hI4ijNkMmEiDVg/zB4Y0PToGfGZdl/Y+GQGebQtzLJDHhH+z5XDVugDU/F8iubrOSDNbmXi+3PR72utL0V36dueYUfg2JPh97jrkOf7GLT35Jnq/2+uPaNci5Tq7jUvT+jnEFipVnmOOi8fZBkuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=m6PDe5z9; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="m6PDe5z9"
Received: from github.com (hubbernetes-node-7103907.ac4-iad.github.net [10.52.179.62])
	by smtp.github.com (Postfix) with ESMTPA id BA2F4641225
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Feb 2026 12:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1771012832;
	bh=NqZiWonRq5Rqm2YFW9PaA5X7LSxr+pSkQhC0evYpiV4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=m6PDe5z9oIuGbFtZ2VlXen0+1quJ5M4+KwKCp8O8YKMm7jvBODyXLI7WU9+Hkx2yA
	 j5K8/pLOPI3fci2nul/O4n2oTzyIVU7PPRYleY1SOhzMvr7fGk+R2bu718JPP9H78Q
	 wpIp8dRuQfh9/PmjUHxnzEEDSkxAw7dGhU4zZeqg=
Date: Fri, 13 Feb 2026 12:00:32 -0800
From: Copilot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/copilot/fix-lenovo-keyboard-input/e5ff33-418072@github.com>
Subject: [bluez/bluez] 418072: Add investigation summary with root cause and
 fix ...
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

  Branch: refs/heads/copilot/fix-lenovo-keyboard-input
  Home:   https://github.com/bluez/bluez
  Commit: 41807248a255542d2e3bb2f2efa3e355c2606d03
      https://github.com/bluez/bluez/commit/41807248a255542d2e3bb2f2efa3e355c2606d03
  Author: copilot-swe-agent[bot] <198982749+Copilot@users.noreply.github.com>
  Date:   2026-02-13 (Fri, 13 Feb 2026)

  Changed paths:
    A SUMMARY.md

  Log Message:
  -----------
  Add investigation summary with root cause and fix recommendations

Co-authored-by: Vudentz <2156363+Vudentz@users.noreply.github.com>



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
