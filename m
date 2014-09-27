Return-Path: <cyrus@holtmann.org>
From: "Gu, Chao Jie" <chao.jie.gu@intel.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH v3 2/4] shared/gatt-client: Add CSRK part to support
 signed write
Date: Sat, 27 Sep 2014 08:42:00 +0000
Message-ID: <3D02B219753AD44CBDDDE484323B17741130B3FA@SHSMSX104.ccr.corp.intel.com>
References: <1411717728-15415-1-git-send-email-chao.jie.gu@intel.com>
 <1411717728-15415-3-git-send-email-chao.jie.gu@intel.com>
 <9AF598FF-82F3-499C-8739-72947EDA695A@holtmann.org>
In-Reply-To: <9AF598FF-82F3-499C-8739-72947EDA695A@holtmann.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

> > +bool bt_gatt_client_set_local_csrk(struct bt_gatt_client *client,
> > +				bool valid_local_csrk,
> > +				uint8_t key[16]);
>=20
> why do we have the parameter valid_local_csrk. I find that highly confusi=
ng. If you
> do not have a valid CSRK, then do not call this function. It should be th=
at simple.
>=20

My initial purpose to set this parameter valid_local_csrk here, user can ca=
ll one API
to set flag valid_local_csrk ture/false and CSRK key in one time.
According to your proposal, I think it really result in confusion for user.

So for more clear to call API , I think we should split two API for upper l=
ayer:
1. When we need to set CSRK , check the CSRK is valid , then call bt_gatt_c=
lient_set_local_csrk
  Just to pass one parameter key to function and in the function to set fla=
g valid_local_csrk is true.

2 When two device dispair each other, we should give user possibility to un=
set flag and CSRK.
  So in this condition , we have to create bt_gatt_client_unset_local_csrk(=
struct bt_gatt_client *client)
  to clear CSRK and set flag valid_local_csrk to false.

Do you think this thought would be ok for you?

Best Regards
Chaojie Gu
