Return-Path: <StefanMischke@web.de>
Message-ID: <412F3619.40202@web.de>
Date: Fri, 27 Aug 2004 15:24:41 +0200
From: Stefan Mischke <StefanMischke@web.de>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>,
   "Stefan Mischke (E-Mail)" <survivor@upb.de>
Subject: Re: [Bluez-devel] SDP memory leak?
References: <412F29D2.7000001@web.de> <1093610969.2581.119.camel@pegasus>
In-Reply-To: <1093610969.2581.119.camel@pegasus>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: StefanMischke@web.de
List-ID: <bluez-devel.lists.sourceforge.net>

Hi!

Marcel Holtmann schrieb:

>no, I think you are right. I expect more memory leaks in the SDP code.
>We need some people to check this and send me patches.
>  
>
Well then, I just figured out (in my own TestApp based on 
"bnep_sdp_search()") that it simply doesn't work like this. I propose to 
do "sdp_close()" as the last sdp_* call (as in the code below). Same 
with dund. So there might be no memory leak but an illegal pointer 
access. One has to correct "pand/sdp.c" and "dund/sdp.c".

Regards
Stefan

<CODE>

int bnep_sdp_search(bdaddr_t *src, bdaddr_t *dst, uint16_t service)
{
    sdp_list_t *srch, *rsp = NULL;
    sdp_session_t *s;
    uuid_t svclass;
    int err, res;

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
    res = sdp_list_len(rsp);
    sdp_close(s);

    /* Assume that search is successeful
     * if at least one record is found */
    if (!err && res)
        return 1;

    return 0;
}

</CODE>
