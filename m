Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1587C1F91C7
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Feb 2025 20:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739997450; cv=none; b=t89Deq/NE8vOkjlMpuQogocbJvHyKIctGLedyClcegI5j6Q1Vn4zUBXy0CjNvAArGPhi22hsybgIhPEOibMzlupZrBSpCmPgVXgwXV1bbhsUTRHpszd+lZNMufag+Ij88HtHRRGyxb4u7TeR0tr9m3LseTbOAeAESfR1W1bPy/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739997450; c=relaxed/simple;
	bh=gZDQBbo07cpHphmLiuUVVL/Fl+F7SvWh6SXa7MSk7oc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=uhjK7O5NyJLwYpBrR0GMBuPjCLu32R9LEUtqw0bYpJxfHg1TNY9KD2cNl40EpqWdoTnfPZT1FPf3YOR+hmmjp2G02CTitYhZyGVzn7dZeHVHVIx6c5RWLJ7uWrZsfZqQnkHpninuS3EgWLW40Kby486wa+U4dkKRp5sZ8F6oadU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=LJE3ezFa; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="LJE3ezFa"
Received: from github.com (hubbernetes-node-58bed60.va3-iad.github.net [10.48.145.31])
	by smtp.github.com (Postfix) with ESMTPA id 1C2A68C034E
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Feb 2025 12:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1739997448;
	bh=KQ+bVVeVSdLDl7aMHknrcuzPVTVHFeXhSGVizyQ1EgA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=LJE3ezFagLurwLKH4YJsRY39RaC5VXzwERNZSsirel6hcryhXLfTDwpqEDoq1Hucr
	 eaHzUp0XOu27HhJOxRpeswjBGXoknKpdUJj3oJxoYEURmCvtaxsbKku/G+Cbbq5zMK
	 +2x7DYrCAIKm81aa0STWTYThp2uEKiA1nuIdHkCs=
Date: Wed, 19 Feb 2025 12:37:28 -0800
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/3c62df-65fbc4@github.com>
Subject: [bluez/bluez] ea3f40: a2dp: Remove Endpoints cache entries on device
 rem...
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: ea3f4047e452b081e34d017cce316aba9d623301
      https://github.com/bluez/bluez/commit/ea3f4047e452b081e34d017cce316=
aba9d623301
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-02-19 (Wed, 19 Feb 2025)

  Changed paths:
    M profiles/audio/a2dp.c

  Log Message:
  -----------
  a2dp: Remove Endpoints cache entries on device removal

When a device is removed, currently the endpoints and last used info
are kept in cache:
  [General]
  Name=3DFrederic's Phone

  [Endpoints]
  01=3D00:00:01:29f50235
  02=3D00:02:01:80010484e200
  LastUsed=3D01:02

This may prevent future connection, after a new pairing, to use the
best codec available.


  Commit: 65fbc47143a5b0e8b889d39b758fe0056e54bc59
      https://github.com/bluez/bluez/commit/65fbc47143a5b0e8b889d39b758fe=
0056e54bc59
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-02-19 (Wed, 19 Feb 2025)

  Changed paths:
    M src/shared/vcp.c

  Log Message:
  -----------
  shared/vcp: fix setting volume back to current value

If there is a volume change request in flight, always update pending
volume. Otherwise, setting the value back to old value before
notification arrives, is wrongly ignored.

Fixes: e77884accdb2 ("shared/vcp: have only one volume change in flight a=
t a time")


Compare: https://github.com/bluez/bluez/compare/3c62df13abbc...65fbc47143=
a5

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
