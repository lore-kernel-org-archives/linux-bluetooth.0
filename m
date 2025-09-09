Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CAE3002C1
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Sep 2025 20:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757451056; cv=none; b=tTaaUoiuuScUoq5y1FH+qZLY9/ZjjEJ+Y0WNeKRNLdUhCds64FBeIABE53L9MAxjkHqlTlKQrQQEu8MoTJHhd7IxXYCZ1jKaBx+fsGyWzwMR4CiuE1GUEIwXgQ6hxNgRb4bFruN8qwYFAUIDW+c9WsQqakgYCmdP5xVyP4T0JFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757451056; c=relaxed/simple;
	bh=YoQJTHoVRDVWN4a6xtKSH+oBJO4mO1QeyDFeq9NDnhY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=jolu11EXTehRBcUxSx+UUU+crG9DB4ysoFvbIEysQOnDwzn0yZNgM+18sc3WP+N0VeTvzAL6e38K7rFnJJm/+vRdz0nZNFjU3hFE/2cX1s5lL1TDENM403h86TYJs1mjVzqkULz1jWFqPxegePyTAeDVsZGoTpm7usWOUt8lYAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=K8T+VcFL; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="K8T+VcFL"
Received: from github.com (hubbernetes-node-b0b59b4.va3-iad.github.net [10.48.132.44])
	by smtp.github.com (Postfix) with ESMTPA id 0B9E18C09E5
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Sep 2025 13:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1757451054;
	bh=p+CCbUUpdKESuKDbx8niZb25FIyCHv2AegZlhnH9Bks=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=K8T+VcFLhe8Y/45EUrOqAkn4mA6w2QLGuplDtow/tRYAKxMlHby+pTUsd0XguxdZn
	 X6f7jcayNeEpwo+J4vOueOVK05CrieVo3TGHfgvRRotx8YzJN1pMDRZQyVJpvH0nTa
	 ms9S3J1njWOwOLUXYFbumo2BnmhzPgj05FPJ3icw=
Date: Tue, 09 Sep 2025 13:50:54 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1000203/be5fb9-000000@github.com>
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

  Branch: refs/heads/1000203
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
