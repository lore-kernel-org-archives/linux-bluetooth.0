Return-Path: <cyrus@holtmann.org>
Subject: Re: [Bluez-devel] forcing SCO connection patch
From: Guillaume Bedot <littletux@zarb.org>
To: Louis JANG <louis@mizi.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <47C62147.90007@mizi.com>
References: <47666E1F.2000902@mizi.com>
	 <a8e1da0802242330l765b8b1ava62b857baf8a5568@mail.gmail.com>
	 <47C28A33.4070102@mizi.com>
	 <a8e1da0802250155u1b7af481va203849f68d9106b@mail.gmail.com>
	 <47C2A7FA.2060902@mizi.com>
	 <70692DDF-93B7-447E-ABEE-3CDBD94F15F1@holtmann.org>
	 <47C38D40.3040809@mizi.com>
	 <B96BD3FE-F490-4AD5-9315-ECD42CE9C728@holtmann.org>
	 <47C4C3D4.8010902@mizi.com>
	 <2A7EF87C-1340-45D7-B457-F81799674B1E@holtmann.org>
	 <47C555E5.2000903@mizi.com>
	 <5D9353FF-6A69-4039-9033-C0EBD1CDA756@holtmann.org>
	 <47C62147.90007@mizi.com>
Content-Type: text/plain
Date: Thu, 28 Feb 2008 11:57:04 +0100
Message-Id: <1204196224.9466.15.camel@littletux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On jeu, 2008-02-28 at 11:49 +0900, Louis JANG wrote:
> Hi Marcel,
> 
> I changed what you said below and attached patch again.
> 
> And did you check Guillaume's patch for this issue? his patch try to
> find again when ev->link_type is SCO_LINK only. I think his way is
> better than mine. I haven't saw other case (LM is not support esco but
> ESCO_LINK is connected) and I think it shouldn't happen in a normal
> situation.

Perhaps my patch fixes half of the issue, as it does not get a handle on
the other case, and I just miss the point.

The cases represented in the "Messages Sequences Chart" are said to be
"examples", and they cover all the possible cases.
Maybe I just lack imagination.

If I have no example, it doesn't matter : if it happens, the same issue
will occur if the two link types aren't tried.

Best regards,

Guillaume B.


