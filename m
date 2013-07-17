Return-Path: <cyrus@holtmann.org>
Date: Wed, 17 Jul 2013 10:03:19 +0200
From: Gianluca Anzolin <gianluca@sottospazio.it>
To: Peter Hurley <peter@hurleysoftware.com>
Cc: gustavo@padovan.org, linux-bluetooth@vger.kernel.org,
	marcel@holtmann.org
Subject: Re: [PATCH 5/8] Use the tty_port_* functions in
 tty_open/tty_close/tty_hangup
Message-ID: <20130717080319.GA8226@sottospazio.it>
References: <1373661649-1385-1-git-send-email-gianluca@sottospazio.it>
 <1373661649-1385-5-git-send-email-gianluca@sottospazio.it>
 <51E5B259.2090501@hurleysoftware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <51E5B259.2090501@hurleysoftware.com>
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Jul 16, 2013 at 04:51:37PM -0400, Peter Hurley wrote:
> On 07/12/2013 04:40 PM, Gianluca Anzolin wrote:
> >Use the tty_port_open tty_port_close and tty_port_hangup functions that manage
> >properly the port.count and the tty_port operations.
> 
> Please merge this patch with 'Move device initialization and shutdown...".
> See comments below.

Thank you for your review, I'll rework the patches following your
instructions.

After I sent them I noticed also there were whitespace issues, for the next
iteration I will be more careful.

Gianluca
