Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BC0A32
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 Nov 2024 03:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730776830; cv=none; b=NnpNqtjzKDFd/K82fjg/H04cqLqLAqI3NybvORI7Wv2jIAsdTsIAT9Ga0J4sE0UVsxYVADtAmUX3rBNd3WeL+tWmh+EXpuVy9OuUqEDgF2AnPf0PnL9NrWged556xbv+lk9anaDU/Zmoa+dptSwL1MCg0rKVaLuH274RPd1/Dfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730776830; c=relaxed/simple;
	bh=+NASP8VLgavvWIVxw7xp2p3SbDyZUppHZWXaoYvojfI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=cL189fWhYLF04V9hv7xDk+tLkN4W3WpWW7brDLy7UlYD8yI9+t8/9ay53OwNaqGmGuok2emV6oZRQlDGCSHQJ1018EWbh8rK+8OY8GXTFKKNV+dfmsUpwVz+9YjEIlSD3sabHrEoR7DyJ+fCbd+6bzcsop5lCVe0V/3RxeH9gfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=hpvS6wwL; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="hpvS6wwL"
Received: from github.com (hubbernetes-node-9c73447.va3-iad.github.net [10.48.200.57])
	by smtp.github.com (Postfix) with ESMTPA id 31AEDE03F2
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 Nov 2024 19:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1730776828;
	bh=J7FzVcWqhqne/isODDqv0NrPEID7A7DyNZsRiwNjNLg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=hpvS6wwLxqkBXRqO/n3p6ng37Kfp/XYBWmF6DF0rM7HpXCK9AO1H1ngwxlkE/Fr2b
	 s8pS1bAdlaCSuRHKLZByJh8ymACspluElp54UQEEd/C1Htphexl6B6hiqvDn7zZV1b
	 iWuwwTfEYhdLhYNN9FlisffZjqAoVeqG87p2dhe8=
Date: Mon, 04 Nov 2024 19:20:28 -0800
From: =?UTF-8?B?R3XDsG5pIE3DoXIgR2lsYmVydA==?= <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/7322ec-9d69db@github.com>
Subject: [bluez/bluez] 9d69db: gdbus: define MAX_INPUT for musl
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
  Commit: 9d69dba21f1e46b34cdd8ae27fec11d0803907ee
      https://github.com/bluez/bluez/commit/9d69dba21f1e46b34cdd8ae27fec1=
1d0803907ee
  Author: Gu=C3=B0ni M=C3=A1r Gilbert <gudni.m.g@gmail.com>
  Date:   2024-11-04 (Mon, 04 Nov 2024)

  Changed paths:
    M gdbus/object.c

  Log Message:
  -----------
  gdbus: define MAX_INPUT for musl

This is the same solution as was done in src/shared/util.c



To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
