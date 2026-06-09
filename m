Received: from out-5.smtp.github.com (out-5.smtp.github.com [192.30.252.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B99181334
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 22:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781042876; cv=none; b=P5f4nQnJKPd9cqXSPkepkGdmvcU/tZYJu7JoLmlM/2agF9M2P4LbSqSbWz5FChksw/on5syMz4Wai8IKZZg4FiJ6OFkl5bo6N5/2T6vkN4HTGs8b9yuk02ZepVsg21pyoiZO6FpgJUFmjXQmoXPp7VUjlBGSAYH7p4PKSZ3MjWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781042876; c=relaxed/simple;
	bh=n3DxvBPswfTNKKxJmleHD8Sdtfd4ddqBK6cMesZMBRU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=LoHAzclniZUODM24L9w5KsIvaiLEC3YzlmS3fERuYaPxJqtAaqRRWmIeD5/LbBlH009iabJT+D0mbrfJL9+aiaw/feO97cuxap59fQWo572hfTFvcAt0QFGQNh7UiZBmGVMJPDYxdT30HL+BUAaF6PmQh38s+ntzPWBR0mcqc64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=XG7y3ZP+; arc=none smtp.client-ip=192.30.252.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="XG7y3ZP+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1781042874;
	bh=Zc6IVPg6hmg9E5y9FkN1ntQr0qq1B54yT/9w0O0AqBQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=XG7y3ZP+CtXPrmo60+NHS1b3Te/g+7voIAgwe1u/E8lCFJYXuBghkt3hPzfRbHZju
	 Ujm3445drviVnLJeZVny5REpof3uoV+5COM9CnY75cYpc0803ipjor8WhAhKUdNqKb
	 C3rIxCV2jlZ/lhHinn/14jJDzVwBpF4cd+i+XIvc=
Received: from github.com (hubbernetes-node-ca4a8a5.va3-iad.github.net [10.48.12.56])
	by smtp.github.com (Postfix) with ESMTPA id 4804C7802F5
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 15:07:54 -0700 (PDT)
Date: Tue, 09 Jun 2026 15:07:54 -0700
From: =?UTF-8?B?xaBpbW9uIE1pa3VkYQ==?= <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1108824/000000-b854c4@github.com>
Subject: [bluez/bluez] b854c4: shared/bap: Don't link ucast streams before CIS
 ID...
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

  Branch: refs/heads/1108824
  Home:   https://github.com/bluez/bluez
  Commit: b854c4a729f3c8c36f8f90f18e957430bf8acc5c
      https://github.com/bluez/bluez/commit/b854c4a729f3c8c36f8f90f18e957430bf8acc5c
  Author: Simon Mikuda <simon.mikuda@streamunlimited.com>
  Date:   2026-06-09 (Tue, 09 Jun 2026)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Don't link ucast streams before CIS IDs are assigned

bap_ucast_io_link pairs streams whose CIG/CIS IDs match, but the IDs
are unset in Codec Configured state, so a Sink and Source bound for
different CISes get linked. The stray link later propagates a
disconnect to the wrong ASE and breaks Receiver Start Ready.

Skip linking until QoS Configured assigns the IDs.

Fixes PTS test BAP/USR/STR/BV-362-C



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
