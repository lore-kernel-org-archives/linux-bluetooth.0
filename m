Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb0602140426x662ffa26id1fb386397280da8@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] [DBUS PATCH] scan mode
In-Reply-To: <1139902844.21873.2.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <e1effdeb0602130950x5834aa71lb6eeeec3fc5bb4cd@mail.gmail.com>
	 <1139902844.21873.2.camel@localhost>
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
Date: Tue, 14 Feb 2006 10:26:34 -0200

Hi Marcel,

On 2/14/06, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Claudio,
>
> > This patch add/fix the following services:
> > 1. Changed GetMode/SetMode arguments to string, instead of use byte
> > 2. Added IsConnectable
> > 3. Added IsDiscoverable
>
> I applied the patch to keep it going, but we need to rework the data
> object associated with the device path. Using it like this
>
>         const uint8_t hci_mode =3D dbus_data->path_data;
>
> won't work forever and actually it is bad coding.
[Claudio Takahasi]
I don't know exactly what is problem, but I guess it should be related
to uint32 to uint8 casting.

I will change the path_data to a device settings structure, where I
want store the scan mode and the discoverable timeout. In my opinion
the discoverable timeout should be unique for each local adapter. Do
you have any comments or suggestion?


 struct device_settings {
         uint32_t discoverable_to;
         uint8_t  scan_mode;
 };

 struct hci_dbus_data {
         uint16_t dev_id;
         uint16_t path_id;
         struct device_settings dev_settings;
 };

>
> > Next action:
> > - Discoverable timout functions.
>
> Go ahead. I really like to see this in action.
[Claudio Takahasi]
I am planning use the SIGALARM. Another option is integrate inside the
main loop, using a poll timeout. However it is a little bit more
complicated.
Do you agree with this approach?

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
