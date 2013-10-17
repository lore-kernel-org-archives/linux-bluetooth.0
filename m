Return-Path: <cyrus@holtmann.org>
Date: Thu, 17 Oct 2013 11:28:08 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] android: Make toool compile on Android 4.2.2
Message-ID: <20131017082807.GP2861@aemeltch-MOBL1>
References: <1381993898-30445-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <CAHCYCoyLsS5oj5Q+4Z_vmvPfjri3Jkvc9HrQzza2=bCn8UG+sg@mail.gmail.com>
 <20131017081100.GN2861@aemeltch-MOBL1>
 <CAHCYCowr5fs27oP+QTSsXn+WgXHhfhmgeP49-OQzDzH=y+F5zg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAHCYCowr5fs27oP+QTSsXn+WgXHhfhmgeP49-OQzDzH=y+F5zg@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Oct 17, 2013 at 10:16:18AM +0200, Jerzy Kasenberg wrote:
> Hi Andrei,
> 
> No error, but since it's not defined code is never included in version above 17
>

OK, got it. I thought those flags are added automatically to build by
Android.

Best regards 
Andrei Emeltchenko  
> -- 
> Best regards
> Jerzy Kasenberg
> 
> On 17 October 2013 10:11, Andrei Emeltchenko
> <Andrei.Emeltchenko.news@gmail.com> wrote:
> > Hi Jerzy,
> >
> > On Thu, Oct 17, 2013 at 10:06:52AM +0200, Jerzy Kasenberg wrote:
> >> Hi Andrei,
> >>
> >> Shouldn't PLATFORM_SDK_VERSION be defined in Android.mk?
> >
> > No, it works as is for me. Do you have errors?
> >
> > Best regards
> > Andrei Emeltchenko
> >
> >>
> >> LOCAL_CFLAGS := -DPLATFORM_SDK_VERSION=$(PLATFORM_SDK_VERSION)
> >>
> >> --
> >> Best regards
> >> Jerzy Kasenberg
> >>
> >> On 17 October 2013 09:11, Andrei Emeltchenko
> >> <Andrei.Emeltchenko.news@gmail.com> wrote:
> >> > From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> >> >
> >> > On our current target the tools cannot be compiled.
> >> > ---
> >> >  android/client/if-bt.c    |    4 ++++
> >> >  android/client/if-main.h  |    3 +++
> >> >  android/client/textconv.c |    2 ++
> >> >  3 files changed, 9 insertions(+)
> >> >
> >> > diff --git a/android/client/if-bt.c b/android/client/if-bt.c
> >> > index a0a4bd9..7b4e71e 100644
> >> > --- a/android/client/if-bt.c
> >> > +++ b/android/client/if-bt.c
> >> > @@ -277,7 +277,9 @@ static bt_callbacks_t bt_callbacks = {
> >> >         .acl_state_changed_cb = acl_state_changed_cb,
> >> >         .thread_evt_cb = thread_evt_cb,
> >> >         .dut_mode_recv_cb = dut_mode_recv_cb,
> >> > +#if PLATFORM_SDK_VERSION > 17
> >> >         .le_test_mode_cb = le_test_mode_cb
> >> > +#endif
> >> >  };
> >> >
> >> >  static void init_p(int argc, const char **argv)
> >> > @@ -577,8 +579,10 @@ static void get_profile_interface_p(int argc, const char **argv)
> >> >                 pif = &dummy; /* TODO: chenge when if_hh is there */
> >> >         else if (strcmp(BT_PROFILE_PAN_ID, id) == 0)
> >> >                 pif = &dummy; /* TODO: chenge when if_pan is there */
> >> > +#if PLATFORM_SDK_VERSION > 17
> >> >         else if (strcmp(BT_PROFILE_AV_RC_ID, id) == 0)
> >> >                 pif = &dummy; /* TODO: chenge when if_rc is there */
> >> > +#endif
> >> >         else
> >> >                 haltest_error("%s is not correct for get_profile_interface\n",
> >> >                      id);
> >> > diff --git a/android/client/if-main.h b/android/client/if-main.h
> >> > index 9cac7ef..1cebb72 100644
> >> > --- a/android/client/if-main.h
> >> > +++ b/android/client/if-main.h
> >> > @@ -35,7 +35,10 @@
> >> >  #include <hardware/bt_sock.h>
> >> >  #include <hardware/bt_hf.h>
> >> >  #include <hardware/bt_hl.h>
> >> > +
> >> > +#if PLATFORM_SDK_VERSION > 17
> >> >  #include <hardware/bt_rc.h>
> >> > +#endif
> >> >
> >> >  #include "textconv.h"
> >> >
> >> > diff --git a/android/client/textconv.c b/android/client/textconv.c
> >> > index eebad70..f38e368 100644
> >> > --- a/android/client/textconv.c
> >> > +++ b/android/client/textconv.c
> >> > @@ -94,7 +94,9 @@ INTMAP(bt_property_type_t, -1, "(unknown)")
> >> >         DELEMENT(BT_PROPERTY_ADAPTER_DISCOVERY_TIMEOUT),
> >> >         DELEMENT(BT_PROPERTY_REMOTE_FRIENDLY_NAME),
> >> >         DELEMENT(BT_PROPERTY_REMOTE_RSSI),
> >> > +#if PLATFORM_SDK_VERSION > 17
> >> >         DELEMENT(BT_PROPERTY_REMOTE_VERSION_INFO),
> >> > +#endif
> >> >         DELEMENT(BT_PROPERTY_REMOTE_DEVICE_TIMESTAMP),
> >> >  ENDMAP
> >> >
> >> > --
> >> > 1.7.10.4
> >> >
> >> > --
> >> > To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> >> > the body of a message to majordomo@vger.kernel.org
> >> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
