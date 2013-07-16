Return-Path: <cyrus@holtmann.org>
From: "Xu, Martin" <martin.xu@intel.com>
To: "Hedberg, Johan" <johan.hedberg@intel.com>
CC: "martin.xu@linux.intel.com" <martin.xu@linux.intel.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH 1/3] Profile: fix set default exteranl profile authorize
Date: Tue, 16 Jul 2013 06:22:50 +0000
Message-ID: <29981E9CC6590A438DB8A519AEB0053010D4264C@SHSMSX103.ccr.corp.intel.com>
References: <1373857569-4191-1-git-send-email-martin.xu@linux.intel.com>
 <20130715073518.GA24712@x220.p-661hnu-f1>
 <29981E9CC6590A438DB8A519AEB0053010D41E05@SHSMSX103.ccr.corp.intel.com>
 <20130715095104.GA1869@x220.p-661hnu-f1>
In-Reply-To: <20130715095104.GA1869@x220.p-661hnu-f1>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan:

> -----Original Message-----
> From: Johan Hedberg [mailto:johan.hedberg@intel.com]
> Sent: Monday, July 15, 2013 17:51
> To: Xu, Martin
> Cc: martin.xu@linux.intel.com; linux-bluetooth@vger.kernel.org
> Subject: Re: [PATCH 1/3] Profile: fix set default exteranl profile
> authorize
> 
> Hi Martin,
> 
> On Mon, Jul 15, 2013, Xu, Martin wrote:
> > > >  	ext->sec_level = BT_IO_SEC_MEDIUM;
> > > > -	ext->authorize = true;
> > > >  	ext->enable_client = true;
> > > >  	ext->enable_server = true;
> > > >  	ext->remote_uuid = NULL;
> > >
> > > The above change is still wrong. Not setting to true is the same as
> > > setting to false since g_new0 was used. Don't change that part at a
> > I can't find issue here
> > I set the ext->authorize = settings->authorize so no matter the
> > original value is, it will be just set as the same value with default
> > setting.
> 
> That's true, but what if the external profile is something that we
> don't have a settings entry for? In that case ext->authorize will never
> be explicitly set to anything.
You are right, I will resent the patch. :)
