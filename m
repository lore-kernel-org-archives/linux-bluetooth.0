Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: 'Szymon Janc' <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, d.kasatkin@samsung.com,
	bharat.panda@samsung.com, cpgs@samsung.com
References: <1410352944-16586-1-git-send-email-gowtham.ab@samsung.com>
 <3030038.LEiDkyyyur@uw000953>
In-reply-to: <3030038.LEiDkyyyur@uw000953>
Subject: RE: [PATCH 3/3] android/hal-utils.c : Fix null pointer dereference
Date: Thu, 11 Sep 2014 15:46:53 +0530
Message-id: <000601cfcda9$86b83520$94289f60$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> -----Original Message-----
> From: Szymon Janc [mailto:szymon.janc@tieto.com]
> Sent: Thursday, September 11, 2014 3:11 PM
> To: gowtham babu
> Cc: linux-bluetooth@vger.kernel.org; d.kasatkin@samsung.com;
> bharat.panda@samsung.com; cpgs@samsung.com
> Subject: Re: [PATCH 3/3] android/hal-utils.c : Fix null pointer dereference
> 
> Hi,
> 
> On Wednesday 10 of September 2014 18:12:24 gowtham babu wrote:
> > Handles the possible null pointer dereference: bd_addr by checking it
> against null.
> > ---
> >  android/hal-utils.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/android/hal-utils.c b/android/hal-utils.c index
> > ceefefc..64ab5a1 100644
> > --- a/android/hal-utils.c
> > +++ b/android/hal-utils.c
> > @@ -166,11 +166,13 @@ int int2str_findstr(const char *str, const struct
> int2str m[])
> >   */
> >  const char *bt_bdaddr_t2str(const bt_bdaddr_t *bd_addr, char *buf)  {
> > -	const uint8_t *p = bd_addr->address;
> > +	const uint8_t *p;
> >
> >  	if (!bd_addr)
> >  		return strcpy(buf, "NULL");
> >
> > +	p = bd_addr->address;
> > +
> >  	snprintf(buf, MAX_ADDR_STR_LEN,
> "%02x:%02x:%02x:%02x:%02x:%02x",
> >  					p[0], p[1], p[2], p[3], p[4], p[5]);
> >
> 
> This patch looks OK to me, but I have one question before applying it.
> 
> Do you really want your name to be visible in git history as it is in this email ie.
> without any capital letters?
> 
> --
> Best regards,
> Szymon Janc


Sorry for the top posting. Regarding the git name, that’s  OK. 

Regards,
Gowtham

