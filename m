Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb05032812481ffbe5a2@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Re: [Bluez-users] PANU service search
In-Reply-To: <1112040117.9016.47.camel@pegasus>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_5223_29601721.1112042926102"
References: <e1effdeb05032805225cf1b8dd@mail.gmail.com>
	 <1112016560.9016.32.camel@pegasus>
	 <e1effdeb0503280607600d1863@mail.gmail.com>
	 <1112019482.9016.37.camel@pegasus>
	 <e1effdeb050328110339a02eb7@mail.gmail.com>
	 <1112037740.9016.45.camel@pegasus>
	 <e1effdeb05032811466fe34801@mail.gmail.com>
	 <1112040117.9016.47.camel@pegasus>
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
Date: Mon, 28 Mar 2005 17:48:46 -0300

------=_Part_5223_29601721.1112042926102
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Marcel,

Sorry, I forgot clarify one point. I added the function "add_panu"
just for convenience.
Search for PANU service is just a small part of my project, I need solve a lot
bluetooth issues to provide a seamless connectivity for UPnP applications.

I agree that the function "add_panu" is unncessary if we consider that
this service is
provided by pand daemon (pand --listen --role PANU) Therefore, another
approach is
add "NULL" instead of  "add_panu" in the service structure. The patch
for this approach
is attached. Be aware that "sdptool add panu" will run but nothing
will be exported.
The structure "service" is common for add and search features.

I have 3 years of experience with mobile application for cell phones,
but this is my
first open source development. Sorry for the large amount of emails,
but understand
all bluez features is hard task.

Please forgot my last email. When my research became more advanced/clear I will
contact you again for support. 

Regards,
Claudio.
________________________________________
Claudio Takahasi
INdT - Nokia Technology Institute
Phone: +55 81 21223034
Recife - Pernambuco - Brazil 




On Mon, 28 Mar 2005 22:01:57 +0200, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Claudio,
> 
> > The code for support search for PANU service is attached. The change
> > is very small
> > but will help me create a PAN for UPnP application in ad hoc scenario.
> 
> I applied the patch to the CVS, but I still don't get why you needed it
> in the first place. The pand application is able to register the PANU
> service record and search for it by itself.
> 
> Regards
> 
> Marcel
> 
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>

------=_Part_5223_29601721.1112042926102
Content-Type: text/x-patch; name="panu_support_2.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="panu_support_2.diff"

--- bluez-utils-2.15-panu2/tools/sdptool.c=092005-03-28 17:27:13.934245848 =
-0300
+++ bluez-utils-2.15/tools/sdptool.c=092004-12-25 16:06:02.000000000 -0200
@@ -1793,7 +1793,6 @@
=20
 =09{ "NAP",=09NAP_SVCLASS_ID,=09=09=09add_nap=09=09},
 =09{ "GN",=09=09GN_SVCLASS_ID,=09=09=09add_gn=09=09},
-=09{ "PANU",       PANU_SVCLASS_ID,                NULL            },
=20
 =09{ "HID",=09HID_SVCLASS_ID,=09=09=09NULL=09=09},
 =09{ "CIP",=09CIP_SVCLASS_ID,=09=09=09NULL=09=09},

------=_Part_5223_29601721.1112042926102--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
