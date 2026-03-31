Received: from out-8.smtp.github.com (out-8.smtp.github.com [192.30.252.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA92B31714F
	for <linux-bluetooth@vger.kernel.org>; Tue, 31 Mar 2026 16:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774975537; cv=none; b=CAY5t/otAPIyTQskG2XW6v1YMMJvv2H7XORUh9J9hxrrMBLzZHLMCbBPJqkQKIutE2w+7wU1auDS/hHb8cItLtfMiLTHsJJ99G7Gff+YOLHxeq/jVveDV0IhTSQ3OvCkous86ml5P8YhshxWY9r2Vmxrr0dU4uuGhRhwmDXEWt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774975537; c=relaxed/simple;
	bh=S88ouaYVhgn59I6EJlihxI3wXIA7MBf8s2+dWLbaWYc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=bMqJzp74DGn33wOOJr70J2qatOqWqW8qBOyShLOKHzrM2vyi/s1af8DUovLfCnA6b59f1c9oi/aLOa6BliULs+TwdqQYvOzHk/2zoshfXBSM2WnqA+CIzrb7oO5v4gAhIib9rTeLj5f2NDOVYF5CgtA3mmsGSvE4goW4JOO9GOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=QOP6M+Pg; arc=none smtp.client-ip=192.30.252.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="QOP6M+Pg"
Received: from github.com (hubbernetes-node-2686e31.va3-iad.github.net [10.48.164.56])
	by smtp.github.com (Postfix) with ESMTPA id D6DE690107F
	for <linux-bluetooth@vger.kernel.org>; Tue, 31 Mar 2026 09:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1774975535;
	bh=gFaGF0Co8OV/DNAAhjwXWOOWnrAPzm7qdKc8khSzxtU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=QOP6M+PgI8QViEntpUZ2IOxunqBFeKXDTNlq5hmByzvUxD0UASXklfp5/ay4pl1xJ
	 zOrRgxXLgozOb3404d7WcGyROLgdm6PO13+oAdkjaiBz9s9iWfshqvfv4g8JSEXjqw
	 gqbUGhAx8YcVKr6N/nSW5/4noMjTK8vFHR8HAa7U=
Date: Tue, 31 Mar 2026 09:45:34 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1074168/2a934d-000000@github.com>
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

  Branch: refs/heads/1074168
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
