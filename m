Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E521A706F;
	Thu,  3 Oct 2024 17:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727975772; cv=none; b=WQBfguLMofq0Ho3d3+4atZ9Egp6QZOgz1DtQinpZ4x2WpnOxZDsuBnkjb9fMs42u93zx7BMV6wUJTtDrMzPRo8Kj4gRSeQPE8PN3+AjZbQUwG4Hv287b1jDpbUqYr72M7zzjqeJvzzVkcsWVKH/IVv3sa6O6Zu/vs8v3vEgNu+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727975772; c=relaxed/simple;
	bh=e7D4hobOqd225DG+zQcY8sCES/eQeMsusT1t+CamYzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KyXYXXIjHbvxYeNHiv4hgWO8btyrcARcjOd3gPaNVjmpwoiTYUAa9zCIS0nHG2sAMa4BVwJS8YCfALJGc74Sh/7dMVSh1a5QHF6wGstXe6+gXtPthYHIECwLKasLMUo4bI6lUlZ/Jvho7z+toeKHCEIW4/VmX3KrQB0ZipacLOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=pg9kMZgn; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="pg9kMZgn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=6dMXLEP6AG16UTPfZKDGlkx3svSo6DpKyVS2oKZNG8c=;
	b=pg9kMZgncrQSoce+LHBQaBq5FL1IqhAJeu9HCyS5eRkTWsk4CHkvOtjPVnOamj
	hiCwxy1QAN6frM+JAcfF7U7KPxF7iJqDvpmOJU5yF0LBXjimFxmLyzcCtPGgajPf
	HTTz61ebLTfidvhVvLa7DD3OOKPFUEoFsrsaFzIEccRTI=
Received: from localhost (unknown [36.5.132.7])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wC3fwVH0f5mIiIxAw--.45120S2;
	Fri, 04 Oct 2024 01:15:51 +0800 (CST)
Date: Fri, 4 Oct 2024 01:15:51 +0800
From: Qianqiang Liu <qianqiang.liu@163.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: syzbot <syzbot+03d6270b6425df1605bf@syzkaller.appspotmail.com>,
	johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org, marcel@holtmann.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in
 set_powered_sync
Message-ID: <Zv7RRwVy7fcDLPHJ@fedora>
References: <Zv67JUPfzgQp7Kgf@fedora>
 <66fec4aa.050a0220.9ec68.004b.GAE@google.com>
 <Zv7KOuMKKHrLTvfw@fedora>
 <CABBYNZ+BwrGdL0HYh3cmQ39RFwEqjzreJSyYhFkkhSWxeoorNg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABBYNZ+BwrGdL0HYh3cmQ39RFwEqjzreJSyYhFkkhSWxeoorNg@mail.gmail.com>
X-CM-TRANSID:_____wC3fwVH0f5mIiIxAw--.45120S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUjzuAUUUUU
X-CM-SenderInfo: xtld01pldqwhxolxqiywtou0bp/1tbiRRBtamb+zaItHAAAsU

Hi Luiz,

> Are you sure this hasn't been already fixed by Bluetooth: MGMT: Fix
> possible crash on mgmt_index_removed?

Oh, it looks like it's already fixed by your patch, thanks!

-- 
Best,
Qianqiang Liu

