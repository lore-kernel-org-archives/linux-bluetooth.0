Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF06479877
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2026 21:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789593911; cv=none; b=H75KYsaCTAyHHQ6EuhQdTs40Uaih9V97VwiAPhjKJpiG16A7Vh2ahu4bllkz2VkxfuAe7uqFx0i9SvU5QkEYHV+nhxCSFjhAV3TiRAoArfGXyvaRuQIYTBrUNk7IL2M1bKiTTqd//w4Tjjp/FcGQ6ZJUlk4z+04sbGI0pnNc4gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789593911; c=relaxed/simple;
	bh=2+z16SYQvq4CGZJmlXylFRTeSrT9RzaWsdveRcf7aDM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=mm/FrJSChN/lwAaIUoPQJ+s+acLsRhgMTVrmj5hGhjDHJNhDTEbJP6h4f6oqNFKM/8YmaTpviHVbCrQP3g5ZUdEvNro0km1neBobRP0AxWl57jd4oAUhcDquuZ15ee8eOyuamDlLcSmhnplaTzf2L0HEQgBKEwoqQzFhgL/ubeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=YvrNdOlL; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="YvrNdOlL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1789593896;
	bh=76mHmbsXdFrrpthDqRB10f/JOzpQ768XnijFdHcceSY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=YvrNdOlLrRTTp61iR1xUGU8t9Zb7E0ywOZGl7aHHCxcEImSAwywPzCAwVul+8V780
	 rS1Qo5uXt5H5k3a+hDlaTZmOL0/029u3bJKesxuxY2eIpMpusRjgJ290xOOl5O9MRd
	 A6RCAcn3lx2foDM0OYo4L33uk6YDp9A9fWXX7Zsc=
Received: from github.com (hubbernetes-node-ecd1cc4.ac4-iad.github.net [10.52.178.40])
	by smtp.github.com (Postfix) with ESMTPA id 2B7A8A0A5B
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2026 14:24:56 -0700 (PDT)
Date: Wed, 16 Sep 2026 14:24:56 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1165938/d6364a-000000@github.com>
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

  Branch: refs/heads/1165938
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
