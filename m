Return-Path: <crosser@average.org>
Subject: Re: [Bluez-devel] Re: Reproducible kernel oops on PPP session start
From: Eugene Crosser <crosser@average.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1073943342.8198.8.camel@pegasus>
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
Content-Type: text/plain
Message-Id: <1073944953.5527.16.camel@pccross.average.org>
Mime-Version: 1.0
Date: Tue, 13 Jan 2004 01:02:33 +0300
List-ID: <bluez-devel.lists.sourceforge.net>

On Tue, 2004-01-13 at 00:35, Marcel Holtmann wrote:

> first use l2test only and don't load any other highlevel Bluetooth
> protocol. I will also try to reproduce it with my test machines. If it
> is a L2CAP only problem it is much more easier to find the bug.

while right now I only have one host where l2test can be run, I tried
it:

l2test -s 00:01:02:03:04:05
 - l2cap count increased by 2, then I get "Host is down" and count
decreased by 2

l2test -r
 - count increased by 3, program waits.  When I hit ctrl-break, count
decreased by 3

Eugene
