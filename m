Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BD31FA272
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Nov 2025 23:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762297212; cv=none; b=MAU125/io2DOWK/Itj1EBL0gTKI1n6r7X3SzKLOwHbmk+E4vS1MEObMITs1iuuuahsnrL8uOKFdcW/ZSENiRCDHGzi2d6WUWstmk50/inSuGf9ofQnaT7XlbIVnopcVcXtD748oRs+1xq5GyzCN7M4F1pvJGDoP0y4nArZUZO9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762297212; c=relaxed/simple;
	bh=1N+8+R8pWdo3JQVOnnZCQChmzcSD0Ils2nsMRzLeJDM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Io+y6Mx4KFVVhORl5Uv6t4sM61sssIqYe+jaydOYhKaMRCG47GY26J8xVlG5q/45/cu4CpO2e39CIj4keJrwmFL7rZdsYGdfsjT0rtlUstatebJwaLuiAUpEEgJIIbeYx7oAee6NmvI+iSQCbYpViZzSPs38Ek9Zcdk0gM4CdNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Rm1FdMQ1; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Rm1FdMQ1"
Received: from github.com (hubbernetes-node-f9bcf7e.va3-iad.github.net [10.48.166.15])
	by smtp.github.com (Postfix) with ESMTPA id DAAAF4E02B0
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Nov 2025 15:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1762297209;
	bh=ENpnYK/Q0LIzv4CQItVK0leshxH0KjvORsEXkHavSPw=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Rm1FdMQ1GejTvUBrILVrh0HvMg/XNGd5q0tdafHc86YQ9c14jj6Y4creO7ENtn4ci
	 x44989wgScgQeTLQi+CKwDMz1tuss1OG02SEypc2qei526E8vFXuLLKVUeezjds1Yy
	 r0BPLurcvile0wTmhLqNO7RF5DhRojQlhlamKV/k=
Date: Tue, 04 Nov 2025 15:00:09 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1008564/a0dda3-000000@github.com>
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

  Branch: refs/heads/1008564
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
