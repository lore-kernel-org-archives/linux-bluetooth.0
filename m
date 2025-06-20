Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB9223185D
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Jun 2025 20:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750452681; cv=none; b=VkhrNdWhxQr9rJIuK5tF1Mw5DbuhXrKMFTiHOcmdENpI0FHuVTqfur6HnJGX/CxNGRP/Yrl5eqMolhcjQaSaf0n2UxQ9/N6ZLtBf7hWSqBlpQHFLv5eKSJlJqP3bgCsDIv7xlIXEEzF3eqzEzzMnOd5z8m4tMKxq2WUWBZhdMwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750452681; c=relaxed/simple;
	bh=mBE1k8MAQmWZ7deQzdMJGsLJZDR/S0xuGMbmJtOSLBQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=GTlRG2VkpeUbVhsolEGcUk4gAWoM/cEhXKmLM4NbEdY9rQujlnW1DvhBcfDlUAZWh66HoLjsA9/BguMYbE0CmFq4CWFzihx9kZ9XPnMjLTfmFwFP0WiXd2Lebahii6RLNlL52jlBZ2yzzp5IUrCRbQrYsiEhb/KtXeM/MPHFWyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Eijnqofm; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Eijnqofm"
Received: from github.com (hubbernetes-node-89310bd.ac4-iad.github.net [10.52.164.17])
	by smtp.github.com (Postfix) with ESMTPA id 574497004E1
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Jun 2025 13:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1750452679;
	bh=7VdzeSe2kIs44FJyjRwy4E4u/Qu66UTFitPk2shmUlg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Eijnqofm+OlLABcuklILp8KM2vDj0hpgQFfdm0xQlYV6oCNQ9QjlyVoaT1nhErayU
	 pL+Zz0QvRxE+m4dKMzXQDUMOMDvzJYYTvSYKljlNkMas03V8vItmLC4IiJ2tPZ5So8
	 57+MeRD+wtw9OQh/Bs1a34nKPoroLbedaHn3Wrr0=
Date: Fri, 20 Jun 2025 13:51:19 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/974407/000000-e4df1f@github.com>
Subject: [bluez/bluez] e4df1f: bap: don't pass in stream's own metadata to
 enable()
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

  Branch: refs/heads/974407
  Home:   https://github.com/bluez/bluez
  Commit: e4df1f543efa650f842fd89d3a6123428744c2f0
      https://github.com/bluez/bluez/commit/e4df1f543efa650f842fd89d3a6123428744c2f0
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-06-20 (Fri, 20 Jun 2025)

  Changed paths:
    M profiles/audio/transport.c

  Log Message:
  -----------
  bap: don't pass in stream's own metadata to enable()

Stream owned metadata pointers may be invalidated in bt_bap_stream
operations. Just pass in NULL to keep the current value.

Fixes:

ERROR: AddressSanitizer: heap-use-after-free
READ of size 8 at 0x7b86a76f5d18 thread T0
    #0 0x000000836745 in util_iov_dup src/shared/util.c:353
    #1 0x0000008ea96b in bap_stream_metadata src/shared/bap.c:1991
    #2 0x0000008ebfbe in bap_ucast_enable src/shared/bap.c:2072
    #3 0x0000009226e7 in bt_bap_stream_enable src/shared/bap.c:6392
    #4 0x00000044037d in transport_bap_resume profiles/audio/transport.c:1981
freed by thread T0 here:
    #0 0x7f66a92e5bcb in free.part.0 (/lib64/libasan.so.8+0xe5bcb)
    #1 0x000000837002 in util_iov_free src/shared/util.c:392
    #2 0x0000008ea94e in bap_stream_metadata src/shared/bap.c:1990
    #3 0x0000008ebfbe in bap_ucast_enable src/shared/bap.c:2072



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
