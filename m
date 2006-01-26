Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb0601260609n644c313u91d193b8f5df89bb@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] [DBUS] remote name patch
In-Reply-To: <1138047251.3750.6.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <e1effdeb0601201037y4d6eccdem6a9cbca135196520@mail.gmail.com>
	 <1137808123.20856.122.camel@localhost>
	 <e1effdeb0601230833t25905a64he7ca62c7d1ab48cf@mail.gmail.com>
	 <1138036115.7327.14.camel@localhost>
	 <e1effdeb0601231054q2a3e1ec1q6f0e2c90a48c05e3@mail.gmail.com>
	 <1138047251.3750.6.camel@localhost.localdomain>
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
Date: Thu, 26 Jan 2006 12:09:41 -0200

Hi Marcel,

On 1/23/06, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Claudio,
>
> > > Regarding the name, we might simply say the hcid/bluetoothd always se=
nds
> > > a remote name signal if something changes. So it might get the short
> > > name from the extended inquiry first and after that it receives the f=
ull
> > > remote name. We can also always send the cached name and we update th=
at
> > > name on every service discovery, because then it is at zero cost.
> >
> > The remote name is triggered by D-Bus clients. hcid/bluetoothd doesn't
> > request the remote when the inquiry finishes. For EIR, are you
> > suggesting send the "InquiryResult" signal followed by a "RemoteName"?
>
> this sounds like a sane and backward compatible way of doing this.
[Claudio Takahasi]
I did some tests and discovered that if we add extra fields at the
ending we can keep the
backward compatibility if applications check the signature partially.
The functions dbus_message_get_args and dbus_message_get_basic can be
used to extract the first three signal fields(bdaddr, class, rssi)
without broke. For python applications add an extra signal handler
function with the new signature is enough.

Therefore, we have another option: Add the name at the ending of the
"InquiryResult" signal arguments.

>
> > If we send the "RemoteName" with the short name, probably D-Bus
> > clients will not request the RemoteName to retrieve the complete name.
> > D-Bus clients should not distinguish short/complete name.
>
> It is up to hcid/bluetoothd to update the remote when the client
> requests a service discovery.
>
> > Regarding the RemoteName request service signature. Do you agree with
> > my initial proprosal? (see the first e-mail sent: have an alternative
> > to force send the HCI remote name and another using the cache)
>
> No. We don't need any extra stuff. The client asks for a name and we
> give them a name. That's it and all the rest is implementation specific
> to hcid/bluetoothd.
[Claudio Takahasi]
Sorry I didn't understand your proposal. Which logic do you want?
When the hcid/bluetoothd receives the RemoteName(bdaddr) request,
which steps should be done?

This is the patch approach:
name =3D get_device_name(local, bdaddr); /* retrieving from names file */
if (name =3D=3D NULL) {
   /* send HCI remote name request */
}
...
Which modifications must be done on this patch?

>
> > > So we have one device name. This maybe a cached, a remote or a shorte=
ned
> > > name. The application doesn't really have to care and it gets updates=
 as
> > > soon as hcid/bluetoothd knows them.
> > >
> > > Besides the device name, we should implement an alias name. This name=
 is
> > > associated with the BD_ADDR and can be changed by the user if he/she
> > > doesn't like the device name. Implementing this alias through the D-B=
us
> > > interface makes it available for all applications and we can store th=
e
> > > aliases in /var/lib/bluetooth/<bdaddr>/aliases.
> >
> > When a client requests a RemoteName, which value should be returned?
> > The value stored in the aliases file or the value stored in the names
> > file? Or are you suggesting create a property
> > "GetProperty("alias")/SetProperty("alias", "value")?
>
> When they request the remote name or device name, then they get the
> device name that is valid at the moment. This will maybe a cached name,
> but that doesn't matter. If hcid/bluetoothd knows better they will send
> out a remote name signal to tell them.
>
> The alias name is totally different and independent. It is application
> choice to use the alias name or not. If the alias name is empty they can
> use the remote/device name.
[Claudio Takahasi]
Is there someone working on this stuff?

Regards,
Claudio.

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
