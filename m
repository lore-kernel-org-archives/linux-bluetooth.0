Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] D-Bus interfaces
From: Marcel Holtmann <marcel@holtmann.org>
To: Fredrik Noring <noring@nocrew.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1076323602.5263.41.camel@kalkyl.roxen.com>
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
Content-Type: text/plain
Message-Id: <1076324584.6869.109.camel@pegasus>
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
Date: Mon, 09 Feb 2004 12:03:05 +0100

Hi Fredrik,

> > I don't wanna support this. The hcid.conf file is a configuration file
> > for a default configuration and don't needs to read or stored through
> > the D-Bus interface. All modifications done through the D-Bus must be
> > stored in another file/database. The goal is to have an interface that 
> > can be used by Gnome, KDE etc. ...
> 
> This doesn't make sense. What happens when a user edits hcid.conf
> manually? It's simpler and straight forward to have exactly one config
> file which also can be edited manually if required. Please note that
> Gnome will most likely not expose _all_ HCI configuration features and
> that manual editing will be required to use these.

I don't wanna support a config file which is intend to be editable by a
user and changable by a program. This is always a mess.

The hcid.conf will provide the default settings for new devices or
special settings that are not in the database. If a setting is in the
database, this one will be used. The hcid.conf can also contain features
which we don't provide over a D-Bus interface. I don't have any problems
if the Gnome utility don't provide support for all HCI config stuff. We
need to write a command line utility with full support anyway, because
the interface must be tested.

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
