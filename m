Return-Path: <cyrus@holtmann.org>
Date: Sat, 13 Aug 2011 11:26:21 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: Isaiah Sarju <Isaiah.Sarju@Dartmouth.edu>,
	linux-bluetooth@vger.kernel.org
Subject: Re: RFCOMM channel 1 behavior differences
Message-ID: <20110813082621.GA11338@dell.Elisa>
References: <4E45B5F1.4020807@Dartmouth.edu>
 <20110813000615.GA32541@piper>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110813000615.GA32541@piper>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Aug 12, 2011, Vinicius Costa Gomes wrote:
> On 19:23 Fri 12 Aug, Isaiah Sarju wrote:
> > Hello,
> > 
> > Does Ubuntu, linux kernel 2.6.38.10, running bluez 4.91-0ubuntu1
> > have a special security policy for incoming rfcomm connections on
> > channel 1, and not other channels?
> > 
> 
> Most probably this is caused by a problem in how Ubuntu packages
> BlueZ. 
> 
> Could you try this: edit /etc/bluetooth/main.conf and add "pnat-server"
> to the DisabledPlugins field (perhaps you will need to uncomment that
> line). Restart bluetoothd and see if it works.

That could be the reason, however the plugin name is "pnat" and not
"pnat-server" (pnat-server is just the adapter driver name that the pnat
plugin registers).

Johan
