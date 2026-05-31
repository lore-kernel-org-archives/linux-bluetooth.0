Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EA334DCE3;
	Sun, 31 May 2026 18:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780251208; cv=none; b=OSkMtsXvnIZEobqIXzIv8jxpbUj1hG5DpsD4gvyTLBbZ50tsivbu7f6SFI9fJV9TtZEVyZyQvcMcTbUWFVTdUjCQ2POYG0qLcr76ls3rFOHZEFnXftNtJz34krN/i/ruNfpBFN3l8JEePThU+qQN0IyK7lFXnD/CQNugc115mWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780251208; c=relaxed/simple;
	bh=SPjNoAM7cI/vxu/aa+0h+noA56RLxSahAlut2kpKKMQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=XZ0Dq5PhdL48p4t3CC+xTjeYynLz2W8hrQe1I7N/cVtEvgKjvb6bPiKKjZpPnC5nSqQAQoK4Dgf/j8ChxCU2HvPkE/Bd6JMNbwGB7BBf/0uSiVkgD+BTAARVdZDlIlpeDZXiZC3zur3xFdRZPmfD5LNHrVwBkeIbhKidjjbE0u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=sicwFF1h; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="sicwFF1h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1780251198; x=1780855998; i=markus.elfring@web.de;
	bh=9Oo81tRIISdHYRbr7fFi2xaX4j6BMLGwkbmVrF+U/nA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=sicwFF1hNnPxeTQOHKKPBqGzTaYUAVzLcz07+VtG1jd0MCtpFjBdfXZN1JIlJ3m4
	 obZiFwr6i9B/WShBkXo8J16KkUFkINEeCTRS+3ZqvT8TdjsROS1fXegCVIXMtzHCQ
	 8BvB9bscBlFSNhw9dRKPdeoB9oK2UdrD0UoARg9x5fHgTR/BFhusGfxk4b3xfl5dI
	 Pd5gx+RT7Ilg/tPIznm0aUaCmwtfbi1Z7CvnyWQLXnlIE8nyFv3SWjR6FqBN4DTJn
	 fjnJQlYdyDgq3vTI27Rtki7mFFNUprE9dJ33NYhwdZNl9fk90VyaiKZuYht1Y6SKY
	 FojQMPJ/jXoVmlMllw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MaHSp-1wooIt2WSz-00USYa; Sun, 31
 May 2026 20:13:18 +0200
Message-ID: <16f5ac4a-c71f-4650-821b-baf98a6022ae@web.de>
Date: Sun, 31 May 2026 20:13:17 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Bharath Reddy <kbreddy.rpbc@gmail.com>, linux-bluetooth@vger.kernel.org,
 Luiz Von Dentz <luiz.dentz@gmail.com>, Marcel Holtmann <marcel@holtmann.org>
Cc: syzbot+535ecc844591e50588a5@syzkaller.appspotmail.com,
 LKML <linux-kernel@vger.kernel.org>
References: <20260531163032.102728-1-kbreddy.rpbc@gmail.com>
Subject: Re: [PATCH v2] Bluetooth: fix memory leak in error path of
 hci_alloc_dev()
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260531163032.102728-1-kbreddy.rpbc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KQzt4ODlzh17s6A6eobrTQ+FJkUuxPpZZ/hi6RIxR7WjpGHhUyJ
 CrfNejKhwv8IRzWuDhT2DtITqZS64m/D3tCyD4v1RQiugxiSK49F2Cy2v9YrDrKbvcmV6yD
 F/DfjpLpbl0sjM4yOzMjx8FA4C3i5nnzP3T4FOItBK1oAD8BlJYNG3r5OMDWK5sBEzgKSp9
 yDfdgyzxKiqVvfjeFoCNA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dplKfytxakQ=;IJWYo3kdpPxWL84Oi9ReLiAhbLo
 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
 V1CrLg==

=E2=80=A6
> Fix the leak by explicitly calling cleanup_srcu_struct() in the
> fallback (unregistered) branch of bt_host_release() before freeing
> the device.
=E2=80=A6
> ---
>  net/bluetooth/hci_sysfs.c | 4 +++-

Some contributors would appreciate patch version descriptions.
https://lore.kernel.org/all/?q=3D%22This+looks+like+a+new+version+of+a+pre=
viously+submitted+patch%22
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv7.1-rc5#n310

Regards,
Markus
