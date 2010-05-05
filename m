Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] MCAP implementation for BlueZ
From: Santiago Carot-Nemesio <scarot@libresoft.es>
To: Elvis =?ISO-8859-1?Q?Pf=FCtzenreuter?= <epx@signove.com>
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	Santiago Carot-Nemesio <sancane@gmail.com>,
	linux-bluetooth@vger.kernel.org
In-Reply-To: <391F3B56-3BDD-418D-9AE1-8DC00E2989A3@signove.com>
References: <1272962595-4108-1-git-send-email-sancane@gmail.com>
	 <20100504200657.GC26732@vigoh> <1273045541.2105.27.camel@mosquito>
	 <391F3B56-3BDD-418D-9AE1-8DC00E2989A3@signove.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 05 May 2010 15:01:15 +0200
Message-ID: <1273064475.2105.187.camel@mosquito>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

El mié, 05-05-2010 a las 09:15 -0300, Elvis Pfützenreuter escribió:
> > 
> > We have some home-made tools and scripts for testing MCAP, if you are
> > interested i'll put them in plubic git too.
> 
> Yes, this is important, because we are about to write some MCAP tools too, and would be nice not to do the same thing again :)--

We have already set up a public git with all code that we have generated
until now. MCAP and tools are included too. There you can find a beta
implementation of HDP, but please don't consider it as definitive
implementation, it's simply for testing purpose.

We expect that thanks to this git we can work together in development
task. If you are interested in having an account, please contact with
us ;)

As we suggested yesterday in IRC, at current moment we believe that fix
HDP API and testing MCAP are the more priority task wich we have to
focus our current effort.

There is the git url:
git://193.147.51.48/git/mcap.git

Please, feel free to get the code and submit bugs and patches.

There you can see next branches:

mcap: This branch has the latest code for MCAP.

mcap_dbus: Here you can find an stupid dbus interface to play with MCAP,
note that MCAP code in this branch is older than mcap branch, it may be
interested update it if you want play with last MCAP code.

If you have some questions, please, you don't hesitate in contact with
us.

Best regards.


