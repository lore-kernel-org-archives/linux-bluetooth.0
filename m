Return-Path: <cyrus@holtmann.org>
From: Amitkumar Karwar <akarwar@marvell.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Cathy Luo
	<cluo@marvell.com>, Zhaoyang Liu <liuzy@marvell.com>
Subject: RE: [PATCH 4/4] Bluetooth: btmrvl: change debug prints to btmrvl_dbg
Date: Fri, 16 Oct 2015 06:10:08 +0000
Message-ID: <7f4d454f4e5145b092c9ac8339576dcf@SC-EXCH04.marvell.com>
References: <1444836883-14701-1-git-send-email-akarwar@marvell.com>
 <1444836883-14701-4-git-send-email-akarwar@marvell.com>
 <E8748FA3-3F04-42F8-9B02-CF298DF734D3@holtmann.org>
 <8fc952a00b5c4a5a8a892517a2408d17@SC-EXCH04.marvell.com>
 <11913A3A-9988-4614-ABBE-68CF0E119186@holtmann.org>
In-Reply-To: <11913A3A-9988-4614-ABBE-68CF0E119186@holtmann.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> owner@vger.kernel.org] On Behalf Of Marcel Holtmann
> Sent: Thursday, October 15, 2015 8:21 PM
> To: Amitkumar Karwar
> Cc: linux-bluetooth; Cathy Luo; Zhaoyang Liu
> Subject: Re: [PATCH 4/4] Bluetooth: btmrvl: change debug prints to
> btmrvl_dbg
>=20
> Hi Amitkumar,
>=20
> >> From: Marcel Holtmann [mailto:marcel@holtmann.org]
> >> Sent: Thursday, October 15, 2015 4:39 AM
> >> To: Amitkumar Karwar
> >> Cc: linux-bluetooth; Cathy Luo; Zhaoyang Liu
> >> Subject: Re: [PATCH 4/4] Bluetooth: btmrvl: change debug prints to
> >> btmrvl_dbg
> >>
> >> Hi Amitkumar,
> >>
> >>> This patch changes all debug print from BT_INFO/BT_DBG/BT_ERR to
> >>> marvell bluetooth driver specific debug functions.
> >>
> >> so BT_INFO and BT_ERR are not debug prints. They are genuine valid
> >> information that should be printed when something goes wrong or is
> >> informational.
> >
> > We will correct the words.
> >
> >>
> >>>
> >>> Signed-off-by: Zhaoyang Liu <liuzy@marvell.com>
> >>> Signed-off-by: Cathy Luo <cluo@marvell.com>
> >>> Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
> >>> ---
> >>> drivers/bluetooth/btmrvl_debugfs.c |   3 +-
> >>> drivers/bluetooth/btmrvl_main.c    | 145 ++++++++++-------
> >>> drivers/bluetooth/btmrvl_sdio.c    | 311 ++++++++++++++++++++++-----
> --
> >> --------
> >>> 3 files changed, 275 insertions(+), 184 deletions(-)
> >>>
> >>> diff --git a/drivers/bluetooth/btmrvl_debugfs.c
> >>> b/drivers/bluetooth/btmrvl_debugfs.c
> >>> index af52b03..7bbe3dc 100644
> >>> --- a/drivers/bluetooth/btmrvl_debugfs.c
> >>> +++ b/drivers/bluetooth/btmrvl_debugfs.c
> >>> @@ -257,7 +257,8 @@ void btmrvl_debugfs_init(struct hci_dev *hdev)
> >>> 	priv->debugfs_data =3D dbg;
> >>>
> >>> 	if (!dbg) {
> >>> -		BT_ERR("Can not allocate memory for btmrvl_debugfs_data.");
> >>> +		btmrvl_dbg(priv->adapter, ERROR,
> >>> +			   "Can not allocate memory for
> >> btmrvl_debugfs_data.");
> >>
> >> Errors are not debug messages. The syntax for btmrvl_dbg is not
> correct.
> >> We can not have such a code merged upstream.
> >>
> >> I am also feeling to see all this value with debug_mask and so on.
> >> The Linux kernel supports dynamic debug which is way more powerful
> >> than trying to invent your own mask based logging. And BT_DBG and
> >> other debug print functions are hooked into it. So why not use it.
> >>
> >> If you prefer having some btmrvl_dev_info wrappers, then that seems
> >> reasonable, but they either map to BT_INFO or pr_dev_info or similar.
> >>
> >> I would really prefer if this patch series gets re-thought and done
> >> the Linux kernel way.
> >
> > CONFIG_DYNAMIC_DEBUG compiler flag is not by default enabled on some
> of the platforms.
> > This was the reason we decided to implement this mask based logging.
> We do have such implementation for our WLAN driver. Also, I can see
> similar thing in other driver in wireless subsystem.
>=20
> and that is a good enough reason to duplicate functionality? My
> viewpoint is that it is not and that even wireless drivers should be
> cleaned up.
>=20

This has been implemented this just to get logs for the issues reported by =
end user where DYNAMIC DEBUG is not enabled.
If isn't a standard way in Linux kernel, please drop these patches.
I suppose you can still consider 1/4.


Regards,
Amit
