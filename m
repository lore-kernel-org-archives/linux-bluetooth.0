Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88621A3169
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 May 2025 20:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746477867; cv=none; b=mdlMOsMujVDuPEVw2QTMJPmbsEDK//9Kyv8a0ua4lMNkxgHuI/QLjBQcgYc653fP3mfAgrZg6cOJLXVLKe8PEAS9v9V/XatEsnyh2yU7gRd0XCCAS21ujsoGCXUD9b5vvoiVXd19HqjT077mJXV/alKkOJgQ1IuIjezyThIhQ3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746477867; c=relaxed/simple;
	bh=tg/yLeA5BbgqRw2nmJEx5oeSxA7CV1NvzSwD+Kq8IOA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=chFcbTKVDsejOO8eXSNqbY+tcpK7/zyGOxeRUeRKiEIqZqjJ16S6Db9yJXFJlGCU14aVLtEK9HL3LDxzW1+TolSPy5n+2EeH+yjeZu4bfcPczKfq2JD+EKnpxdQae4s1dQRFSWWMujRmY2ryNcAQiiH/VR2aYH155uQ/HnOBEDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=M9k4pnRW; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="M9k4pnRW"
Received: from github.com (hubbernetes-node-55ce082.ac4-iad.github.net [10.52.153.38])
	by smtp.github.com (Postfix) with ESMTPA id 9E1C220928
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 May 2025 13:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1746477864;
	bh=bUuDKcvWcHV87IGpB8KI56m5/xkG3XTb6J12djXJr90=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=M9k4pnRWVN+CITkIBUwoJrcbszcjr2wy55ZTWnVyBKmB3iIWPDIVgdBdP6qFLGImX
	 HK0kAAQnpq8Gc1sfzcYRFmiDc1NPQjK1HBB/S1CVEl1OjB3hq0GApw6x46FukUXfXU
	 FuaHiwwvPLZ/v8YX9ywTHRIBezVZg6B07vHYJW3M=
Date: Mon, 05 May 2025 13:44:24 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/959622/dcb585-000000@github.com>
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

  Branch: refs/heads/959622
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
