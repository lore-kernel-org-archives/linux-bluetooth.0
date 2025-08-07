Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15EF227EA7
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Aug 2025 14:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754577538; cv=pass; b=IHnfVuvFByORbhdgZ8nBXLpwPaRUFRisb0E59l4+XNErdGI7QACTElW7QMOo/ms9z7G6oR7IXFPrH2ZAEK4mPuOhG+yPOIv6K66bU6ffnIXWHtCVopJVqr4bOhRlSofSi5axp564eooJOEzvIreB85x4HiFe9YEWmiZT0MUvPhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754577538; c=relaxed/simple;
	bh=az6S+kEOVUveqQjxhLw2nuLFwpKe6vrLsocoRe45TwE=;
	h=From:Content-Type:Mime-Version:Subject:Date:References:To:
	 In-Reply-To:Message-Id; b=KNgNCXC51tpTkaSqo7j3tz4UAYdLAtVHC9oQWdFS3DRl7946WrLlkZo+xrUUoMe7h/pHhHOjvl+zkAy/XOui0eUow2PcBJi/rLRMC63oQKytZ32OJuHjk/hT9vLUvrcpcKyjyJYdBREAG6FSz12NzwMRpD6dBuz46hUU6ktiGbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=george.kiagiadakis@collabora.com header.b=Wgf+Qn4+; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=george.kiagiadakis@collabora.com header.b="Wgf+Qn4+"
ARC-Seal: i=1; a=rsa-sha256; t=1754577534; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=JNeJZG3avE5bb9rSsfj3pDrJgwWv89ih2CgmsUcKzCpga8RQqe8EJeNmnMgqA8LUn99tREIboyVvUiy/RwjOzG4Xld/x+/TVPMDTUXvHR4sdoRPp10nbNgxzK4IFVa1mrUZfK40Zy/FzxPWGD0ug0H7w5fDl+dSo1cST6oYPC+o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1754577534; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=Aw7BPAekvjuKuum0/y5C3mtQXs6aI8rbX5NmEvfI15A=; 
	b=SEvUi4XuXwfLYAadTKd0+ExjZeEvJ9UnUnOwrwlX7EVTlawImHA/ubM9R7vng5gaTxPF93DeMKbj2IhYg7e4xmSiTinUKkfVPhHWt9LA1zf5u9XupDT0YkbK6RwtHCVAi+cCBD8digcFRHhgkvb620FUHveMowY7b0ybqit6Jcg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=george.kiagiadakis@collabora.com;
	dmarc=pass header.from=<george.kiagiadakis@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1754577534;
	s=zohomail; d=collabora.com; i=george.kiagiadakis@collabora.com;
	h=From:From:Content-Type:Content-Transfer-Encoding:Mime-Version:Subject:Subject:Date:Date:References:To:To:In-Reply-To:Message-Id:Message-Id:Reply-To:Cc;
	bh=Aw7BPAekvjuKuum0/y5C3mtQXs6aI8rbX5NmEvfI15A=;
	b=Wgf+Qn4+N9RiqIi/Hq6U4vehHDo7Dwa8tXXkOJEBYP7k+XK1Dwus8M0OhBVPFUQ4
	ow5YiFarc5r0L4UmlDSytIBmElLZRnq0ImxDTGwdIO1oO+aBCinTP9H+ENiDOd09una
	SbjHOPO3j66OWqKGJG8XsWOq3ZpNo/WPd4jZLaJU=
Received: by mx.zohomail.com with SMTPS id 1754577532866733.277188368078;
	Thu, 7 Aug 2025 07:38:52 -0700 (PDT)
From: George Kiagiadakis <george.kiagiadakis@collabora.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [bluez/bluez]
Date: Thu, 7 Aug 2025 17:38:40 +0300
References: <bluez/bluez/push/refs/heads/979806/de485c-000000@github.com>
To: linux-bluetooth@vger.kernel.org
In-Reply-To: <bluez/bluez/push/refs/heads/979806/de485c-000000@github.com>
Message-Id: <AC7EF8FC-E94E-43D7-8D49-030C6C0A7E3E@collabora.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)

> On 6 Aug 2025, at 22:59, BluezTestBot <noreply@github.com> wrote:
>=20
>  Branch: refs/heads/979806
>  Home:   https://github.com/bluez/bluez
>=20
> To unsubscribe from these emails, change your notification settings at =
https://github.com/bluez/bluez/settings/notifications
>=20

Hi,=20

I wonder if these e-mails can be turned off. It looks like it=E2=80=99s =
just a GitHub notification informing us that the test bot has created a =
new branch. There appears to be no practical use of this information, =
afaict.

Best regards,
George

