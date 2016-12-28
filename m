Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <1482942317.2308.5.camel@hadess.net>
Subject: Re: [PATCH 3/3] sixaxis: Set created devices trusted by default
From: Bastien Nocera <hadess@hadess.net>
To: Szymon Janc <szymon.janc@codecoup.pl>,
        Juha Kuikka <juha.kuikka@synapse.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 28 Dec 2016 17:25:17 +0100
In-Reply-To: <148295789.8zPOI8aDb3@ix>
References: <1482384054-59718-1-git-send-email-juha.kuikka@synapse.com>
         <1482384054-59718-4-git-send-email-juha.kuikka@synapse.com>
         <148295789.8zPOI8aDb3@ix>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 2016-12-28 at 17:07 +0100, Szymon Janc wrote:
> Hi Juha,
> 
> On Wednesday, 21 December 2016 21:20:54 CET Juha Kuikka wrote:
> > If user has enabled the sixaxis plugin and plugs a controller in,
> > it can be assumed they also want the controllers to be able to
> > connect
> > automatically.
> > ---
> >  plugins/sixaxis.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/plugins/sixaxis.c b/plugins/sixaxis.c
> > index 1fb2091..ba96b54 100644
> > --- a/plugins/sixaxis.c
> > +++ b/plugins/sixaxis.c
> > @@ -349,6 +349,7 @@ static bool setup_device(int fd, int index,
> > struct
> > btd_adapter *adapter) btd_device_set_pnpid(device,
> > devices[index].source,
> > devices[index].vid, devices[index].pid, devices[index].version);
> >  	btd_device_set_temporary(device, false);
> > +	btd_device_set_trusted(device, true);
> > 
> >  	return true;
> >  }
> 
> This was already NACKed in the past for security reasons (mostly due
> to 
> possibility of fake device being trusted).

Juha, you could take a look at a way of getting this cleaned up and
merged:
https://www.spinics.net/lists/linux-bluetooth/msg62970.html
https://www.spinics.net/lists/linux-bluetooth/msg62967.html

I couldn't get a straight answer about the patch, as the developers
themselves seemed to disagree on how to solve the problem.

Cheers
