Return-Path: <cyrus@holtmann.org>
Date: Wed, 18 Dec 2013 10:05:05 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 1/7] android/tester: Fix enum and define coding style
Message-ID: <20131218080505.GG12649@x220.p-661hnu-f1>
References: <1387283874-29721-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
 <CABBYNZLCgpqR+hsR7vcadV52Y+x2jdRSWGQWfsSr3PhyPKCNTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CABBYNZLCgpqR+hsR7vcadV52Y+x2jdRSWGQWfsSr3PhyPKCNTQ@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Tue, Dec 17, 2013, Luiz Augusto von Dentz wrote:
> On Tue, Dec 17, 2013 at 2:37 PM, Grzegorz Kolodziejczyk
> <grzegorz.kolodziejczyk@tieto.com> wrote:
> > This changes all enums values and defines to uppercase instead of
> > lowercase according to coding style.
> > ---
> >  android/android-tester.c | 86 ++++++++++++++++++++++++------------------------
> >  1 file changed, 43 insertions(+), 43 deletions(-)
> >
> > diff --git a/android/android-tester.c b/android/android-tester.c
> > index eb938d0..4eb265b 100644
> > --- a/android/android-tester.c
> > +++ b/android/android-tester.c
> > @@ -37,10 +37,10 @@
> >  #include <hardware/bluetooth.h>
> >  #include <hardware/bt_sock.h>
> >
> > -#define adapter_props adapter_prop_bdaddr, adapter_prop_bdname, \
> > -                       adapter_prop_uuids, adapter_prop_cod, \
> > -                       adapter_prop_type, adapter_prop_scan_mode, \
> > -                       adapter_prop_bonded_devices, adapter_prop_disc_timeout
> > +#define ADAPTER_PROPS ADAPTER_PROP_BDADDR, ADAPTER_PROP_BDNAME, \
> > +                       ADAPTER_PROP_UUIDS, ADAPTER_PROP_COD, \
> > +                       ADAPTER_PROP_TYPE, ADAPTER_PROP_SCAN_MODE, \
> > +                       ADAPTER_PROP_BONDED_DEVICES, ADAPTER_PROP_DISC_TIMEOUT
> >
> >  static bt_scan_mode_t test_setprop_scanmode_val =
> >                                         BT_SCAN_MODE_CONNECTABLE_DISCOVERABLE;
> > @@ -52,19 +52,19 @@ static uint32_t test_setprop_disctimeout_val = 120;
> >   */
> >
> >  enum hal_bluetooth_callbacks_id {
> > -       adapter_test_end,
> > -       adapter_test_setup_mode,
> > -       adapter_state_changed_on,
> > -       adapter_state_changed_off,
> > -       adapter_prop_bdaddr,
> > -       adapter_prop_bdname,
> > -       adapter_prop_uuids,
> > -       adapter_prop_cod,
> > -       adapter_prop_type,
> > -       adapter_prop_scan_mode,
> > -       adapter_prop_disc_timeout,
> > -       adapter_prop_service_record,
> > -       adapter_prop_bonded_devices
> > +       ADAPTER_TEST_END,
> > +       ADAPTER_TEST_SETUP_MODE,
> > +       ADAPTER_STATE_CHANGED_ON,
> > +       ADAPTER_STATE_CHANGED_OFF,
> > +       ADAPTER_PROP_BDADDR,
> > +       ADAPTER_PROP_BDNAME,
> > +       ADAPTER_PROP_UUIDS,
> > +       ADAPTER_PROP_COD,
> > +       ADAPTER_PROP_TYPE,
> > +       ADAPTER_PROP_SCAN_MODE,
> > +       ADAPTER_PROP_DISC_TIMEOUT,
> > +       ADAPTER_PROP_SERVICE_RECORD,
> > +       ADAPTER_PROP_BONDED_DEVICES
> >  };
> 
> This is something I dislike right now, why are defining these and not
> using directly the values defined in hal-msg.h? We should probably
> have a struct with expected opcode and value e.g:
> .{HAL_EV_ADAPTER_PROPS_CHANGED, BT_STATE_ON} and don't try to invent
> another ID for each of those.

I missed this email from you and already applied the patch. You're right
that if these are already defined elsewhere they should not be
redefined. What bugged me most about this was the lower-case so whatever
fix is done will have to be on top of this patch.

Johan
