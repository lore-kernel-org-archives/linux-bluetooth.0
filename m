Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA401FBEBE;
	Wed,  9 Jul 2025 06:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752041997; cv=none; b=CJiU+z+6I/z/QmDYbzCB/pGzo1dEVjBkuBd6Ucxvi5xfAnFEgX6euGxpuypD1VF7PtBPB9d/NI/uhtEyEbQQWtDjyB+vlsw72izb51OJ/sxU9/UdMUmWydx/tw3dPkfixES/oy5ulGxFI81JozBLzFNIZW7r9b2bZOKup3lubTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752041997; c=relaxed/simple;
	bh=FlHTxJ1V43hI5o5ZJ+SlN3A4KGENsQifV0g7O6ZzoGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FegUHUtCHeDmgm6fCwrn+E30JVk+2LeKJQd3kl7FPxFL4NlFOA4nU0rCr1H9QEE6s6/syikVAwWO/A6fpvPohiWiCKajKgUhMSXGQnI7CGay3TtGik2f4CIQ+kiRLdfoW70iiu1i4eP8+ByPLtdMRRBltaNUxg4wza5vw4sqAmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LC1n28rj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LC1n28rj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62927C4CEF0;
	Wed,  9 Jul 2025 06:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752041995;
	bh=FlHTxJ1V43hI5o5ZJ+SlN3A4KGENsQifV0g7O6ZzoGg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LC1n28rjvytXokGtR523u+UlPHXeBBoZdd1jhmBQRC0ZhdT2B6t3N1nuSR09VNO9Y
	 IkbCK7t0Xp93f3SnLDLY05jdGIeQ07W5HZdmKzHTcCB6zmC6Kw52HMBEZ6z9GyanAi
	 9et+dV13NaUO4A/58V3zn1vzkrbMaP56j/fx6fEI=
Date: Wed, 9 Jul 2025 08:19:52 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Christian Eggers <ceggers@arri.de>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 6.6.y] Bluetooth: HCI: Set extended advertising data
 synchronously
Message-ID: <2025070935-curdle-policy-9559@gregkh>
References: <2025070625-wafer-speed-20c1@gregkh>
 <2025070807-dimple-radish-723b@gregkh>
 <CABBYNZJKGkqU0=Wt9mWurhw9zL=np-NPhpCDFh_aN2Y-i0ZkRw@mail.gmail.com>
 <22184570.4csPzL39Zc@n9w6sw14>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22184570.4csPzL39Zc@n9w6sw14>

On Tue, Jul 08, 2025 at 11:14:59PM +0200, Christian Eggers wrote:
> > > You made major changes here from the upstream version, PLEASE document
> > > them properly in the changelog.  Also, can you test it to verify that it
> > > works and doesn't blow up the stack like I'm guessing it might?
> 
> @Greg: The only reason for the "differences" between the mainline and the 6.6
> version of the patch is, that the existing code I had to move up within 
> hci_sync.c differs between these kernels. The actual modifications I made,
> should be the same. Is this something I shall document in the changelog
> (and resend the patch)?

Yes please.

thanks,

greg k-h
