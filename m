Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Announce : BlueZ-based implemantation of JSR82
From: Marcel Holtmann <marcel@holtmann.org>
To: Julien Campana <juliencampana@yahoo.fr>
Cc: BlueZ-devel List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1085653295.914.36.camel@fischer>
References: <1085393268.892.40.camel@fischer>
	 <1085487245.9779.89.camel@pegasus>  <1085489942.900.89.camel@fischer>
	 <1085492205.9779.119.camel@pegasus>  <1085496174.900.127.camel@fischer>
	 <1085497660.9779.139.camel@pegasus>  <1085653295.914.36.camel@fischer>
Content-Type: text/plain
Message-Id: <1085660937.2797.11.camel@merlin>
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
Date: Thu, 27 May 2004 14:28:57 +0200

Hi Julien,

> > > > What I also don't wanna use is somekind of "de.avetana.bluetooth" vendor
> > > > extensions. If something is not possible in pure Java JSR-82, sorry not
> > > > my bad ;)
> > > 
> > > JSR-82 provides just the minimal amount of classes. It lets the
> > > programmer use "background classes" but this is transparent for the
> > > end-user (I will give some example of this transparency in the future
> > > how-to). These de.avetana.bluetooth.* classes are really needed to fully
> > > implement all javax.bluetooth.* classes.
> > 
> > You must explain this to me in detail, because I don't understand why.
> > Actually I think we should avoid this.
> 
> In order to explain this, I will take an example:
> JSR-82 provides an interface called ServiceRecord. The role of the class
> could be compared with the role of the sdp_record_t of BlueZ: storing
> attributes and related DataElements. 
> But no implementation of ServiceRecord is provided, it is just an
> interface. 
> Moreover, a look at the description of some JSR82 methods like
> LocalDevice.getRecord() shows that two kinds of ServiceRecord are
> needed: a "local" ServiceRecord and a "remote" ServiceRecord. This two
> ServiceRecord must differ (for example, the "local" Service Record does
> not implement some methods like getConnectionURL()). 
> That's why I had to provide two different implementation of
> ServiceRecord (LocalServiceRecord and RemoteServiceRecord). 
> But if you use the javax.bluetooth.* api, you will mostly manipulate
> ServiceRecord objects without even knowing if they are instance of
> Local- or RemoteServiceRecord.

I remember the Java interface stuff and I never liked it. However if
this is what the specifications says, we have to do it this way. I will
offer the org.bluez.* namespace to be mostly clear with it, but we
should avoid it wherever possible.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
