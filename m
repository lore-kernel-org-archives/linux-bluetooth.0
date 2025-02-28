Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEA726B2B3
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Feb 2025 15:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740757107; cv=none; b=p1rlSYFGsgQxbqKOQklmyyB4ECoSHe8zw1R7c8KB52TPopw644KUSaZadn1/SlloCtT+nvOjTZEo8WiNvoNacZmErRLPgLFFa+AQlW9cIDta2E0WR7zKNZOygQX5UqxIzM5aoey2vH8ha1kvmMnaqHGmDGhOPGjkFhasq0wjv0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740757107; c=relaxed/simple;
	bh=+i1+5MTUV95YWjf7KKUfKfasAbrYjLYR1eiLYkjRBXM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=IzKlOuGYxOxo03fXXNCEcQ7bRd5wvkJN5Lra9a1o5M6BbdUfPwcfKP72QGr3B/bKlMgGZ+oi1caD2P1o6ewzoqGhg4AMrClvr3QdIMrwpNsjdxVOc1hasnhQVc4DfzdiJcE3B0BsbHpRqrnabd69z+8ABV2Q5kmKoczDWf+OPEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=kHiRKwDk; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="kHiRKwDk"
Received: from github.com (hubbernetes-node-7baa3b0.ac4-iad.github.net [10.52.201.58])
	by smtp.github.com (Postfix) with ESMTPA id 075F27005C9
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Feb 2025 07:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1740757105;
	bh=9Co9hpdrI5xq3G0SJadLvm6zUvhPyRfz7zxDLtkrBu4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=kHiRKwDkdRdp1EhSV2T05k5EjO5JxOq9WB+Jv5iZ2pkCwAPBsTEBUAa0Tx2ZPUVWG
	 RPJrnCiNv5JvJL7cR1rL5g8AJaC7sSXakr4c5npfSgBtvL0kwCuPlXEZszFgmFR2ZQ
	 62eLMSNiutpR+wkLbqwFhOV1uHmw96FwHs9HllOI=
Date: Fri, 28 Feb 2025 07:38:25 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/5f901b-8d1c51@github.com>
Subject: [bluez/bluez] 8d1c51: obex: Add null check for data pointer for PCE
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
  Commit: 8d1c5165fcd80cc48fb3b7db7744c708c03ac310
      https://github.com/bluez/bluez/commit/8d1c5165fcd80cc48fb3b7db7744c708c03ac310
  Author: Amisha Jain <quic_amisjain@quicinc.com>
  Date:   2025-02-28 (Fri, 28 Feb 2025)

  Changed paths:
    M obexd/client/pbap.c

  Log Message:
  -----------
  obex: Add null check for data pointer for PCE

Incase of legacy server, when the 'supported fetures bit' attribute
is NULL, Add the check to avoid any invalid memory access.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
