Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <ef9938ec0503020048272b98c7@mail.gmail.com>
From: Albert Huang <ashuang@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] confusion about libs/sdp.c - sdp_service_search_req()
Cc: steve.crane@rococosoft.com
In-Reply-To: <1109593239.14742.131.camel@baroque.rococosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <ef9938ec05022511243993f46d@mail.gmail.com>
	 <1109579650.17256.29.camel@pegasus>
	 <1109593239.14742.131.camel@baroque.rococosoft.com>
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
Date: Wed, 2 Mar 2005 03:48:53 -0500

it appears that the internal documentation for sdp_record_register is
also incorrect.

libs/src/sdp.c:2288
 *
 * Returns a non-null value (a pointer) to a service
 * record if successful, else -1 setting errno
 */

I think it should read something like:
 *
 * Returns zero if successful, also setting rec->handle 
 * else -1 setting erro
 */

You may also want to update libs/include/sdp_lib.h to indicate the
behavior of sdp_record_register

Regards,
Albert

On Mon, 28 Feb 2005 12:20:38 +0000, Stephen Crane
<steve.crane@rococosoft.com> wrote:
> Hi Albert, Marcel,
> 
> The documentation is incorrect: the correct behaviour of
> sdp_service_search_req() is that it returns a list of service record
> handles --- you then use sdp_search_attr_req() to fetch attributes of
> interest. Alternatively, you can use sdp_search_attr_req() to perform a
> combined search.
> 
> I have fixed the comment in CVS.
> 
> Thanks,
> Steve
> 
> On Mon, 2005-02-28 at 09:34 +0100, Marcel Holtmann wrote:
> > Hi Albert,
> >
> > > the documentation for sdp_service_search_req() states that it outputs
> > > an sdp_list_t * of sdp_record_t * (list of sdp service records)
> > >
> > > reading through the code, it appears that it actually returns a list
> > > of uint32_t * data structures.
> > >
> > > line 2721:
> > >         extract_record_handle_seq(pdata, rsp, rec_count, &scanned);
> > >
> > >
> > > line 2523:
> > > static void extract_record_handle_seq(char *pdu, sdp_list_t **seq, int
> > > count, int *scanned)
> > > {
> > >     sdp_list_t *pSeq = *seq;
> > >     char *pdata = pdu;
> > >     int n;
> > >
> > >     for (n = 0; n < count; n++) {
> > >         uint32_t *pSvcRec = (uint32_t *) malloc(sizeof(uint32_t));
> > >         *pSvcRec = ntohl(bt_get_unaligned((uint32_t *) pdata));
> > >         pSeq = sdp_list_append(pSeq, pSvcRec);
> > >         pdata += sizeof(uint32_t);
> > >         *scanned += sizeof(uint32_t);
> > >     }
> > >     *seq = pSeq;
> > > }
> > >
> > > I think this will cause segfaults when you try to sdp_record_free the
> > > records in the list (it does for me).
> > >
> > > perhaps it shold read something more like:
> > >         sdp_record_t *pSvcRec = (sdp_record_t*) malloc(sizeof(sdp_record_t));
> > >         pSvcRec->attrlist = pSvcRec->pattern = 0;
> > >         pSvcRec->handle = ntohl(bt_get_unaligned((uint32_t *) pdata));
> > >         pSeq = sdp_list_append(pSeq, pSvcRec);
> >
> > Steve, any thoughts on this one?
> >
> > Regards
> >
> > Marcel
> >
> >
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


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
