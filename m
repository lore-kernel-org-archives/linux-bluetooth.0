Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <6fe4bec60504052037e64ed52@mail.gmail.com>
From: shamsheer yousaf <shamsheeryousaf@gmail.com>
To: Bluez-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_8250_22515595.1112758646340"
Subject: [Bluez-devel] SDP data elements
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
Date: Wed, 6 Apr 2005 09:07:26 +0530

------=_Part_8250_22515595.1112758646340
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi ,
I'm implementing JSR-82 as a project for college using BlueZ as the native=
=20
protocol stack.=20
One of the things JSR-82 specifies is creation of data elements for the SDP=
.=20
The JSR-82 specifies codes for each type of data element which corresponds=
=20
to the bluetooth datatype + size descriptor code. Now JSR-82 specifies=20
DataSequence code as 0x30 and DataAlternate code as 0x38. When i looked in=
=20
the sdp.h header file these codes corresponded to SDP_SEQ_UNSPEC and=20
SDP_ALT_UNSPEC ,which seems to be allright. But when i looked in the
sdp.cat the sdp_data_alloc() function (which i'm using to allocate
data elements
for other types like INT16,INT32 etc) , i cann't find an entry for=20
SDP_SEQ_UNSPEC and SDP_ALT_UNSPEC. Are these types supported by Bluez? If s=
o=20
, how can i create an instance of these types.

Thanking you in advance

Yours Sincerely
Shamsheer Y
--=20
"Never let your sense of morals prevent you from doing what is right!"=20
- "Salvor Hardin , Foundation " , Isaac Asimoc

------=_Part_8250_22515595.1112758646340
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi ,<br>
&nbsp; I'm implementing JSR-82 as a project for college using BlueZ as the =
native protocol stack. <br>
One of the things JSR-82 specifies is creation of data elements for the
SDP. The JSR-82 specifies codes for each type of data element which
corresponds to the bluetooth datatype&nbsp; + size descriptor code. Now
JSR-82 specifies DataSequence code as 0x30 and DataAlternate code as
0x38. When i looked in the sdp.h header file these codes corresponded
to SDP_SEQ_UNSPEC and&nbsp; SDP_ALT_UNSPEC ,which seems to be allright.
But when i looked in the sdp.c at the sdp_data_alloc() function (which
i'm using to allocate data elements for other types like INT16,INT32
etc) , i cann't find an entry for SDP_SEQ_UNSPEC and&nbsp;
SDP_ALT_UNSPEC. Are these types supported by Bluez? If so , how can i
create an instance of these types.<br>
<br>
Thanking you in advance<br>
<br>
Yours Sincerely<br>
Shamsheer Y<br>-- <br>&quot;Never let your sense of morals prevent you from=
 doing what is right!&quot; <br>&nbsp;&nbsp; - &quot;Salvor Hardin , Founda=
tion &quot; , Isaac Asimoc
------=_Part_8250_22515595.1112758646340--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
