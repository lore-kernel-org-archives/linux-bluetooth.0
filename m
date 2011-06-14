Return-Path: <cyrus@holtmann.org>
Date: Tue, 14 Jun 2011 14:24:46 +0100
From: Alan Cox <alan@linux.intel.com>
To: Florian Fainelli <ffainelli@freebox.fr>
Cc: linux-kernel@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>,
 "Gustavo F. Padovan" <padovan@profusion.mobi>, Wolfgang Grandegger
 <wg@grandegger.com>, Andreas Koensgen <ajk@comnets.uni-bremen.de>, Samuel
 Ortiz <samuel@sortiz.org>, Paul Mackerras <paulus@samba.org>, Greg
 Kroah-Hartman <gregkh@suse.de>, Mikael Starvik <starvik@axis.com>, Jesper
 Nilsson <jesper.nilsson@axis.com>, Pavan Savoy <pavan_savoy@ti.com>, Felipe
 Balbi <balbi@ti.com>, Thomas Gleixner <tglx@linutronix.de>, David Miller
 <davem@davemloft.net>, Eric Dumazet <eric.dumazet@gmail.com>, Oliver
 Hartkopp <socketcan@hartkopp.net>, Tobias Klauser <tklauser@distanz.ch>,
 Jiri Slaby <jslaby@suse.cz>, linux-bluetooth@vger.kernel.org,
 socketcan-core@lists.berlios.de, netdev@vger.kernel.org,
 linux-hams@vger.kernel.org, linux-ppp@vger.kernel.org,
 linux-cris-kernel@axis.com, linux-serial@vger.kernel.org
Subject: Re: [PATCH] TTY: define TTY_MAX_RECEIVE_ROOM to 65536
Message-ID: <20110614142446.063c0859@bob.linux.org.uk>
In-Reply-To: <1308057986-11472-1-git-send-email-ffainelli@freebox.fr>
References: <1308057986-11472-1-git-send-email-ffainelli@freebox.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 14 Jun 2011 15:26:25 +0200
Florian Fainelli <ffainelli@freebox.fr> wrote:

> A lot of TTY drivers are setting their receive_room value to 65536
> so let's define a constant for this.

These are not all the same thing so NAK

Linus wants to get rid of tty->receive_room anyway
