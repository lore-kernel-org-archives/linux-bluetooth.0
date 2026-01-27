Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10C42EB878
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 17:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769534806; cv=none; b=jBpWvTZf/IIydLbCesKEMW0r8rF+VDXfwmPRGQ5s+OXVgTPnnMwUdB/NEh/zm4txm8oiWVDJbYZEXSdNKyyIuIQC1aaie6PGkI4vs1qwANfOEyjJ37qoWglJpcKU1kezI2SdI8lTEAofBQxILjQze4+DJ8vdFwLkxgR1inoc2Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769534806; c=relaxed/simple;
	bh=ezeAiWNHwIrNYn892y6oKJs0cXbjq4pif1zv4bqyhe4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=JdlQ+Ek+n8KMVynQN1zaWE2d8nl14KgDuwJ9rqKQiDmg2k6vADOUGYk8lTIXg7to+uBInsl3aIMnxLFSA/JU07Vo+c3lKN6jmB7YfcvuQmm7puqTn8GQUTRG7c2oK4qf6cHaVH6R+xukm9yqC2voUTXYf7Z6D+q1EFk4beAHSb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=izxG/dpy; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="izxG/dpy"
Received: from github.com (hubbernetes-node-4624538.va3-iad.github.net [10.48.130.39])
	by smtp.github.com (Postfix) with ESMTPA id 73DC4E089C
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 09:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1769534795;
	bh=Fb5sVPhnv4VU8ICgCmKuJlzSJle7Lv3MewMztJS7Xrc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=izxG/dpy+ZS7yd8T9de2VabPQol/yAwzzu6JEgbWh+A1TNb1AxzSdfo8NfyFGITSs
	 1JcrsmJCQ3SANwFkVud23eQD3lDwDYdxZxNYT4D9CkWAJSf5LtIAzq/pgiTbRRwco6
	 V/+RYQAkSFrTrNPvUWdj5FlxD9J5AQ/1XlG//mXk=
Date: Tue, 27 Jan 2026 09:26:35 -0800
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1047701/000000-a15b57@github.com>
Subject: [bluez/bluez] a15b57: doc/qualification: Add PICS and howto for the
 HSP ...
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/1047701
  Home:   https://github.com/bluez/bluez
  Commit: a15b577e4657f23d656a5f0a64adaf5b9cddbfdd
      https://github.com/bluez/bluez/commit/a15b577e4657f23d656a5f0a64ada=
f5b9cddbfdd
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-01-27 (Tue, 27 Jan 2026)

  Changed paths:
    A doc/qualification/hsp-pics.rst
    A doc/qualification/hsp-pts.rst

  Log Message:
  -----------
  doc/qualification: Add PICS and howto for the HSP qualification



To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
