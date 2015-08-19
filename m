Return-Path: <cyrus@holtmann.org>
Date: Wed, 19 Aug 2015 19:23:19 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: tony <tony.makkiel@convergeddevices.net>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: SEC SEM BV 09, MITM + No Bonding
Message-ID: <20150819162319.GA16000@t440s.P-661HNU-F1>
References: <55D4834E.9080705@convergeddevices.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55D4834E.9080705@convergeddevices.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tony,

On Wed, Aug 19, 2015, tony wrote:
> Can somebody please advise on how to force blueZ to initiate connection with
> authentication requirement 1 (MITM required + No Bonding)? From the blueZ
> code, I noticed it follows lead from the remote device. But couldn't find
> anything obvious when initiating connection.

IIRC you do this by setting HIGH or FIPS security level together with
PSM 1 (SDP). l2cap_get_auth_type() in net/bluetooth/l2cap_core.c seems
to indicate that is will give no bonding + MITM.

Johan
