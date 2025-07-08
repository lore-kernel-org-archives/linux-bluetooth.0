Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0ED72DEA82
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 19:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752001910; cv=none; b=FNy9Y6cILGjhuh/9Fl+TISAiYLyC3lYLJRnshpvPPRBOHhDUhvQlYY9ZR4rjr/hGmK3TmRTn9oxeg/lZHHxr7QhGVCNBozy+cXuHsxtGIXm9stklMtu3q0G/gpZhmU5+j6qwnYQ0TXP7cMREan3T7LvSXEMmDabJ5so0YLJ8in4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752001910; c=relaxed/simple;
	bh=4AK6DgUCP/PHEeP7/A6oQm15tHiVaI/PKK+HlkEYf4A=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=iH6THn73WjuScjUmZJ/0lo9nE0+wbEAqAQWbRYWtGhu0aq7xQ26G1c+7aX8FrJfGeapSRLpeA/wGR4mIKYP9TGk3To8AvKAtjExaCvHALi0KZbP3OnQp1Y8LMpstfrhliRvPTioqUKamYQsy1xQ+Yh7DNs3I1pw6OKpjWl7dHOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=IipMjKbA; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="IipMjKbA"
Received: from github.com (hubbernetes-node-b732a6d.va3-iad.github.net [10.48.174.43])
	by smtp.github.com (Postfix) with ESMTPA id 180E34E0B3A
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 12:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1752001908;
	bh=g8GZvHwJUpVsB8yyRbXXIeOaP3PjES0JGiyK5txqS5g=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=IipMjKbAlH0LWI2NecX7Hb0xzbDeg0pVjYUbR+JtprH9SXEGxLEx+IN5SPaL2fwwj
	 /9a6q1CjJpa/MjXFl/zGqN9e0IBO241YtRPw612EExbQew1CBnQsQCCfwZpHsBkB11
	 FzY5phFFM6tzbNOW34Z8q734KCXvYglWu5n6Z45Q=
Date: Tue, 08 Jul 2025 12:11:48 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/979707/8b7cb1-000000@github.com>
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

  Branch: refs/heads/979707
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
