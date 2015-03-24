Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAHrH25Si72YGyV3Dy+AkQ0T4WgWDwK-uR98DSjf67+AN_c3wQw@mail.gmail.com>
References: <1426976135-2783-1-git-send-email-jpawlowski@google.com>
	<1426976135-2783-2-git-send-email-jpawlowski@google.com>
	<CAHrH25Si72YGyV3Dy+AkQ0T4WgWDwK-uR98DSjf67+AN_c3wQw@mail.gmail.com>
Date: Mon, 23 Mar 2015 20:18:56 -0700
Message-ID: <CAD0=r8z6Wqdb5iXLmHaQqLRQHcF0uFxgO_Vut0G_VdcWPR5caA@mail.gmail.com>
Subject: Re: [PATCH v1 2/8] core/adapter: Refactor of scan type
From: Jakub Pawlowski <jpawlowski@google.com>
To: Arman Uguray <armansito@chromium.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Mar 23, 2015 at 4:58 PM, Arman Uguray <armansito@chromium.org> wrote:
>
> Hi Jakub,
>
> > On Sat, Mar 21, 2015 at 3:15 PM, Jakub Pawlowski <jpawlowski@google.com> wrote:
> > This patch replaces scan type with defined constants, and creates
> > new method that might be used to get currently avaliable scan type.
> > ---
> >  src/adapter.c | 29 +++++++++++++++++++++--------
> >  1 file changed, 21 insertions(+), 8 deletions(-)
> >
> > diff --git a/src/adapter.c b/src/adapter.c
> > index 6eeb2f9..99f9786 100644
> > --- a/src/adapter.c
> > +++ b/src/adapter.c
> > @@ -88,6 +88,10 @@
> >  #define TEMP_DEV_TIMEOUT (3 * 60)
> >  #define BONDING_TIMEOUT (2 * 60)
> >
> > +#define SCAN_TYPE_BREDR (1 << BDADDR_BREDR)
> > +#define SCAN_TYPE_LE ((1 << BDADDR_LE_PUBLIC) | (1 << BDADDR_LE_RANDOM))
> > +#define SCAN_TYPE_DUAL (SCAN_TYPE_BREDR | SCAN_TYPE_LE)
>
> SCAN_TYPE_DUAL isn't being used anywhere in this patch, is it needed
> here? Maybe only include this in the patch that actually uses it?
>
I'll fix that.
> > +
> >  static DBusConnection *dbus_conn = NULL;
> >
> >  static bool kernel_conn_control = false;
> > @@ -1185,7 +1189,7 @@ static gboolean passive_scanning_timeout(gpointer user_data)
> >
> >         adapter->passive_scan_timeout = 0;
> >
> > -       cp.type = (1 << BDADDR_LE_PUBLIC) | (1 << BDADDR_LE_RANDOM);
> > +       cp.type = SCAN_TYPE_LE;
> >
> >         mgmt_send(adapter->mgmt, MGMT_OP_START_DISCOVERY,
> >                                 adapter->dev_id, sizeof(cp), &cp,
> > @@ -1327,6 +1331,21 @@ static void cancel_passive_scanning(struct btd_adapter *adapter)
> >         }
> >  }
> >
> > +static uint8_t get_current_type(struct btd_adapter *adapter)
> > +{
> > +       uint8_t type;
> > +
> > +       if (adapter->current_settings & MGMT_SETTING_BREDR)
> > +               type = SCAN_TYPE_BREDR;
> > +       else
> > +               type = 0;
>
> I'd just initialize type = 0 and then bitwise or SCAN_TYPE_BREDR if
> the BREDR setting is set, which I think makes for more readable code.
>

So when I was writing some kernel code, Marcel told me that they
prefer to delay initialization of variables as long as possible, and
that's in that manner. I also didn't write this code, I just moved it
from other place, so this should be good, or was some convention
changed ?


> > +
> > +       if (adapter->current_settings & MGMT_SETTING_LE)
> > +               type |= SCAN_TYPE_LE;
> > +
> > +       return type;
> > +}
> > +
> >  static void trigger_start_discovery(struct btd_adapter *adapter, guint delay);
> >
> >  static void start_discovery_complete(uint8_t status, uint16_t length,
> > @@ -1372,13 +1391,7 @@ static gboolean start_discovery_timeout(gpointer user_data)
> >
> >         adapter->discovery_idle_timeout = 0;
> >
> > -       if (adapter->current_settings & MGMT_SETTING_BREDR)
> > -               new_type = (1 << BDADDR_BREDR);
> > -       else
> > -               new_type = 0;
> > -
> > -       if (adapter->current_settings & MGMT_SETTING_LE)
> > -               new_type |= (1 << BDADDR_LE_PUBLIC) | (1 << BDADDR_LE_RANDOM);
> > +       new_type = get_current_type(adapter);
> >
> >         if (adapter->discovery_enable == 0x01) {
> >                 /*
> > --
> > 2.2.0.rc0.207.ga3a616c
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> Thanks,
> Arman
