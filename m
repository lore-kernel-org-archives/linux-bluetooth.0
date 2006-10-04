Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <becc9d2c0610040814r82bf05dsc851d5629a7adc01@mail.gmail.com>
Date: Wed, 4 Oct 2006 17:14:26 +0200
From: "Andrea Carlevato" <andrea.carlevatoml@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-devel] SDP browsing a 128 bit UUID ???
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1119690767=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1119690767==
Content-Type: multipart/alternative;
	boundary="----=_Part_140959_28857335.1159974866783"

------=_Part_140959_28857335.1159974866783
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,
i ve this problem:

i neet to write a simple code to search a sdp record on
my cell phone, identified by a 128 bit UUID and loaded
by a java midlet.
In particular, the UUID is:
f07122bf9a648cf8082c0553b183326

i wrote this code,  00:11:9F:B0:EA:02 is the MAC of my phone.
But when i run it, value of "err" after 'sdp_service_search_attr_req'
is always 0, and the response list seem to be empty.
Can someone tell me if it's a wrong code ??

thanks a lot
Andrea


-----------------------------------------------------

void sdp_search()
{
    uint32_t svc_uuid_int[] = { 0xf07122bf, 0x09a648cf, 0x8082c055,
0x3b183326 };
    uuid_t svc_uuid;
    int err;
    bdaddr_t target;
    sdp_list_t *response_list = NULL, *search_list, *attrid_list;
    sdp_session_t *session = 0;

    str2ba( "00:11:9F:B0:EA:02", &target );

    // connect to the SDP server running on the remote machine
    printf("SDP Connecting\n");
    session = sdp_connect( BDADDR_ANY, &target, SDP_RETRY_IF_BUSY );
    printf("SDP Connecting\n");


    // specify the UUID of the application we're searching for
    sdp_uuid128_create( &svc_uuid, &svc_uuid_int );
    search_list = sdp_list_append( NULL, &svc_uuid );

    // specify that we want a list of all the matching applications'
attributes
    uint32_t range = 0x0000ffff;
    attrid_list = sdp_list_append( NULL, &range );

    // get a list of service records that have UUID 0xabcd
    err = sdp_service_search_attr_req( session, search_list, \
            SDP_ATTR_REQ_RANGE, attrid_list, &response_list);

    sdp_list_t *r = response_list;
    printf("COMPLETE: %d\n", err);
    // go through each of the service records
    for (; r; r = r->next ) {
        printf("RECORD\n");
        sdp_record_t *rec = (sdp_record_t*) r->data;
        sdp_list_t *proto_list;

        // get a list of the protocol sequences
        if( sdp_get_access_protos( rec, &proto_list ) == 0 ) {
        sdp_list_t *p = proto_list;

        // go through each protocol sequence
        for( ; p ; p = p->next ) {
            sdp_list_t *pds = (sdp_list_t*)p->data;

            // go through each protocol list of the protocol sequence
            for( ; pds ; pds = pds->next ) {

                // check the protocol attributes
                sdp_data_t *d = (sdp_data_t*)pds->data;
                int proto = 0;
                for( ; d; d = d->next ) {
                    switch( d->dtd ) {
                        case SDP_UUID16:
                        case SDP_UUID32:
                        case SDP_UUID128:
                            proto = sdp_uuid_to_proto( &d->val.uuid );
                            break;
                        case SDP_UINT8:
                            if( proto == RFCOMM_UUID ) {
                                printf("rfcomm channel: %d\n",d->val.int8);
                            }
                            break;
                    }
                }
            }
            sdp_list_free( (sdp_list_t*)p->data, 0 );
        }
        sdp_list_free( proto_list, 0 );

        }

        printf("found service record 0x%x\n", rec->handle);
        sdp_record_free( rec );
    }

    sdp_close(session);

}

------=_Part_140959_28857335.1159974866783
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,<br>i ve this problem:<br><br>i neet to write a simple code to search a sdp record on <br>my cell phone, identified by a 128 bit UUID and loaded<br>by a java midlet.<br>In particular, the UUID is:<br>f07122bf9a648cf8082c0553b183326
<br><br>i wrote this code,&nbsp; 00:11:9F:B0:EA:02 is the MAC of my phone.<br>But when i run it, value of &quot;err&quot; after 'sdp_service_search_attr_req'<br>is always 0, and the response list seem to be empty.<br>Can someone tell me if it's a wrong code ??
<br><br>thanks a lot<br>Andrea<br><br><br>-----------------------------------------------------<br><br>void sdp_search()<br>{<br>&nbsp;&nbsp;&nbsp; uint32_t svc_uuid_int[] = { 0xf07122bf, 0x09a648cf, 0x8082c055, 0x3b183326 };<br>&nbsp;&nbsp;&nbsp; uuid_t svc_uuid;
<br>&nbsp;&nbsp;&nbsp; int err;<br>&nbsp;&nbsp;&nbsp; bdaddr_t target;<br>&nbsp;&nbsp;&nbsp; sdp_list_t *response_list = NULL, *search_list, *attrid_list;<br>&nbsp;&nbsp;&nbsp; sdp_session_t *session = 0;<br><br>&nbsp;&nbsp;&nbsp; str2ba( &quot;00:11:9F:B0:EA:02&quot;, &amp;target );<br><br>&nbsp;&nbsp;&nbsp; // connect to the SDP server running on the remote machine
<br>&nbsp;&nbsp;&nbsp; printf(&quot;SDP Connecting\n&quot;);<br>&nbsp;&nbsp;&nbsp; session = sdp_connect( BDADDR_ANY, &amp;target, SDP_RETRY_IF_BUSY );<br>&nbsp;&nbsp;&nbsp; printf(&quot;SDP Connecting\n&quot;);<br>&nbsp;&nbsp;&nbsp; <br><br>&nbsp;&nbsp;&nbsp; // specify the UUID of the application we're searching for
<br>&nbsp;&nbsp;&nbsp; sdp_uuid128_create( &amp;svc_uuid, &amp;svc_uuid_int );<br>&nbsp;&nbsp;&nbsp; search_list = sdp_list_append( NULL, &amp;svc_uuid );<br><br>&nbsp;&nbsp;&nbsp; // specify that we want a list of all the matching applications' attributes<br>&nbsp;&nbsp;&nbsp; uint32_t range = 0x0000ffff;
<br>&nbsp;&nbsp;&nbsp; attrid_list = sdp_list_append( NULL, &amp;range );<br><br>&nbsp;&nbsp;&nbsp; // get a list of service records that have UUID 0xabcd<br>&nbsp;&nbsp;&nbsp; err = sdp_service_search_attr_req( session, search_list, \<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP_ATTR_REQ_RANGE, attrid_list, &amp;response_list);
<br><br>&nbsp;&nbsp;&nbsp; sdp_list_t *r = response_list;<br>&nbsp;&nbsp;&nbsp; printf(&quot;COMPLETE: %d\n&quot;, err);<br>&nbsp;&nbsp;&nbsp; // go through each of the service records<br>&nbsp;&nbsp;&nbsp; for (; r; r = r-&gt;next ) {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf(&quot;RECORD\n&quot;);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdp_record_t *rec = (sdp_record_t*) r-&gt;data;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdp_list_t *proto_list;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // get a list of the protocol sequences<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if( sdp_get_access_protos( rec, &amp;proto_list ) == 0 ) {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdp_list_t *p = proto_list;<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // go through each protocol sequence
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for( ; p ; p = p-&gt;next ) {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdp_list_t *pds = (sdp_list_t*)p-&gt;data;<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // go through each protocol list of the protocol sequence<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for( ; pds ; pds = pds-&gt;next ) {
<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // check the protocol attributes<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdp_data_t *d = (sdp_data_t*)pds-&gt;data;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int proto = 0;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for( ; d; d = d-&gt;next ) {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch( d-&gt;dtd ) { 
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SDP_UUID16:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SDP_UUID32:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SDP_UUID128:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; proto = sdp_uuid_to_proto( &amp;d-&gt;val.uuid );<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SDP_UINT8:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if( proto == RFCOMM_UUID ) {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf(&quot;rfcomm channel: %d\n&quot;,d-&gt;val.int8);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdp_list_free( (sdp_list_t*)p-&gt;data, 0 );<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdp_list_free( proto_list, 0 );<br>
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf(&quot;found service record 0x%x\n&quot;, rec-&gt;handle);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdp_record_free( rec );<br>&nbsp;&nbsp;&nbsp; }<br><br>&nbsp;&nbsp;&nbsp; sdp_close(session);<br><br>}<br><br>

------=_Part_140959_28857335.1159974866783--


--===============1119690767==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1119690767==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1119690767==--
