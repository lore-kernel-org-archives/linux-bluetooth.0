Return-Path: <cyrus@holtmann.org>
Date: Fri, 27 Jun 2014 17:26:47 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv3 09/12] android/health: Add handling for ECHO service
Message-ID: <20140627142646.GC21456@aemeltch-MOBL1>
References: <1403855994-29262-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1403868303-8129-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1403868303-8129-9-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <2101847.l1r4UDlVof@uw000953>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2101847.l1r4UDlVof@uw000953>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Fri, Jun 27, 2014 at 04:09:18PM +0200, Szymon Janc wrote:
> Hi Andrei,
> 
> On Friday 27 of June 2014 14:25:00 Andrei Emeltchenko wrote:
> > From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > 
> > Reply received buffer back for ECHO service.
> > ---
> >  android/health.c | 63 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 62 insertions(+), 1 deletion(-)
> > 
> > diff --git a/android/health.c b/android/health.c
> > index 4f15f93..9631d9e 100644
> > --- a/android/health.c
> > +++ b/android/health.c
> > @@ -1054,9 +1054,70 @@ static int get_dcpsm(sdp_list_t *recs, uint16_t *dcpsm)
> >  	return -1;
> >  }
> >  
> > +static int send_echo_data(int sock, const void *buf, uint32_t size)
> > +{
> > +	const uint8_t *buf_b = buf;
> > +	uint32_t sent = 0;
> > +
> > +	while (sent < size) {
> > +		int n = write(sock, buf_b + sent, size - sent);
> > +		if (n < 0)
> > +			return -1;
> > +		sent += n;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static gboolean serve_echo(GIOChannel *io, GIOCondition cond, gpointer data)
> > +{
> > +	struct health_channel *channel = data;
> > +	uint8_t buf[MCAP_DC_MTU];
> > +	int fd, len;
> > +
> > +	DBG("channel %p", channel);
> > +
> > +	if (cond & (G_IO_ERR | G_IO_HUP | G_IO_NVAL)) {
> > +		DBG("Error condition on channel");
> > +		return FALSE;
> > +	}
> > +
> > +	fd = g_io_channel_unix_get_fd(io);
> > +
> > +	len = read(fd, buf, sizeof(buf));
> > +	if (len < 0)
> > +		goto fail;
> > +
> > +	if (send_echo_data(fd, buf, len)  >= 0)
> > +		return TRUE;
> 
> Shouldn't initiator send only one single data packet in echo test function?
> 

yes you are right here.

> > +
> > +fail:
> > +	free_health_device(channel->dev);
> 
> Wouldn't that leave dangling pointer in channel? Also, why is this free here?
> 

I will rework this patch.

Best regards 
Andrei Emeltchenko 
