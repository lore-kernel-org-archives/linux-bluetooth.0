Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E167A6E602
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 May 2024 15:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715958852; cv=none; b=Qdlpk8a8/hLddVn5dOdJhfvIz8QdMsM8LUT4lpKNKwJHmfXDSHhrsIWUlaPYyAVr781GC2dfQvOl+CJNS3n3Jt9T7WZJmEqBi/0afFeS8ZrpriHG16EGnAAfqIkk2lb0wD06yXS4dop8rTGHHmF+fKQjNbRrBZAU46+kycXACgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715958852; c=relaxed/simple;
	bh=YW2l59LHjZjyLIwYy/+ifga/LMLwB2jrtYHkVHmupmY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=E7ryySplO66da5/YtAi6STUZfjZCzx7Lp2xYWlJKu9uO1pIU7tYFuiUUYcjGePqbvyY4K5F21VU/Vie6Uko1jg/AkBRcWcjotndMWnw8d28I4Z9/cFgbCnOwm/75nnZ8CukKnXvn7TCRu6ZQl0FWIHpcmYyMEk7r5l6/J5eFQM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=iSpnIZrG; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="iSpnIZrG"
Received: from github.com (hubbernetes-node-60955da.ac4-iad.github.net [10.52.133.22])
	by smtp.github.com (Postfix) with ESMTPA id E92D55E0FAC
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 May 2024 08:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1715958849;
	bh=x/S3UfQn/x2uUnCVawpEjyUFUSWSdtqsGaFujeNefNE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=iSpnIZrGB+L02EBXejMWcEcbuPsFdqNh98iVA0uxmVsoK5XtesvKkRMpWqn61D7/e
	 5ZScXw6H7gWq4ToR4rV6fR+oHqkBF6s3q/ad3U0DZ/iY0hu45HyySwa4sCqs87rD6q
	 r9oeJahZu8fvIiT9d+tBCbgkBJDmK6arc27YumlE=
Date: Fri, 17 May 2024 08:14:09 -0700
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/f6241a-46c0e3@github.com>
Subject: [bluez/bluez] 46c0e3: obexd: Fix memory leak
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
  Commit: 46c0e376fe134aba1d0876a7a50e524dfdf7175d
      https://github.com/bluez/bluez/commit/46c0e376fe134aba1d0876a7a50e524dfdf7175d
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2024-05-17 (Fri, 17 May 2024)

  Changed paths:
    M obexd/plugins/filesystem.c

  Log Message:
  -----------
  obexd: Fix memory leak

To not leak "buf", we need object->buffer to take ownership of it using
g_string_new_take() (but it's only available in 2.78 and newer), or we
need to actually free "buf".

Error: RESOURCE_LEAK (CWE-772): [#def66] [important]
obexd/plugins/filesystem.c:411:3: alloc_arg: "g_file_get_contents" allocates memory that is stored into "buf".
obexd/plugins/filesystem.c:418:3: noescape: Resource "buf" is not freed or pointed-to in "g_string_new".
obexd/plugins/filesystem.c:440:2: leaked_storage: Variable "buf" going out of scope leaks the storage it points to.
438|			*err = 0;
439|
440|->	return object;
441|
442|   fail:



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
