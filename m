Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E29330320
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Feb 2026 20:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770753603; cv=pass; b=uqAq+X9dcc1pFE/ZF+FPiNYIR7oZ1tCmtWxofBKTNI9fG6g2YxSC6z9EKSVdQLYonZhJR1B2zJYXbg6JxWYzGpie04WTRQX7o29FckBKuUS5swcLVDGTMrZKNFkfm0yk0YCE4mrqHmcxVfWkHQ659mUgSO5YbFHoEEVnMcmkrno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770753603; c=relaxed/simple;
	bh=rqbki6P+DEoHm2oL4eA5/sEcPxHR59X49IxDhWkt8/Q=;
	h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To; b=LZAqNVln+OxJ1R8PiGEXQ+trpDz2g5V8TyTF+dVx0bl752NnZBn6UbU79NqZvNd9rO5tVxXRktMV3dB5XdHx+OPcZNHtMSjkyxlEcxsFQV3g78+Z1hyW/7xTe/spWRpBLy6Lp2ZfSOcK5cU/aXL903ABVwXpBySx7uzhnuXhJMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=george.kiagiadakis@collabora.com header.b=Lmw9jOMo; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=george.kiagiadakis@collabora.com header.b="Lmw9jOMo"
ARC-Seal: i=1; a=rsa-sha256; t=1770753601; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=LtCO8Xapm++hOsy63vCgJuZWHio8fsK7kg0gsg6QPmuYAk3NnvoC//rmecr1DBYPFOCy+GVYq5o6q9jmvgIfif923/ADaNhwk7q8Fz2m8XUYEMNiDRvVxm6TOBE61xutKwRjPkBEbYE4p/7jmFXglTvALWP1HH+EJWsQYgtTjOU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1770753601; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:MIME-Version:Message-ID:Resent-Date:Resent-To:Resent-From:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=rqbki6P+DEoHm2oL4eA5/sEcPxHR59X49IxDhWkt8/Q=; 
	b=UCl5Wf5pwYvZ6H86/3Xio09IycPXVex2v2OzR/ct/tfmFDlsE3DvNcy0ZrB25RpYkH2OAz12hlI0DouST4qjGL7oflPJXadID4z8K7nASiVazJQbqXB7dAkfsnLaxDNrjOHPEj4p0qqRve87+Vt9ROKHvQJ7wFlOzo/fo1ZKqYQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=george.kiagiadakis@collabora.com;
	dmarc=pass header.from=<george.kiagiadakis@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1770753601;
	s=zohomail; d=collabora.com; i=george.kiagiadakis@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:Resent-From:Date:Date:Content-Transfer-Encoding:Resent-Date:Resent-To:Message-Id:Message-Id:To:To:Reply-To:Cc;
	bh=rqbki6P+DEoHm2oL4eA5/sEcPxHR59X49IxDhWkt8/Q=;
	b=Lmw9jOMo6XzIiCUFReBrjFXn4j6GStnZMXzqB2xrYT+SpS1CzjkqT3OlXKFvDA3/
	76j9hnv6YUNzfzUHXVBkSmCSIDN3OsZFYjqhKfVSYHBCCDyXVRIYAvySatHeczlrFE+
	HTepj0jd6Xcv9fC+4iKAbsoO85kpGo+IroW3shlE=
Received: by mx.zohomail.com with SMTPS id 1770753598919614.939650018146;
	Tue, 10 Feb 2026 11:59:58 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: BlueZ Face-to-Face Meetup - Nice, France, May 30-31, 2026
From: George Kiagiadakis <george.kiagiadakis@collabora.com>
Resent-From: George Kiagiadakis <george.kiagiadakis@collabora.com>
Date: Tue, 10 Feb 2026 21:54:55 +0200
Content-Transfer-Encoding: quoted-printable
Resent-Date: Tue, 10 Feb 2026 21:59:45 +0200
Resent-To: linux-bluetooth@vger.kernel.org
Message-Id: <3B603994-659D-4AF2-9E7C-5DA00DE14C94@collabora.com>
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
https://github.com/orgs/bluez/discussions/1881#discussioncomment-15756005=20=


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

