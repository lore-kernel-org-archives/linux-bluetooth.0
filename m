Return-Path: <cyrus@holtmann.org>
Date: Thu, 10 Oct 2013 15:52:38 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv3 09/15] android: Add Android Makefile for libbluetooth
Message-ID: <20131010125236.GO23879@aemeltch-MOBL1>
References: <1381131496-9417-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1381243883-2745-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1381243883-2745-10-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <67FF7DAD-8C17-4ADB-8050-5F35CC7C34D4@holtmann.org>
 <20131010124347.GM23879@aemeltch-MOBL1>
 <EE03C055-2E09-4B8D-90BB-5E827BA227E0@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <EE03C055-2E09-4B8D-90BB-5E827BA227E0@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Oct 10, 2013 at 02:45:35PM +0200, Marcel Holtmann wrote:
> >>> +
> >>> +lib_headers := \
> >>> +	bluetooth.h \
> >>> +	hci.h \
> >>> +	hci_lib.h \
> >>> +	sco.h \
> >>> +	l2cap.h \
> >>> +	sdp.h \
> >>> +	sdp_lib.h \
> >>> +	rfcomm.h \
> >>> +	bnep.h \
> >>> +	cmtp.h \
> >>> +	hidp.h \
> >> 
> >> I would really prefer we do not install these.
> > 
> > this creates directly bluetooth with links to headers since this is they
> > way BlueZ is referring to them. What do you propose here?
> 
> I prefer that we do not install these headers or the shared library.
> Nothing outside of BlueZ build should need them.

They are not installed anywhere. Just links created locally.

Best regards 
Andrei Emeltchenko 
