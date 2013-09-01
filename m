Return-Path: <cyrus@holtmann.org>
Date: Sun, 1 Sep 2013 18:44:17 +0100
From: Gustavo Padovan <gustavo@padovan.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2] Bluetooth: Introduce new HCI socket channel for user
 operation
Message-ID: <20130901174417.GM7440@joana>
References: <1377578452-7316-2-git-send-email-marcel@holtmann.org>
 <20130901164544.GI7440@joana>
 <28EA1BF5-3484-4ABE-9049-6845F006C778@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <28EA1BF5-3484-4ABE-9049-6845F006C778@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

2013-09-01 Marcel Holtmann <marcel@holtmann.org>:

> Hi Gustavo,
> 
> >> This patch introcuces a new HCI socket channel that allows user
> >> applications to take control over a specific HCI device. The application
> >> gains exclusive access to this device and forces the kernel to stay away
> >> and not manage it. In case of the management interface it will actually
> >> hide the device.
> >> 
> >> Such operation is useful for security testing tools that need to operate
> >> underneath the Bluetooth stack and need full control over a device. The
> >> advantage here is that the kernel still provides the service of hardware
> >> abstraction and HCI level access. The use of Bluetooth drivers for
> >> hardware access also means that sniffing tools like btmon or hcidump
> >> are still working and the whole set of transaction can be traced with
> >> existing tools.
> >> 
> >> With the new channel it is possible to send HCI commands, ACL and SCO
> >> data packets and receive HCI events, ACL and SCO packets from the
> >> device. The format follows the well established H:4 protocol.
> >> 
> >> The new HCI user channel can only be established when a device has been
> >> through its setup routine and is currently powered down. This is
> >> enforced to not cause any problems with current operations. In addition
> >> only one user channel per HCI device is allowed. It is exclusive access
> >> for one user application. Access to this channel is limited to process
> >> with CAP_NET_RAW capability.
> >> 
> >> Using this new facility does not require any external library or special
> >> ioctl or socket filters. Just create the socket and bind it. After that
> >> the file descriptor is ready to speak H:4 protocol.
> >> 
> >>        struct sockaddr_hci addr;
> >>        int fd;
> >> 
> >>        fd = socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI);
> >> 
> >>        memset(&addr, 0, sizeof(addr));
> >>        addr.hci_family = AF_BLUETOOTH;
> >>        addr.hci_dev = 0;
> >>        addr.hci_channel = HCI_CHANNEL_USER;
> >> 
> >>        bind(fd, (struct sockaddr *) &addr, sizeof(addr));
> >> 
> >> The example shows on how to create a user channel for hci0 device. Error
> >> handling has been left out of the example. However with the limitations
> >> mentioned above it is advised to handle errors. Binding of the user
> >> cahnnel socket can fail for various reasons. Specifically if the device
> >> is currently activated by BlueZ or if the access permissions are not
> >> present.
> >> 
> >> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> >> ---
> >> include/net/bluetooth/hci.h |  1 +
> >> net/bluetooth/hci_sock.c    | 86 ++++++++++++++++++++++++++++++++++++++++++---
> >> 2 files changed, 82 insertions(+), 5 deletions(-)
> >> 
> >> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> >> index 128157d..30c88b5 100644
> >> --- a/include/net/bluetooth/hci.h
> >> +++ b/include/net/bluetooth/hci.h
> >> @@ -1571,6 +1571,7 @@ struct sockaddr_hci {
> >> #define HCI_DEV_NONE	0xffff
> >> 
> >> #define HCI_CHANNEL_RAW		0
> >> +#define HCI_CHANNEL_USER	1
> >> #define HCI_CHANNEL_MONITOR	2
> >> #define HCI_CHANNEL_CONTROL	3
> > 
> > Wouldn't this break BlueZ 4.101? It would open the channel 1 thinking it is
> > the CONTROL one but it is not. I think we need to redefine this to 4.
> > I can do this when applying the patch if you are okay with it.
> 
> it would not break it since I am explicitly returning EINVAL when you try to establish a user channel with HCI_DEV_NONE.

Fair enough. Both patches have been applied to bluetooth-next. Thanks.

	Gustavo
