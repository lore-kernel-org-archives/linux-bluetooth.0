Return-Path: <cyrus@holtmann.org>
Subject: Re: Building master on Debian systems fails at linking "check".
From: Marcel Holtmann <marcel@holtmann.org>
To: Brian Gix <bgix@codeaurora.org>
Cc: Antonio Ospite <ospite@studenti.unina.it>,
	linux-bluetooth@vger.kernel.org
Date: Tue, 15 Nov 2011 11:59:38 +0900
In-Reply-To: <4EC1D53D.4030500@codeaurora.org>
References: <20111114155620.4fc2987fad25c9ccd724f68a@studenti.unina.it>
			 <4EC15A27.90305@codeaurora.org>
			 <20111114225100.c75e709827f4b22fa83e0327@studenti.unina.it>
		 <1321323919.15441.475.camel@aeonflux> <4EC1CEEB.2000702@codeaurora.org>
	 <1321325610.15441.479.camel@aeonflux> <4EC1D53D.4030500@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1321325981.15441.481.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brian,

> >> I believe it is more likely an X86-64 issue.  And support for libcheck
> >> is checked (and is there), but for some reason fails in this instance.
> >
> > So what does "pkg-config --libs check" actually tells you?
> 
> 
> $ pkg-config --libs check
> -lcheck

there you have your problem. It should return -lcheck_pic if that is
required for building with a dynamic library. File a bug with Debian for
this.

Regards

Marcel


