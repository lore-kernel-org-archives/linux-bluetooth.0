Return-Path: <cyrus@holtmann.org>
Date: Mon, 18 Feb 2013 10:58:06 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Randy Yates <yates@digitalsignallabs.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: mgmt-api.txt
Message-ID: <20130218085806.GB11034@x220>
References: <87d2vygjyy.fsf@randy.site>
 <20130218081221.GA8590@x220>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130218081221.GA8590@x220>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Feb 18, 2013, Johan Hedberg wrote:
> On Mon, Feb 18, 2013, Randy Yates wrote:
> > Almost all text files in doc/ are consistently-documented dbus APIs,
> > specifying service, interface, and object path.
> > 
> > However, doc/mgmt-api.txt is in a completely different format. It states
> > something about "Packet Structures" but I have no idea which packets the
> > document is referring to.
> > 
> > Can someone explain how to use this API? We have a requirement to set
> > some of these properties, such as discoverability and link level
> > security.
> 
> This is just a special socket type that kernel versions from 3.4 onwards
> provide. See e.g. the mgmt_new_default() function in src/shared/mgmt.c
> for an example of creating a mgmt socket that you can use to communicate
> using the protocol described in mgmt-api.txt. There are also several
> tools in the source tree that use mgmt sockets, e.g. tools/btmgmt
> client/bluetoothctl and monitor/btmon. Looking at the source code for
> those tools may also be helpful.

Minor mistake there: bluetoothctl doesn't use mgmt sockets (it uses just
the D-Bus interface). I also went ahead and pushed a description of how
to create mgmt sockets to mgmt-api.txt since this was a quite obvious
omission in the file. Another file you'll probably find useful is
lib/mgmt.h which has structs and numerical definitions for the mgmt
protocol.

Johan
