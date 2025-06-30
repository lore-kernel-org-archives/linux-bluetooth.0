Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFD328C031
	for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jun 2025 14:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751295405; cv=none; b=cSLMN6jMtMDHwhOaNFFU3f1klMXTwtwr7XpzKCWK7Ywv0DzxRTWjvt6eE30iABiMVty1gjAPy9Aq8pe2lxSMvQTv/99IRsEkOlc000tioqgEsGHmdvJ8HH2g4Kut8SW5CFh9EQkXCJ5FGFSmLA1MlKJ7AIOw9TEkI1tOHOL+gFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751295405; c=relaxed/simple;
	bh=+lp8RVq+29bO1C3RtYQYwRG06CcrpdFON55lfiSCF+c=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=TFIuEqjQoOypSUMpTXzxLMBdXrLPFw3w3QUaMfrpjihmlMVr94yqa1Vbfe191rX9J3na5CRGTQOAS27ZyBdtps99jppJsKhgNb3fBr+r32l3SgbhsnQ9pKTWeQvLzT7oECuQluEnzgEgfDlbhF961PzhLU7MiHZQFwj5AqQb+Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=J8Ufn8UQ; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="J8Ufn8UQ"
Received: from github.com (hubbernetes-node-652fc07.ac4-iad.github.net [10.52.207.44])
	by smtp.github.com (Postfix) with ESMTPA id E787E7005D3
	for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jun 2025 07:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1751295402;
	bh=lIFUT29QGGECG7nCzcagR237loG+1WspX/EeBIEzsco=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=J8Ufn8UQKReWDujBIOEkKquYu16e8uAXBe+XX+6j/MuDG3qcqIAx4F23TM2GM+jOr
	 bQWwiCRSxNkYgwE2L/WEDXjuIOlLc3ZrTMfXtDv45XqzcR8dtSF56qkPeg/KW2BJnP
	 1OaF/5EKPtJnHCJfgEPpGIBT5eBAnW52xDLwYSdA=
Date: Mon, 30 Jun 2025 07:56:42 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/975818/c9acde-000000@github.com>
Subject: [bluez/bluez]
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

  Branch: refs/heads/975818
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
