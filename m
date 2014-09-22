Return-Path: <cyrus@holtmann.org>
From: "Gu, Chao Jie" <chao.jie.gu@intel.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: Szymon Janc <szymon.janc@tieto.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"armansito@chromium.org" <armansito@chromium.org>
Subject: RE: [PATCH] Add signed write command
Date: Mon, 22 Sep 2014 12:48:50 +0000
Message-ID: <3D02B219753AD44CBDDDE484323B17741130A119@SHSMSX104.ccr.corp.intel.com>
References: <1410958395-7174-1-git-send-email-chao.jie.gu@intel.com>
 <12273172.GZIjs3WGW2@leonov>
 <3D02B219753AD44CBDDDE484323B17741130A080@SHSMSX104.ccr.corp.intel.com>
 <CD6FEB99-0D29-4AA7-8794-D5B5DFA28C37@holtmann.org>
In-Reply-To: <CD6FEB99-0D29-4AA7-8794-D5B5DFA28C37@holtmann.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


> >>> Add bt_att_set_csrk for btgatt-client tool. However this patch hook
> >>> into shared/mgmt, so btgatt-client now should be running by the root user.
> >>
> >> I guess this could be made optional.
> >
> > You said this could be made optional , what's you point ? I am not
> > very clear about That.
> 
> just provide a command line option to btgatt-client to provide the CSRK to be used.
> There is no need to attach to mgmt since that is only seeing keys during pairing
> anyway.

You means that let user get CSRK from DEVICE_FILE which stored CSRK value
when pairing, and put this CSRK into command line option by himself , right?
 
> >>> +
> >>> +void bt_att_set_csrk(struct bt_att *att,
> >>> +			const uint8_t *val,
> >>> +			uint32_t local_sign_cnt)
> >>
> >> This should allow to set local and/or remote csrk. Either we have two
> >> functions or flag identifying which key is provided.
> >
> > This is good idea. But this patch for client side, there is no need to
> > use remote_csrk, So would it be better to add remote csrk part when we need
> this?
> 
> I want to function. One to set the local CSRK and one for setting the remote CSRK.
> However I have no idea why we are bothering with the sign counter. Just reset it
> when creating bt_att.
> 
That's fine . I will implement it.

Best Regards
Chaojie Gu
