Return-Path: <justin-qt-dated-1065600036.f62268@affinix.com>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [Bluez-devel] dtl1_cs suspend bug
Date: Tue, 23 Sep 2003 16:48:12 -0700
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
References: <200309220408.04569.justin-qt@affinix.com>
	<200309231444.09863.justin-qt@affinix.com> <1064355476.1619.51.camel@pegasus>
In-Reply-To: <1064355476.1619.51.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200309231648.12696.justin-qt@affinix.com>
From: Justin Karneges <justin-qt@affinix.com>
List-ID: <bluez-devel.lists.sourceforge.net>

On Tuesday 23 September 2003 03:17 pm, Marcel Holtmann wrote:
> The Affix stack came with support of the DTL-1 card and I have started
> to read their code, which was very ugly by the way. After analysing the
> complete HCI abstraction and the driver itself, the driver divides into
> two parts. One is the HCI transport protocol which is not H:4, the other
> part is the correct way of driving the internal UART on the card. The
> Affix driver was not portable in any way, so I have started to write a
> driver for these cards from scratch.

I hadn't considered looking at Affix until you mentioned it just now.  After 
looking through the code, I notice they do have more elaborate handling of 
the UART, for instance the init_uart() function found in 
affix-kernel/drivers/uart/btuart.c.  What does the Bluez dtl1_cs use for the 
UART code?  It does not appear as obvious.

Has anyone here used Affix, and can they claim that suspend/resume works for 
the DTL1 card?  I noticed the driver does have some handling functions, like 
affix_uart_suspend() and affix_uart_resume(), which appear to simply detach / 
reattach the driver from the HCI subsystem.  Under Bluez, such an action 
would do just about nothing (in my experience anyway), but I think under 
Affix, the act of attaching to the hci subsystem causes the hardware to be 
affected also.  My guess is that init_uart gets called somwhere down the 
line.

-Justin
