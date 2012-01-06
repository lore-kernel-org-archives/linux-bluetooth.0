Return-Path: <cyrus@holtmann.org>
Message-ID: <1325887030.6454.104.camel@aeonflux>
Subject: RE: [PATCH] Breaks in A2DP playback during device search
From: Marcel Holtmann <marcel@holtmann.org>
To: "Aj, SanthoshX" <santhoshx.aj@intel.com>
Cc: Amir Hadar <amir.hadar.ti@gmail.com>,
	"Hedberg, Johan" <johan.hedberg@intel.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Holtmann, Marcel" <marcel.holtmann@intel.com>,
	"Nair, Rashmi G" <rashmi.g.nair@intel.com>
Date: Fri, 06 Jan 2012 13:57:10 -0800
In-Reply-To: <001F63875E1AF5428162B5A2D3ED1BDD8FAF@IRSMSX101.ger.corp.intel.com>
References: <001F63875E1AF5428162B5A2D3ED1BDD8E98@IRSMSX101.ger.corp.intel.com>
	 <20120105141946.GA8667@x220>
	 <4f05c20d.0b52650a.405a.ffffffe4@mx.google.com>
	 <001F63875E1AF5428162B5A2D3ED1BDD8FAF@IRSMSX101.ger.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Santhosh,

> > > > Subject: [PATCH] To change the latency of controller  This change
> > is
> > > > done to fix the a2dp breaks as the IMC controller  expects the
> > > > latency to be set explicitly by calling HCI QoS setup
> > > >
> > > > ---
> > > >  audio/device.c         |    7 +++
> > > >  common/Android.mk      |    3 +-
> > > >  common/android_bluez.c |  111
> > > > ++++++++++++++++++++++++++++++++++++++-
> > > --------
> > > >  3 files changed, 98 insertions(+), 23 deletions(-)
> > >
> > > As was previously mentioned by others patches to this list are
> > > expected to be against the upstream git tree. This looks like
> > > something else. One thing I'd like to add though:
> > >
> > > > +static int vendor_high_priority(int fd, uint16_t handle) {
> > > > +    unsigned char hci_sleep_cmd[] = {
> > > > +        0x01,               // HCI command packet
> > > > +        0x57, 0xfc,         // HCI_Write_High_Priority_Connection
> > > > +        0x02,               // Length
> > > > +        0x00, 0x00          // Handle
> > > > +    };
> > > > +
> > > > +    hci_sleep_cmd[4] = (uint8_t)handle;
> > > > +    hci_sleep_cmd[5] = (uint8_t)(handle >> 8);
> > > > +
> > > > +    int ret = write(fd, hci_sleep_cmd, sizeof(hci_sleep_cmd));
> > > > +    if (ret < 0) {
> > > > +        error("write(): %s (%d)]", strerror(errno), errno);
> > > > +        return -1;
> > > > +    } else if (ret != sizeof(hci_sleep_cmd)) {
> > > > +        error("write(): unexpected length %d", ret);
> > > > +        return -1;
> > > > +    }
> > > > +    return 0;
> > > > +}
> > >
> > > When you need to need to create a mechanism which controls some
> > aspect
> > > of an RFCOMM, L2CAP or ACL link your first option should be to
> > > consider implementing it as a socket option. If that's not possible
> > > (though in this case I think it is) then the only other alternative
> > is
> > > to abstract it behind the adapter_ops interface since the core daemon
> > > shouldn't any longer do direct HCI access. So you'd implement sending
> > > this command in hciops and then add the appropriate mgmt command and
> > > add support for it into mgmtops.c and the kernel.
> > 
> > I work in TI (with Chen Ganir and Ilia Kolominsky),
> > 
> > We encountered the same dilemma and suggested a solution using Flow
> > specification.
> > 
> > The Flow Specification HCI relates to an ACL handle and not a specific
> > L2CAP channel. If we intend to configure the Flow Spec using socket
> > option then different profiles might overrun each other settings.
> > 
> > The other option of using the mgmt is not too good either. Since this
> > command is "Link" related and not "Adapter/Device" related, the daemon
> > dbus API would have to receive the ACL handle as parameter or introduce
> > a new property on Device node which might not exist. Note that one can
> > create an L2CAP socket without interfacing the daemon.
> > 
> > My humble opinion is to set the Flow Spec per socket (l2cap/rfcomm)
> > using socket options. Store it per channel and send accumulated flow
> > spec on every change per ACL.
> > 
> > - channel changed its flow sepc
> > - channel with flow spec was closed
> > 
> > All done in the kernel, no changes to the daemon.
> > 
> > Kind Regards,
> > Amir Hadar
> > 
> > 
> 
> Thanks for your valuable inputs; as mentioned earlier please note we are 
> currently using Android Froyo (2.2.2) which has bluez version 4.47 & 
> kernel version 2.6.32.
> 
> Using Flow specification is seems to be good. I will change it to flow spec 
> instead of qos setup command.
> 
> I want to know one thing if we want to use setsockopt to send flow spec 
> (add new socket option SO_L2CAP_OQOS) just handle it l2cap.c to send hci flow spec command,
> that's what you are suggesting?

for the first attempt, I rather go a bit simpler and just trigger this
via SO_PRIORITY and HCI_PRIO_MAX.

We can however also add a general BT_FLOW_SPECIFICATION socket option. I
am looking forward for patches.

Also we have to fallback gracefully to HCI_Setup_QoS for older
controllers.

Regards

Marcel


