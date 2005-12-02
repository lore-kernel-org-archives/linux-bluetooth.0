Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Remote name delay
From: Bastien Nocera <hadess@hadess.net>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <e1effdeb0512020833q3f319166lfe8e63e612a86c4e@mail.gmail.com>
References: <e1effdeb0512011117i730f7dd0p4ffc099d06a09cb8@mail.gmail.com>
	 <1133470780.18554.2.camel@blade>
	 <e1effdeb0512020321g2b492f1cl5c553d7c3b24bfb8@mail.gmail.com>
	 <1133523028.20834.8.camel@blade>
	 <e1effdeb0512020833q3f319166lfe8e63e612a86c4e@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1133541708.19173.14.camel@bnocera.surrey.redhat.com>
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
Date: Fri, 02 Dec 2005 16:41:48 +0000

On Fri, 2005-12-02 at 14:33 -0200, Claudio Takahasi wrote:
> Hi Marcel,
> 
> On 12/2/05, Marcel Holtmann <marcel@holtmann.org> wrote:
> > Hi Claudio,
> >
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
> [Claudio Takahasi]
> Yes. I am using GladeXML object to load the widgets inside a XML file
> description.
> There are soem screenshot available at:
> http://www.cin.ufpe.br/~ckt/gbluezconf/

Most of the backend stuff could be merged in libbtctl, and the GUI stuff
in gnome-bluetooth (we're working on removing the python gnome-
bluetooth-manager).

Are you interested in working on those, rather than creating another
module/UI/etc.?

---
Bastien Nocera <hadess@hadess.net> 
"Don't send me flowers when I'm dead. If you like me, send them while
I'm alive" - Brian Clough, after the liver transplant which saved his
life.



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
