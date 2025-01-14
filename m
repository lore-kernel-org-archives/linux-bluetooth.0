Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84E923242C;
	Tue, 14 Jan 2025 15:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736868413; cv=none; b=ZdaaMRzlg4h0+PStY3kYjKQ/hso29focrdByb88tHKeZR1KcU6FkGDEGepx9tpTx3bs8Y8gN5d2ugpN9PI6dMdQGvDkSlQ4UvbKEvfsh8I1tVtgMD7jQw235smbtnHf48stnnm15Q1V6SFnRuVSGWRr1q7RUSXwD5ZMzKtgpxBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736868413; c=relaxed/simple;
	bh=kgvis2tHLwbch3v1GLHliYeKtxfGAjT6Jgn8TYKUPtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UyP7BWtLJjDOuZSwwK7i7TTSbqT6gfcn2J9ZkC9vXpkSyJq43iBqxPS/oSv7CtFoEsRmY47X5SmxPsBNTCvooDJhFNF7O+3sUXmGxs1TwqrzgvTXWGxIbsNfypOmW8bOYcZteoK3t6gvpJ03oqHhBS7nX91Ia/LwGpj6b1jx8HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aQq8BgNl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aQq8BgNl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 624CCC4CEDD;
	Tue, 14 Jan 2025 15:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736868413;
	bh=kgvis2tHLwbch3v1GLHliYeKtxfGAjT6Jgn8TYKUPtQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aQq8BgNlElZyTY/FjvADwoSo0FYWTeO5psqmiyYKttS/MKw1P176F1HjIXwcJ0Ew+
	 G8y9/NwzqO3UCIewr+tJPg/U45xPha4Luru18fuRNC2pgMTTsNeNl5Dnrk61BNk0+H
	 ZBDvAmjPHs0Mzidr6rOkqe3YxU0BtZ5fxGvjt+OrlKpuMPLJPe8BMGS+ty8ObrBzTv
	 2i2IoHJft26Yu3Vb1ZKoNGv6vD+jr9SwX/xw2oUjEad6PI06y7TSp5PlugQl3p1A1H
	 9zHgd8G0Owcq8D9jk89aDOBdUSgdO73x9qI4I3KVQm3y1AG4pFkR7NtQzTc26bDU0B
	 ZT+nq4+i1T/NA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1tXioh-000000007cR-1HRp;
	Tue, 14 Jan 2025 16:26:56 +0100
Date: Tue, 14 Jan 2025 16:26:55 +0100
From: Johan Hovold <johan@kernel.org>
To: Andreas Kemnade <andreas@kemnade.info>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, pmenzel@molgen.mpg.de,
	jirislaby@kernel.org, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	Adam Ford <aford173@gmail.com>, Tony Lindgren <tony@atomide.com>,
	tomi.valkeinen@ideasonboard.com,
	=?utf-8?B?UMOpdGVy?= Ujfalusi <peter.ujfalusi@gmail.com>,
	robh@kernel.org, hns@goldelico.com
Subject: Re: [PATCH v4 2/4] Bluetooth: ti-st: Add GNSS subdevice for TI
 Wilink chips
Message-ID: <Z4aCP-r-IUTmyizm@hovoldconsulting.com>
References: <20240606183032.684481-1-andreas@kemnade.info>
 <20240606183032.684481-3-andreas@kemnade.info>
 <Z4ZVNU0PdCDpMaNY@hovoldconsulting.com>
 <20250114140525.763b4c33@akair>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114140525.763b4c33@akair>

On Tue, Jan 14, 2025 at 02:05:25PM +0100, Andreas Kemnade wrote:
> Am Tue, 14 Jan 2025 13:14:45 +0100
> schrieb Johan Hovold <johan@kernel.org>:
> 
> > > GNSS support is available through
> > > channel 9 whilst FM is through channel 8. Add a platform subdevice for
> > > GNSS so that a driver for that functionality can be build.  
> > 
> > > To avoid having
> > > useless GNSS devices, do it only when the devicetree node name contains
> > > gnss.  
> > 
> > That's seems like an unorthodox use of device tree. These devices are
> > primarily (WiFi and) Bluetooth controllers so should probably not have
> > gone about and updated the node names to 'bluetooth-gnss' as you did,
> > for example, here:
> 
> yes, the matching of the node name is a bit unorthodox. How do you
> define primary? The old design with ti-st driver and bluetooth and
> other functions on top does not look like anything primary. If you look
> at the current situation with the GNSS stuff sitting on to of
> bluetooth, the picture is different, but that is implementation.

I call it primary based on (my understanding of) the architecture,
protocol and chip family. It look to me like the FM, GPS and NFC
functionality is bolted on top of the Bluetooth one for which a protocol
already existed (and which is also used by standalone non-wilink
Bluetooth controllers).

> As the
> devicetree is describing hardware, having the nodenames describe things
> seems like the right way to do.

We have serial controllers which also implements a gpio controller, but
no one would expect those to be named 'serial-gpio' for example. But we
can still describe that with a 'gpio-controller' property (and the
compatible string indicates what the device is capable of).

Since these chips do not come without Bluetooth (e.g. only wifi + gps)
and the Bluetooth protocol is used to access the GPS function I think
it makes perfect sense to just leave them named 'bluetooth'. That also
avoids having to add all the permutations of

	bluetooth-gnss-fmradio-nfc

etc. (and having to name them such also when there is no gnss antenna
connected).

> But I agree with you that the driver should not care about the node
> name, but use a boolean property.

Johan
