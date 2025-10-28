Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2592922A7E4
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Oct 2025 14:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761663390; cv=none; b=iivxY5HwyFBZl5FhcFXu1cMoRvAEXptPvbXsOPP6O4qfGpJpKCve+EPunKKonkAOucAj0LTr5p+JXOT/rCmEp6jedvPipOKDjm93e+VISenc4JG3f40s2j/waB3Ecjmw+N7K+3sLH42vhCbONVuHf+R+XODyuYaccfmtOMI8sbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761663390; c=relaxed/simple;
	bh=kkDtA51rHbXug90ZH2+7/3xBAuNVcMtsDPeA+69/b0c=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Ef7SVAYAWF5QEADq1FR4+msA7t8u2F9kJ7X8qZ07ECOd/DIGkbkf579jxkI9ROZUrw38Ur4U+DON5i3JdTHlzGAM/K7QDo1sLUrOOT55ZkSGnXOkOWW7lPNYo0f1Tav6C5Gxd7JlbXHmtxoGFxpa9O21R943MZ/47hAogJqRwXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=bbScVKTP; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="bbScVKTP"
Received: from github.com (hubbernetes-node-c11702f.ac4-iad.github.net [10.52.174.55])
	by smtp.github.com (Postfix) with ESMTPA id 3591C640BC6
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Oct 2025 07:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1761663388;
	bh=ddRAviky60kXl/2N5P2/0aCr4vnOnyqGUmW2Gsm1PWI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=bbScVKTPWw8dP9AowzwLWPSzqd3zNHSo63dmiaAdHV44llmuAk5qBw58s81JhRuFN
	 Sp3ebmubdF+3KHFE+DHySS+v0DRWVxG6iS8jBorT6G/JsOTpeninbhthPdry0W6Rrc
	 YY9YAw97KRK8O+18Zs5nZz+IebxNVB6WWeSDMzfI=
Date: Tue, 28 Oct 2025 07:56:28 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1016339/27acde-000000@github.com>
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

  Branch: refs/heads/1016339
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
