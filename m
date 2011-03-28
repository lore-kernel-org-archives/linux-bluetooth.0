Return-Path: <cyrus@holtmann.org>
From: Arnd Bergmann <arnd@arndb.de>
To: Lukasz.Rymanowski@tieto.com
Subject: Re: [PATCH v2 1/2] staging: Add ST-Ericsson CG2900 driver
Date: Mon, 28 Mar 2011 15:02:05 +0200
Cc: tglx@linutronix.de,
 par-gunnar.p.hjalmdahl@stericsson.com,
 gregkh@suse.de,
 devel@driverdev.osuosl.org,
 linus.walleij@linaro.org,
 linux-kernel@vger.kernel.org,
 linux-bluetooth@vger.kernel.org,
 pavan_savoy@sify.com,
 vitalywool@gmail.com,
 alan@lxorguk.ukuu.org.uk,
 marcel@holtmann.org,
 linus.walleij@stericsson.com,
 pghatwork@gmail.com,
 lee.jones@linaro.org,
 mathieu.poirier@linaro.org
References: <1301302950-10628-1-git-send-email-par-gunnar.p.hjalmdahl@stericsson.com> <alpine.LFD.2.00.1103281110210.31464@localhost6.localdomain6> <7D7F2FD3846CF6429ACEBDFB5A2DD86F07E35E5F89@EXMB01.eu.tieto.com>
In-Reply-To: <7D7F2FD3846CF6429ACEBDFB5A2DD86F07E35E5F89@EXMB01.eu.tieto.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201103281502.05203.arnd@arndb.de>
List-ID: <linux-bluetooth.vger.kernel.org>

On Monday 28 March 2011, Lukasz.Rymanowski@tieto.com wrote:
> >Have you thought about using a threaded interrupt handler?
> >That would make all this work cruft go away.
> 
> Good point.
> To be honest we did think about it but in the time we where we were busy with other issues.
> Anyway, shall we resend patches now or we can push patch for it once driver gets in the tree ?

No need to hold up merging because of this. Either patch it
once the code is in staging, or add a TODO file item.

	Arnd
