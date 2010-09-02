Return-Path: <cyrus@holtmann.org>
From: <Waldemar.Rymarkiewicz@tieto.com>
To: <johan.hedberg@gmail.com>
CC: <hadess@hadess.net>, <linux-bluetooth@vger.kernel.org>,
	<par-gunnar.p.hjalmdahl@stericsson.com>,
	<joakim.xj.ceder@stericsson.com>, <arunkr.singh@stericsson.com>
Date: Thu, 2 Sep 2010 18:30:38 +0300
Subject: RE: [PATCH] BT_SECURITY_HIGH requires 16 digit pin code
Message-ID: <99B09243E1A5DA4898CDD8B70011144809792196AD@EXMB04.eu.tieto.com>
References: <1282909526-19374-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
 <1282911133.835.30.camel@localhost.localdomain>
 <99B09243E1A5DA4898CDD8B7001114480976E15A2C@EXMB04.eu.tieto.com>
 <20100827124524.GA9484@jh-x301>
 <99B09243E1A5DA4898CDD8B7001114480979219655@EXMB04.eu.tieto.com>
 <20100902135108.GA30759@jh-x301>
In-Reply-To: <20100902135108.GA30759@jh-x301>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

>From: Johan Hedberg [mailto:johan.hedberg@gmail.com] 
>Sent: Thursday, September 02, 2010 3:51 PM
>
>
>Thanks. However, the kernel patch and new ioctl will need 
>comments at least from Marcel. Once we add an ioctl we're 
>stuck with it for quite some time and have to maintain it, no 
>matter what kind of newer/better kernel-userspace interfaces 
>we come up with. So the choice of accepting a new ioctl isn't so easy.

Ok. Let's wait for Marcel's comment.

>One thing that you'd definitely need to fix in your patches is 
>to keep at least the same level of support that the current 
>BlueZ has with kernels that don't have the new ioctl. Right 
>now your patch would make legacy pairing fail in such cases 
>which is not acceptable. Only with a major version change 
>(5.x) would it be possible to consider requiring a newer 
>kernel version in order to have essential functionality in place.

Right. Will fix this.

/Waldek
