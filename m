Return-Path: <cyrus@holtmann.org>
Date: Tue, 1 May 2012 13:00:14 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: Weird bluetooth keyboard regression - just me?
Message-ID: <20120501160014.GB1419@joana>
References: <20120501073711.028d31d6@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120501073711.028d31d6@lwn.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jon,

* Jonathan Corbet <corbet@lwn.net> [2012-05-01 07:37:11 -0600]:

> Life has not been conducive to frivolities like trying new kernels, but I
> finally gave 3.4-rc5 a go yesterday.  I'm seeing some decidedly weird
> keyboard behavior; it seems surprising that nobody else has complained.
> 
> I have a logitech Dinovo Edge bluetooth keyboard that I've used for
> years.  With 3.4 kernels, the keyboard generates no input until I've
> banged on it for a couple of seconds.  If I continually hit characters,
> they make it through; as soon as I stop for even a brief period (even
> somebody as verbose as me has to come up for air occasionally), it goes
> back to sleep.

This looks weird, I suspect of something. Could you try running
'bluetoothd -nd -P mgmtops' and check if the problem still happens too
you?

	Gustavo
