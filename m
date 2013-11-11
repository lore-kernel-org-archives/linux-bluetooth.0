Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [RFCv1 2/9] android: Avoid unneeded includes
Date: Mon, 11 Nov 2013 14:31:32 +0100
Message-ID: <2174595.cbNC5cbqPI@athlon>
In-Reply-To: <CABBYNZJMGQHVog9cPDqqLfe7ocdBy4UTrW+T9a6SjWWE=qd6=w@mail.gmail.com>
References: <1384173438-21708-1-git-send-email-Andrei.Emeltchenko.news@gmail.com> <1384173438-21708-3-git-send-email-Andrei.Emeltchenko.news@gmail.com> <CABBYNZJMGQHVog9cPDqqLfe7ocdBy4UTrW+T9a6SjWWE=qd6=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Monday 11 November 2013 15:20:21 Luiz Augusto von Dentz wrote:
> Hi Andrei,
> 
> On Mon, Nov 11, 2013 at 2:37 PM, Andrei Emeltchenko
> 
> <Andrei.Emeltchenko.news@gmail.com> wrote:
> > From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > 
> > Declare struct mgmt in adapter.h. This avoids including mgmt.h in
> > every file using adapter functions like socket and hid.
> > ---
> > 
> >  android/adapter.h |    2 ++
> >  android/hidhost.c |    1 -
> >  2 files changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/android/adapter.h b/android/adapter.h
> > index c62b859..3bda9d9 100644
> > --- a/android/adapter.h
> > +++ b/android/adapter.h
> > @@ -23,6 +23,8 @@
> > 
> >  typedef void (*bt_adapter_ready)(int err);
> > 
> > +struct mgmt;
> > +
> > 
> >  void bt_adapter_init(uint16_t index, struct mgmt *mgmt_if,
> >  
> >                                                         bt_adapter_ready
> >                                                         cb);
> > 
> > diff --git a/android/hidhost.c b/android/hidhost.c
> > index 683938f..8c3e9f6 100644
> > --- a/android/hidhost.c
> > +++ b/android/hidhost.c
> > @@ -38,7 +38,6 @@
> > 
> >  #include "lib/sdp.h"
> >  #include "lib/sdp_lib.h"
> >  #include "lib/uuid.h"
> > 
> > -#include "src/shared/mgmt.h"
> > 
> >  #include "src/sdp-client.h"
> >  #include "src/glib-helper.h"
> >  #include "profiles/input/uhid_copy.h"
> > 
> > --
> > 1.7.10.4
> 
> Well it looks like we need to find a proper place for the mgmt
> interaction, or then perhaps pass the fd and use mgmt_new on adapter
> but that seems to require some work as it does create a different mgmt
> objects with different queues which I don't think is safe to use.

I've some patches that try to address this issue. Should be able to send them
soon.

-- 
Szymon K. Janc
szymon.janc@gmail.com
