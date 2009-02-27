Return-Path: <cyrus@holtmann.org>
Message-ID: <20090227144517.qrsrnqmncw4woc4k@webmail.uniserve.com>
Date: Fri, 27 Feb 2009 14:45:17 -0500
From: zakharov@ca.inter.net
To: linux-bluetooth@vger.kernel.org
Subject: Passkey in Bluez4.x
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	DelSp=Yes	format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Good day (Marcel & Co),

We did use bluez3.x with Ubuntu 8.04 along with chan_mobile from
Asterisk add-on, and pairing was done using hcid.conf.
We would like to move to bluez4.x - install fresh Ubunti 8.04 without
bluez-utils and bluetooth-dev packages and then compile/install
bluez4.31 (we are looking for impreved sound quality etc. and overall
would like to be up to speed with your current development). If you
don't mind to answer the following:

1) During Astrerisk add-ons compile chan-mobile portion is looking for
bluez libraries - did it change (location, names, API etc.) since
bluez3.x?
2) Do you have confirmed statements that bluez4.x and chan-mobile do
play nicely with each other?
3) I am confused with regard to pairing in Bluez4.x - we need to be able
to pair with cell phone in a server environment - no GUI whatsoever, so
I am looking for cli based setup instructions - google didn't give me
much in terms of roadmap. After installing bluez4.30 I was able to
hcitool dev and hcitool scan, but when I tried to pair the phone, then
phone didn't see any active devices. Do I miss something here? I saw
somewhere in a mailing list your reply to similar question, but didn't
get it - it was something to do with 'agent'. I did try trunk Ubuntu
(9.04) with claimed bluez4.30, but my chan-mobile compile wouldn't pick
up needed libraries. I would like to stay with Ubuntu 8.04 LTS and
compile/install Bluez manually.

Best regards,
Alexander

