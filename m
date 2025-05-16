Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDF21A2643
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 May 2025 19:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747425467; cv=none; b=iaCSZLVfaU1B8tyF7dzNVb6SaW0gjM6DfyQtHjKHwGIXE0pnQFXR69S5kqVeFEjG0bns5V1d7Ctf+2ZM4BOW1+fJQq+Il7BDCYKYWcRsr4mYoa+VR2hMWh9tHjPWh5tF5aP4NfqH88kL4X0YYzOdMH5O+4/PVvJ0YVuY84tVkNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747425467; c=relaxed/simple;
	bh=WuUqEWw128Q7Du8ewP2tnocNCwVZhQZTgu5hoiza9nk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=LDFfLtA47YhG0hO95pO34327PjmuBvHNkKwLk7BrEBj7Y7K0Xa6ILJ8afSQ1tBqdDJ8UIkl1Ak2h/I/8lW0TtxMNAQOY+6vvT84pgDLHb7kVnSO0NiF1oAaKmXp9PJ4U/zWbgh7ixyRcEAw7JnGLdydJY4PEtb2UXYrn/UtkF9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=MGQxLWOE; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="MGQxLWOE"
Received: from github.com (hubbernetes-node-741fd13.va3-iad.github.net [10.48.160.18])
	by smtp.github.com (Postfix) with ESMTPA id 5C8F18C0271
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 May 2025 12:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1747425462;
	bh=SmDxKfvjipovr2tNrXENz9m29lzbbkgRLVZS7PRrumo=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=MGQxLWOErbt2+Xi/EGVI5NEsSg8yrNpS/BgWhLrzNSSpLLEba+g38UJhvlQkOihaj
	 jdsWRD0ooTxUlC7R9H2ifmpmA6qrdrz91kwqL69vI7fk9Sa2cXoXjAVasdZGbdHERU
	 2tvLlSBjhbFEvnIgGQUHMltiMrn1Qg8zwN/Wgo8g=
Date: Fri, 16 May 2025 12:57:42 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/963744/ec6a8a-000000@github.com>
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

  Branch: refs/heads/963744
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
