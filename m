Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>,
	linux-bluetooth@vger.kernel.org,
	Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: Re: [PATCH 01/36] android/gatt: Add comment about event type being sent
Date: Tue, 29 Apr 2014 12:20:58 +0200
Message-ID: <1439479.TyufhVOCIM@uw000953>
In-Reply-To: <20140429075718.GA21742@t440s.lan>
References: <1398734107-4793-1-git-send-email-lukasz.rymanowski@tieto.com> <1398734107-4793-2-git-send-email-lukasz.rymanowski@tieto.com> <20140429075718.GA21742@t440s.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Tuesday 29 of April 2014 10:57:18 Johan Hedberg wrote:
> Hi,
> 
> On Tue, Apr 29, 2014, Lukasz Rymanowski wrote:
> > ---
> >  android/gatt.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/android/gatt.c b/android/gatt.c
> > index 0e81e7d..ed4ee75 100644
> > --- a/android/gatt.c
> > +++ b/android/gatt.c
> > @@ -599,6 +599,11 @@ failed:
> >  static void send_client_disconnection_notify(struct app_connection *connection,
> >  								int32_t status)
> >  {
> > +	/* disconnect and connect events are binary the same so its safe to pass
> > +	 * hal_ev_gatt_client_disconnect struct even for connect event.
> > +	 * Note that server do this the right way, having single event for
> > +	 * connection state notification.
> > +	 */
> 
> I believe the user space commenting style (if we try to be consistent)
> is to have an empty line in the beginning of a multi-line comment.

Yeah, we are a bit inconsistent wrt multi-line comments in android folder.
I'll push bulk patch that fix this.

-- 
Best regards, 
Szymon Janc
