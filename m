Return-Path: <alon.barlev@gmail.com>
Message-ID: <9e0cf0bf0710231127o485a52e1sc7a06df7c8bc0189@mail.gmail.com>
Date: Tue, 23 Oct 2007 20:27:16 +0200
From: "Alon Bar-Lev" <alon.barlev@gmail.com>
To: "Marcel Holtmann" <marcel@holtmann.org>
Subject: Re: [BUG] rfcomm]
Cc: "Jiri Kosina" <jikos@jikos.cz>, linux-kernel@vger.kernel.org,
        bluez-devel@lists.sourceforge.net
In-Reply-To: <1193163905.6184.214.camel@violet>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
References: <200710231950.31313.alon.barlev@gmail.com>
	 <1193162106.6184.208.camel@violet>
	 <Pine.LNX.4.64.0710232004260.18815@twin.jikos.cz>
	 <1193163905.6184.214.camel@violet>
List-ID: <bluez-devel.lists.sourceforge.net>

On 10/23/07, Marcel Holtmann <marcel@holtmann.org> wrote:
> nice. I've never used it. Currently I am using what comes with Ubuntu
> 7.10 and that seems to work.

Have you tried to suspend while pppd is using rfcomm?

The fact that it happens with suspend2 and uswsusp means that the
issue is suspend blind.
Do you need any more information in order to determine what is the problem?

Best Regards,
Alon Bar-Lev.
