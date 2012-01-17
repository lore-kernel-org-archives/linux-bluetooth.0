Return-Path: <cyrus@holtmann.org>
Date: Tue, 17 Jan 2012 10:27:25 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Daniel Wagner <wagi@monom.org>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v3] Bluetooth: Fix l2cap conn failures for ssp devices
Message-ID: <20120117082725.GA14943@x220.P-661HNU-F1>
References: <1312921615.2261.1.camel@THOR>
 <4F04285E.1070500@monom.org>
 <4F0AA5A2.4070903@monom.org>
 <20120111112646.GB23277@x220>
 <1326742631.32064.21.camel@thor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1326742631.32064.21.camel@thor>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Peter,

On Mon, Jan 16, 2012, Peter Hurley wrote:
> The situation with this patch is that I asked Gustavo not to apply it
> (via IRC). Although the patch works, the overall logic of the
> auth/encryption system is flawed.
> 
> With respect to this issue specifically (ie, ssp vs. non-ssp auth +
> encrypt), the flaw is that the semantic meaning of the
> HCI_CONN_ENCRYPT_PEND bit is overloaded. The meaning of one sense is
> that an actual HCI_OP_SET_CONN_ENCRYPT command is in-flight, and thus,
> for this hci connection, neither an auth nor encrypt request should be
> sent. The second meaning is that the event handler *should* submit an
> encrypt request upon receiving a successful auth complete event.
> 
> At the time, I had a patch prepared which addressed this duality as part
> of a series which enabled true re-auth & sec_level promotion.
> Unfortunately, I discovered that a prior patch had been submitted and
> applied which specifically disables sec_level promotion for non-ssp
> devices. The ml conversation died here
> http://marc.info/?l=linux-bluetooth&m=131609282919575&w=2 so I dropped
> it.

I think it'd be important to continue with this work. Even for
controllers that don't allow a "security upgrade" you can still detect
the situation when you get an auth_complete without any preceding
link_key or PIN request and just drop the connection in such a case. For
legacy pairing this would only happen when going from MEDIUM to HIGH
since LOW means that you don't have a link key yet.

Btw, could you tell me the commit id of this "patch which specifically
disables sec_level promotion for non-ssp devices"?

Johan
