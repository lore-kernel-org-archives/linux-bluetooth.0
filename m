Return-Path: <steve.crane@rococosoft.com>
Subject: Re: [Bluez-users] Multisync Bluetooth No devices
From: Stephen Crane <steve.crane@rococosoft.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: andy@beuth.info, BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1092131858.24961.1052.camel@baroque.rococosoft.com>
References: <1092127580.9886.56.camel@goya>
	 <1092127904.4564.79.camel@pegasus>
	 <1092131858.24961.1052.camel@baroque.rococosoft.com>
Content-Type: text/plain
Message-Id: <1092133350.25087.1054.camel@baroque.rococosoft.com>
Mime-Version: 1.0
Date: Tue, 10 Aug 2004 11:22:31 +0100
List-ID: <bluez-users.lists.sourceforge.net>

Not enough coffee ;-) That should have been:

# ln -s /usr/lib/libbluetooth.so.1.0.8 /usr/lib/libsdp.so

On Tue, 2004-08-10 at 10:57, Stephen Crane wrote:
> Hi Andy, Marcel,
> 
> On Tue, 2004-08-10 at 09:51, Marcel Holtmann wrote:
> > Hi Andy,
> > 
> > > I run debian unstable with kernel 2.6.7 and mh4 from Marcel Holtmann
> > > (thanx). My problem is the following. By booting my pc i got the message
> > > No devices in HCI mode found.
> > > My Bluetooth is working under gnome with all applications exclude
> > > MULTISYNC. My Card is PCCARD 3COM 3CRWB6096 mit Kernel Driver und
> > > firmware loader. I can send SMS via Bluetooth and scmxx to my Siemens
> > > S55 but there is no way to get it work with Multisync.
> > > The Bluetooth Button in the "Connect with" selection is only grey.
> > > Any Idea??
> > > hid2hci say "No devices in HCI mode found" too.
> > 
> > the Multisync package maintainer linked the Bluetooth plugin against the
> > libsdp which is no longer present. File a Debian bug report, because
> 
> You can bodge around this by making a softlink:
> # ln -s /usr/lib/libsdp.so /usr/lib/libbluetooth.so.1.0.8
> 
> Pretty awful but it should work.
> 
> Later,
> Steve
-- 
Stephen Crane, Rococo Software Ltd. http://www.rococosoft.com
steve.crane@rococosoft.com +353-1-6601315 (ext 209)
