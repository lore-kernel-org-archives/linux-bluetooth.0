Received: from out-6.smtp.github.com (out-6.smtp.github.com [192.30.252.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B94A1DF75B
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 May 2026 20:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778273946; cv=none; b=mzgzb5i4HGTVShYZLqzfABpaYtOnK4GKMt52HnHf/pgmTOEZdIBHgAqGjEG1Y8fhJyi0icOcdctpKCzGBoO0xbpnevLecpCFNGZTdmEUMnDeHTehT4m7QFWv1mcRBNl5L4erFN6RE8BeXzNtWNdb7pA8CmmBstSuHTUOD0HLKoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778273946; c=relaxed/simple;
	bh=mlOu3EWsZzVjDKf9FhNm9eOfGPHdMXGS2xdwtvrMUkg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=t4XD5JIUHAqIpBG9ICWleV5Dwr6UREmneD9kXhXYpRkv7f3/g6NqsyA3zmjhKjSyVI/AorXBwWQx0+uE6i6s6Ay7JduKMgKM3wi9TlDnK0MJ0hxo+dc5fCWGxsJmkyYms38Z8zzG6hAjTTEmS+gx7jAA4aUKMKXw61rqzMDpQk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=i7JNeMYL; arc=none smtp.client-ip=192.30.252.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="i7JNeMYL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1778273944;
	bh=T7jGNXbiVKYjPj4oyO0U2prk6rhCPN4LdUS/fZB+WCQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=i7JNeMYLVbZMFVQgjURfyugTIRDps0qQfhdLp71aF9KWOdtxFX09RsFA25UTWQqL+
	 Wroxyf1bz6BfXVJOiK0cntJ6YUNaywxoeQX7UxQTrFGA6i66Tihcyn/eGRCpv+og8w
	 HzaiXGzKnFnAiWR69C+mpPkdGZN9jGOzDrZm6uW4=
Received: from github.com (hubbernetes-node-38bfdea.va3-iad.github.net [10.48.87.33])
	by smtp.github.com (Postfix) with ESMTPA id 43A51781004
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 May 2026 13:59:04 -0700 (PDT)
Date: Fri, 08 May 2026 13:59:04 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1091796/000000-b58ccc@github.com>
Subject: [bluez/bluez] b58ccc: monitor: Fix RAS CS step mode parsing issues
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

  Branch: refs/heads/1091796
  Home:   https://github.com/bluez/bluez
  Commit: b58ccc9678cba3caa765b7b70da0a47fcc8ead91
      https://github.com/bluez/bluez/commit/b58ccc9678cba3caa765b7b70da0a47fcc8ead91
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-05-08 (Fri, 08 May 2026)

  Changed paths:
    M monitor/att.c

  Log Message:
  -----------
  monitor: Fix RAS CS step mode parsing issues

Fix double space typo in print_ranging_steps signature.

Fix ToA_ToD sign extension using proper cast via (uint32_t)(int16_t)
instead of unconditionally OR-ing with 0xFFFF0000 which corrupts
positive values.

Refactor print_step_mode_3 to reuse print_step_mode_1 and
print_step_mode_2 eliminating ~90 lines of duplicated code.

Initialize first_segment to false so the error path via goto done
does not incorrectly print remaining data when the segmentation
header was never parsed.

Improve Mode 0 step data length heuristic with better alignment
check and clearer documentation of the limitation.

Assisted-by: OpenCode:claude-opus-4.6



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
