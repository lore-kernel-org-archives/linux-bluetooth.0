Return-Path: <cyrus@holtmann.org>
Date: Fri, 10 Sep 2010 14:38:13 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: pghatwork@gmail.com
Cc: par-gunnar.p.hjalmdahl@stericsson.com,
	linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	linus.walleij@stericsson.com
Subject: Re: Request for input regarding new driver in MFD for
 GPS_Bluetooth_FM controller CG2900
Message-ID: <20100910143813.4af0a3ce@lxorguk.ukuu.org.uk>
In-Reply-To: <AANLkTikTBdr4U1bPtfXWhgLgdvWDMPJrFjBCktPL40dg@mail.gmail.com>
References: <AANLkTikTBdr4U1bPtfXWhgLgdvWDMPJrFjBCktPL40dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

>  - Is it OK to dynamically use the channels either from Kernel or User space?

Quite a few devices do this. In most cases it makes no sense to burden
the user with channel management so its only natural that opening the tty
or direct interfaces should "just work"
