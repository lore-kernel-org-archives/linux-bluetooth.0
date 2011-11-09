Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 1/2] Bluetooth: Add SMP support to user_confirm_reply
From: Marcel Holtmann <marcel@holtmann.org>
To: Brian Gix <bgix@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 10 Nov 2011 07:44:08 +0900
In-Reply-To: <4EBAFFE7.2030506@codeaurora.org>
References: <1320866027-14202-1-git-send-email-bgix@codeaurora.org>
		 <1320866027-14202-2-git-send-email-bgix@codeaurora.org>
	 <1320877587.15441.352.camel@aeonflux> <4EBAFFE7.2030506@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1320878652.15441.361.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brian,

> >> +	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK,&cp->bdaddr);
> >> +	if (!conn) {
> >> +		conn = hci_conn_hash_lookup_ba(hdev, LE_LINK,&cp->bdaddr);
> >> +		if (!conn) {
> >> +			err = cmd_status(sk, index, mgmt_op, ENOTCONN);
> >> +			goto done;
> >> +		}
> >> +
> >> +		/* Forward Confirm response to SMP */
> >> +
> >> +		err = cmd_status(sk, index, mgmt_op, 0);
> >> +		goto done;
> >> +
> >>   	}
> >
> > I am a bit lost why we are trying to find an ACL_LINK here first.
> 
> We want to route the confirmation to the Secure Simple Pair HCI command 
> if this is being done on an ACL link, and to the SMP pairing algorythm 
> if it is being done on an LE link.
> 
> While I suppose we could route all non-LE results to the related HCI 
> command, it seemed cleaner to me to reject it with an ENOTCONN, rather 
> than make an invalid HCI call, and depending on the baseband generating 
> the error.

now I am getting it. This is not really obvious when you look at the
code for the first time. Reason is that the ENOTCONN is too nested to be
obvious. Care to add a comment about this so I do not ask dumb question
next time ;)

Regards

Marcel


