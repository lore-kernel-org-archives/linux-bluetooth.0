Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307DD366DC1
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 11:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780918186; cv=none; b=fQpnmh7pfyryxm+oKswDiCil9oB8l4NyE9VD76i6F0GnwAZrF/StRitMNLUSSOFoVvOpIDj026CPNuj99PNMIo26wMfNwZfZh9Lxfs/rwt4qSxXIiO/d6ukC/uZjInZycRqnqEeGT/bRcOivkWcq+36wutS9VS+eQfTB3i0xfdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780918186; c=relaxed/simple;
	bh=2+Xp20eApCqKwv+S4t8SFzlaeb944BztyHU8R3ZYRaM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Yb491XlZ7t+0jrAiGzhJNV2KuOmEWVbiB4Qjh7Pw/8MrV9TVC6YFI4pW45M4f3q+8TttbdYagI4bRSd2AMf+caRaFb1NOERCquPJGM9peNik+fFLiWR9YzR4DFaEAUmi45sYi//m3Ht2MRV3NxylAlqmsxycqXKiv9di7mDPDtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=diZZ6IUg; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="diZZ6IUg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1780918179;
	bh=vokl0PpbPLX28HtJenzIdkRnMD5UP9ucttDpiGiR/oI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=diZZ6IUgD04LuVz/OaYUE3uWP+8fM3ImVCvEc89lBkvJ0aWlQ5xjXmj7wPsEyUYXW
	 NuMyfSIniFtTmZqvo57kHr2eFhn3usn+vfdsGgPxyS9U2AhdelNYKIjKblenz1nuqK
	 vl2cTcQ1gzYTVKlABqfmKT+ju6VTmGumTu7a4Qhg=
Received: from github.com (hubbernetes-node-6a9b1d8.va3-iad.github.net [10.48.179.62])
	by smtp.github.com (Postfix) with ESMTPA id 2015E501153
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 04:29:39 -0700 (PDT)
Date: Mon, 08 Jun 2026 04:29:39 -0700
From: =?UTF-8?B?xaBpbW9uIE1pa3VkYQ==?= <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1107778/000000-435c7a@github.com>
Subject: [bluez/bluez] 435c7a: a2dp: Add codec prioritization
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

  Branch: refs/heads/1107778
  Home:   https://github.com/bluez/bluez
  Commit: 435c7ae4f79cc3f616d76e7142b03dd2d5d343a4
      https://github.com/bluez/bluez/commit/435c7ae4f79cc3f616d76e7142b03dd2d5d343a4
  Author: Simon Mikuda <simon.mikuda@streamunlimited.com>
  Date:   2026-06-08 (Mon, 08 Jun 2026)

  Changed paths:
    M profiles/audio/avdtp.c

  Log Message:
  -----------
  a2dp: Add codec prioritization

This change will select best codec when connecting to A2DP:
LDAC > AptX HD > AptX > AAC > SBC



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
