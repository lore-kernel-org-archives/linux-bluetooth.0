Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C5125A2A7
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Oct 2025 16:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759423041; cv=none; b=kc9OoYoTEIsHaL+ziErSgpCHlZT0SRUOn46xIlSzFoOBWlmi1CzdDBSF9BeafSzT048j9Lo7EQ9JJHi+xQ7AgFO6xPCNVR5uESR1zk5w6/DdNMKwglwlSUyo8cbXbH6VOeVEH+rB4JlkX9otrFgt2/uI5bpTvIDRqDSdOdE0fO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759423041; c=relaxed/simple;
	bh=6EP5WCucl6fSo5wRzJyfZRDDW5ezIghe0OOQedcleoA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=uHnI7CftzMiXMh6/Jo3vGiwSEHRB/xOMSOl9KTuv3iL6vtiLOLV8/gOBX/cDYvcurNMdTEu8piRa90sfyRcFZw7lzF3SoJeR3Sff8y7lE8o8CxeS691cK++ZVw+/c6ytjWHX/fR3X88nUCpsnaF1/1byTHiSW4xZ5aoo2M9aPgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=m687yXdn; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="m687yXdn"
Received: from github.com (hubbernetes-node-724b1cc.va3-iad.github.net [10.48.207.46])
	by smtp.github.com (Postfix) with ESMTPA id C87468C0DB4
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Oct 2025 09:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1759423037;
	bh=jA0Q55SP4R2DvyEdjtjCGOWezkX2lAVqFv6yiGhYkKA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=m687yXdnkgzQ14t7iWRXvQmSeJ0wwS/Fis+SrERpI4+281hW5l91FB8pvWBHUL98p
	 ryjFAor/PFN5fJLa10GPbFhkfeQBR8Ct83HW2ne1Y0RAQM5DLNr7AA8W30VCnSbnIM
	 v63qz3LvnuyaA8LmzS+77orXMW/GdUVP2Z1gKUyM=
Date: Thu, 02 Oct 2025 09:37:17 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1008056/f272cc-000000@github.com>
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

  Branch: refs/heads/1008056
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
