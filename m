Return-Path: <steve.crane@rococosoft.com>
Subject: Re: [Bluez-devel] Announce : BlueZ-based implemantation of JSR82
From: Stephen Crane <steve.crane@rococosoft.com>
To: Julien Campana <juliencampana@yahoo.fr>
Cc: Marcel Holtmann <marcel@holtmann.org>,
   BlueZ-devel List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1085653295.914.36.camel@fischer>
References: <1085393268.892.40.camel@fischer>
	 <1085487245.9779.89.camel@pegasus>  <1085489942.900.89.camel@fischer>
	 <1085492205.9779.119.camel@pegasus>  <1085496174.900.127.camel@fischer>
	 <1085497660.9779.139.camel@pegasus>  <1085653295.914.36.camel@fischer>
Content-Type: text/plain
Message-Id: <1085654720.17536.405.camel@baroque.rococosoft.com>
Mime-Version: 1.0
Date: Thu, 27 May 2004 11:45:20 +0100
List-ID: <bluez-devel.lists.sourceforge.net>

Yeah, having built a JSR82 solution with callbacks to Java from the
native layer for SDP, I can whole-heartedly recommend passing the
bytearray returned from the search back to Java and parsing it there.

I'd been thinking of splitting the SDP code along these lines: one base
layer which encapsulates the protocol and some user-space helper
functions which (de-)construct the byte-arrays passed to this base
layer. What do you think Marcel?

Another tip: only pass primitive types across the native interface. For
example, return an integer status and on the basis of that throw an
exception rather than constructing the exception object in native code. 

Good luck!
Steve

On Thu, 2004-05-27 at 11:21, Julien Campana wrote:
> Am Di, den 25.05.2004 schrieb Marcel Holtmann um 17:07:
> > Hi Julien,
> 
> Hi Marcel,
> 
> > 
> > > There are main reason why I rewrote some BlueZ functions is that:
> > > - Functions like "sdp_service_search_attr_req" return a list of
> > > sdp_record_t. If I had to parse these sdp_record_t  in order to
> > > construct the requested Java Objects, this would have been an amazing
> > > amount of switch or if statement. The best solution was therefore to
> > > directly send the bytes to the java implementation.
> > 
> > put this problem up in a seperate thread on the mailing list and tell
> > how the Java Objects have to look like. We should find a better solution
> > for that.
> 
> I will post this today or tomorrow. Furthermore, I will provide the
> HOW-TO help file next week (sorry for the delay, but I currently have a
> lot of work to do!). 
> 
> 
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
> 
> > 
> > > > The native interface should only be a wrapper. Let's talk about the
> > > > stuff and put some of it back to the Bluetooth library where it should
> > > > belong.
> > > 
> > > I would say that 90% of the native interface is today a wrapper. Only
> > > the service search uses home-made-functions derived from the BlueZ code.
> > 
> > As said already, lets fix this in the Bluetooth library itself. I know
> > that SDP itself is a horrible mess of object oriented stuff, but I think
> > we will find a solution for it.
> 
> Thanks!
> 
> Regards, 
> 
> Julien
> > 
> > Regards
> > 
> > Marcel
> > 
> > 
> > 
> > 
> > -------------------------------------------------------
> > This SF.Net email is sponsored by: Oracle 10g
> > Get certified on the hottest thing ever to hit the market... Oracle 10g. 
> > Take an Oracle 10g class now, and we'll give you the exam FREE.
> > http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
> > _______________________________________________
> > Bluez-devel mailing list
> > Bluez-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/bluez-devel
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: Oracle 10g
> Get certified on the hottest thing ever to hit the market... Oracle 10g. 
> Take an Oracle 10g class now, and we'll give you the exam FREE.
> http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
-- 
Stephen Crane, Rococo Software Ltd. http://www.rococosoft.com
steve.crane@rococosoft.com +353-1-6601315 (ext 209)
