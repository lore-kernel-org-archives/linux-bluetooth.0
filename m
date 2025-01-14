Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F952361DF;
	Tue, 14 Jan 2025 11:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736855824; cv=none; b=qDy/VoSU9cDtK8Iwa7zKNqfvAfNnJkXLhdrYFGIfN7/ECqUfiNaYGUC1501+y5I1Zx3UL3Y9YpJEubMEYPs6r5qh73QmPPj4q2gnFiMGtfgWbAktg2X9cxzDcpokDAgLct25NHd2yjR7EbtaA14sAzpwDHphd//jlFWIMc7aL2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736855824; c=relaxed/simple;
	bh=gEGR8MRokPia2nvtzq2dhpCodYQQ24YcVeUiUIQoKes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qZtKQnb9b2LAiAWffLM0EUYQQO716ccqWgG3RiZCyg/wFs+plncsRC1gOtSx2aq2sbhJBlX/d0r6KbBcYC4BzLRbwJbnLsbZM7DZ898ulxf79AB+eRJW5ZSkHsy3fakR2YGR6BjOqwkmwdh/T94Myf7+OFbzGdRp8J+VYX5RSuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uvvHYPNi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uvvHYPNi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14722C4CEDD;
	Tue, 14 Jan 2025 11:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736855824;
	bh=gEGR8MRokPia2nvtzq2dhpCodYQQ24YcVeUiUIQoKes=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uvvHYPNiE3+4StSzt6UzMk7qIndi35ySphFZLtQNtUkIPeht2Om3dFvNupKuVVLT5
	 Io5lhZiE7ULQhpSlWIK4HQciVV8hHzbiQPWwneVo+D1Js5oAFMkAigHG7FTobHrxkE
	 7JBgJfT5W9se64f/z7pP/YlkZB0yECLtJTMpTM53VLL129afo1z4dv3zX+PeXbzNo0
	 2M6MNU+zKDq9eTZkWH0k+kHPYd+N1eQAylctphF4lvScLI+w3/NuneHu8odSJPW7Sj
	 SHOS66pnKsxrSnH8WIJwGpZEDsMxpZHA3aPHoB66DMscOA179H+YS2dnSxv0SFJ5vJ
	 R4veLIg8MgWZw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1tXfXd-000000002J2-1ckK;
	Tue, 14 Jan 2025 12:57:06 +0100
Date: Tue, 14 Jan 2025 12:57:05 +0100
From: Johan Hovold <johan@kernel.org>
To: Andreas Kemnade <andreas@kemnade.info>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, pmenzel@molgen.mpg.de,
	jirislaby@kernel.org, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	Adam Ford <aford173@gmail.com>, Tony Lindgren <tony@atomide.com>,
	tomi.valkeinen@ideasonboard.com,
	=?utf-8?B?UMOpdGVy?= Ujfalusi <peter.ujfalusi@gmail.com>,
	robh@kernel.org, hns@goldelico.com,
	Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v4 0/4] Bluetooth/gnss: GNSS support for TiWi chips
Message-ID: <Z4ZREdC3aPkkxB2l@hovoldconsulting.com>
References: <20240606183032.684481-1-andreas@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606183032.684481-1-andreas@kemnade.info>

[ +CC: Sebastian ]

Hi Andreas,

and sorry about the late reply on this.

On Thu, Jun 06, 2024 at 08:30:28PM +0200, Andreas Kemnade wrote:
> Some of these chips have GNSS support. In some vendor kernels
> a driver on top of misc/ti-st can be found providing a /dev/tigps
> device which speaks the secretive Air Independent Interface (AI2) protocol.

Please expand the cover letter and commit messages with more details on
the protocols and backstory here. I spent hours over the Christmas break
digging through drivers, git logs and mail archives for information that
should have been part of the series.

Specifically, give a better description of these chips which are WiFi
controllers with Bluetooth primarily and then some have (optional?) FM
radio and GPS support as well. Some even seem to support NFC too (also
over HCI?).

Provide some background on the ti-st driver, which have now been
removed; the fact that we already had two drivers for these chips with
one only supporting the Bluetooth (and later some PM) bits; say
something about the FM driver which someone also recently decided to
remove on questionable grounds.

Please also refer to the prior attempts at adding support for the
various subfunctions to the driver (e.g. Sebastian's discussion with
Marcel on how to possibly abstract this in Bluetooth core), such as:

	https://lore.kernel.org/lkml/0C9AD246-B511-4E59-888F-47EAB034D4BF@holtmann.org/

> To be more compatible with userspace send out NMEA by default but
> allow a more raw mode by using a module parameter.

I'm very hesitant about adding a module parameters for such
configuration. There's very little detail about the AI2 protocol in this
series, but I'm inclined to just say expose it to user space and let it
deal with it. Or you can argue that we'll never be able to reverse
engineer the protocol enough, but that enabling NMEA and exposing that
is straight-forward enough (and safe) to be done in the kernel.

At the least, please provide an overview of the protocol (and also
include an example such as the one you provided in a previous thread),
what functionality it appears to provide, and how it can be used to
generate NMEA (e.g. so we can have a discussion about this).

Do all the WiLink devices use AI2? Or could some be exposing raw NMEA?

(And how does "TiWi" relate to "WiLink"?)
 
> This was tested on the Epson Moverio BT-200.
> 
> Who will take this series (1-3)? GNSS with ack from Bluetooth?

I can take the whole series once we've figured out how to model this.

Johan
