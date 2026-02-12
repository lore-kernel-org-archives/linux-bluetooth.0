Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9361F936
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Feb 2026 21:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770930205; cv=none; b=pxkdXvRQWJhA8HvRkzXAgdU7AB9kAyYH4hHuWUWSSTEmmUf0NHUdRApXnIcsKC/OwfmG729nspKxa59+HZdlYtgwnO+kCmc3WJS5w7ssB8SBW/FyAVQElHoRhV3rQ7zNhXom5P83SmyxTO28d0qOZ+5eegbB9ojoojDshOJQOc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770930205; c=relaxed/simple;
	bh=afokQRFVllTDQoaLMPMJoYS5+/sqXBSZaZlptbZn4Zo=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=BH0rUVzctUVZKEbOr/ZG25+tobK9pZnwvF2vowOOAYKsMvAcPQnrU3BS04Q+vmPWPeqaE39aNuq5Nt35IhrHabOUtko116ARyofsIGa0XfJJcf9t9BQ4+74IUzzByyNbEaKQeNhDZXx85VA2LdMwbKfh3ZrzSSMdGy8/Xyk4KrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=J7GbXFmI; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="J7GbXFmI"
Received: from github.com (hubbernetes-node-b07be57.va3-iad.github.net [10.48.221.80])
	by smtp.github.com (Postfix) with ESMTPA id 65944E0882
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Feb 2026 13:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1770930203;
	bh=e+N11aaGU7ECPKNzC5wzxhf8rW9ajUP1ZvQsdsd2stM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=J7GbXFmIbxnRJlytNsQM2raJdYCx+M/1jrSDvzOWoWsq7yxJez10t0VoB9I5S9IWd
	 hQrnM2NJh2MyQjsAaKResDXTmXIbdN2lmqJuZz0WXMoEzS2gT3WhWEswTTUq+C50ZH
	 05VCAm9pfshcV4/B1AZHjjfJznMSlemmTO+DY6Q4=
Date: Thu, 12 Feb 2026 13:03:23 -0800
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1053680/000000-88e0e2@github.com>
Subject: [bluez/bluez] 88e0e2: bass: Fix crash if setup is freed before
 bass_bcod...
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

  Branch: refs/heads/1053680
  Home:   https://github.com/bluez/bluez
  Commit: 88e0e2219eff83144c992deb81f3e1cd2cb14367
      https://github.com/bluez/bluez/commit/88e0e2219eff83144c992deb81f3e1cd2cb14367
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-02-12 (Thu, 12 Feb 2026)

  Changed paths:
    M profiles/audio/bass.c

  Log Message:
  -----------
  bass: Fix crash if setup is freed before bass_bcode_req response

If a the stream is set to idle (e.g. because the endpoint is
unregistered) the bass_bcode_req would be left with a dangling
pointer possibly leading to a crash if the remote peer respond or
the request times out.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
