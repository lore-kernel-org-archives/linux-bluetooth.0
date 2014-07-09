Return-Path: <cyrus@holtmann.org>
Date: Wed, 9 Jul 2014 12:45:28 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 2/7] Bluetooth: Introduce a whitelist for BR/EDR
 devices
Message-ID: <20140709094528.GA13302@t440s.P-661HNU-F1>
References: <1404895392-12588-1-git-send-email-johan.hedberg@gmail.com>
 <1404895392-12588-3-git-send-email-johan.hedberg@gmail.com>
 <C1F2DD39-B0C1-43A8-94DA-691C76841231@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <C1F2DD39-B0C1-43A8-94DA-691C76841231@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Jul 09, 2014, Marcel Holtmann wrote:
> > @@ -5230,8 +5230,26 @@ static int add_device(struct sock *sk, struct hci_dev *hdev,
> > 				    MGMT_STATUS_INVALID_PARAMS,
> > 				    &cp->addr, sizeof(cp->addr));
> > 
> > +	if (cp->action != 0x00 && cp->action != 0x01)
> > +
> 
> something is wrong here. Shouldn't this return invalid params?

Yes, very good catch. Seems I did cut&paste instead of copy&paste and
neither I nor the compiler noticed it.

Johan
