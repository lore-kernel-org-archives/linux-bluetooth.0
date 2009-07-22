Return-Path: <cyrus@holtmann.org>
Subject: Re: bluetooth SPP link to Nokia phone
From: Henry Gomersall <whg21@cam.ac.uk>
Reply-To: heng@cantab.net
To: linux-bluetooth@vger.kernel.org
In-Reply-To: <1248177100.5156.14.camel@whg21-laptop>
References: <1248169540.7048.52.camel@whg21-laptop>
	 <20090721100239.GA19048@jh-x301>  <1248177100.5156.14.camel@whg21-laptop>
Content-Type: text/plain
Date: Wed, 22 Jul 2009 12:14:57 +0100
Message-Id: <1248261297.5156.23.camel@whg21-laptop>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 2009-07-21 at 12:51 +0100, Henry Gomersall wrote:
> I've tried doing the same thing using the rfcomm program. This allows
> me
> to set up a stable connection using:
> rfcomm connect /dev/rfcomm0 'XX:XX:XX:XX:XX:XX'

I've done a little more investigation.

(please correct me if I am wrong) The rfcomm app speaks directly to the
kernel bluetooth interface. It works fine.

The sample test-serial program works through the dbus interface to the
bluetooth daemon and has exactly the same problem as my test program -
namely the serial link is dropped as soon as I attempt to write data to
it.

The problem I have is the large overhead to understanding the source
tree, with the wiki being pretty out of date. I'm keen to sort this
problem.

Cheers,

Henry

