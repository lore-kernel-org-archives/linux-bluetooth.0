Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF91308F3E
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2026 19:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776193985; cv=none; b=NebvB3/r9VTLDTMvHQP9hYTi5e7GQkULcinr5rZ6zQmuqrGhJigyFzgJwB+5dOEjMy7T5wZ3oIa8w0xqaDd+ldD/vhklJ7V8lFEeT/kWnz6eGTnl+DK9PL55zPcxwTJRel+PLRt1AXtIqtmaMw3uhvfSuKccLn5/tgTfdArIsN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776193985; c=relaxed/simple;
	bh=0cLLTx0QavASC4O4NViN2MFvCES3Vi/qzSv+4u/+PmE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=rAldpj+yUVFr4sHDqRTUdycbRkF9W6LsOe13RlHtodxMKlgAYbxxkU4VTLeZsr7rqrsPOP+Cbxe0pp08Zr3WAgKuYqBrP+SemveejVIgzPnsYrsdhmTU6fs1hgZFn7dLCZlvklLrueFxILKJi+k6EHS0BVTkI9SfsBjkR/ayBjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=cGWfSbSW; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="cGWfSbSW"
Received: from github.com (hubbernetes-node-37d7efd.ash1-iad.github.net [10.56.158.30])
	by smtp.github.com (Postfix) with ESMTPA id AC30E141054
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2026 12:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1776193983;
	bh=GpT0VQFend6PS4vSB1P03aMFO4HuhGpwJPU/6nBv0lE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=cGWfSbSWATHzWY87hbq72IDTey5w768zZ0lmmG239OGjBxO4vgZKJAMp2dZ/DzOrq
	 n43/WNqBQ0N/GBs4eBa3/2AKGKACvuit6ZUb0e3S+Tp8Bb0dut/M5nmWi9fOvw2Dnn
	 Lb6aRdG4x3yg/M4fmy1duRVuFMqpVOdGSzbvmqSk=
Date: Tue, 14 Apr 2026 12:13:03 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/d6171b-b3e1ac@github.com>
Subject: [bluez/bluez] b3e1ac: workflow/ci: Add checks:write permission and
 expli...
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
  Commit: b3e1acdf9cd084c265fe64116af6f96f96c70d37
      https://github.com/bluez/bluez/commit/b3e1acdf9cd084c265fe64116af6f96f96c70d37
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-04-14 (Tue, 14 Apr 2026)

  Changed paths:
    M .github/workflows/ci.yml

  Log Message:
  -----------
  workflow/ci: Add checks:write permission and explicit reopened trigger

The CI action now creates individual GitHub Check Runs per test, which
requires 'checks: write' permission on the GITHUB_TOKEN. Also make the
pull_request trigger types explicit to include 'reopened', allowing CI
to be retriggered by closing and reopening a PR.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
