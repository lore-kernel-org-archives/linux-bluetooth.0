Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08A13EE1D4
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 23:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791932755; cv=none; b=cnlokY1LmwTKFHJqXyfBaF2ZyJW+hvfLDHExRPOln9icXR4PZQRKM1DalZudiEHxssFLb9ZWP0cVIS5cMP+QWAcHu8kGWgtU5RIOZTcC8va1MZ+0ALMXC16j7MySXGt9yYOoFlrypLRL5BImrwpP9BGLF/j7rQmWCq6cJrcqNpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791932755; c=relaxed/simple;
	bh=1+L67u+mJU9T7a3XVuzd2AdKpLTuNVOk/zdKiIc7P8E=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=t68hqJourG5gmWhi+3ikTbpu6NJ8gPAW1zRQiJ2QDgLw3DJyqGkHPpXW1g514qfycBI/Dn0jNYZ0g9e6ai914n2B6kPLSrGGrKBqYHikrrHVC9H3L3iwO36unQN0R5X4aA2sncHXsNpDq2DDVoFRlDoUatPcakKkLU5XlgE3COQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=OB6CY0IY; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="OB6CY0IY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1791932753;
	bh=Q2+iSrX16ugIR3mK4wliW3ZeOIUcrOl9DWbE/b1cVdQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=OB6CY0IY+RPhoPJdDoGS1hxnwrTMfKlTpOz4/27TTz5I4weOUeQjdhzPFRaqnof1U
	 a5Vq8FbsxG2ksACEBfLrKUIIpU6OqJsJ2xBl5mlhrh3tGxwqwt/5RwqxfkMpGdOjI5
	 lndxTH65F3Btotr++tmSMNVPuw/v61C4UrzFu5UXeGDFjlspQ8/yTHrI2PBzRVg4vE
	 bUSp/sWVnpDkobqMdx2HnK66UoHDsBzYFUXZXo8BIThX3W3XOaE9n34IKow6Re1JXa
	 gA007xOak6vnrYOu9mlxomefSkt+nk5+YKu6urDFsCiR3IJ+TZaBkv12RU1N/gciVg
	 yKnwKZgD81UfA==
Received: from github.com (hubbernetes-node-c2b8510.ash1-iad.github.net [10.56.131.81])
	by smtp.github.com (Postfix) with ESMTPA id B4EF3360799
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 16:05:53 -0700 (PDT)
Date: Tue, 13 Oct 2026 16:05:53 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1184363/e04c6b-000000@github.com>
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

  Branch: refs/heads/1184363
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
