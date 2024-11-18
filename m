Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E0018E1A;
	Mon, 18 Nov 2024 09:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731923577; cv=none; b=IjJPfwfwiZ15VG3qK2qu6y1Yqsgkv6vGKDpnnjLRh735hFAlPSneTky7lJmLwR3+EjimKer7paJE+LrWdVes1PxDJb5Yd22RomtcV63lhfnjGguxSHsEd9cC+QPP74qZ/P87NrkrYpwaQWbTtsfYhE6ltngxmS+EIJJ/PkjVJ1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731923577; c=relaxed/simple;
	bh=RvljlFslvxovyIBV821stdwlL+aqSIryaZxEZbYQcVg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=apT7XrjEYeRqqSmiGLu6EVEUxDAywrDJFRyPx33d07gXEZWmqnYdtjM4quS9kCAJkKX3m958umNojWfcMUs9IyuU2e0ovcQBeoEhtLgaR2emsd30hwcWgM99uRskNiJz+VuE9zfuyb101na5lcwos08Tmb6GZKroZaOXc3rZTNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=bbVorwGv; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="bbVorwGv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=w+tsxUM7l9EXyVhwNGX4iL5qbm/KFlKv+dX1jmgGhGc=; b=bbVorwGvmIB4TtfH2uEv55CT5F
	6SDOyeFN/LJhHk+xjjb1+03d8UWawGOhfuU6hhNqnXova2OBb8GZ0CZI/8qyHUX+YYgcc/biXjH6Q
	Fn3p7nwjpJfABUuqOtVeWuzyWYawk83P8cJ4zhPe6LR8Q/YvxduS827WeWV2PFjCDwKcLpUfBCK1x
	jfYBqhoICeiEJpjN6lPkg74N3OtI2At2Dhq/PaLvdQ8oDAGDXtdVF+wZ1AnfYLtkDGCqZhEwTHrM4
	vdZ75PRa99gvaho0hnb3hmGOCPYOjJ6FKxUa6BtmDw94C7sgrvAxG8vx1bM5ZzmU2w8RppVH1xKur
	2JtDUKBQ==;
Date: Mon, 18 Nov 2024 10:52:50 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: Johan Hovold <johan@kernel.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, marcel@holtmann.org,
 pmenzel@molgen.mpg.de, jirislaby@kernel.org, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org, Adam Ford
 <aford173@gmail.com>, Tony Lindgren <tony@atomide.com>,
 tomi.valkeinen@ideasonboard.com, =?UTF-8?B?UMOpdGVy?= Ujfalusi
 <peter.ujfalusi@gmail.com>, robh@kernel.org, hns@goldelico.com
Subject: Re: [PATCH v4 0/4] Bluetooth/gnss: GNSS support for TiWi chips
Message-ID: <20241118105250.6c67e8af@akair>
In-Reply-To: <ZtWEr8ESJGLa-lUm@hovoldconsulting.com>
References: <20240606183032.684481-1-andreas@kemnade.info>
	<CABBYNZ+Fz2TLSNa28H3kjVKOSA7C-XOzdQJiHdJs3FKxnq01DA@mail.gmail.com>
	<20240902112221.1a6ac6f5@akair>
	<ZtWEr8ESJGLa-lUm@hovoldconsulting.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Am Mon, 2 Sep 2024 11:26:07 +0200
schrieb Johan Hovold <johan@kernel.org>:

> On Mon, Sep 02, 2024 at 11:22:21AM +0200, Andreas Kemnade wrote:
> > Am Thu, 6 Jun 2024 16:04:10 -0400
> > schrieb Luiz Augusto von Dentz <luiz.dentz@gmail.com>:  
> 
> > > > Andreas Kemnade (4):
> > > >   gnss: Add AI2 protocol used by some TI combo chips
> > > >   Bluetooth: ti-st: Add GNSS subdevice for TI Wilink chips    
> > > 
> > > The bluetooth one looks relatively simple so I could take that one and
> > > push to bluetooth-next if there are no dependencies on the other
> > > changes.
> > >   
> > hmm, nothing happens here. You did not ack it so Johan could not take
> > it. So what about taking the bluetooth patch now and the other ones can
> > go in for maybe 6.13? At least that would reduce spam and the poor
> > bluetooth ci bot will not spam complaints because it sees non-bluetotoh
> > patches.  
> 
> No, please don't merge anything before I've looked at this. It's on my
> list, I'll try to get to this soon.
> 
any updates here?

Regards,
Andreas

> Johan
> 

