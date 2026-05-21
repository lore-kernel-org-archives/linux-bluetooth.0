Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB113EDE5F
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2026 18:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779388816; cv=none; b=GwgDdurMlNFvrM5PJyXZPx1k5FnKK5ILZ3hw8ftqI1/Gi3oAEuaFsUvjuj07pBqmAJ0JZ2VlA/dW6l6oFNHtkOu3yKpW0+wkHrlJsEKUcagtIS7+Vbcbv8p3DdL+ljwT5ZWFWeXUOxY8c09Rk1cjoqZ+QjawZA0ABcuqnj42O2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779388816; c=relaxed/simple;
	bh=NdGbyWMcUrJx1/ZuCWwVAVt5ubMwN95uz/y+AJ24FHM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ih4RBz0Kt5WoIHRa1r5OxHpKXkJDyiO5pTqpbR2Ug1pdIpx9aHABbG5oX8L00YRrWEKBvekqZr//xH7IxoxqokLW+3C7rpIi078HsxFFfl1sBK25BdsgIH6TRrwCy9XVAz4ZWpCXTcAqUOgxCmORBQqwVOvizUuO4mZ6+LfwyXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Vu5aMkyH; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Vu5aMkyH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1779388810;
	bh=qXn9O50p8kav6KGiCvT9dQw4Fls9/4+rktQa/fJc/8g=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Vu5aMkyHadIFAHuI1dV5cpaY1vR34v4QwmKWU4PYECARC33gSsm6p3Z1wVsiu3b0t
	 CEUPnHu3LlGVqMq8kU+32vQZsSUp3+d5PMZZq8s1k9z6cPh+gdQhKSiAcJ1bXNoQDH
	 gw4gIdcYUM8FeeeRus9X5DrpbXfyPnK/jutEjdoo=
Received: from github.com (hubbernetes-node-3a84fce.va3-iad.github.net [10.48.221.39])
	by smtp.github.com (Postfix) with ESMTPA id 8796C281160
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2026 11:40:10 -0700 (PDT)
Date: Thu, 21 May 2026 11:40:10 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/action-ci/push/refs/heads/main/f2343f-9b6d3e@github.com>
Subject: [bluez/action-ci] 9b6d3e: gitlint: ignore lines with URLs and enable
 regex-s...
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

  Branch: refs/heads/main
  Home:   https://github.com/bluez/action-ci
  Commit: 9b6d3efc843524b8fb96a978c10f2de7185a7bf0
      https://github.com/bluez/action-ci/commit/9b6d3efc843524b8fb96a978c10f2de7185a7bf0
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-05-21 (Thu, 21 May 2026)

  Changed paths:
    M gitlint

  Log Message:
  -----------
  gitlint: ignore lines with URLs and enable regex-style-search

Lines containing URLs (Link: tags, lore.kernel.org references) cannot
be reasonably wrapped to 80 chars. Ignore them along with Fixes: tags.

Also set regex-style-search=true to suppress the deprecation warning
about switching from match to search semantics.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/action-ci/settings/notifications
