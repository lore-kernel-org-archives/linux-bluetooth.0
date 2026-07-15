Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394C93CB566
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2026 18:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784138489; cv=none; b=QufwPT29X5PIkBExs+aiC2OjdxAnmieLVO06RS7AGxlqtv+r74CMp0Ty+z8/Ys+dBgxOyvYLOXap6+UhtrAURVuj4lV1r9yH+B5T7SOXCz1xLpaSkE9kAtqZotld5g/GoqIvxl/IcLKnOM2uBz4Ldql94aJS4hUCd+s8moqrmrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784138489; c=relaxed/simple;
	bh=H+AhzsAja6CbdIHRxo0gg24gSwTSVAgevBVUEFwo/n4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=FCHYENflvkInBWIqYwaZjb975t8t49Jkw1m8O/sbmh4cXgtXanXSDBf3t2A94IXx6iPve38cx3agk2a/Q/KY01Fmqm6xQS0oQeHVEAYoCAWz7kFZ1azub2J/6GRVFSijf/udUr3bwelWTCCSrdAUIYCWiGHHomQcXNY9+5PU7nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=JmcxwN1m; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="JmcxwN1m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1784138481;
	bh=huBS43mJAslZMBEpZDJ5KR6S9jdo2OQQ28JN1rKJJ/o=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=JmcxwN1myMBvLERGletbxiZDOIc3MHsfWySlFCkC+AxMQUT9CV2m1DOIgKBnIX6As
	 x5OB44hl4GPZQvTBsop08bbRoD9XF/xhxZBTK8xfUhEBzj/eNuEicNKe9KVetC/gis
	 v6vdk9J2qg+Dq7ffSKon6GBN6mAUefsO1JdajG5Q=
Received: from github.com (hubbernetes-node-801c17f.va3-iad.github.net [10.48.84.34])
	by smtp.github.com (Postfix) with ESMTPA id E05921813B1
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2026 11:01:21 -0700 (PDT)
Date: Wed, 15 Jul 2026 11:01:21 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1128272/758541-000000@github.com>
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

  Branch: refs/heads/1128272
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
