Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Steve Brown <sbrown@cortland.com>
Message-ID: <1513321068.4409.15.camel@ewol.com>
Subject: Re: [PATCH V2 1/8] mesh: meshctl: Change command names to
 <cmd>-<get/set>
To: "Stotland, Inga" <inga.stotland@intel.com>,
        "sbrown@cortland.com" <sbrown@cortland.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Thu, 14 Dec 2017 23:57:48 -0700
In-Reply-To: <1513304088.3023.39.camel@intel.com>
References: <20171212125832.13440-1-sbrown@cortland.com>
         <20171212125832.13440-2-sbrown@cortland.com>
         <1513238880.3023.18.camel@intel.com> <1513242768.11292.10.camel@ewol.com>
         <1513304088.3023.39.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Inga,

On Fri, 2017-12-15 at 02:14 +0000, Stotland, Inga wrote:
> Hi Steve,
> 
> On Thu, 2017-12-14 at 02:12 -0700, Steve Brown wrote:
> > Hi Inga,
> > On Thu, 2017-12-14 at 08:08 +0000, Stotland, Inga wrote:
> > > Hi Steve,
> > > 
> > > On Tue, 2017-12-12 at 12:58 +0000, sbrown@cortland.com wrote:
> > > > From: Steve Brown <sbrown@cortland.com>
> > > > 
> > > > Fix lines over 80 chars
> > > > Move cmd_default()
> > > > Add parameter to pub-set to control retransmit count
> > > > ---
> > > >  
> > > 
> > > Since you are modifying pub-set command, could you please fix it
> > > to
> > > correctly indicate SIG and vendor models, similarly to "bind"
> > > command
> > > (adding an optional "cid" parameter for vendor models).
> > > 
> > > Regards,
> > > 
> > > Inga Stotland
> > 
> > It looks like the pub command already assumes it's a vendor model
> > if
> > the model id is > 0xffff. Is that a correct assumption?
> > 
> > If it is, should I make the same change to bind and remove the
> > optional
> > parameter?
> > 
> > Steve
> > 
> The check for model id is > 0xffff is not entirely correct since it
> does not account for a case when CID is 0x0000.
> 
> Regards,
> 
> Inga

I made the changes/corrections you requested and sent V3.

Steve

