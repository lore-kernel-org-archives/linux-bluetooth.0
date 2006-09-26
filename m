Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <3f5a9ba20609252330p3d14854eu7b47acc600c28daf@mail.gmail.com>
Date: Tue, 26 Sep 2006 14:30:33 +0800
From: "Mingfan.Lu" <lucharse@gmail.com>
To: Bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-devel] Can I search two services at the same time?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0891598716=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0891598716==
Content-Type: multipart/alternative;
	boundary="----=_Part_550_7854993.1159252233635"

------=_Part_550_7854993.1159252233635
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Problem,
   I have seen that there is a function named sdp_service_search_req,
   So,I append two service uuid such as obexpush's uuid and another
service's uuid into the search list, I want to get the two services' info
only call search func once.
  and then set the max_rec_num = 2,
  then call
       sdp_service_search_req(session,search_list,2,&rsp_list);
 but ,I have seen that the func return 0, but the rsp_list is NULL.

My func named getService() which uses sdp_service_search_req

int BTWorker::getService(Device * pDev)
{
  int CPS_err;
  sdp_list_t *CPS_r,*next;
  sdp_record_t *CPS_rec;
  sdp_list_t *CPS_proto_list;
  bool bFound=false;
  uint8_t numoffound=0;
  uint8_t rfcommChannel;
  uint8_t obexChannel;
  char desc[100];

  bdaddr_t source;//the source dongle should be saved in the adaptor, you
should config it in the ap.ini
  bdaddr_t target;
  str2ba(pDev->getDeviceAddress()->getAddress_str().c_str(),&target);
      sdp_session_t *session = 0;
  str2ba(adaptor->getAddress()->getAddress_str().c_str(),&source);
  // connect to the SDP server running on the remote machine
  session = sdp_connect_custom(&source,&target,SDP_RETRY_IF_BUSY);
  if(session==NULL)
  {
      return -1;
      }

  // specify the UUID of the application service(s) we're searching for
  uint16_t CPS_svc_uuid_int=CPS_SERV_UUID;   // 0x2222
  uint16_t OBEX_svc_uuid_int=OBEX_SERV_UUID; // 0x 1105
  uuid_t CPS_svc_uuid;
  uuid_t OBEX_svc_uuid;
  sdp_uuid16_create(&CPS_svc_uuid, CPS_svc_uuid_int);
  sdp_uuid16_create(&OBEX_svc_uuid,OBEX_svc_uuid_int);

  sdp_list_t * CPS_search_list;
  CPS_search_list = sdp_list_append(NULL,&CPS_svc_uuid);
  CPS_search_list = sdp_list_append(CPS_search_list,&OBEX_svc_uuid );

  // specify that we want a list of all the matching services' attributes

  uint16_t rec_num =2;
  // get a list of service records that have UUID CPS_SERV_UUID +
OBEX_SERV_UUID
  sdp_list_t *CPS_response_list = NULL;

  // search

   CPS_err =
sdp_service_search_req(session,CPS_search_list,255,&CPS_response_list);

  printf("CPS_err is %d\n",CPS_err);
  if(CPS_response_list == NULL)
   printf("Rsp is NULL\n");
  sdp_list_free(CPS_search_list,0);
  sdp_close(session);
  //...............other..................
}

My program's output is:

CPS_err is -1
Rsp is NULL
NO CPS or OBEX svc founded
Get service failed!00:12:D1:D1:08:47

The HCIDUMP -X -V output is:

.................

< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:12:D1:D1:08:47 ptype 0xcc18 rswitch 0x01 clkoffset 0x40c8
(valid)
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 1 bdaddr 00:12:D1:D1:08:47 type ACL encrypt 0x00
< ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
    handle 1 policy 0x0f
    Link policy: RSWITCH HOLD SNIFF PARK
> HCI Event: Command Complete (0x0e) plen 6
    Write Link Policy Settings (0x02|0x000d) ncmd 1
    status 0x00 handle 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 1 slots 5
> HCI Event: Connection Packet Type Changed (0x1d) plen 5
    status 0x00 handle 1 ptype 0xcc18
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> ACL data: handle 1 flags 0x02 dlen 10
    L2CAP(s): Info req: type 2
< ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Info rsp: type 2 result 1
      Not supported
> ACL data: handle 1 flags 0x02 dlen 28
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 1 status 2
      Connection pending - Authorization pending
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
< ACL data: handle 1 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 1 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      Success
      MTU 672
< ACL data: handle 1 flags 0x02 dlen 20
    L2CAP(d): cid 0x0040 len 16 [psm 1]
        SDP SS Req: tid 0x0 len 0xb
          pat uuid-16 0x2222 uuid-16 0x1105 (OBEXObjPush)
          max 2
          cont 00
> ACL data: handle 2 flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 1]
        SDP SS Rsp: tid 0x0 len 0x5
          count 0
          cont 00
< ACL data: handle 2 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x00bb scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 2 packets 1
> ACL data: handle 2 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x00bb scid 0x0040
< HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 1 reason 0x13
    Reason: Remote User Terminated Connection
> HCI Event: Command Status (0x0f) plen 4
    Disconnect (0x01|0x0006) status 0x00 ncmd 1
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 1 reason 0x16
    Reason: Connection Terminated by Local Host
< HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 2 reason 0x13
    Reason: Remote User Terminated Connection
> HCI Event: Command Status (0x0f) plen 4
    Disconnect (0x01|0x0006) status 0x00 ncmd 1
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 2 reason 0x16
    Reason: Connection Terminated by Local Host


 Who can you tell me why?
thank you.

-- 
With respects,
   Mingfan.Lu


-- 
With respects,
   Mingfan.Lu

------=_Part_550_7854993.1159252233635
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Problem,</div>
<div>&nbsp;&nbsp; I have seen that there is a&nbsp;function named sdp_service_search_req,</div>
<div>&nbsp;&nbsp; So,I append two service uuid such as obexpush's uuid and another service's uuid into the search list, I want to get the two services' info only call search func once.</div>
<div>&nbsp; and then set the max_rec_num = 2,</div>
<div>&nbsp; then call </div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdp_service_search_req(session,search_list,2,&amp;rsp_list);</div>
<div>&nbsp;but ,I have seen that the func return 0, but the rsp_list is NULL.</div>
<div>&nbsp;</div>
<div>My func named getService() which uses sdp_service_search_req</div>
<div>
<p>int BTWorker::getService(Device * pDev)<br>{<br>&nbsp;&nbsp;int CPS_err;<br>&nbsp;&nbsp;sdp_list_t *CPS_r,*next;<br>&nbsp;&nbsp;sdp_record_t *CPS_rec;<br>&nbsp;&nbsp;sdp_list_t *CPS_proto_list;<br>&nbsp;&nbsp;bool bFound=false;<br>&nbsp;&nbsp;uint8_t numoffound=0;<br>&nbsp;&nbsp;uint8_t rfcommChannel; 
<br>&nbsp;&nbsp;uint8_t obexChannel;<br>&nbsp;&nbsp;char desc[100];</p>
<p>&nbsp;&nbsp;bdaddr_t source;//the source dongle should be saved in the adaptor, you should config it in the ap.ini<br>&nbsp;&nbsp;bdaddr_t target;<br>&nbsp;&nbsp;str2ba(pDev-&gt;getDeviceAddress()-&gt;getAddress_str().c_str(),&amp;target);<br>&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;sdp_session_t *session = 0; 
<br>&nbsp;&nbsp;str2ba(adaptor-&gt;getAddress()-&gt;getAddress_str().c_str(),&amp;source);<br>&nbsp;&nbsp;// connect to the SDP server running on the remote machine<br>&nbsp;&nbsp;session = sdp_connect_custom(&amp;source,&amp;target,SDP_RETRY_IF_BUSY); 
<br>&nbsp;&nbsp;if(session==NULL)<br>&nbsp;&nbsp;{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -1;<br>&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;}</p>
<p>&nbsp;&nbsp;// specify the UUID of the application service(s) we're searching for<br>&nbsp;&nbsp;uint16_t CPS_svc_uuid_int=CPS_SERV_UUID;&nbsp;&nbsp; // 0x2222<br>&nbsp;&nbsp;uint16_t OBEX_svc_uuid_int=OBEX_SERV_UUID; // 0x 1105<br>&nbsp;&nbsp;uuid_t CPS_svc_uuid;<br>
&nbsp;&nbsp;uuid_t OBEX_svc_uuid;<br>&nbsp;&nbsp;sdp_uuid16_create(&amp;CPS_svc_uuid, CPS_svc_uuid_int);<br>&nbsp;&nbsp;sdp_uuid16_create(&amp;OBEX_svc_uuid,OBEX_svc_uuid_int);</p>
<p>&nbsp;&nbsp;sdp_list_t * CPS_search_list;<br>&nbsp;&nbsp;CPS_search_list = sdp_list_append(NULL,&amp;CPS_svc_uuid);<br>&nbsp;&nbsp;CPS_search_list = sdp_list_append(CPS_search_list,&amp;OBEX_svc_uuid );<br>&nbsp;&nbsp;<br>&nbsp;&nbsp;// specify that we want a list of all the matching services' attributes 
</p>
<p>&nbsp;&nbsp;uint16_t rec_num =2;<br>&nbsp;&nbsp;// get a list of service records that have UUID CPS_SERV_UUID + OBEX_SERV_UUID<br>&nbsp;&nbsp;sdp_list_t *CPS_response_list = NULL;</p>
<p>&nbsp;&nbsp;// search<br>&nbsp;&nbsp;<br>&nbsp; &nbsp;CPS_err = sdp_service_search_req(session,CPS_search_list,255,&amp;CPS_response_list);<br>&nbsp;&nbsp;<br>&nbsp;&nbsp;printf(&quot;CPS_err is %d\n&quot;,CPS_err);<br>&nbsp;&nbsp;if(CPS_response_list == NULL)<br>&nbsp;&nbsp;&nbsp;printf(&quot;Rsp is NULL\n&quot;); 
<br>&nbsp;&nbsp;sdp_list_free(CPS_search_list,0);<br>&nbsp;&nbsp;sdp_close(session);<br>&nbsp;&nbsp;//...............other..................<br>}</p>
<p>My program's output is:</p>
<p>CPS_err is -1<br>Rsp is NULL<br>NO CPS or OBEX svc founded<br>Get service failed!00:12:D1:D1:08:47</p>
<p>The HCIDUMP -X -V output is:</p>
<p>.................</p>
<p>&lt; HCI Command: Create Connection (0x01|0x0005) plen 13<br>&nbsp;&nbsp;&nbsp; bdaddr 00:12:D1:D1:08:47 ptype 0xcc18 rswitch 0x01 clkoffset 0x40c8 (valid)<br>&nbsp;&nbsp;&nbsp; Packet type: DM1 DM3 DM5 DH1 DH3 DH5<br>&gt; HCI Event: Command Status (0x0f) plen 4 
<br>&nbsp;&nbsp;&nbsp; Create Connection (0x01|0x0005) status 0x00 ncmd 1<br>&gt; HCI Event: Connect Complete (0x03) plen 11<br>&nbsp;&nbsp;&nbsp; status 0x00 handle 1 bdaddr 00:12:D1:D1:08:47 type ACL encrypt 0x00<br>&lt; ACL data: handle 1 flags 0x02 dlen 12 
<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Connect req: psm 1 scid 0x0040<br>&lt; HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4<br>&nbsp;&nbsp;&nbsp; handle 1 policy 0x0f<br>&nbsp;&nbsp;&nbsp; Link policy: RSWITCH HOLD SNIFF PARK<br>&gt; HCI Event: Command Complete (0x0e) plen 6 
<br>&nbsp;&nbsp;&nbsp; Write Link Policy Settings (0x02|0x000d) ncmd 1<br>&nbsp;&nbsp;&nbsp; status 0x00 handle 1<br>&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>&nbsp;&nbsp;&nbsp; handle 1 packets 1<br>&gt; HCI Event: Max Slots Change (0x1b) plen 3<br>
&nbsp;&nbsp;&nbsp; handle 1 slots 5<br>&gt; HCI Event: Connection Packet Type Changed (0x1d) plen 5<br>&nbsp;&nbsp;&nbsp; status 0x00 handle 1 ptype 0xcc18<br>&nbsp;&nbsp;&nbsp; Packet type: DM1 DM3 DM5 DH1 DH3 DH5<br>&gt; ACL data: handle 1 flags 0x02 dlen 10<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Info req: type 2 
<br>&lt; ACL data: handle 1 flags 0x02 dlen 12<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Info rsp: type 2 result 1<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Not supported<br>&gt; ACL data: handle 1 flags 0x02 dlen 28<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 1 status 2 
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Connection pending - Authorization pending<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Connection successful<br>&lt; ACL data: handle 1 flags 0x02 dlen 12<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0 
<br>&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>&nbsp;&nbsp;&nbsp; handle 1 packets 1<br>&gt; ACL data: handle 1 flags 0x02 dlen 12<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0<br>&gt; HCI Event: Number of Completed Packets (0x13) plen 5 
<br>&nbsp;&nbsp;&nbsp; handle 1 packets 1<br>&lt; ACL data: handle 1 flags 0x02 dlen 14<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success<br>&gt; ACL data: handle 1 flags 0x02 dlen 18<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4 
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MTU 672<br>&lt; ACL data: handle 1 flags 0x02 dlen 20<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 16 [psm 1]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SS Req: tid 0x0 len 0xb<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pat uuid-16 0x2222 uuid-16 0x1105 (OBEXObjPush) 
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max 2<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont 00<br>&gt; ACL data: handle 2 flags 0x02 dlen 14<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 10 [psm 1]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SS Rsp: tid 0x0 len 0x5<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; count 0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont 00<br>&lt; ACL data: handle 2 flags 0x02 dlen 12 
<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Disconn req: dcid 0x00bb scid 0x0040<br>&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>&nbsp;&nbsp;&nbsp; handle 2 packets 1<br>&gt; ACL data: handle 2 flags 0x02 dlen 12<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Disconn rsp: dcid 0x00bb scid 0x0040 
<br>&lt; HCI Command: Disconnect (0x01|0x0006) plen 3<br>&nbsp;&nbsp;&nbsp; handle 1 reason 0x13<br>&nbsp;&nbsp;&nbsp; Reason: Remote User Terminated Connection<br>&gt; HCI Event: Command Status (0x0f) plen 4<br>&nbsp;&nbsp;&nbsp; Disconnect (0x01|0x0006) status 0x00 ncmd 1 
<br>&gt; HCI Event: Disconn Complete (0x05) plen 4<br>&nbsp;&nbsp;&nbsp; status 0x00 handle 1 reason 0x16<br>&nbsp;&nbsp;&nbsp; Reason: Connection Terminated by Local Host<br>&lt; HCI Command: Disconnect (0x01|0x0006) plen 3<br>&nbsp;&nbsp;&nbsp; handle 2 reason 0x13 
<br>&nbsp;&nbsp;&nbsp; Reason: Remote User Terminated Connection<br>&gt; HCI Event: Command Status (0x0f) plen 4<br>&nbsp;&nbsp;&nbsp; Disconnect (0x01|0x0006) status 0x00 ncmd 1<br>&gt; HCI Event: Disconn Complete (0x05) plen 4<br>&nbsp;&nbsp;&nbsp; status 0x00 handle 2 reason 0x16 
<br>&nbsp;&nbsp;&nbsp; Reason: Connection Terminated by Local Host</p></div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>&nbsp;Who can you tell me why?</div>
<div>thank you.</div>
<div><br>-- <br>With respects,<br>&nbsp;&nbsp; Mingfan.Lu </div><br clear="all"><br>-- <br>With respects,<br>&nbsp;&nbsp; Mingfan.Lu 

------=_Part_550_7854993.1159252233635--


--===============0891598716==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0891598716==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0891598716==--
