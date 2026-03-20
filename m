Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149E72C21E6
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Mar 2026 04:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773979431; cv=none; b=Rh7Y0N0qDcVHjMFfFqFGe1w700uwFrrz+c7JAd+Vd6y4CAvAR+eQSe3mLbCnZOxACYV5jOpAlTBERF4NDlXVhRg6UT3R0mwUJnIW3C4oSIkj8Ur9UZFHYMYceXDbkUFJv9vEF+jb/Y0yxSwjqjstgTKnEPNfvxk0k73P9Td5d9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773979431; c=relaxed/simple;
	bh=QEOUrtGOgielJ+al5hzElUYi8apIA78tecjlRj9WBE8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=sDTxeqDRvJhzeOegiHkMMmnbqMN+HGFb3B4PCBjCUzX2/1zaRX0dsoHTaYigspQ6mRGkz0z2K5kpFks23Q8KauciOg9sf7BStibYVkSzdUinJSnQkDDwn+zvgfk7hRvPBCC/yxHc+UkEgUCPIzNuSAK3aK4gYfK4wxuet/v1Ekc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=R4r9Oonh; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="R4r9Oonh"
Received: from github.com (hubbernetes-node-d2643a4.ash1-iad.github.net [10.56.192.55])
	by smtp.github.com (Postfix) with ESMTPA id 39CA0920BD1
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 21:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1773979429;
	bh=zIM8tB0ypOhRQbJUxZ4FGMEUr+tPj9m05vPkCrDfqU4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=R4r9Oonh41/+c9Bgmy/aOaKipNURn2uYIkTCFWBUy85MA1gx5LneF9GiclOaUoMSG
	 Al/04XF3riG5vZO95D9885fzart6aUxWeYGOOU1UeNzVJ7PzcMqZMrWWqqamaWTZD7
	 /2nOzk8Oi4XGWg8mS1djMMpwNNjuCl3jSYhI8MjE=
Date: Thu, 19 Mar 2026 21:03:49 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1055060/03b822-000000@github.com>
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

  Branch: refs/heads/1055060
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
