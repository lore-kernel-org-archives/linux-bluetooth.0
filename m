Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <537e39c905073003545b9466c@mail.gmail.com>
From: Jordi Jaen Pallares <jordijp@gmail.com>
To: bluez-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_11943_20019814.1122720853701"
Subject: [Bluez-devel] Trouble adding a text parameter to the SDP service record
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
Date: Sat, 30 Jul 2005 12:54:13 +0200

------=_Part_11943_20019814.1122720853701
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi list,

I am trying to add a attribute "Public Key" (20 bytes length) to the=20
description of a service, but I get a segfault (see code below).=20

Following some examples in the bluez source code=20
(and in=20
http://people.csail.mit.edu/people/albert/pubs/ashuang-sm-thesis-2005.pdf)=
=20
I have managed to add successfully the PSM and the protocol version=20
attributes to the service description, but I could not find examples of=20
adding "custom" parameters.=20

I am sure that I still have to provide an identifier to the attribute, but=
=20
could not find out how to do it.

Any further help will be appreciated.

Here is the code :

---- snip ----

int main()
{
int ret =3D 0;
uint32_t service_uuid_int[] =3D { 0, 0, 0, 0x00FF };
uint16_t l2cap_psm =3D 1111, ver =3D 0x001;
uuid_t root_uuid, l2cap_uuid, svc_uuid;

sdp_list_t *l2cap_list =3D 0 ,
*root_list =3D 0 ,
*proto_list =3D 0 ,
*access_proto_list =3D 0 ;

sdp_data_t *psm =3D 0 , *version =3D 0, *psha1 =3D 0;

const char *service_name =3D "new service";
const char *service_dsc =3D "description of my service" ;
const char *service_prov =3D "Bluetooth Access Point" ;

// this is the key I want to put in the parameter
const char *pubsha1 =3D "0123456789abcdef6789" ;

sdp_record_t *record =3D sdp_record_alloc();

// set the general service ID
sdp_uuid128_create (&svc_uuid, &service_uuid_int) ;
sdp_set_service_id (record, svc_uuid) ;

// make the service record publicly browsable
sdp_uuid16_create (&root_uuid, PUBLIC_BROWSE_GROUP) ;
root_list =3D sdp_list_append (0, &root_uuid) ;
sdp_set_browse_groups (record, root_list) ;
sdp_list_free (root_list, 0);

// set l2cap information
sdp_uuid16_create (&l2cap_uuid, L2CAP_UUID) ;
l2cap_list =3D sdp_list_append (0, &l2cap_uuid) ;

// set PSM information=20
psm =3D sdp_data_alloc (SDP_UINT16, &l2cap_psm) ;
l2cap_list =3D sdp_list_append (l2cap_list, psm) ;=20

// set protocol version=20
version =3D sdp_data_alloc(SDP_UINT16, &ver);
l2cap_list =3D sdp_list_append(l2cap_list, version);

// set key parameter
psha1 =3D sdp_data_alloc(SDP_TEXT_STR16, pubsha1) ;
l2cap_list =3D sdp_list_append (l2cap_list, psha1) ;

proto_list =3D sdp_list_append (0 , l2cap_list) ;

// attach protocol information to service record
access_proto_list =3D sdp_list_append ( 0 , proto_list ) ;
printf("The next line causes segmentation fault\n");
sdp_set_access_protos ( record, access_proto_list ) ;
printf("not reached\n");

// set the name, provider , and description
sdp_set_info_attr (record, service_name, service_prov, service_dsc ) ;

// connect to the local SDP server and register the service record
sdp_session_t *session =3D 0 ;

session =3D sdp_connect ( BDADDR_ANY, BDADDR_LOCAL, SDP_RETRY_IF_BUSY ) ;
ret =3D sdp_record_register ( session , record , SDP_RECORD_PERSIST ) ;
if (ret < 0) {
printf("Service Record registration failed\n");
ret =3D -1;

}=20

printf("Service registration completed\n");

// cleanup
sdp_list_free (l2cap_list, 0);
sdp_list_free (access_proto_list, 0);
sdp_record_free (record);

return ret;
}

--- snap ---

Best regards,

Jordi

------=_Part_11943_20019814.1122720853701
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi list,<br>
<br>
I am trying to add a attribute &quot;Public Key&quot; (20 bytes length) to =
the
description of a service, but I get a segfault (see code below). <br>
<br>
Following some examples in the bluez source code <br>
(and in <a href=3D"http://people.csail.mit.edu/people/albert/pubs/ashuang-s=
m-thesis-2005.pdf">http://people.csail.mit.edu/people/albert/pubs/ashuang-s=
m-thesis-2005.pdf</a>) <br>
I
have managed to add successfully the PSM and the protocol version
attributes to the service description, but I could not find examples of
adding &quot;custom&quot; parameters. <br>
<br>
I am sure that I still have to provide an identifier to the attribute, but =
could not find out how to do it.<br>
<br>
Any further help will be appreciated.<br>
<br>
Here is the code :<br>
<br>
---- snip ----<br>
<br>
int main()<br>
{<br>
&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;&nbsp;&nbsp; uint32_t service_uuid_int[] =3D { 0, 0, 0, 0x00FF };<br>
&nbsp;&nbsp;&nbsp; uint16_t l2cap_psm =3D 1111, ver =3D 0x001;<br>
&nbsp;&nbsp;&nbsp; uuid_t root_uuid, l2cap_uuid, svc_uuid;<br>
<br>
&nbsp;&nbsp;&nbsp; sdp_list_t&nbsp;&nbsp;&nbsp; *l2cap_list =3D 0 ,<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; *root_list =3D 0 ,=
<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; *proto_list =3D 0 =
,<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; *access_proto_list=
 =3D 0 ;<br>
<br>
&nbsp;&nbsp;&nbsp; sdp_data_t *psm =3D 0 , *version =3D 0, *psha1 =3D 0;<br=
>
<br>
&nbsp;&nbsp;&nbsp; const char *service_name =3D &quot;new service&quot;;<br=
>
&nbsp;&nbsp;&nbsp; const char *service_dsc =3D &quot;description of my serv=
ice&quot; ;<br>
&nbsp;&nbsp;&nbsp; const char *service_prov =3D &quot;Bluetooth Access Poin=
t&quot; ;<br><br>
&nbsp;&nbsp;&nbsp; // this is the key I want to put in the parameter<br>
&nbsp;&nbsp;&nbsp; const char *pubsha1 =3D &quot;0123456789abcdef6789&quot;=
 ;<br>
&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; sdp_record_t *record =3D sdp_record_alloc();<br>
&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; // set the general service ID<br>
&nbsp;&nbsp;&nbsp; sdp_uuid128_create (&amp;svc_uuid, &amp;service_uuid_int=
) ;<br>
&nbsp;&nbsp;&nbsp; sdp_set_service_id (record, svc_uuid) ;<br>
&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; // make the service record publicly browsable<br>
&nbsp;&nbsp;&nbsp; sdp_uuid16_create (&amp;root_uuid, PUBLIC_BROWSE_GROUP) =
;<br>
&nbsp;&nbsp;&nbsp; root_list =3D sdp_list_append (0, &amp;root_uuid) ;<br>
&nbsp;&nbsp;&nbsp; sdp_set_browse_groups (record, root_list) ;<br>
&nbsp;&nbsp;&nbsp; sdp_list_free (root_list, 0);<br>
<br>
&nbsp;&nbsp;&nbsp; // set l2cap information<br>
&nbsp;&nbsp;&nbsp; sdp_uuid16_create (&amp;l2cap_uuid, L2CAP_UUID) ;<br>
&nbsp;&nbsp;&nbsp; l2cap_list =3D sdp_list_append (0, &amp;l2cap_uuid) ;<br=
>
<br>
&nbsp;&nbsp;&nbsp; // set PSM information <br>
&nbsp;&nbsp;&nbsp; psm =3D sdp_data_alloc (SDP_UINT16, &amp;l2cap_psm) ;<br=
>
&nbsp;&nbsp;&nbsp; l2cap_list =3D sdp_list_append (l2cap_list, psm) ; <br>
<br>
&nbsp;&nbsp;&nbsp; // set protocol version <br>
&nbsp;&nbsp;&nbsp; version =3D sdp_data_alloc(SDP_UINT16, &amp;ver);<br>
&nbsp;&nbsp;&nbsp; l2cap_list =3D sdp_list_append(l2cap_list, version);<br>
<br>
&nbsp;&nbsp;&nbsp; // set key parameter<br>
&nbsp;&nbsp;&nbsp; psha1 =3D sdp_data_alloc(SDP_TEXT_STR16, pubsha1) ;<br>
&nbsp;&nbsp;&nbsp; l2cap_list =3D sdp_list_append (l2cap_list, psha1) ;<br>
<br>
&nbsp;&nbsp;&nbsp; proto_list =3D sdp_list_append (0 , l2cap_list) ;<br>
<br>
&nbsp;&nbsp;&nbsp; // attach protocol information to service record<br>
&nbsp;&nbsp;&nbsp; access_proto_list =3D sdp_list_append ( 0 , proto_list )=
 ;<br>
printf(&quot;The next line causes segmentation fault\n&quot;);<br>
&nbsp;&nbsp;&nbsp; sdp_set_access_protos ( record, access_proto_list ) ;<br=
>
printf(&quot;not reached\n&quot;);<br>
<br>
&nbsp;&nbsp;&nbsp; // set the name, provider , and description<br>
&nbsp;&nbsp;&nbsp; sdp_set_info_attr (record, service_name, service_prov, s=
ervice_dsc ) ;<br>
&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; // connect to the local SDP server and register the serv=
ice record<br>
&nbsp;&nbsp;&nbsp; sdp_session_t *session =3D 0 ;<br>
<br>
&nbsp;&nbsp;&nbsp; session =3D sdp_connect ( BDADDR_ANY, BDADDR_LOCAL, SDP_=
RETRY_IF_BUSY ) ;<br>
&nbsp;&nbsp;&nbsp; ret =3D sdp_record_register ( session , record , SDP_REC=
ORD_PERSIST ) ;<br>
&nbsp;&nbsp;&nbsp; if (ret &lt; 0) {<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; printf(&quot;Service Record registrat=
ion failed\n&quot;);<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ret =3D -1;<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; } <br>
<br>
&nbsp;&nbsp;&nbsp; printf(&quot;Service registration completed\n&quot;);<br=
>
<br>
&nbsp;&nbsp;&nbsp; // cleanup<br>
&nbsp;&nbsp;&nbsp; sdp_list_free (l2cap_list, 0);<br>
&nbsp;&nbsp;&nbsp; sdp_list_free (access_proto_list, 0);<br>
&nbsp;&nbsp;&nbsp; sdp_record_free (record);<br>
<br>
&nbsp;&nbsp;&nbsp; return ret;<br>
}<br>
<br>
--- snap ---<br>
<br>
Best regards,<br>
<br>
Jordi<br>


------=_Part_11943_20019814.1122720853701--


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
