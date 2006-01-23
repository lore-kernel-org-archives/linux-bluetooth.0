Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb0601230833t25905a64he7ca62c7d1ab48cf@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] [DBUS] remote name patch
In-Reply-To: <1137808123.20856.122.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <e1effdeb0601201037y4d6eccdem6a9cbca135196520@mail.gmail.com>
	 <1137808123.20856.122.camel@localhost>
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
Date: Mon, 23 Jan 2006 14:33:04 -0200

Hi Marcel,


I has just read some parts of "Specification Change Request". What is
the current status of the BlueZ Kernel? I figure out that there is a
function to parse the extended inquiry result event, however in the
code I have the 240 bytes are being ignored.

I prefer use just one signal instead of add a new signal to represent
the extended inquiry response. My suggestion is unify the standard and
the extended inquiry. If the user wants to know some response
properties, we can add an extra signal field to indicate the
type(Standard, with RSSI or EIR) and the remote name property(shorted,
full, cached).

Regarding the shorted/full name, in my opinion applications generally
will not want to distinguish the name type. The others UUIDs(service,
manufacturer, ...) included in the EIR packet can be ignore for now.
If required, we add extra fields in the inquiry cache to store these
UUIDs and add an D-Bus services to retrieve these data later.

Inquiry Result signal format proposal:

/* type flags */
#define STD_INQUIRY_RESPONSE   0x00010000
#define RSSI_INQUIRY_RESPONSE  0x00010000  /* RSSI included*/
#define EIR_INQUIRY_RESPONSE   0x01000000  /* */

/* name flags */
#define SHORTED_NAME           0x00000001
#define FULL_NAME              0x00000010
#define CACHED_NAME            0x00000100

Signal arguments:
UINT32: type (STD_INQUIRY_RESPONSE/RSSI_INQUIRY_RESPONSE/EIR_INQUIRY_RESPON=
SE
| FLAGS
String: BDADDR
String: name /* "n/a", cached value, shorted or full name */
UINT32: Device class
INT32: RSSI

"n/a" in the name field will be applied to standard inquiry, where the
remote name should be retrieved later or for EIR, when the local name
length is zero.

What do you think?  Do you have another suggestion or comments?

Regards,
Claudio.

On 1/20/06, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Claudio,
>
> > The attached patch improves the remote name request. It's the same
> > approach of "hcitool name", I am using the textfile library. Maybe we
> > should move the function "get_device_name" to a common place, like
> > "libtextfile.a" or create a new utility library(ie: "libbluezutil.a").
>
> before I pick up this patch, we might wanna discuss the three different
> kinds of device names we will have in the future. The full remote name
> of a device, the local cached name and then the name (shorted or full)
> from the extended inquiry. How do we deal with them? Do we wanna give
> the user of the D-Bus API any chance to distinguish between them?
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
