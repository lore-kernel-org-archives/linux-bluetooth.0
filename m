Received: from mail.commetrax.com (mail.commetrax.com [141.95.18.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA612BD597
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Oct 2025 07:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.95.18.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760428608; cv=none; b=P5SZAvGTPWGyrPaaKxBori5BuFU/RCsURnUJhjibpILcT35BWwuaa5ZrXF2qzIO5GVpZEFj9uif8N7xLAJzob6i6ntAd5PeSduvGGu7vmgO158LYSzyD/P9zwWjsXmg1jCIpk4edyjVW/htaFFcyjzdYhMjQuouHPKO5pjH5OiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760428608; c=relaxed/simple;
	bh=M2z+nFeXqIRcbI6rcgrOtIQjqLLid9ZQ1XheJsIeFLM=;
	h=Message-ID:Date:From:To:Subject:MIME-Version:Content-Type; b=iFZQYGJ3rECaLm9SldnVKjQjJP+nGB+6bWIA/PPjG6ZlYxlFIW+kSHKnAF9rbMbb4b2QO8kgD/Yx01M+d8RsdF0QR0vm+0SaREQZYpiAIYHHAwuzZ/GYqCQEkEvXlSo/tv26PL35UFY8YLnswqj8K/1wVQqXW+rpdFMkWBq4DUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=commetrax.com; spf=pass smtp.mailfrom=commetrax.com; dkim=pass (2048-bit key) header.d=commetrax.com header.i=@commetrax.com header.b=P9W09GbN; arc=none smtp.client-ip=141.95.18.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=commetrax.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=commetrax.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=commetrax.com header.i=@commetrax.com header.b="P9W09GbN"
Received: by mail.commetrax.com (Postfix, from userid 1002)
	id 7AD8923F7C; Tue, 14 Oct 2025 09:56:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=commetrax.com;
	s=mail; t=1760428599;
	bh=M2z+nFeXqIRcbI6rcgrOtIQjqLLid9ZQ1XheJsIeFLM=;
	h=Date:From:To:Subject:From;
	b=P9W09GbNnKbbiDQLsgqgpYGTliPMWKzl08jvuldyh07b+tlZd859jkNbtbYkDknUc
	 xpRts442fj0QIF9j668BBaaTyQ0rYEfiQ+TPZxSbV4uqypYmoA7snGL47ZvAAB2+St
	 0U2T9Nj2QkcaX+lHn+wk2yTAk+xahj087dv86FgkUGBQSSZLSUUxTdttXchMRQnE8Y
	 /wwAYoVyVO/4V/D3Y/kMn6X3vC8BFr5DyqvgjyOw6gZY8DzozvFBy3jJewaijEz93K
	 8o4CB9+ty42pMZRlNWEK66ZSfjKEqVW+p4tHagLDDGQePmOzCIA3TNjqrG4g4J2vst
	 s9qZkz965oFMQ==
Received: by mail.commetrax.com for <linux-bluetooth@vger.kernel.org>; Tue, 14 Oct 2025 07:55:46 GMT
Message-ID: <20251014084500-0.1.c9.16nlj.0.en8gaeqdou@commetrax.com>
Date: Tue, 14 Oct 2025 07:55:46 GMT
From: "Luke Walsh" <luke.walsh@commetrax.com>
To: <linux-bluetooth@vger.kernel.org>
Subject: Welders ready to work
X-Mailer: mail.commetrax.com
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

we support companies in carrying out industrial projects by providing wel=
ding and assembly of steel structures =E2=80=93 both on-site and in-house=
=2E

In practice, this means we enter with a ready team of welders and fitters=
, take responsibility for preparing the components, their installation an=
d quality control.=20

The client receives a complete, safe and timely delivered structure.

If you have projects that require steel solutions, we would be happy to t=
alk about how we can take over this part of the work and relieve your tea=
m.

Would you be open to a short conversation?


Best regards
Luke Walsh
