Return-Path: <cyrus@holtmann.org>
Date: Thu, 20 Nov 2014 16:57:26 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Steven Walter <stevenrwalter@gmail.com>,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] Bluetooth: automatically flushable packets aren't
 allowed on LE links
Message-ID: <20141120145726.GA11947@t440s.P-661HNU-F1>
References: <1416419951-27659-1-git-send-email-stevenrwalter@gmail.com>
 <20141120113813.GA23288@t440s.lan>
 <80321467-10AB-489E-A47E-44B0ECEE4BE1@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <80321467-10AB-489E-A47E-44B0ECEE4BE1@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Nov 20, 2014, Marcel Holtmann wrote:
> > static u16 get_acl_flags(struct hci_conn *hcon, struct l2cap_chan *chan)
> > {
> 
> If we do it with a helper functions, then it should only provide the
> l2cap_chan since we can get the hci_conn from there.

One of the places it'd get called from (l2cap_send_cmd)  doesn't have a
l2cap_chan context at all which is why I split this into one mandatory
(hci_conn) and another optoinal (l2cap_chan) parameter.

Anyway, if you're happy with having this inline with a code comment
explaining the (rather complex) if-statement then I'm fine with that
too.

Johan
