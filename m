Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6222426A1A4
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 18:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776362862; cv=none; b=dOn2lAzvIA4zgu3L9xbAFK41q2PWFkbBZGMgGSHR9l9H8q71yJuaSo+psGXVAkVv2c9tNcCw02uR7EbI8WA/ryqULAH/7CcoibP0uqRrAciyJLg0c6I52KQmMv5VrTIK+OnFHf/OzEduzgmfo+/PRyemNAuS5I4VUSNkKIlsgVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776362862; c=relaxed/simple;
	bh=6eB2f8JN6NO3fxpvUQkFWC+lGBf3HLj0o/1YwC7IV3M=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=NTCUiOcjU2Fw3RjgIUiiZue9F62iogOl2dzigdg3HFOs6ziHNfo7hIsMZlfC5x/0vt+gVmnDsZHKj7gRiszL5MyK2Xftbz12DNCTRT5ytTPxJqSgIG4uUqN6GVL9JDFevtKnP4op3FAW6a3Ab+/qEOl25WD+0DLmp9wauuqGOWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=bAIVHilv; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="bAIVHilv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1776362859;
	bh=DQoAP6zDxkoF6AWtTPkcKnjXHB+tKk9HsIG2iTUx/m4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=bAIVHilvk3cgJgsAnqgkWh7oMfgyQkCkorCizUY7txkt8miO82U6XpWckAvB3u3jd
	 0SvObWjt3JBQtAwLq8+439fHUNJZx5DnUJ+AT4UU4nhzlABB2Fj74EgQR2ZqMG1kTD
	 IBNlqTUNbzMHwV6G7XJVAlcmbiChoJUSUfzovHe8=
Received: from github.com (hubbernetes-node-498850a.va3-iad.github.net [10.48.15.69])
	by smtp.github.com (Postfix) with ESMTPA id 95BA08010EF
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 11:07:39 -0700 (PDT)
Date: Thu, 16 Apr 2026 11:07:39 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/150806-ce07e9@github.com>
Subject: [bluez/bluez] b73ba1: github: Add YAML issue template and
 btsnoop-analyz...
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
  Commit: b73ba12b0bd62211609e1f6c94af780950a628ee
      https://github.com/bluez/bluez/commit/b73ba12b0bd62211609e1f6c94af780950a628ee
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-04-16 (Thu, 16 Apr 2026)

  Changed paths:
    R .github/ISSUE_TEMPLATE/issue.md
    A .github/ISSUE_TEMPLATE/issue.yml
    A .github/workflows/btsnoop-analyzer.yml

  Log Message:
  -----------
  github: Add YAML issue template and btsnoop-analyzer workflow

Replace the markdown issue template with a structured YAML form that
includes fields for description, reproduction steps, btmon trace upload,
analysis focus area selection, and privacy consent checkboxes.

Add a btsnoop-analyzer workflow that automatically analyzes btsnoop
traces attached to new issues using Vudentz/btsnoop-analyzer action,
posting results as issue comments.


  Commit: ec6940c1a28413d5b7f52be27216cd1997653ced
      https://github.com/bluez/bluez/commit/ec6940c1a28413d5b7f52be27216cd1997653ced
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-04-16 (Thu, 16 Apr 2026)

  Changed paths:
    M .github/workflows/btsnoop-analyzer.yml

  Log Message:
  -----------
  github: Make result posting robust against action failures

Use always() conditions with file-existence checks so steps 1-4
results are posted even if the btsnoop-analyzer action fails
partway through. The error comment now only fires on actual action
failure (e.g. btmon build error), not LLM errors which are handled
gracefully by the analyzer.


  Commit: ce07e906e49998c32d5a3d3245bc8b1245e3b368
      https://github.com/bluez/bluez/commit/ce07e906e49998c32d5a3d3245bc8b1245e3b368
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-04-16 (Thu, 16 Apr 2026)

  Changed paths:
    A .github/workflows/btsnoop-analyze.yml

  Log Message:
  -----------
  github: Add btsnoop-analyzer slash command workflow

Add caller workflow for the btsnoop-analyzer reusable workflow,
enabling trace analysis from any issue comment.


Compare: https://github.com/bluez/bluez/compare/15080642a414...ce07e906e499

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
