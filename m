Received: from out-31.smtp.github.com (out-31.smtp.github.com [192.30.252.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D619368275
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Apr 2026 09:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776938186; cv=none; b=sW3uimk+6RRFITAR3mzyJYoUoypquIWYT2fIKv9wLApaDOK5cquzYmHIrUFwhpM0QraJSZKPkgH2vXcXu0G0c2b6LoHThJWpZRQWNoYFgy+4mscrMYVogCz98BnH+OLCZvhczqhgSEztXUFXfFRYCLhcOOyciuIUVWzsQIQH5sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776938186; c=relaxed/simple;
	bh=nlihN9q7ZTG22MizOdXvn9HLZ9eAif7T+COKup7YNVM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=J8vpPcx3eZ2XlX0gSre7gC79bxH30SumSEhHdFYMJrAUA8CHK4xYhxDFG170e3B6FljDShqAHRNhd4nFbLEjAg3ZR4qcwi8e2aiNa3Vn/JOCd8q5BggpBHPiOgqvahpbFq0e0AQlQijMbxn84g/4e35C6Ca/UzJy/p46FLJH7nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=C6rXYVRh; arc=none smtp.client-ip=192.30.252.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="C6rXYVRh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1776938184;
	bh=oEB+bhJLKZAZUbROCAYmeinxIQ50iw2e/i/jVXuRrGI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=C6rXYVRhyK+ETq2ROzM7of8xQUDydhgljv21ZOx8UWzLtiEDKSneQSZbO4CgtSOyD
	 iStg38qIOOW+TPPBGZpVl9X9gdHob8EdmLRT7Jr8DMpWbpxigXbkqO339+SF04CZMB
	 aVjMzJF8fuFvDm5YzQOIGS/+FyFdQOtW/bk9i5ww=
Received: from github.com (hubbernetes-node-dcefcc5.ac4-iad.github.net [10.52.206.140])
	by smtp.github.com (Postfix) with ESMTPA id 4739C3226A9
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Apr 2026 02:56:24 -0700 (PDT)
Date: Thu, 23 Apr 2026 02:56:23 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1083418/2a5c70-000000@github.com>
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

  Branch: refs/heads/1083418
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
