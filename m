Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] confusion about libs/sdp.c -
	sdp_service_search_req()
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Cc: Stephen Crane <steve.crane@rococosoft.com>
In-Reply-To: <ef9938ec05022511243993f46d@mail.gmail.com>
References: <ef9938ec05022511243993f46d@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1109579650.17256.29.camel@pegasus>
Mime-Version: 1.0
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
Date: Mon, 28 Feb 2005 09:34:10 +0100

Hi Albert,

> the documentation for sdp_service_search_req() states that it outputs
> an sdp_list_t * of sdp_record_t * (list of sdp service records)
> 
> reading through the code, it appears that it actually returns a list
> of uint32_t * data structures.
> 
> line 2721:
>         extract_record_handle_seq(pdata, rsp, rec_count, &scanned);
> 
> 
> line 2523:
> static void extract_record_handle_seq(char *pdu, sdp_list_t **seq, int
> count, int *scanned)
> {
>     sdp_list_t *pSeq = *seq;
>     char *pdata = pdu;
>     int n;
>  
>     for (n = 0; n < count; n++) {
>         uint32_t *pSvcRec = (uint32_t *) malloc(sizeof(uint32_t));
>         *pSvcRec = ntohl(bt_get_unaligned((uint32_t *) pdata));
>         pSeq = sdp_list_append(pSeq, pSvcRec);
>         pdata += sizeof(uint32_t);
>         *scanned += sizeof(uint32_t);
>     }
>     *seq = pSeq;
> }
> 
> I think this will cause segfaults when you try to sdp_record_free the
> records in the list (it does for me).
> 
> perhaps it shold read something more like:
>         sdp_record_t *pSvcRec = (sdp_record_t*) malloc(sizeof(sdp_record_t));
>         pSvcRec->attrlist = pSvcRec->pattern = 0;
>         pSvcRec->handle = ntohl(bt_get_unaligned((uint32_t *) pdata));
>         pSeq = sdp_list_append(pSeq, pSvcRec);

Steve, any thoughts on this one?

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
