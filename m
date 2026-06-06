Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9267821CA13
	for <linux-bluetooth@vger.kernel.org>; Sat,  6 Jun 2026 18:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780772117; cv=none; b=NHByTYbTi52m8p+LPN3JwL5MNf/NxiKeS6xaP1pGpS8z7GB/o6pwRSngrNpRTQMchYcd55qycm64S9YCJ6QVR2BHwzVb9E33/g+MCNAmNT9nAaMnDHABH9JbBgsGpDjHzF5CgeuoBONXcdu3mKVdoBja0XYJyHHoWHOIIj6tB+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780772117; c=relaxed/simple;
	bh=YOoA9m684mOuO3vH54yG1kNjcqxLcGmEEEG0PWEWSp0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=AYpO14bLWcgvWWpiNbnQV+nMszhy1JuHsE5D5VXR48y23Z9KzXMA93zSfeErO6oaf4IKesjJut2Rb5Ovdu29BZFb+LOoHpLGIR+gCOZhEjJey6W8T/6hSRK7gxWE492l3gTdguwJGp7YrLnPb6ZUJaP87YKoe8KdNOW4BkjdbGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=PnZmwnlp; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="PnZmwnlp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1780772115;
	bh=SUP7RwCkSOWiIH7TFGjeimQa9TGrIQTKtFqEnW6/exs=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=PnZmwnlpE5cnR9S4f1mVN7saJ1zBBzgvKlRHUmotn35iD666/3MvWhiTmbeAbJ5lf
	 N8uAxBVlglOrN1crSzReBvzdcq70xDJizQB/0UiMy9z+WRjAoi3jp3aM2HFFCempP5
	 oR+MggpchqP8Xj7TElg9XIlhzAruqV4qL1y9GVAI=
Received: from github.com (hubbernetes-node-eace93d.va3-iad.github.net [10.48.143.20])
	by smtp.github.com (Postfix) with ESMTPA id A1AAA18105F
	for <linux-bluetooth@vger.kernel.org>; Sat,  6 Jun 2026 11:55:15 -0700 (PDT)
Date: Sat, 06 Jun 2026 11:55:15 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1091197/27e1da-000000@github.com>
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

  Branch: refs/heads/1091197
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
