Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] D-Bus interfaces
From: Marcel Holtmann <marcel@holtmann.org>
To: Fredrik Noring <noring@nocrew.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1076327592.5263.64.camel@kalkyl.roxen.com>
References: <1076265358.2670.36.camel@pegasus>
	 <1076266267.14742.38.camel@akka.yeti.nocrew.org>
	 <1076267396.2670.58.camel@pegasus>
	 <1076275689.14742.93.camel@akka.yeti.nocrew.org>
	 <1076277250.6869.24.camel@pegasus>
	 <1076278554.14742.112.camel@akka.yeti.nocrew.org>
	 <1076279508.6869.54.camel@pegasus>
	 <1076280612.14742.147.camel@akka.yeti.nocrew.org>
	 <1076282343.6869.65.camel@pegasus>
	 <1076284317.14742.179.camel@akka.yeti.nocrew.org>
	 <1076287085.6869.70.camel@pegasus>
	 <1076311376.14742.202.camel@akka.yeti.nocrew.org>
	 <1076321200.6869.75.camel@pegasus>
	 <1076322129.5263.28.camel@kalkyl.roxen.com>
	 <1076323138.6869.93.camel@pegasus>
	 <1076323602.5263.41.camel@kalkyl.roxen.com>
	 <1076324584.6869.109.camel@pegasus>
	 <1076327592.5263.64.camel@kalkyl.roxen.com>
Content-Type: text/plain
Message-Id: <1076331669.6869.164.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 09 Feb 2004 14:01:09 +0100

Hi Fredrik,

> > I don't wanna support a config file which is intend to be editable by a
> > user and changable by a program. This is always a mess.
> 
> That's actually the way many other configuration tools in Linux works...
> Like it or not, it's the simplest and most robust way to have it working
> because you will have to trust the administrator of the system for
> certain things anyway. 

this is only true if the plain file itself is designed in somekind of
database format like /etc/passwd, but for hcid.conf that is not
acceptable. The format of hcid.conf is more flexible and if a user has
to edit this file, I don't wanna allow a program do edit it as well and
introduce its own format style.

> If the administrator decides to edit a system file, it's very likely
> because something really needs to be done. Hiding the real configuration
> files behind special binary databases is a true nightmare when stuff
> simply isn't working.

So we have to separate some settings.

> > We need to write a command line utility with full support anyway, because
> > the interface must be tested.
> 
> Emacs/grep/awk/perl et. al. are much more powerful than most special 
> tools. The user interfaces, DBus interfaces and tools only need to 
> support the common cases when plain text files are used. This shouldn't 
> stop anyone from actually implementing _all_ configuration features in some 
> tool, but the advanced stuff can be also be left to the administrator.

If we want a clean interface for the configuration stuff that is not
covered by the HCI specification (like name cache etc.) we must go
through these interface in all cases, because the hcid implementation is
replaceable and the storage format also.

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
