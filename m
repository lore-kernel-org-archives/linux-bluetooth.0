Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FBA362131
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Mar 2026 08:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773995916; cv=none; b=Ef/lujReWsHrpc7lBjSuxsawfSZLeHrfTzfUAEcbyAxfeu0sSbDCckirTZeQ9q8PSbjaZwEPP+xQTjxtANputyefNL1qNiZGtZjlyCLGHlKfu9ojXJg1DgphOwUoyBSMzTVcuTKfsflEEyM+/eQKDsQ5UsxqAFJqXrHip3rZfG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773995916; c=relaxed/simple;
	bh=SMoJwlfriPwTELde9Tjj742A7KgSTNQR7k5jdAsF0VU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ui7ToLrTJqdMZKytba1MO1mN9cIXOMajUYTzHDcjLCMfgEYDAUqyOTzpLDs3wc2TL1YfJYonZZRwHdnbhxQfwCmO9sIYu9jPtYtHRMyxrha3PYad4HR4SqPlswNOVAFcbyHabVUa09SnxTgmWU6sD0k6C0BGi4WrUe1OifswQbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Livk9lC1; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Livk9lC1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1773995913;
	bh=SMoJwlfriPwTELde9Tjj742A7KgSTNQR7k5jdAsF0VU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Livk9lC1WmBBqCLHE9MNugAbNay0/qqZfzFqRE05gao0MRXGIx7FWegSifIxNhCYf
	 P2WmPsnoRVOe+4lrY+bE0Q7ky51nsnvp9tQz2l5kaLkcdAAJRkmfy5eVzGV6m3ERTz
	 FGHMl+nsGbFg9jyeJTtZHJ1TcoGKNtQrjN/WOJBq8QE2XbHp5SVJBjmIMBoD/jhsVX
	 EdY8p6r7SZKJSVkg1+cHWs7Ro/fy/wrvMcpbfAIYYfU2eez+Yi4kaRC2zGZKH2cEVo
	 bGe5Je6WBu4qRAoIQQr9YjQjPgWwYZoN9ETK+NS3kMww9VDF6uDKQLw8pfld0qbua/
	 1J0rmZGTvfw7g==
Received: from fedora.localdomain (unknown [49.37.144.103])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: raghavendra)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id CB3A517E026C;
	Fri, 20 Mar 2026 09:38:32 +0100 (CET)
From: raghava447 <raghavendra.rao@collabora.com>
To: linux-bluetooth@vger.kernel.org
Cc: Raghavendra Rao <raghavendra.rao@collabora.com>
Subject: Re: [PATCH BlueZ 1/1] client: Add public-broadcast profile advertise command
Date: Fri, 20 Mar 2026 14:04:43 +0530
Message-ID: <20260320083443.5040-1-raghavendra.rao@collabora.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CABBYNZ+O232jp2PPdne=sSGhiynZZa7=rComj+7uzmjBwCT2fA@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Raghavendra Rao <raghavendra.rao@collabora.com>=0D

Thanks for the suggestion.=0D
=0D
My intention with this patch was to keep it limited to the semantic helper=
=0D
for the Public Broadcast Announcement service.=0D
=0D
I can work on a follow-up patch to integrate the broadcast name handling so=
=0D
that when public broadcast is in use, a configured name can also be staged=
=0D
as the Public Broadcast Name AD field.=0D
