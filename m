Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0317F330D27
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Nov 2025 14:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762268235; cv=none; b=lbp4mOhKsJ3q6PNzdktcNgA75XSX/fpYnNVVCD28ilWIQTK4DhoNUGKxagKojmoy7f9vZfn5N6IkJ+qy/xl/2Q7w6J661yhEe+RpC3103w40xPhDqfUVa2p8ljH/JULVCbQQxaVg9xZ5+8log0XnRqPql8jG96kzFBifdEheeRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762268235; c=relaxed/simple;
	bh=IU/B3SokjQWqP/pZcQSZ+BX08o7XunaQ5M6G4sEy7i4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=CN9AJwsDJqm6VP2FY3VoGNAVDTTU37O0GoHE2a1EWIdbVJ54KSvFMOhZ0QIKzdU60dj/Z6vWKd0Xp/Ltxrg58n0sdKUxpJHKD8PSKz8W5nm3Yjju6OBceOlP9O0AOWxB+KnYgwFgi2cCOsCApnGnilI/JpL5nNVsYR9jnWPQoZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=IjOXc5zX; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="IjOXc5zX"
Received: from github.com (hubbernetes-node-b6b8be6.ac4-iad.github.net [10.52.130.35])
	by smtp.github.com (Postfix) with ESMTPA id EAA6A4010DE
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Nov 2025 06:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1762268233;
	bh=k+MgO4MTnVQT6ihDwJpmJz8qrkC8yduzOSnfbofV6io=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=IjOXc5zX7xZy5k06/tBL1FKUfR2Ab383wcWuPYPJwTVvvKQopUVyeXEIHRGdm5Dy6
	 fwiPQwQB4BRdhUTPu7thKtrxrZvbfGeEEjAwoR7pr9JWfswbBsz3276Bv0HneR6G7s
	 LzKEfwKFITadUWxa896+z4mkhIscfPIWOJubQwI4=
Date: Tue, 04 Nov 2025 06:57:12 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1019114/afd44f-000000@github.com>
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

  Branch: refs/heads/1019114
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
