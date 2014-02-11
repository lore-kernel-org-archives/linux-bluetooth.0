Return-Path: <cyrus@holtmann.org>
Date: Tue, 11 Feb 2014 13:15:06 +0200
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/3] avrcp: Fix using incorrect buffer for SetVolume
Message-ID: <20140211111504.GE8980@aemeltch-MOBL1>
References: <1391098376-26834-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1391098376-26834-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <20140204140815.GQ2930@aemeltch-MOBL1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140204140815.GQ2930@aemeltch-MOBL1>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Feb 04, 2014 at 04:08:17PM +0200, Andrei Emeltchenko wrote:
> On Thu, Jan 30, 2014 at 06:12:55PM +0200, Andrei Emeltchenko wrote:
> > From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > 
> > The command requires one parameter.
> 
> ping

ping

> 
> > ---
> >  profiles/audio/avrcp.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
> > index 2e1a940..128f7d3 100644
> > --- a/profiles/audio/avrcp.c
> > +++ b/profiles/audio/avrcp.c
> > @@ -3706,7 +3706,7 @@ int avrcp_set_volume(struct btd_device *dev, uint8_t volume)
> >  {
> >  	struct avrcp_server *server;
> >  	struct avrcp *session;
> > -	uint8_t buf[AVRCP_HEADER_LENGTH + 2];
> > +	uint8_t buf[AVRCP_HEADER_LENGTH + 1];
> >  	struct avrcp_header *pdu = (void *) buf;
> >  
> >  	server = find_server(servers, device_get_adapter(dev));
> > -- 
> > 1.8.3.2
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
