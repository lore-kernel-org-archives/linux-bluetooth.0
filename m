Return-Path: <cyrus@holtmann.org>
From: Biman Paul <biman.paul@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: 'JAGANATH KANAKKASSERY' <jaganath.k@samsung.com>,
	'CHETHAN T N' <chethan.tn@samsung.com>,
	'Seungyoun Ju' <sy39.ju@samsung.com>,
	=?ks_c_5601-1987?B?J73Dvs8n?= <s.syam@samsung.com>
References: 
In-reply-to: 
Subject: RE: MGMT_OP_SET_DISCOVERABLE is queued for a long time if Pairing is
 in progress
Date: Wed, 17 Dec 2014 14:25:40 +0530
Message-id: <00a401d019d7$413a57b0$c3af0710$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=ks_c_5601-1987
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If the device has initiated pairing and after that it tries to change
discovery mode, discovery mode change request is queued until the pairing
operation is completed(be it successful, failed, timeout).

Steps to Reproduce:
1. Initiate Pairing from Instrument Under Test
2. Accept in Instrument under Test but do not accept in remote device
3. Try to change the Visibility from off to on or on to off.
Visibility change does not happen until pairing operation is
completed(Pairing is accepted, rejected or timeout in remote).

Please suggest the best way we can handle this.


Thanks and Regards

Biman Paul
Samsung R&D Institute India - Bangalore

