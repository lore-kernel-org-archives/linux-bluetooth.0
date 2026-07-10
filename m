Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BE23E2745
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 08:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783672567; cv=none; b=BFMgZegGO/bompa+DgKKKHkg1cuMl5VDv+vlc/jEwK3ImgjQgmmA0xlOz6Uj6JuNSnZZ8SxQ5OxP09JYzfRLKtyeDGiEHOmYNiOgJz+zjk8180uh2pblqq9YUJy8aSuCzKSv5znnBblkwz+XkShVj8jTM5n93m6YLBPYxWXW/EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783672567; c=relaxed/simple;
	bh=7tg13zNLcz4wCbxKqD0SHW0h/cvTbOAILblsTI+w3Ss=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=F/O1fp/rA6xJLwJklqObt0aFPi2GYEwa4hljQwF/jn+vGgIMJF/hDZ8gqPkAOjyVFlkVDb8TI/AvKGx1oZouoh/c3d/8ZFfdr1zOXrfYzjK1sVtS0r5DlJS5m9ZmMRUstuNUHMmtGw0IyPkYNUOt+iPxbEUmke6kkfik1HC7DKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=MIeLFoWD; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="MIeLFoWD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1783672565;
	bh=C2mTtqwT82/HZZcSU3hw/TbyfyMUkjFzTFslXF0EZ24=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=MIeLFoWDxsPequyTjJPARSZThEnAEEYwKFZmYIT+1NWPnhJlmvNWd1J2iR3GL+59x
	 EfrWoeMIO2eumNJeSPC3H29MDWdS2w51OOELze/6N3awKQfdbRtCha5FiT3oxTRbjw
	 kqOjD+b7TIeuWpWA2pZDsnlGN+6zUmGj+tGWSw/k=
Received: from github.com (hubbernetes-node-1b4e47e.ac4-iad.github.net [10.52.155.38])
	by smtp.github.com (Postfix) with ESMTPA id 923069406B9
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 01:36:05 -0700 (PDT)
Date: Fri, 10 Jul 2026 01:36:05 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1124699/e22caf-000000@github.com>
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

  Branch: refs/heads/1124699
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
