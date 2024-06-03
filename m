Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87A612C46F
	for <linux-bluetooth@vger.kernel.org>; Mon,  3 Jun 2024 20:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717445678; cv=none; b=qE9r9UmzOADBmYCY51B69w2c84sGVKd8TU/JTQ02op51onxXNHFR+w2d0P8Qqi5YVP/uV4jB8/Nxok4bwC1ktTG+xROubHA8bXm3d62AlD8xGAeBGHQMsGP5WPeMK9SbMq4dSSy8JPj3xMQwMr/LxAcM89/ZSMCuXMGrOmffRVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717445678; c=relaxed/simple;
	bh=mg01YqRLEng6Ms6jFX9x4SLf+FTWtWNVWRaDXY5TcKw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=kCnPMCV5rsxGLbjbg7Nb5R8rfAWNd5jVcbEI0423A3TtQXeJETeUE+i3fWDMs+ua+7DPJknahQ0/7kjIBa9IePUPH/+5lwWOzhVSEidq7tVM6NdWWsrsoVlRZt63koyugAClCeI1JoLFwhLYezkzBM/H7Sysc3XWyGyYz3ziyk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=QqWr1OYE; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="QqWr1OYE"
Received: from github.com (hubbernetes-node-6538989.va3-iad.github.net [10.48.143.42])
	by smtp.github.com (Postfix) with ESMTPA id 0758DE0921
	for <linux-bluetooth@vger.kernel.org>; Mon,  3 Jun 2024 13:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1717445676;
	bh=/chPynIfbK9uy5SI5HhRe481Tsu9ksLprYIyGUuA/R8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=QqWr1OYEw4p9+lztODU1YdLJhFqT3o+P4Bi/eU0+gIU5HDeCdd79YUPqoaUNLfo1z
	 rIHwo5XE7mwJ6GtD800CJZNz1pRcF0K7D5EsABnxQxROPR9YpeaNnfp3Xj6igNj7l1
	 EqTS0cWfRN/wWu3RcWS4TS8Gb1Pr7Wi0xj58bC9o=
Date: Mon, 03 Jun 2024 13:14:36 -0700
From: silviubarbulescu <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/cc8e6e-60b482@github.com>
Subject: [bluez/bluez] 60b482: Transport: Update bcast sink transport state to
 pe...
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 60b482c3c9baaee92fe34384db5211e7fe951e50
      https://github.com/bluez/bluez/commit/60b482c3c9baaee92fe34384db5211e7fe951e50
  Author: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
  Date:   2024-06-03 (Mon, 03 Jun 2024)

  Changed paths:
    M profiles/audio/transport.c

  Log Message:
  -----------
  Transport: Update bcast sink transport state to pending

Once the broadcast source is detected and a transport is created
for a BIS that has the configuration supported by the broadcast
sink, this transport must be set in the pending state so the
sound server know this transport has data available.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
