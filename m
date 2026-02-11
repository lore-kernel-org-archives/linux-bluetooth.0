Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB065D8F0
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Feb 2026 08:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770799863; cv=pass; b=PN02AxfapUjnUIcblDpSCnzyfBBnnYGSJUaGI07XtfmeZtF6XTyySTrpPp3uhS9P6LRaszJFxLHtbkWJKkjwoyZ4rI+RF/w70gFE7FxBIz4ggRqnKNdbgHnaqhdx2IqkPgECJuM6h8NkGZGkHJrvTeLkIpV0kzFGYjHFmHWgXGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770799863; c=relaxed/simple;
	bh=RXHwb9Hnvj5gpnjtRy+n6fYaFU5ihxeLevSkONSgM7I=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=tKU5UQ5t1nTkoCHitGeCTkXB97Hs47KfsDVTz/jl6qhCW0uqaK3DAdVmUQGcOldyKuLUGGlgT70RdfJYBUiNSAWObZ8qeIYBpi7Oyd295FM+DdXRS+tiVtBfRehek0ylJxGH+S2aBCJFkB4FZ7+tL+Um7afDkvvk658aw7Emzqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=george.kiagiadakis@collabora.com header.b=GNOJ8gF+; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=george.kiagiadakis@collabora.com header.b="GNOJ8gF+"
ARC-Seal: i=1; a=rsa-sha256; t=1770799859; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=UwA9huzAtKZg9nCYC9VNjT5vbRTOg4M5dKE94390e1Ty2Vl5LNnoNN00lPn0JAtBBehdcWH7ckqwt1kKFTQpeUrn1UVF/XzwsP3X9+KWhbVCJHkYqitSqZvHsr7mlChqXrybmOyhZtLyCO6RhT+QWfTPQIXQ/XDROx1xEpUQDuE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1770799859; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=RXHwb9Hnvj5gpnjtRy+n6fYaFU5ihxeLevSkONSgM7I=; 
	b=jyyBzaBMMv/g6SInUBG+oyOZtUWhVzngtjgryS9YJFoat8IhUBMFkI8OvyU3jrV1bgb45lvFxiN8hkaM9hYL3ZrYq15XIgdm7iER74MqeLGz15dMQsNDTKHwRwFX9d1sowVJW0iEogNqoATwT4n81QhePIG9vf+j+rQjUYLlslg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=george.kiagiadakis@collabora.com;
	dmarc=pass header.from=<george.kiagiadakis@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1770799859;
	s=zohomail; d=collabora.com; i=george.kiagiadakis@collabora.com;
	h=From:From:Content-Type:Content-Transfer-Encoding:Mime-Version:Subject:Subject:Message-Id:Message-Id:Date:Date:To:To:Reply-To:Cc;
	bh=RXHwb9Hnvj5gpnjtRy+n6fYaFU5ihxeLevSkONSgM7I=;
	b=GNOJ8gF+8RnPwKEinYjP/iABPAgy3MafNthAOxVntM1UMY6eqBXj8M6p3PCBxrWc
	q53FwOCMyeTj3o8byTk5qIZj7yiwsB7BUyyxvu5ylUT9gAM5HeRjf0Bn+lGthSnGuuK
	yze9W5Z9BW2jiOcAz/BJP+zt5x8pEDLV1ubk4Ajk=
Received: by mx.zohomail.com with SMTPS id 1770799857450196.1651161105159;
	Wed, 11 Feb 2026 00:50:57 -0800 (PST)
From: George Kiagiadakis <george.kiagiadakis@collabora.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: BlueZ Face-to-Face Meetup - Nice, France, May 30-31, 2026
Message-Id: <39DA4E65-9DE8-4857-8776-41F7BAF00C56@collabora.com>
Date: Wed, 11 Feb 2026 10:50:43 +0200
To: linux-bluetooth@vger.kernel.org
X-Mailer: Apple Mail (2.3864.300.41.1.7)

Hello everyone,

We are pleased to announce a BlueZ face-to-face meetup in Nice, France =
on May 30-31, 2026. The meetup is organized and sponsored by Collabora =
and will take place right after the Embedded Recipes [1] conference, =
co-located also with other events.

This is an excellent opportunity for developers and stakeholders to meet =
in person, discuss current development priorities, and collaborate on =
technical challenges. You are very welcome to join us!

Announcement: https://github.com/orgs/bluez/discussions/1881
Dates: Saturday, May 30th & Sunday, May 31st, 2026
Location: Radisson Blu Hotel Nice

Registration is free of charge, but we kindly ask you to confirm your =
attendance by commenting on the GitHub discussion thread: =
https://github.com/orgs/bluez/discussions/1881#discussioncomment-15756005

The meetup is strategically scheduled adjacent to several related =
events:

- Embedded Recipes conference (May 27-28) [1]
- PipeWire hackfest (May 29-30) [2]
- Linux Media Summit, Buldroot hackathon, libcamera, Yocto Project and =
others... [3]
- Bluetooth SIG Member Summit & UPF in Milan (June 2-7) - conveniently =
accessible via train from Nice

Note that the meetup will share the venue with the PipeWire hackfest on =
Saturday. This co-location offers additional opportunity to nail down LE =
Audio integration topics that are shared between the two projects.

We look forward to productive discussions and the opportunity to =
strengthen collaboration within the BlueZ community.

Best regards,
George

[1]. https://embedded-recipes.org/2026/
[2]. =
https://gitlab.freedesktop.org/pipewire/pipewire/-/wikis/PipeWire-Hackfest=
-in-Nice---May-2026
[3]. https://embedded-recipes.org/2026/colo/

--
George Kiagiadakis
Principal Software Engineer

Collabora Limited | Unit 1.06, St John's Innovation Centre, Cowley Road, =
Cambridge, CB4 0WS, UK
Registered in England and Wales | Company No. 05513718



