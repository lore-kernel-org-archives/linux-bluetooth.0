Return-Path: <cyrus@holtmann.org>
Date: Thu, 10 Oct 2013 15:48:41 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv3 07/15] android: Create HAL API header skeleton
Message-ID: <20131010124839.GN23879@aemeltch-MOBL1>
References: <1381131496-9417-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1381243883-2745-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1381243883-2745-8-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <69ADBAAE-9261-4C56-9779-5708DE897CBA@holtmann.org>
 <20131010122911.GJ23879@aemeltch-MOBL1>
 <56EFB0C2-81B7-4E25-B1ED-B61465248141@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56EFB0C2-81B7-4E25-B1ED-B61465248141@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Oct 10, 2013 at 02:35:37PM +0200, Marcel Holtmann wrote:
> >>> +#define HAL_MSG_OP_BT_SET_REMOTE_DEVICE_PROP	0x08
> >>> +struct hal_msg_cp_bt_set_remote_device_prop {
> >>> +	__bdaddr_t bdaddr;
> >>> +	uint8_t type;
> >>> +	uint16_t len;
> >> 
> >> Lets make these all align properly.
> > 
> > Align with tabs? So this will be very different from lib/mgmt.h ?
> 
> In monitor/bt.h, I did align them with spaces.

Just to be sure: align structures with spaces always?

Best regards 
Andrei Emeltchenko 
