Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372CD9475
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Jul 2025 13:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753451478; cv=none; b=tv+QB1dI84nXlOkGlA94S5qCddAMtnp5vl7zo19cDc7h6hHV4WY+TKFj+EaqqJrly5qB2X6lyKSEZhI+vzTY+RwFvEq1S5jX1ilgaX6+M6Bfi0orkfepJGfsGgcDolqtEK8TpD2OumJFA5rFqzRBX/ryDwPsL8QBXyP5YDyVvFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753451478; c=relaxed/simple;
	bh=IwhuD78HfuA+AeULQFkzEAe0EUa+7QeigMbBRQr9AAM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=MNrCKNAMNj5k2yqJEAmufRZgDyr7MrNplavxrXunGDNYIEiiVgxrG/MCfirEwIUPG5sDnFVlG08ttsKwIFU41hK8Adf2sZnGUK+1C3JPeP63Pq2Hfzl3+8UHcndNe8lEg827KU4LMuvVNF5z7tLz4zaDoX2p2SpJZYvEM38wKbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=DEa6x6m/; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="DEa6x6m/"
Received: from github.com (hubbernetes-node-e5d6c39.ash1-iad.github.net [10.56.167.42])
	by smtp.github.com (Postfix) with ESMTPA id 2657E141170
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Jul 2025 06:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1753451476;
	bh=GarM+TthrWYIt138x15exgfcd2PerG6aAUAr5bbVNMk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=DEa6x6m/zpL1QUjS4v4uupA64K61akNuWPFZfj7TBdbhM8GUq9QjmIGabT3F3rwwB
	 QncLVC84Gmfu31b4xRDzvJqVWApiUDcfoQu/sb9Yqk7Gs+KEYMx9N6w6vbQfnjMzad
	 iYLPcehGfVmu6r285xkVmcBQ+vjNpNWC3po10gak=
Date: Fri, 25 Jul 2025 06:51:16 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/985699/03b766-000000@github.com>
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

  Branch: refs/heads/985699
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
