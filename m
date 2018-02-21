Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] advertising: Fix setting discoverable flag only for peripheral
Date: Wed, 21 Feb 2018 08:59:00 +0100
Message-ID: <2071439.3ZS44CKUQD@ix>
In-Reply-To: <CABBYNZ+gAGOHFyJ+gCDiTf_cJMF_+g5cyx2JtQ5S4nh_eUGGzQ@mail.gmail.com>
References: <20180220151358.20781-1-szymon.janc@codecoup.pl> <CABBYNZ+gAGOHFyJ+gCDiTf_cJMF_+g5cyx2JtQ5S4nh_eUGGzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Tuesday, 20 February 2018 17:21:54 CET Luiz Augusto von Dentz wrote:
> Hi Szymon,
> 
> On Tue, Feb 20, 2018 at 5:13 PM, Szymon Janc <szymon.janc@codecoup.pl> 
wrote:
> > General Discoverable mode can also be set for non-connectable
> > advertising. This was affecting GAP/DISC/GENM/BV-03-C qualification
> > testcase.
> > ---
> > 
> >  src/advertising.c | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> > 
> > diff --git a/src/advertising.c b/src/advertising.c
> > index 38d2a2d1f..6e227d4d1 100644
> > --- a/src/advertising.c
> > +++ b/src/advertising.c
> > @@ -622,12 +622,11 @@ static int refresh_adv(struct btd_adv_client
> > *client, mgmt_request_func_t func)> 
> >         DBG("Refreshing advertisement: %s", client->path);
> > 
> > -       if (client->type == AD_TYPE_PERIPHERAL) {
> > +       if (client->type == AD_TYPE_PERIPHERAL)
> > 
> >                 flags = MGMT_ADV_FLAG_CONNECTABLE;
> > 
> > -               if
> > (btd_adapter_get_discoverable(client->manager->adapter))
> > -                       flags |= MGMT_ADV_FLAG_DISCOV;
> > -       }
> > +       if (btd_adapter_get_discoverable(client->manager->adapter))
> > +               flags |= MGMT_ADV_FLAG_DISCOV;
> 
> iirc there were something saying that non-connectable advertisement
> should not set these flags, if I recall this right this was why
> beacons used to not show on the discovery or something like that.

As mentioned in commit there is qualification test which tests it.

GAP/DISC/GENM/BV-03-C
[General Discoverable Mode Non-Connectable Mode - LE Only]

That said, this patch isn't valid since in bluetoothd discoverable requires 
connectable so currently we are not able to configure non-connectable 
advertising instance when discoverable.

I think we should extend Add Advertising mgmt command with flag that would 
allow to force non-connectable advertising regardless of global connectable 
flag.

Thoughts?

-- 
pozdrawiam
Szymon Janc


