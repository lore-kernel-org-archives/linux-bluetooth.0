Return-Path: <cyrus@holtmann.org>
Date: Fri, 1 Aug 2014 14:27:05 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv4 09/12] tools: Fix memory leak
Message-ID: <20140801112703.GC9036@aemeltch-MOBL1>
References: <1406643661-29323-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1406643661-29323-9-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <20140801103517.GA24358@t440s.P-661HNU-F1>
 <20140801111238.GB9036@aemeltch-MOBL1>
 <20140801112124.GA28357@t440s.P-661HNU-F1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140801112124.GA28357@t440s.P-661HNU-F1>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Fri, Aug 01, 2014 at 02:21:24PM +0300, Johan Hedberg wrote:
> Hi Andrei,
> 
> On Fri, Aug 01, 2014, Andrei Emeltchenko wrote:
> > Hi Johan,
> > 
> > On Fri, Aug 01, 2014 at 01:35:17PM +0300, Johan Hedberg wrote:
> > > Hi Andrei,
> > > 
> > > On Tue, Jul 29, 2014, Andrei Emeltchenko wrote:
> > > > lmpver and hciver are allocated through malloc and need to be freed.
> > > > ---
> > > >  tools/parser/hci.c | 19 ++++++++++++++++---
> > > >  1 file changed, 16 insertions(+), 3 deletions(-)
> > > 
> > > I've applied all 8 patches before this one.
> > > 
> > > > diff --git a/tools/parser/hci.c b/tools/parser/hci.c
> > > > index 351f843..1a639af 100644
> > > > --- a/tools/parser/hci.c
> > > > +++ b/tools/parser/hci.c
> > > > @@ -2445,17 +2445,25 @@ static inline void read_local_version_dump(int level, struct frame *frm)
> > > >  		p_indent(level, frm);
> > > >  		printf("Error: %s\n", status2str(rp->status));
> > > >  	} else {
> > > > +		char *lmpver = lmp_vertostr(rp->lmp_ver);
> > > > +		char *hciver = hci_vertostr(rp->hci_ver);
> > > > +
> > > >  		p_indent(level, frm);
> > > >  		printf("HCI Version: %s (0x%x) HCI Revision: 0x%x\n",
> > > > -					hci_vertostr(rp->hci_ver),
> > > > +					hciver ? hciver : "n/a",
> > > >  					rp->hci_ver, btohs(rp->hci_rev));
> > > >  		p_indent(level, frm);
> > > >  		printf("LMP Version: %s (0x%x) LMP Subversion: 0x%x\n",
> > > > -					lmp_vertostr(rp->lmp_ver),
> > > > +					lmpver ? lmpver : "n/a",
> > > >  					rp->lmp_ver, btohs(rp->lmp_subver));
> > > >  		p_indent(level, frm);
> > > >  		printf("Manufacturer: %s (%d)\n",
> > > >  				bt_compidtostr(manufacturer), manufacturer);
> > > > +
> > > > +		if (lmpver)
> > > > +			bt_free(lmpver);
> > > > +		if (hciver)
> > > > +			bt_free(hciver);
> > > 
> > > These trace back to using malloc (in hci_uint2str) so I suppose free is
> > > more appropriate than bt_free (which should be used for bt_malloc).
> > 
> > OK, I will change it to free(). Shall I also change other similar
> > bt_free() calls which I took as example?
> 
> I'm not sure it's worth bothering with legacy code like this which will
> eventually disappear from the tree.

Those constructions are in hcitool and hciconfig

Best regards 
Andrei Emeltchenko 

