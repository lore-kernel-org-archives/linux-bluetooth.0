Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBD3286894
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Sep 2025 19:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758309541; cv=none; b=aDP7qMO8THYNyYL1q790Mp6DHS7Q9lYqSnQ7cAJF/6cYtBwUm1ncugTrjXn22zjeLEEoh0MXukzlDuNPsf6BhpGawLyR+fTeTLmIJqs2MstVOvbMoMm8M0xzQi3F+oXUvCUTEbHDvxEM1fCPKByJWfgo5XBIq+3+gPmcekKh/vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758309541; c=relaxed/simple;
	bh=0fDrWSbduihdvJ4p4Jcg5Dh+5wdUxk3zMzFWbOsxUc0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=MD7+aaCo6aD+Ulo56RsHmhEGkplWZXS8XPtBljQX45ZFj+muWwmn6bqDpY4m7clj9b4vTa6JSoglGd+ulO1UsRHzwxEV9/u4PIokLmTuQPoiFGRdPFaHP/mInB7+6MK3uzRp+cPKg7RAUuL+FSA+y2RovjHxmhlYDu20DzSargU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=H5Pw+394; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="H5Pw+394"
Received: from github.com (hubbernetes-node-910bf76.ac4-iad.github.net [10.52.153.34])
	by smtp.github.com (Postfix) with ESMTPA id 09BDB2029E
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Sep 2025 12:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1758309539;
	bh=Sp/XDcrRzClKy1D3TqdWk6zM1vV5LzFxIC+LU7Brh1s=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=H5Pw+394Kmukzy2QbwVjRlnJVhTvGWPxDixwO2+DSyAYIjK3pejSg+okLYEjJ9IQW
	 2WsNABm04v+qHS6qaet+6cMsFomxjsHMYjkfdCuuFjLsk9plDNqFO53lGdoE6rxNVr
	 ICgwYtWwNkUi7NZNgSZSyXxt4Dmm+D4pYILeJZh4=
Date: Fri, 19 Sep 2025 12:18:59 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/da5daf-6b0a08@github.com>
Subject: [bluez/bluez] 6b0a08: media: fix pac_config_cb() error code return
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
  Commit: 6b0a08776ae44a9102d7c6875a77e83dc6a11a37
      https://github.com/bluez/bluez/commit/6b0a08776ae44a9102d7c6875a77e83dc6a11a37
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-09-19 (Fri, 19 Sep 2025)

  Changed paths:
    M profiles/audio/media.c

  Log Message:
  -----------
  media: fix pac_config_cb() error code return

Fixes: a887b1a1b91f ("audio: Add support for specific error codes for A2DP configuration")



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
