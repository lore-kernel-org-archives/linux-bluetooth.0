Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846071643B
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Feb 2026 20:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771012870; cv=none; b=uw5SJG8eyTP6PEg0jx6Rid2GbcfVwdP9zKyWLvMfO0L7Uk9PVqb5wEQTn/is34o0E/DOTbwyBKLqtUEMNTKjC9IuNVCsSQiFrzd/rOfglz9JdWic8kQS3lLS+ZYkRK+LETlMqZRGsW1ewatyuUmu7YF8EoiZlscsdr8SH6D3lHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771012870; c=relaxed/simple;
	bh=MXTx1pYftKNUMuGLgQLPL4fbPDqqag/sNc+B2m3ecWI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=YI2/y5jEKxsjpIFZUnUxMLO5OAhRb1i1W4PyNdXgAIY9uLzMU0ww4+QqNv76TTo3zWX15x264RzjKya7dEm+RqjNz1tDLyMgJl5JrlehmtkMvxK0kUC28xUEybjhiYFvIVUIcC4IBzqFNHNmT4hxdQQReRatoCtm3xzMUt3fUu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=bEAm9fmn; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="bEAm9fmn"
Received: from github.com (hubbernetes-node-8b6c621.ash1-iad.github.net [10.56.201.15])
	by smtp.github.com (Postfix) with ESMTPA id BE88E601090
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Feb 2026 12:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1771012868;
	bh=tlNP7o6NyqlflafHOtqdADaBTTildBg7SuslKq96uPs=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=bEAm9fmnNURtoS4q8ZTFJKXFxWt/zYlrLL4ZbtDESgSm3txLvlDNBB04z0F2XM569
	 DFEtb7UED1ZbeXi9QOru/FgOl3u25F3IjDCb9b3x+e0V3SXQks3r3Rp/1FafkfoS+b
	 VikTIFjhk1q1+Ei48jHg8J9xOXL3coxcMBcjjakQ=
Date: Fri, 13 Feb 2026 12:01:08 -0800
From: Copilot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/copilot/fix-lenovo-keyboard-input/418072-df1726@github.com>
Subject: [bluez/bluez] df1726: Add README for analysis documentation
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
  Commit: df1726a2662b6237eacbaae33e4d3493d8026b04
      https://github.com/bluez/bluez/commit/df1726a2662b6237eacbaae33e4d3493d8026b04
  Author: copilot-swe-agent[bot] <198982749+Copilot@users.noreply.github.com>
  Date:   2026-02-13 (Fri, 13 Feb 2026)

  Changed paths:
    A README-ANALYSIS.md

  Log Message:
  -----------
  Add README for analysis documentation

Co-authored-by: Vudentz <2156363+Vudentz@users.noreply.github.com>



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
