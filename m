Received: from out-39.smtp.github.com (out-39.smtp.github.com [192.30.252.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525253859E2
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 04:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791864041; cv=none; b=YmPsuP5eG0zbDhQrbSyfPuilaL8L3OfCYOaf95wTtWwyF+9ouVx9vDhpnG/zQ4mxogQ8avc9gXQ1a9xXCi8xVR+CCFqdearqFGe2AQLDlqjBzJ9qed48eiVh5ZLagU8Ok+Og3RltzArVT77G2PXTUbr0Snn9KvB2RALavAzQJ8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791864041; c=relaxed/simple;
	bh=wfm+aY9b0/a8KwIVpKZf4izIIXP03niwmWGjEsYBEgA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=T2loc+LGbVEwo4rAwrlth6GhfjI/NWzNz5V9IaowS5M9pwkG5Vt6vMd9AnONW2ZquHghxZfnnvbrrJBXSVGOn8SGj+XnX8syLXgLAV7mOfh7q1ck6JkviiGDv4Njn8mGzn6gBGI08mVuE3V7pu1z7PMSfAmrfjRFvp67604+adE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=J53PtrH1; arc=none smtp.client-ip=192.30.252.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="J53PtrH1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1791864039;
	bh=ag7y4HfoGC39qElmJBEcd9WePZd/4S+ZlCTIYdmKThU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=J53PtrH1q2Ee7sfHOQtjdGwnkJsaoZ8guHkllptWqhGrn7X/I++ALo5enA8rAaquJ
	 HNGGp6+QkGaAGzoPFXyptPboo+Bx2h34v05Vnhn5yIAUJRSRD36Qlr0WoXZFoA72Nb
	 0DLv4/BIy6crO19fSJyX8xoh//LjkvANxmTwf3KOlNAWWd41ZEmf57+b1k/KXJePgU
	 4gtE/06Q+05gYa5yaJr9CKOW+3+Vfd5C34uDfi3q7DFe6yuPcW4A2678nN5d0KBgvH
	 8K+2glIBT89T9Z09mfSsEutPRx9R8MWjsbLockNPjPKmOwu849hDtRjsVrhPcoSt0m
	 HSxMIGLVLA8Aw==
Received: from github.com (hubbernetes-node-73301dc.ash1-iad.github.net [10.56.143.32])
	by smtp.github.com (Postfix) with ESMTPA id 87D63920989
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2026 21:00:39 -0700 (PDT)
Date: Mon, 12 Oct 2026 21:00:39 -0700
From: cochcoder <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1184360/000000-9bfa8e@github.com>
Subject: [bluez/bluez] 9bfa8e: asha: allow LE 2M PHY on the audio channel
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

  Branch: refs/heads/1184360
  Home:   https://github.com/bluez/bluez
  Commit: 9bfa8eb7f314680d8e6ef326f41ecf6d4a9eeb54
      https://github.com/bluez/bluez/commit/9bfa8eb7f314680d8e6ef326f41ecf6d4a9eeb54
  Author: Kyle Pepper <cochcoder@proton.me>
  Date:   2026-10-13 (Tue, 13 Oct 2026)

  Changed paths:
    M .gitignore
    M Makefile.am
    M profiles/audio/asha.c
    A unit/test-asha-phy.c

  Log Message:
  -----------
  asha: allow LE 2M PHY on the audio channel

Allow LE 2M on the CoC socket to increase available throughput for
capable peers. Retain LE 1M fallback and treat BT_PHY as best effort
for older kernels.

Test the PHY mask and continued startup when the preference is rejected.

Assisted-by: OpenCode:gpt-6.1-sol



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
