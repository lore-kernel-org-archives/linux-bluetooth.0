Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: =?utf-8?B?xYF1a2Fzeg==?= Rymanowski
	<lukasz.rymanowski@codecoup.pl>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ 2/2] core/device: Don't set MTU when acting as a peripheral
Date: Fri, 04 Mar 2016 14:35:02 +0100
Message-ID: <1470750.IYgv6yt3ls@ix>
In-Reply-To: <CABBYNZLYzkL8x7rVfrO9tO=xqfKScbOWU=NVhVdy4cgKuxBbJw@mail.gmail.com>
References: <1457094267-5925-1-git-send-email-luiz.dentz@gmail.com> <CAExxLLC4moiHCOtWo+L+d9R=M1K_tVsvB4GRCbjGCAeswz3Gtg@mail.gmail.com> <CABBYNZLYzkL8x7rVfrO9tO=xqfKScbOWU=NVhVdy4cgKuxBbJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Friday 04 March 2016 15:12:39 Luiz Augusto von Dentz wrote:
> Hi Łukasz,
> 
> On Fri, Mar 4, 2016 at 2:51 PM, Łukasz Rymanowski
> 
> <lukasz.rymanowski@codecoup.pl> wrote:
> > Hi Luiz,
> > 
> > On 4 March 2016 at 13:24, Luiz Augusto von Dentz <luiz.dentz@gmail.com> 
wrote:
> >> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >> 
> >> Some Android versions don't seem to cope well with the fact that the
> >> peripheral can actually set a MTU thus leave the MTU as the default.
> > 
> > Just tested that and for me connection with Android works OK even BlueZ
> > started Exchange MTU procedure. Tested on Android 5 and 6.
> > 
> > I saw once the issue that Android could not retrieve services after
> > connection to BlueZ
> > but from the logs it looked like BlueZ start search for primary
> > services  and Android not.
> > If Android make to sent search request for primary services first then
> > it was fine.
> > 
> > Maybe Android don't like BlueZ to start search primary if Android is
> > initiator? But this is their bug
> > BTW. I saw it on Android 5 not yet on 6.
> 
> With 4.4 it actually made a difference.
> 
> >> ---
> >> 
> >>  src/attrib-server.c | 2 +-
> >>  src/device.c        | 8 +++++---
> >>  src/device.h        | 2 +-
> >>  src/gatt-database.c | 2 +-
> >>  4 files changed, 8 insertions(+), 6 deletions(-)
> >> 
> >> diff --git a/src/attrib-server.c b/src/attrib-server.c
> >> index 4439c27..e92ca5c 100644
> >> --- a/src/attrib-server.c
> >> +++ b/src/attrib-server.c
> >> @@ -1281,7 +1281,7 @@ static void connect_event(GIOChannel *io, GError
> >> *gerr, void *user_data)>> 
> >>         if (!device)
> >>         
> >>                 return;
> >> 
> >> -       device_attach_att(device, io);
> >> +       device_attach_att(device, io, false);
> >> 
> >>  }
> >>  
> >>  static gboolean register_core_services(struct gatt_server *server)
> >> 
> >> diff --git a/src/device.c b/src/device.c
> >> index 14e850e..b4bc593 100644
> >> --- a/src/device.c
> >> +++ b/src/device.c
> >> @@ -4664,7 +4664,7 @@ static bool remote_counter(uint32_t *sign_cnt, void
> >> *user_data)>> 
> >>         return true;
> >>  
> >>  }
> >> 
> >> -bool device_attach_att(struct btd_device *dev, GIOChannel *io)
> >> +bool device_attach_att(struct btd_device *dev, GIOChannel *io, bool
> >> initiator)>> 
> >>  {
> >>  
> >>         GError *gerr = NULL;
> >>         GAttrib *attrib;
> >> 
> >> @@ -4699,7 +4699,9 @@ bool device_attach_att(struct btd_device *dev,
> >> GIOChannel *io)>> 
> >>                 }
> >>         
> >>         }
> >> 
> >> -       dev->att_mtu = MIN(mtu, BT_ATT_MAX_LE_MTU);
> >> +       /* Only attempt to set MTU if initiator/central */
> > 
> > Keep in mind that MTU echange procedure is bonded to Client/Server
> > role not central/peripheral.
> 
> Well actually is not either GAP or GATT role related since both side
> are in fact allowed to do that, so this is just a workaround.
> 
> >> +       dev->att_mtu = initiator ? MIN(mtu, BT_ATT_MAX_LE_MTU) :
> >> +                                                      
> >> BT_ATT_DEFAULT_LE_MTU;>> 
> >>         attrib = g_attrib_new(io, dev->att_mtu, false);
> >>         if (!attrib) {
> >>         
> >>                 error("Unable to create new GAttrib instance");
> >> 
> >> @@ -4768,7 +4770,7 @@ static void att_connect_cb(GIOChannel *io, GError
> >> *gerr, gpointer user_data)>> 
> >>                 goto done;
> >>         
> >>         }
> >> 
> >> -       if (!device_attach_att(device, io))
> >> +       if (!device_attach_att(device, io, true))
> >> 
> >>                 goto done;
> >>         
> >>         if (attcb->success)
> >> 
> >> diff --git a/src/device.h b/src/device.h
> >> index db10827..5c01ed0 100644
> >> --- a/src/device.h
> >> +++ b/src/device.h
> >> @@ -72,7 +72,7 @@ struct bt_gatt_client
> >> *btd_device_get_gatt_client(struct btd_device *device);>> 
> >>  struct bt_gatt_server *btd_device_get_gatt_server(struct btd_device
> >>  *device); void btd_device_gatt_set_service_changed(struct btd_device
> >>  *device,>>  
> >>                                                 uint16_t start, uint16_t
> >>                                                 end);
> >> 
> >> -bool device_attach_att(struct btd_device *dev, GIOChannel *io);
> >> +bool device_attach_att(struct btd_device *dev, GIOChannel *io, bool
> >> initiator);>> 
> >>  void btd_device_add_uuid(struct btd_device *device, const char *uuid);
> >>  void device_add_eir_uuids(struct btd_device *dev, GSList *uuids);
> >>  void device_set_manufacturer_data(struct btd_device *dev, GSList *list);
> >> 
> >> diff --git a/src/gatt-database.c b/src/gatt-database.c
> >> index d906e2b..4df4a16 100644
> >> --- a/src/gatt-database.c
> >> +++ b/src/gatt-database.c
> >> @@ -499,7 +499,7 @@ static void connect_cb(GIOChannel *io, GError *gerr,
> >> gpointer user_data)>> 
> >>         if (!device)
> >>         
> >>                 return;
> >> 
> >> -       device_attach_att(device, io);
> >> +       device_attach_att(device, io, false);
> > 
> > Not sure if it works when you use white list for autoconnect because
> > iirc we got this callback when BlueZ is initiator
> > then. But still initiator or not, the important thing is if we act as
> > client or server.
> 
> Probably not, I will have to add more logic to detect how it got
> connected, maybe we can actually check who is the master so that the
> master should be the one controlling the MTU.

Both sides can initiate MTU exchange as you can be both server and client.
I really fail to see how mixing that with central vs peripheral would help. 
And if there is a bug in Android then we would have to first understand it eg. 
if problem is just with MTU or any other request would result in same issue.

-- 
pozdrawiam
Szymon Janc
