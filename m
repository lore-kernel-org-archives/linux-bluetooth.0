Return-Path: <steve.crane@rococosoft.com>
Subject: Re: [Bluez-devel] confusion about libs/sdp.c -
	sdp_service_search_req()
From: Stephen Crane <steve.crane@rococosoft.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1109579650.17256.29.camel@pegasus>
References: <ef9938ec05022511243993f46d@mail.gmail.com>
	 <1109579650.17256.29.camel@pegasus>
Content-Type: text/plain
Date: Mon, 28 Feb 2005 12:20:38 +0000
Message-Id: <1109593239.14742.131.camel@baroque.rococosoft.com>
Mime-Version: 1.0
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Albert, Marcel,

The documentation is incorrect: the correct behaviour of
sdp_service_search_req() is that it returns a list of service record
handles --- you then use sdp_search_attr_req() to fetch attributes of
interest. Alternatively, you can use sdp_search_attr_req() to perform a
combined search.

I have fixed the comment in CVS.

Thanks,
Steve

On Mon, 2005-02-28 at 09:34 +0100, Marcel Holtmann wrote:
> Hi Albert,
> 
> > the documentation for sdp_service_search_req() states that it outputs
> > an sdp_list_t * of sdp_record_t * (list of sdp service records)
> > 
> > reading through the code, it appears that it actually returns a list
> > of uint32_t * data structures.
> > 
> > line 2721:
> >         extract_record_handle_seq(pdata, rsp, rec_count, &scanned);
> > 
> > 
> > line 2523:
> > static void extract_record_handle_seq(char *pdu, sdp_list_t **seq, int
> > count, int *scanned)
> > {
> >     sdp_list_t *pSeq = *seq;
> >     char *pdata = pdu;
> >     int n;
> >  
> >     for (n = 0; n < count; n++) {
> >         uint32_t *pSvcRec = (uint32_t *) malloc(sizeof(uint32_t));
> >         *pSvcRec = ntohl(bt_get_unaligned((uint32_t *) pdata));
> >         pSeq = sdp_list_append(pSeq, pSvcRec);
> >         pdata += sizeof(uint32_t);
> >         *scanned += sizeof(uint32_t);
> >     }
> >     *seq = pSeq;
> > }
> > 
> > I think this will cause segfaults when you try to sdp_record_free the
> > records in the list (it does for me).
> > 
> > perhaps it shold read something more like:
> >         sdp_record_t *pSvcRec = (sdp_record_t*) malloc(sizeof(sdp_record_t));
> >         pSvcRec->attrlist = pSvcRec->pattern = 0;
> >         pSvcRec->handle = ntohl(bt_get_unaligned((uint32_t *) pdata));
> >         pSeq = sdp_list_append(pSeq, pSvcRec);
> 
> Steve, any thoughts on this one?
> 
> Regards
> 
> Marcel
> 
> 
