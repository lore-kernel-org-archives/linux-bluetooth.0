Return-Path: <cyrus@holtmann.org>
Date: Thu, 14 Jun 2012 10:48:38 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 4/5] audio: Remove local A2DP endpoints options
Message-ID: <20120614134838.GC3846@joana>
References: <1339681270-24425-1-git-send-email-luiz.dentz@gmail.com>
 <1339681270-24425-4-git-send-email-luiz.dentz@gmail.com>
 <20120614134733.GB3846@joana>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120614134733.GB3846@joana>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* Gustavo Padovan <gustavo@padovan.org> [2012-06-14 10:47:33 -0300]:

> Hi Luiz,
> 
> * Luiz Augusto von Dentz <luiz.dentz@gmail.com> [2012-06-14 16:41:09 +0300]:
> 
> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > 
> > The local endpoints are no use without the internal IPC.
> > ---
> >  audio/a2dp.c     |   72 +-----------------------------------------------------
> >  audio/audio.conf |    5 ----
> >  2 files changed, 1 insertion(+), 76 deletions(-)
> > 
> > diff --git a/audio/a2dp.c b/audio/a2dp.c
> > index 96137e4..094476e 100644
> > --- a/audio/a2dp.c
> > +++ b/audio/a2dp.c
> > @@ -1436,13 +1436,10 @@ static struct a2dp_server *find_server(GSList *list, const bdaddr_t *src)
> >  
> >  int a2dp_register(DBusConnection *conn, const bdaddr_t *src, GKeyFile *config)
> >  {
> > -	int sbc_srcs = 0, sbc_sinks = 0;
> > -	int mpeg12_srcs = 0, mpeg12_sinks = 0;
> > -	gboolean source = TRUE, sink = FALSE, socket = FALSE;
> > +	gboolean source = TRUE, sink = FALSE;
> 
> You need to remove 'Socket' from 
> 
> #Disable=Gateway,Source,Socket
> 
> On audio.conf too.

The following patch do this, forget about this comment.

	Gustavo
