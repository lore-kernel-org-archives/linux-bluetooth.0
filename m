Received: from out-31.smtp.github.com (out-31.smtp.github.com [192.30.252.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851E83A6B65
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jun 2026 06:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780381134; cv=none; b=Q5H9+2IeQ1h85PngcY9bLiidZwmpzpM9tK/3D0sHgs+2z59JH1uLjEQeMNqO2Loc2bA7DvZYVL2GJTkcHPYi/yfbGYgxXJBOgpVW76aIQa10GXP3gFIW1kL/1dhRlRTZS7qEP0QGA60WKr3QqQADAo0gCj76RwAQVSQ2R41ujOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780381134; c=relaxed/simple;
	bh=XsZDmrY2mBpBbQU15jdRJMIwMTsJ135CwNFDKtFPlBo=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=gnI3lSzkoL9ORo/m+8p7goHlnb6VU6X2Q0qaZKPVHGg+RFi7rJ6fxrKlD0S8a1EHhPBnM1+U6m/5E6EpbAJq+VA7CDpk3AyVvVkDbbR1Ghc/LmrTaanS+6QgRqG9YOciNKYfBWDY+lZ4lIr03z6si5iTbRS3q1tSJ9LX6BPAd9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=DqxIlz4C; arc=none smtp.client-ip=192.30.252.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="DqxIlz4C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1780381132;
	bh=DgGBgpbTUJDYa8eyiEtVbd1oY6HE654lgpQu/GSuv2w=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=DqxIlz4Cm90pDqOMBqDSpHwbGB/EfUKnGxeTxeCeGdO4INsKZJ7sFqJUu8k0wt9mk
	 4SvvGF9ACsEsuPO3t7bKqIUKhW7cOw16Os02TEIN9qPaHIWZQJM3h9uuE+FTMS6sa7
	 Z3p7rxZg+qhmhmdDZo0uXIUQr1RvQTUP0iZeMo7E=
Received: from github.com (hubbernetes-node-2602278.ac4-iad.github.net [10.52.201.74])
	by smtp.github.com (Postfix) with ESMTPA id AAAB2321012
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Jun 2026 23:18:52 -0700 (PDT)
Date: Mon, 01 Jun 2026 23:18:52 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1099144/4756b9-000000@github.com>
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

  Branch: refs/heads/1099144
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
