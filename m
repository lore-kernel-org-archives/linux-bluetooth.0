Return-Path: <crosser@average.org>
Subject: Re: [Bluez-devel] Re: Reproducible kernel oops on PPP session start
From: Eugene Crosser <crosser@average.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1074022381.2894.5.camel@pegasus>
References: <1073475736.6998.9.camel@pccross.average.org>
	 <1073477754.2508.135.camel@pegasus>
	 <1073483871.2816.9.camel@pccross.average.org>
	 <1073736024.7742.12.camel@pccross.average.org>
	 <1073736666.12699.4.camel@pccross.average.org>
	 <1073833166.3126.24.camel@pegasus>
	 <1073889186.3923.27.camel@pccross.average.org>
	 <1073913755.3126.48.camel@pegasus>
	 <1073919178.7667.41.camel@ariel.sovam.com>
	 <1073920544.3126.100.camel@pegasus>
	 <1073942535.5527.7.camel@pccross.average.org>
	 <1073943342.8198.8.camel@pegasus>
	 <1073944953.5527.16.camel@pccross.average.org>
	 <1074015121.2533.11.camel@pegasus>  <1074022381.2894.5.camel@pegasus>
Content-Type: text/plain
Message-Id: <1074029444.2819.7.camel@pccross.average.org>
Mime-Version: 1.0
Date: Wed, 14 Jan 2004 00:32:03 +0300
List-ID: <bluez-devel.lists.sourceforge.net>

On Tue, 2004-01-13 at 22:33, Marcel Holtmann wrote:

> actually it is not a wrong owner entry. But the RFCOMM core layer have
> to increment the module reference count of the L2CAP module, when we
> accept a new incoming L2CAP connection. I am not 100% that this is the
> right way to fix this problem, but for me it works. Please check if the
> attached patch helps and don't breaks any other of your setups.

Cool!  At least for me, everything works like a charm.
Thanks a lot, Marcel!

Eugene
