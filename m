Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE1126ACC
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Aug 2025 13:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754918027; cv=none; b=kBJY7VfAUTEqScoig8CRUQhGW70MWodh7jjOkS8ljHQHiUYsXVRqWJWhKb9jDYSGF1FmiNwafiNlD3qJlGcc3ONeCHdDVeItQUeMujCyQ/8J57h56RJnJxTtt+Vftlwg06lAIqZKFCWYtq4vJeOa4EftYBhLqeCv2ct81A1i/Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754918027; c=relaxed/simple;
	bh=21YzQ+/x8r/caW0eeMaJyZUxQtWcMuXdJZL6CynqkMA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=S3E8so4oFaiqP0J13ukKpcbl44dWLfZ2lpYd4F16XfvJv0OlBCtYVhKai7JFCvAXX4DCoAnWQOG6Z7u8KAF5Y65qtb9zB/rf5b3KhpORd47UimjzVmpPo0QeKcFPsLk/O83w44Bpimhp46t8YHvPj3Gu+nCw9Eg6h8VrCdLQG7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=jQZ98LFo; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="jQZ98LFo"
Received: from github.com (hubbernetes-node-59c5cbe.ash1-iad.github.net [10.56.161.62])
	by smtp.github.com (Postfix) with ESMTPA id 4A38892125B
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Aug 2025 06:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1754918025;
	bh=jmNKPCP4QyBqUXZ1DENBhFKgVxF9kLYCMYHCNJ2iCqg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=jQZ98LFoT8y2FsYNmFRlRE3hG4HXvjPDY1MW52cTz3IONhZ29/4n1VnYy+oQ8Oc86
	 5BV5acCHmpyMVQajZOdZ80ox+Vr2z+KGsV1TRsDAP5F7pByMHnqSawHOl/Fc9arCnv
	 ioKpO2iTdf7cNTbOYuxhU8+MDJ7fTIKljLqtylVs=
Date: Mon, 11 Aug 2025 06:13:45 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/989510/3d764d-000000@github.com>
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

  Branch: refs/heads/989510
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
