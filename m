Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <412F29D2.7000001@web.de>
From: Stefan Mischke <StefanMischke@web.de>
MIME-Version: 1.0
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
CC: "Stefan Mischke (E-Mail)" <survivor@upb.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-devel] SDP memory leak?
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 27 Aug 2004 14:32:18 +0200

Hello,

I have a question about "bnep_sdp_search()" from 
"bluez-pan-1.1/pand/sdp.c" (see below for the code).
If I see it correctly, the memory for "sdp_list_t *srch, *rsp" is 
allocated by "sdp_service_search_req()".
But "bnep_sdp_search()" accesses the pointer "rsp" after it has done 
"sdp_close()".
So my question is: 'Who will ever free the memory allocated at "rsp" and 
when?'

I quite new to this, so I probably have missed something. So sorry if 
this is a stupid one :-).

Kind regards
Stefan

<CODE>
int bnep_sdp_search(bdaddr_t *src, bdaddr_t *dst, uint16_t service)
{
    sdp_list_t *srch, *rsp = NULL;
    sdp_session_t *s;
    uuid_t svclass;
    int err;

    switch (service) {
    case BNEP_SVC_PANU:
        sdp_uuid16_create(&svclass, PANU_SVCLASS_ID);
        break;
    case BNEP_SVC_NAP:
        sdp_uuid16_create(&svclass, NAP_SVCLASS_ID);
        break;
    case BNEP_SVC_GN:
        sdp_uuid16_create(&svclass, GN_SVCLASS_ID);
        break;
    }
       
    srch = sdp_list_append(NULL, &svclass);

    s = sdp_connect(src, dst, 0);
    if (!s) {
        syslog(LOG_ERR, "Failed to connect to the SDP server. %s(%d)",
                strerror(errno), errno);
        return 0;
    }

    err = sdp_service_search_req(s, srch, 1, &rsp);
    sdp_close(s);

    /* Assume that search is successeful
     * if at least one record is found */
    if (!err && sdp_list_len(rsp))
        return 1;

    return 0;
} </CODE>



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
