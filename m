Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: Re: [PATCH 2/3] Bluetooth: Move index to common header in management interface
Date: Wed, 23 Feb 2011 14:37:10 +0100
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"par-gunnar.p.hjalmdahl@stericsson.com"
	<par-gunnar.p.hjalmdahl@stericsson.com>,
	"henrik.possung@stericsson.com" <henrik.possung@stericsson.com>
References: <1298456785-1572-1-git-send-email-szymon.janc@tieto.com> <1298456785-1572-2-git-send-email-szymon.janc@tieto.com> <AANLkTin=5B6E26nzSkGad0W7FfTc+3S0_7F7ErsBLbbp@mail.gmail.com>
In-Reply-To: <AANLkTin=5B6E26nzSkGad0W7FfTc+3S0_7F7ErsBLbbp@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201102231437.10401.szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> > -       err = cmd_complete(sk, MGMT_OP_ADD_UUID, &dev_id, sizeof(dev_id));
> > +       err = cmd_complete(sk, index, MGMT_OP_ADD_UUID, &index, sizeof(index));
> 
> Is index still required to be passed as return parameter, now that it
> is part of the header? This is the case for various other commands.

I've missed that, should be cmd_complete(sk, index, MGMT_OP_ADD_UUID, NULL, 0);
Will send fixed version. 

> > -       err = cmd_complete(sk, MGMT_OP_REMOVE_UUID, &dev_id, sizeof(dev_id));
> > +       err = cmd_complete(sk, index, MGMT_OP_REMOVE_UUID, NULL, 0);
> 
> Here controller index is not being passed as return parameter anymore,
> so it looks inconsistent to me.

This one is correct.

> In general, I think all commands which used to have controller index
> as parameters (both cp and rp), would need to be modified because
> index is already part of the header.

Actually all commands were modified, just missed to null parameters.
 
> Also be sure to update doc/mgmt-api.txt from BlueZ.

Sure.

> Regards,
> 

BR
Szymon
