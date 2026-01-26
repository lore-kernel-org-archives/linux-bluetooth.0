Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777AC10F2
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jan 2026 23:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769468495; cv=none; b=O/W1+wecPGr+bBKH8qb3H0bCYE7uSfEg+fJwim23D3IacURHIaFgWWC8gLOEl38Aa1/f6uT9Q4xAeUkiCAY+rDLn8Y43i+tXuZZ71HPEqBJLXVtmHm74jx0vkspXmMMWsr6pwk3dpS62Jy0qOkyz4qeOXhw1lsfMHl0r+UC3fOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769468495; c=relaxed/simple;
	bh=meHGMxcLnwAj1zCIII1cUuunG+j98YBor29HTNmG/Kk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=oTYncuxiV2fJqONkk14eh/fNO3xvFzU/OEQnADqOophWrbcHmUPkrhsAzPO72IU42fFGx9irIfbOxtzAXa69C3+wDzAfTYN2GHOgr71gQbICeEMXQ8zc/czSmBqLGtQtqnJ8Uq+wVraAcnSzO7WIFsnXrF6XaL+rvTOH6d51HjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=e2s/SUCv; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="e2s/SUCv"
Received: from github.com (hubbernetes-node-e3b4f80.ash1-iad.github.net [10.56.208.63])
	by smtp.github.com (Postfix) with ESMTPA id 820FE920968
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jan 2026 15:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1769468493;
	bh=xxz4UoKFaESl0/l22t1rVjSxiNVINOEpGQ4sDGjrN5Y=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=e2s/SUCvEFcXv1fJX1mBgrT97RqjkkE5/mwqnBoCO2uh2QqWUNpM/hKuBHR70brz7
	 U2w2WWfxijhzbxy6qJpPD+B7bqw/69kzlQgcO72I/uButDj5P1zSkJV/HkrD9956bc
	 49zOgliTTKDVqZFJG4NAFE6NIBzehTcD3xwekCiQ=
Date: Mon, 26 Jan 2026 15:01:33 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1046379/f10d3a-000000@github.com>
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

  Branch: refs/heads/1046379
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
