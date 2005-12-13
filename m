Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb0512131352m7a7b870i3f603d69070b7478@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Remote name delay
In-Reply-To: <1133548682.20834.85.camel@blade>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <e1effdeb0512011117i730f7dd0p4ffc099d06a09cb8@mail.gmail.com>
	 <1133470780.18554.2.camel@blade>
	 <e1effdeb0512020321g2b492f1cl5c553d7c3b24bfb8@mail.gmail.com>
	 <1133523028.20834.8.camel@blade>
	 <e1effdeb0512020833q3f319166lfe8e63e612a86c4e@mail.gmail.com>
	 <1133541708.19173.14.camel@bnocera.surrey.redhat.com>
	 <1133548682.20834.85.camel@blade>
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
Date: Tue, 13 Dec 2005 19:52:25 -0200

Hi Bastien,

My initial plan was just develop a test interface to be used as a
reference to other developers. My focus now will be continue develop
BlueZ D-Bus services.

I am not a good linux UI developer. My background is mobile
platforms(BREW, J2ME, Motorola proprietary UIs) and windows :) I
checked the gnome-bluetooth code, but at the momment I don't fell
confortable on changing your code, there are a lot of coding that I
have no idea how it works. However we can reconsider in the future.

If you need more infos about BlueZ D-Bus services, feel free to send emails=
.

Regards,
Claudio

On 12/2/05, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Bastien,
>
> > > Yes. I am using GladeXML object to load the widgets inside a XML file
> > > description.
> > > There are soem screenshot available at:
> > > http://www.cin.ufpe.br/~ckt/gbluezconf/
> >
> > Most of the backend stuff could be merged in libbtctl, and the GUI stuf=
f
> > in gnome-bluetooth (we're working on removing the python gnome-
> > bluetooth-manager).
>
> actually I don't think so, because the GUI should never use the BlueZ
> library directly. The goal is to do everything over D-Bus and you don't
> need another library in between. The D-Bus interface itself is the
> abstraction from the lower level task.
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc. Do you grep through log fi=
les
> for problems?  Stop!  Download the new AJAX search engine that makes
> searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
> http://ads.osdn.com/?ad_id=3D7637&alloc_id=3D16865&op=3Dclick
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>


--
---------------------------------------------------------
Claudio Takahasi
Instituto Nokia de Tecnologia - INdT


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
