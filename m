Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29DE186287;
	Mon,  2 Sep 2024 09:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725269154; cv=none; b=ZJIXsP0BRBY/Zb9ktSNxMNK31MqTIhIrU5Mf13FZ/ba97o1cpTpqGeYaCo0ZnGB7CvqGVA9wIOQbqzw0WLnMBb+bb4YR/xGXaIHKFQZUFRtvRx8IvBNYCdbS42GU5QPIu0wpgrW7HHdcaCgZbgRxlzrSf0CRSyTq4PMsAZAb07I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725269154; c=relaxed/simple;
	bh=y2hA+BM6Wh4Gb/HYnUiwib15uBEwPAS/N4viBKH8hNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iySOvralyTf4ZEP0lgNSYqxSqi2bAUbskobTTKQA2nwOcOPLr0BixVE1NM52eGRy3uyKI38ARphV7BTRh+YH7TLCKZ0bBrAinKWCr7CLDKxKQuH5oZjMJqA6yPYj1yOeXlXWQUIQXOSkmWQy9Ir9nt+wch3xILWTSvxpuwsnEZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BUiqE2Z6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BUiqE2Z6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 536A0C4CEC2;
	Mon,  2 Sep 2024 09:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725269154;
	bh=y2hA+BM6Wh4Gb/HYnUiwib15uBEwPAS/N4viBKH8hNM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BUiqE2Z6SWe7wUi/B2Ju2JT/k3KCXpk+JIGcjkSRpX7fgURtevEka9vtefHW5mFX6
	 jx06+/QruKGv/vXhhXn7AkEs7Bz5JaYeBfCmm/QrmPeuMXyOiyWcl3/gaAU+5+HGIS
	 8ZpMEDRWZMRG2UWgoSm+j/guZf1Avwjbz2IC/vF/yROvZEtsFCn+MPWmGfHCrVh0Zw
	 kEzu/9J0ekfVdfqqA0tbVZ5a2AsOjpEZOrnp1nEr9/9r3lQ3+vkN/maEZ3kfFQsE2+
	 A6BOM8DZbrK4xnWvDEPiXTRbdOpattt9viJgbI0mRzPCzDAWWQCrG1QwmmRJRF7xq7
	 hisGLBapCO4FA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1sl3K3-0000000077m-2Ifc;
	Mon, 02 Sep 2024 11:26:07 +0200
Date: Mon, 2 Sep 2024 11:26:07 +0200
From: Johan Hovold <johan@kernel.org>
To: Andreas Kemnade <andreas@kemnade.info>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, marcel@holtmann.org,
	pmenzel@molgen.mpg.de, jirislaby@kernel.org,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, Adam Ford <aford173@gmail.com>,
	Tony Lindgren <tony@atomide.com>, tomi.valkeinen@ideasonboard.com,
	=?utf-8?B?UMOpdGVy?= Ujfalusi <peter.ujfalusi@gmail.com>,
	robh@kernel.org, hns@goldelico.com
Subject: Re: [PATCH v4 0/4] Bluetooth/gnss: GNSS support for TiWi chips
Message-ID: <ZtWEr8ESJGLa-lUm@hovoldconsulting.com>
References: <20240606183032.684481-1-andreas@kemnade.info>
 <CABBYNZ+Fz2TLSNa28H3kjVKOSA7C-XOzdQJiHdJs3FKxnq01DA@mail.gmail.com>
 <20240902112221.1a6ac6f5@akair>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902112221.1a6ac6f5@akair>

On Mon, Sep 02, 2024 at 11:22:21AM +0200, Andreas Kemnade wrote:
> Am Thu, 6 Jun 2024 16:04:10 -0400
> schrieb Luiz Augusto von Dentz <luiz.dentz@gmail.com>:

> > > Andreas Kemnade (4):
> > >   gnss: Add AI2 protocol used by some TI combo chips
> > >   Bluetooth: ti-st: Add GNSS subdevice for TI Wilink chips  
> > 
> > The bluetooth one looks relatively simple so I could take that one and
> > push to bluetooth-next if there are no dependencies on the other
> > changes.
> > 
> hmm, nothing happens here. You did not ack it so Johan could not take
> it. So what about taking the bluetooth patch now and the other ones can
> go in for maybe 6.13? At least that would reduce spam and the poor
> bluetooth ci bot will not spam complaints because it sees non-bluetotoh
> patches.

No, please don't merge anything before I've looked at this. It's on my
list, I'll try to get to this soon.

Johan
