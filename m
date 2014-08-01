Return-Path: <cyrus@holtmann.org>
Date: Fri, 1 Aug 2014 14:54:00 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv4 09/12] tools: Fix memory leak
Message-ID: <20140801115306.GD9036@aemeltch-MOBL1>
References: <1406643661-29323-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1406643661-29323-9-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <20140801103517.GA24358@t440s.P-661HNU-F1>
 <20140801111238.GB9036@aemeltch-MOBL1>
 <20140801112124.GA28357@t440s.P-661HNU-F1>
 <20140801112703.GC9036@aemeltch-MOBL1>
 <20140801113310.GA28681@t440s.P-661HNU-F1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140801113310.GA28681@t440s.P-661HNU-F1>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Fri, Aug 01, 2014 at 02:33:10PM +0300, Johan Hedberg wrote:
> > > > > > +		if (lmpver)
> > > > > > +			bt_free(lmpver);
> > > > > > +		if (hciver)
> > > > > > +			bt_free(hciver);
> > > > > 
> > > > > These trace back to using malloc (in hci_uint2str) so I suppose free is
> > > > > more appropriate than bt_free (which should be used for bt_malloc).
> > > > 
> > > > OK, I will change it to free(). Shall I also change other similar
> > > > bt_free() calls which I took as example?
> > > 
> > > I'm not sure it's worth bothering with legacy code like this which will
> > > eventually disappear from the tree.
> > 
> > Those constructions are in hcitool and hciconfig
> 
> Still legacy code. If you really feel like there's nothing else
> important to work on feel free to send patches for that.

The question is if we change some programming practice shall we make other
code looks consistent.

Best regards 
Andrei Emeltchenko 
