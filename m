Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795461788;
	b=Qjd61dz4HkylWdnaCzoRzFIWZGMVMNMAHNH4mXetO2pe3s8AXqn4OnqPnW+eoahtelAW
	 i8q/uLuCEITYDxJjIp4+k69JjjKkfbY3eDTVzSBxmqfyhov9fENliiyO23Ntg2EirkeyW
	 QpGd1lMkGJrMiySfKs5mvg6FdJK5zvuXDfV+JLn8Vjolll+9q7ILtiIAq4qpKJ2vnBsdM
	 puDI8c6OEyyxQ6XUxoUeNRU/Elb0St0wzPFn5XlYEx0vttJUf9bl5H7z4V8HHqr374qoZ
	 jKwvdu++/U8yNcC8Au/SCXAAfJYdDJBpPCTKOGdzc2lRkMQwL3RINuGHpJJrcOM+4qA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795461788;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=vmh/iP7xHvN6/jWDIjahoAwDiP8FDETBvYgddurQgVM=;
	b=VbAPF75p6A7dXMOE3K/DdPqgBjL04Bw2HxTV3TudGfMwa92DN7ABQJrVnp6DupJ7iPmh
	 AQaIJUQ0Kv/k+zykQhooiqOAWw1ZQvzv++8xhAPC698+Wjo99ZIgR4unZuIT5DwhSmSZ+
	 lykUqT3Meyw5c0+2MuN1Yq7t7N2HsjGwSwixKBtmHev52ZEIDoYj7gPlHbGdehV6jf4BP
	 voOcv7IXfUuk+y/l2Nz4myBLEl+WmIEYChGJRCob5ufrS/uRw86VNyMQr2YkU31i491CQ
	 FyPKLgrgxOEqan5DjSdyEPWmzem3Jo39km3bkLQD6A/G8UV4f5hFla+o0mPPcaQoq5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bGGL9QIY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D243606A31A;
	Mon, 23 Nov 2026 19:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bGGL9QIY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47B841F000C6;
	Mon, 23 Nov 2026 19:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795461787;
	bh=vmh/iP7xHvN6/jWDIjahoAwDiP8FDETBvYgddurQgVM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bGGL9QIYbDXP+cP6gglzrRn109jATBGaVQPv0nF49vQOUrIrHfTxcEbBomCB5OTbS
	 obUbpDZkwNGJPgJF55OPRASami7Sal8Ygsb0u2RVQLhScYTBsVzXz9jS7SG63mq/AC
	 i/Z7vTUcyKegahKgAExNQEDfkAY4OpV7Ekh9Zx88n3f8PuKjt1sGREQSN19FIQee7l
	 LSX7Mjy2FH8RKiMu/bU0XqIs7f9AHWQsykNsayOop9j/WIUnwu/mxVxf1I0weYBEcw
	 kCR9PuPdkcZp6fKlBGrSKOiRr7VuLi/4L/gf/hucZVIZbKuDTsapjwqx6aNloiKuhG
	 vOsLWuhB4jn8A==
Date: Mon, 23 Nov 2026 11:23:06 -0800
From: Drew Fustini <fustini@kernel.org>
To: Thomas Gerner <thomas.gerner@muenchen-mail.de>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] Bluetooth: btbcm: disable read tx power for
 BeagleV-Ahead
Message-ID: <awSSmjbjkoGNe-zm@thelio>
References: <20261020132604.90708-1-thomas.gerner@muenchen-mail.de>
 <20261020132604.90708-2-thomas.gerner@muenchen-mail.de>
 <awDdetFNaeuxKkbp@x1>
 <fbaa1ed3-6e59-430f-9ce5-26020591bceb@muenchen-mail.de>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbaa1ed3-6e59-430f-9ce5-26020591bceb@muenchen-mail.de>

On Sat, Nov 21, 2026 at 11:50:31AM +0100, Thomas Gerner wrote:
> Am 21.11.26 um 00:53 schrieb Drew Fustini:
> > On Tue, Oct 20, 2026 at 03:26:03PM +0200, Thomas Gerner wrote:
> > > The bluetooth module of the Ampak AP6203BM is identified by the btbcm
> > > driver as BCM4362A2.
> > > 
> > > The firmware of the bluetooth module on the BeagleV-Ahead reports a
> > > capability of reading LE tx power. However reading fails. To get
> > > bluetooth working it is necessary to disable reading of LE tx power on
> > > the BeagleV-Ahead board. The disable is implemented in a similar way as
> > > for several Apple boards but uses the board compatible identification
> > > from the DTB as there is no DMI.
> > Thanks for sending this patch. Do you know if this is a problem on any
> > other boards with the AP6203BM?
> 
> Unfortunately I don't know of other boards with the AP6203BM.
> 
> > Also, is there an error message for the failed read?
> 
> 
> Without the quirk I get this message:
> 
> Bluetooth: hci0: unexpected cc 0x204b length: 1 < 3
> Bluetooth: hci0: Opcode 0x204b failed: -38
> 
> As a result the hci driver stops initializing and Bluetooth is not working.

I think it would be helpful to add those two lines to the commit
message.

Thanks,
Drew
