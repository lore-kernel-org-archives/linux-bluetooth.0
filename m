Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb0602130444t24aa8668ved44c8800379664@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] [DBUS PATCH] BlueZ D-Bus redesign
In-Reply-To: <20060213073021.GA29708@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <e1effdeb0602101029v4f1b6e9dw8a0a75a4daf6ba55@mail.gmail.com>
	 <1139596810.26234.73.camel@localhost>
	 <20060210230043.GA15483@localhost.localdomain>
	 <1139630105.2098.10.camel@localhost>
	 <20060213073021.GA29708@localhost.localdomain>
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
Date: Mon, 13 Feb 2006 10:44:01 -0200

Hi,

On 2/13/06, Johan Hedberg <johan.hedberg@nokia.com> wrote:
> Hi Marcel,
>
> On Sat, Feb 11, 2006, Marcel Holtmann wrote:
> > > Btw Marcel, the API document should probably be added to CVS or
> > > published on this list since AFAIK currently you, I, Claudio and Edua=
rdo
> > > are the only ones in posession of it.
> >
> > Actually I wanted to wait until it is in a better shape, but since they
> > mentioned it several times on the mailing list, we should make it publi=
c
> > anyway. Please do a last review and then I commit it to the CVS.
>
> I don't have currently any big issues with it. One thing we may want to
> add to it in the future is descriptions of the different types of errors
> that the methods can return.
>
> > > > Should we split the Manager interface and the Device interface into=
 two
> > > > separate files?
> > >
> > > I think that would make sense. That way you could also define clearer
> > > interfaces between them in the code (function wise).
> >
> > Any proposals on how we gonna do the split?
>
> I see you've already made the split in CVS, and it looks ok. I'd
> probably split the dbus.h file also into separate files (one for each .c
> file). At some point we might also need a "dbus-common.c" file for
> common helper functions (e.g. the client lifetime tracking may be one
> thing that could go into it).
[Claudio Takahasi]
1. The functions get_device_name(hcitool.c) and
get_peer_name(dbus-device.c) does the same thing. We should move it to
a common file.
2. The header file dbus.h intends to be a file used by D-Bus client
developers. There are some constants, type definition and function
prototypes that we could move to internal header file:
"dbus-internal.h" or split into separeted file(one for each .c file -
according with Johan's suggestion).


Regards,
Claudio.

>
> Johan
>
>
> -------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc. Do you grep through log fi=
les
> for problems?  Stop!  Download the new AJAX search engine that makes
> searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
> http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D103432&bid=3D230486&dat=
=3D121642
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
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
