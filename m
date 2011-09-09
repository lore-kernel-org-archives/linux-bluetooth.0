Return-Path: <cyrus@holtmann.org>
From: <Waldemar.Rymarkiewicz@tieto.com>
To: <peter@hurleysoftware.com>
CC: <padovan@profusion.mobi>, <linux-bluetooth@vger.kernel.org>
Date: Fri, 9 Sep 2011 09:42:51 +0300
Subject: RE: [PATCH v3 1/2] Bluetooth: Fix auth_complete_evt for legacy units
Message-ID: <99B09243E1A5DA4898CDD8B700111448177F047B65@EXMB04.eu.tieto.com>
References: <1306849766-31540-1-git-send-email-waldemar.rymarkiewicz@tieto.com>,<1315505817.2004.70.camel@THOR>
In-Reply-To: <1315505817.2004.70.camel@THOR>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Hi Peter,

>> Legacy devices don't re-authenticate the link properly if a link key
>> already exists.  Thus, don't update sec_level for this case even if
>> hci_auth_complete_evt indicates success. Otherwise the sec_level will
>> not reflect a real security on the link.

>Can you clarify what you mean by "Legacy devices don't re-authenticate
>the link properly if a link key already exists"?

I don't have a BT spec behind me now, but the point is that the legacy devices will not initiate new paring if the link key already exists.
In another words, if the remote device has already been authenticated (e.g. with 4 digit pin), but the service requires higher security (use of 16 digit pin) the whole auth procedure will not start i.e. link_key_request ... etc. Instead, the controller returns auth_req with success immediately.

>Other than a controller defect, I'm having trouble understanding how an
>authentication could be reported as successful by the host controller
>if the remote fails to provide an acceptable LMP_sres pdu. Or did the
>link manager not send an LMP_au_rand or was a new AU_RAND not issued?

The controllers tested by me behaved this way. I didn't look into LMP stuff.

>The reason this came up is because I'm testing a patch set that performs
>automatic re-authentication tied to l2cap channel sec_level promotion,
>via sockopts, and I'm not seeing problems with this reverted.

>Also, can you help me understand why the AUTH_REQUESTED cmd is sent
>anyway and a pend status used for indication (as opposed to testing
>for the legacy device in hci_conn_auth and returning early)

If you mean HCI_CONN_REAUTH_PEND that was used as indication in order to update sec_level correctly.

I guess there was a wider discussion on the list on this topic, check this out as well.

Thanks,
/Waldek

