Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb0602130537t48c88821r7f6e66589b8fd11e@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] [DBUS PATCH] BlueZ D-Bus redesign
In-Reply-To: <1139835102.19677.9.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <e1effdeb0602101029v4f1b6e9dw8a0a75a4daf6ba55@mail.gmail.com>
	 <1139596810.26234.73.camel@localhost>
	 <20060210230043.GA15483@localhost.localdomain>
	 <1139630105.2098.10.camel@localhost>
	 <20060213073021.GA29708@localhost.localdomain>
	 <e1effdeb0602130444t24aa8668ved44c8800379664@mail.gmail.com>
	 <1139835102.19677.9.camel@localhost>
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
Date: Mon, 13 Feb 2006 11:37:31 -0200

Hi guys,

Just to avoid code conflicts, I will start implement the
discoverable/connectable functions. Eduardo told me that he can fix
the dbus-test python script.

Regards,
Claudio.


On 2/13/06, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Claudio,
>
> > 1. The functions get_device_name(hcitool.c) and
> > get_peer_name(dbus-device.c) does the same thing. We should move it to
> > a common file.
>
> not right now. The code duplication is that small that I have no
> problems with it and creating another internal library for it, is way
> too much overhead.
>
> > 2. The header file dbus.h intends to be a file used by D-Bus client
> > developers. There are some constants, type definition and function
> > prototypes that we could move to internal header file:
> > "dbus-internal.h" or split into separeted file(one for each .c file -
> > according with Johan's suggestion).
>
> I have no favor in any direction at the moment, but I don't think that
> we need a global dbus.h file for other C clients using the D-Bus
> interface. My understanding is that no client should depend on any code
> or headers provided by bluez-libs or bluez-utils. We will make a clean
> split with the D-Bus API. If this means that every client has some kind
> of duplication, so will be it.
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
