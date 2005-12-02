Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Remote name delay
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <e1effdeb0512020833q3f319166lfe8e63e612a86c4e@mail.gmail.com>
References: <e1effdeb0512011117i730f7dd0p4ffc099d06a09cb8@mail.gmail.com>
	 <1133470780.18554.2.camel@blade>
	 <e1effdeb0512020321g2b492f1cl5c553d7c3b24bfb8@mail.gmail.com>
	 <1133523028.20834.8.camel@blade>
	 <e1effdeb0512020833q3f319166lfe8e63e612a86c4e@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1133548573.20834.83.camel@blade>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 02 Dec 2005 19:36:13 +0100

Hi Claudio,

> > > > > I am developing a standalone application to perform real D-Bus
> > > > > services tests. The main features are:
> > > > > 1. Running all the time in the systray
> > > > > 2. Handle PIN Request
> > > > > 3. Local adapter configuration
> > > > > 4. Basic operations: Inquiry, Remote name, ...
> > > >
> > > > cool idea. We really need something like this.
> > >
> > > I am not a good UI developer, but this application can be the start
> > > point for other developers to improve it. I will sent the first
> > > prototype to the list as soon as I get better icons :)
> >
> > is this for Gnome and in C? I like to create a bluez-gnome repository
> > and then make a pre-release really soon.
> 
> Yes. I am using GladeXML object to load the widgets inside a XML file
> description.
> There are soem screenshot available at:
> http://www.cin.ufpe.br/~ckt/gbluezconf/

looks very nice. Once you think it is ready for public review, drop me a
note and I create a new repository for it.

> > > > > However I am facing a problem in the RemoteName service when a lot of
> > > > > inquiry replies is received. My app stores the inquired devices in a
> > > > > hash table and when the InquiryCompleted signal is received the app
> > > > > request the name for each device. The "hci_send_req" function is
> > > > > returning an Input/Output error. Looking the hcidump result, the
> > > > > "Command Disallowed" error is displayed :(
> > > > >
> > > > > HCIDUMP:
> > > > > > HCI Event: Command Status (0x0f) plen 4
> > > > >     Remote Name Request (0x01|0x0019) status 0x0c ncmd 1
> > > > >     Error: Command Disallowed
> > > > >  <<<<<Indicates that the controller is in a state where it can process
> > > > > this command at this time.>>>>
> > > > >
> > > > > I noticed the same problem using the hcitool with "--flush" option and
> > > > > removing the cached device information stored in the directory
> > > > > "/var/lib/bluetooth".
> > > >
> > > > What kind of chip is in your dongle? Do you wait until the remote name
> > > > complete event before asking for the next name? Every name request needs
> > > > at least a partial baseband connection.
> > >
> > > Dongle - D-Link DBT-122
> > >         Class: 0x3e0100
> > >         Service Classes: Networking, Rendering, Capturing
> > >         Device Class: Computer, Uncategorized
> > >         HCI Ver: 1.2 (0x2) HCI Rev: 0x0 LMP Ver: 1.2 (0x2) LMP Subver: 0x309
> > >         Manufacturer: Broadcom Corporation (15)
> > >
> > > Yes, I am waiting for the RemoteNameComplete signal, for this case it
> > > works fine. But I am testing simultaneous request. BlueZ D-Bus client
> > > developers should not care about listen for RemoteNameComplete event
> > > before send another request. We can try define a queue for
> > > simultaneous request.  What do you think? What are the other
> > > operations that we will find the same problem?
> >
> > You will always see this problem if the establishment of baseband
> > connection is needed, meaning if you create an ACL link.
> >
> > The good thing is that extended inquiry will solve this almost, but for
> > older devices the only possibility is to retrieve the name from a cache
> > or queue the commands.
> 
> I know that the cache is available at:
> /var/lib/bluetooth/AA:BB:CC:DD:EE:FF/names
> 
> I will analize this issue better in order to try improve the D-Bus
> request name.

It is not worth it. This is a limitation we have to live with.

> > > I will submit a patch to improve the remote name in order to consider
> > > the clock offset and page scan parameters.
> >
> > Don't expose these commands over the D-Bus interface. We don't wanna
> > deal with them there, because they should be internal only.
> 
> Is there a way to retrieve the clock offset and the page scan
> parameters inside the hcid?

You can cache the inquiry results like the kernel is doing it.

> ps: the inquiry result(clock offset and page scan parameters) is not
> being cached before send the D-Bus signals.
> Do you have any idea of how expensive is request the name without
> consider the clock offset and page scan parameters?

This depends on the firmware inside the chip. I still think that newer
CSR firmwares are caching these values and replacing them internally
when needed. However this is only speculation.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
