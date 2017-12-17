Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Steve Brown <sbrown@cortland.com>
Message-ID: <1513500464.18172.87.camel@ewol.com>
Subject: Re: [PATCH V3 3/9] mesh: meshctl: Add set heartbeat publish
To: "Stotland, Inga" <inga.stotland@intel.com>,
        "sbrown@cortland.com" <sbrown@cortland.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Sun, 17 Dec 2017 01:47:44 -0700
In-Reply-To: <1513491536.13970.9.camel@intel.com>
References: <20171215064606.15051-1-sbrown@cortland.com>
         <20171215064606.15051-4-sbrown@cortland.com>
         <1513491536.13970.9.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Sun, 2017-12-17 at 06:18 +0000, Stotland, Inga wrote:
> Hi Steve,
> 
> On Fri, 2017-12-15 at 06:46 +0000, sbrown@cortland.com wrote:
> > From: Steve Brown <sbrown@cortland.com>
> > 
> > Sets heartbeat for node 0100
> > 
> > [config: Target = 0100]# hb-set 0100 0 0 0 0
> > 
> > Set heartbeat for node 0100 status: Success
> > Destination:    0100
> > Count:          00
> > Period:         00
> > TTL:            ff
> > Features:       0000
> > Net_Idx:        0000
> > ---
> > 
> After applying this patch, the code fails to compile because of
> undeclared functions for get/set proxy, get/set relay, get/set ident
> and get pub.
> I believe the expectation is that the code should cleanly compile
> after
> applying each patch. Plus, you would want to keep the new added
> fuctionalities bundled together, i.e., introduce new command menu
> items
> along with the command handling (e.g., "proxy-set" & "proxy-get"
> belong
> in
> "[PATCH Vxxx 6/9] mesh: meshctl: Add set/get proxy"
> 
> Regards,
> 
> Inga
I messed up my tree while changing the heartbeat command. I'll sort it
out and send a V4.

Sorry for the noise.

Steve
