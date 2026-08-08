Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A852F2E401
	for <linux-bluetooth@vger.kernel.org>; Sat,  8 Aug 2026 20:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786219544; cv=none; b=XYb3dCjmHLW22aI8BZ9VAi72QNpmyRHnIY4iBrvK1rzMIGqRYw9PWd6pMGU9gy1VHd6pajGVMo5C+32DAd2TKwpx1GcIkPvnWgzjYqbfVwY06i0jIcyY3RqeSob7k/enXDG51IVUFnRltqOnEqbd+87ImIEx23tYpNBvvXUmOIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786219544; c=relaxed/simple;
	bh=PSZOMK3caoDQdNt/v0QZJgbrcyqYzOtdy4k7S780ZXk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=SqpFfeV24dv6zeEbPU/MLAXnuJYQ2wT3yVKysS3XQKWXG8rpdWe0fw7gyDrLbd32GZ6KnOkspeJKauZYC7bboyEn5h9rNbYFZrsUwIbP0Ku32cQ75Q1KmRsZ/gwc+psu2vvwwBRNDmGbEJjf2OX/KumbNzlBiJjZCZ4/v3SIfmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=SZgCA498; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="SZgCA498"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1786219542;
	bh=o9OuI51TcXzNbzVEDUqqdETlu7dvKZ99F74VluD8Xvk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=SZgCA498c0qw5v+fHDwNkneD9oXcZ7QsdTpqDNuOeLo4W8Fz4gR41jYbgCiU9deeF
	 WXkUiaokcOEuAVgkiE2oEy72SeifN9I54yDVTuGYEhr8YEZ1bipHDM2XtN8CgPkpzv
	 3kRbk/tYfKu8zizcyqzAX8JEueOdDWnosvNQf5pA=
Received: from github.com (hubbernetes-node-f13a5d1.ash1-iad.github.net [10.56.208.39])
	by smtp.github.com (Postfix) with ESMTPA id D00C518035B
	for <linux-bluetooth@vger.kernel.org>; Sat,  8 Aug 2026 13:05:42 -0700 (PDT)
Date: Sat, 08 Aug 2026 13:05:42 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1142763/c92911-000000@github.com>
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

  Branch: refs/heads/1142763
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
