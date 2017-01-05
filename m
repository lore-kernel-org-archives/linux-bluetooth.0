Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <1483615023.2420.23.camel@hadess.net>
Subject: Re: [PATCH v2 4/4] Add new DS4 controller PID into special case
 handler
From: Bastien Nocera <hadess@hadess.net>
To: Juha Kuikka <juha.kuikka@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
        Juha Kuikka <juha.kuikka@synapse.com>,
        Frank Praznik <frank.praznik@gmail.com>,
        roderick.colenbrander@sony.com
Date: Thu, 05 Jan 2017 12:17:03 +0100
In-Reply-To: <CAKvrXUpQ8b76Sc+MLLPkmmQ=ZLSP1YQSYKzep8VgJZr-sx1T0w@mail.gmail.com>
References: <1482971563-15745-1-git-send-email-juha.kuikka@gmail.com>
         <1482971563-15745-5-git-send-email-juha.kuikka@gmail.com>
         <1483012139.2308.9.camel@hadess.net>
         <CAKvrXUpQ8b76Sc+MLLPkmmQ=ZLSP1YQSYKzep8VgJZr-sx1T0w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 2017-01-04 at 11:18 -0800, Juha Kuikka wrote:
> Hi Bastien,
> 
> On Thu, Dec 29, 2016 at 3:48 AM, Bastien Nocera <hadess@hadess.net>
> wrote:
> > On Wed, 2016-12-28 at 16:32 -0800, Juha Kuikka wrote:
> > > There is a special path for various game controllers where they
> > > connect
> > > to the hid service before bluetoothd knows what they are.
> > > 
> > > This patch adds another PID for the Dualshock4 controller. This
> > > new
> > > PID
> > > matches with the model number CUH-ZCT2U.
> > > ---
> > >  profiles/input/server.c | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/profiles/input/server.c b/profiles/input/server.c
> > > index eb3fcf8..3576f2b 100644
> > > --- a/profiles/input/server.c
> > > +++ b/profiles/input/server.c
> > > @@ -135,8 +135,10 @@ static bool dev_is_sixaxis(const bdaddr_t
> > > *src,
> > > const bdaddr_t *dst)
> > >       if (vid == 0x054c && pid == 0x0268)
> > >               return true;
> > > 
> > > -     /* DualShock 4 */
> > > -     if (vid == 0x054c && pid == 0x05c4)
> > > +     /* DualShock 4 CUH-ZCT1U (PID 0x05c4)
> > > +      * DualShock 4 CUH-ZCT2U (PID 0x09cc) (slim/pro)
> > > +      */
> > > +     if (vid == 0x054c && (pid == 0x05c4 || pid == 0x09cc))
> > >               return true;
> > > 
> > >       /* Navigation Controller */
> > 
> > Might be nice to have the struct you currently have in the sixaxis
> > plugin in a shared header, so we don't need to open code this
> > function.
> > For example:
> > 
> > typedef enum {
> >   CABLE_PAIRING_SIXAXIS,
> >   CABLE_PAIRING_DS4
> > } CablePairingType;
> > 
> > static struct {
> >   int vid;
> >   int pid;
> >   CablePairingType type;
> > } cable_pairing_devices[] = {
> >   ...
> > };
> > 
> 
> I agree, having the pertinent VID/PID in one place only would be a
> good idea. One small issue I see here is that it would unnecessarily
> expose internal information from sixaxis plugin.

Which internal information? I don't think you need to export any
information from the sixaxis plugin to make this work.

> > The sixaxis plugin would know which functions to use from the type,
> > the
> > input/server.c code would loop over the array to see whether it's a
> > cable pairing.
> 
> Having a type field instead of the function pointers would make for a
> less clear implementation in sixaxis.c. My previous patch had an
> analogous mechanism for detecting controller type and changing
> behavior accordingly and I got some comments about a function pointer
> approach being preferred.

No, I'm not asking you to replace that. Inside the sixaxis plugin you
used to do:
set_master_bdaddr()
{
  if (is_ds4()) {
    ...
  } else if (is_sixaxis()) {
    ...
  }
}

Here, I'm saying that when you're doing your search you should have:
setup_device()
{
  if (is_ds4())
    device->funcs = ds4_device_funcs;
  else if (is_sixaxis()
    device->funcs = sixaxis_device_funcs;
}

Or you could also use another array for that:
static struct {
  DeviceType type;
  SetupFunc setup_func;
  PostSetupFunc post_setup_func;
} functions[] = {
  CABLE_PAIRING_TYPE_DS4, ds4_setup_func, ...

And set that up in setup_device().

> I saw some patches floating around concerning a generalized cable
> pairing mechanism. Perhaps this change should be part of that?

I don't think we need something more generic at this point.
