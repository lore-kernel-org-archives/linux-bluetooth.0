Received: from out-34.smtp.github.com (out-34.smtp.github.com [192.30.252.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27FC5187DB
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 17:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789753250; cv=none; b=iiv7Pmj7DtJu7vMekUUUf3XkquLsQQZG9ZFFqlTAbOzw8TFRYfyahTAcEDCsStQ/yIMtd75THCPDtUnlhfDpYvNiuJXhyB4g+TgnseE93tj4exygMdC7Y2TvkjWdGIFPflrE76nS2flTz3DiR9ZIYQaBBCYGnVOUC91esjMqsMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789753250; c=relaxed/simple;
	bh=3eB/NDr+GMyluYseoIp13AAjaNv5IexI/4cQxShLg4M=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=AIwJqibcNtOHnLAnycSZMCsowJdVacOiAOpFFa5W/GBhm3sybEXNhxVvlz2JWW/fB0wSSmgTOReV5wJ3snXO8nr7AZTtDP1ZMNfQ/JkXF6LJgzAw5Cv7O1KFXYa28seTQ14p7WXDjtKp2fyK3RRpSED3kN520AEccQVu+T+nIXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=D9AqVur3; arc=none smtp.client-ip=192.30.252.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="D9AqVur3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1789753243;
	bh=QBRkdSuLRrykAVY4r6Mx6SlhB35UNRUBVxxVFtRR0TE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=D9AqVur3OSrd2yGAW7+HeeqR+x8Ru6rYQd4uWWf/YMR3OBVv42WCFNTu8WFraaVsr
	 7Yse1IPcplICgyH6DPLEW5LrGJo5ulNrzs1EKO6bGnvHV1cP0ps7UFCjxH+b7Jog6s
	 tpBVZMBorxlUuoSUs5EJ4rvcyuEmevHYxQYjg0Jo=
Received: from github.com (hubbernetes-node-0601866.ac4-iad.github.net [10.52.130.18])
	by smtp.github.com (Postfix) with ESMTPA id 1D5137409A0
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 10:40:43 -0700 (PDT)
Date: Fri, 18 Sep 2026 10:40:43 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1168152/874084-000000@github.com>
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

  Branch: refs/heads/1168152
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
