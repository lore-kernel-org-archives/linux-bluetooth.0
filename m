Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: RequireAuthentication doesn't require authentication
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAHZ1yCmtYxwiQ0_dPJut83vFaOEQEBm2u6CvE0UGVd_u36qzkw@mail.gmail.com>
Date: Thu, 20 Mar 2014 12:05:05 -0700
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <E8777DED-269B-4C31-9E87-6CBA1F3B1A26@holtmann.org>
References: <CAHZ1yCmtYxwiQ0_dPJut83vFaOEQEBm2u6CvE0UGVd_u36qzkw@mail.gmail.com>
To: Scott James Remnant <keybuk@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Scott,

> The org.bluez.ProfileManager1 API permits a RequireAuthentication
> option to be specified when registering a profile implementation. This
> is defined in the API documentation as:
> 
>    boolean RequireAuthentication
> 
>            Pairing is required before connections
>            will be established. No devices will
>            be connected if not paired.
> 
> This is a little bit hand-wavy, since devices can be paired with an
> authenticated link key or with an unauthenticated link key, depending
> on whether Just Works pairing was used or not.
> 
> Looking at the implementation this option adjusts the security level
> of the socket, when false BT_IO_SEC_LOW is used and when true
> BT_IO_SEC_MEDIUM is used:
> 
>    } else if (strcasecmp(key, "RequireAuthentication") == 0) {
>            if (type != DBUS_TYPE_BOOLEAN)
>                    return -EINVAL;
> 
>            dbus_message_iter_get_basic(value, &b);
>            if (b)
>                    ext->sec_level = BT_IO_SEC_MEDIUM;
>            else
>                    ext->sec_level = BT_IO_SEC_LOW;
> 
> When medium security is selected, an unauthenticated link key is
> permitted to establish the connection:
> 
>    /* An unauthenticated combination key has sufficient security for
>       security level 1 and 2. */
>    if (conn->key_type == HCI_LK_UNAUTH_COMBINATION &&
>        (sec_level == BT_SECURITY_MEDIUM || sec_level == BT_SECURITY_LOW))
>            goto encrypt;
> 
> 
> So RequireAuthentication doesn't require authentication at all, at
> least not in the BT 2.1+ world of authenticated and unauthenticated
> link keys.

the Bluetooth core specification has a mapping table on how Simple Pairing security levels map to Legacy Pairing. The only time you should be requiring High security level is with SAP profile. All other profiles should be just use Medium security. Keep in mind that an unauthenticated link key is still stronger than a link key obtained through legacy pairing.

The term authenticated vs unauthenticated when it comes to the link key means MITM protection or not. It is not the best terminology I might add.

What we mean with the RequireAuthentication is that the connection is authenticated, meaning that you are actually paired.

> The option really means "Require Encryption”.

Authenticated connections that are not encrypted are not really safe. So one comes with the other. And in Bluetooth the encryption is based on a previous authentication.

Also with Simple Pairing you are mandated that all connection oriented channels (with a few well documented exceptions like SDP) are required to be encrypted.

> A few questions:
> 
> 1) Is this as intended? I realize that this probably predates the
>    2.1 security model in its intent, but the Profile API is newer.

As commented above, there is a mapping between Legacy Pairing and Simple Pairing which we follow.

> 2) Would fixing this to use BT_IO_SEC_HIGH be a bad thing? Then the
>    option would actually do what it says.

Yes it would be. It is an interop nightmare since you require MITM. Best example are headsets that can neither confirm a passkey, nor display a passkey.

We have been through this and it does not work in your favor at all. It causes tons of problems left and right. And since the unauthenticated link key is still stronger than legacy pairing derived link key, we left it at that.

> 2a) If no, would there be also scope for allowing a profile to select
>     "require encryption" (unauthenticated link key okay)?
> 
> 2b) If yes, would there be scope for allowing a profile to require
>     an authenticated link key in addition to encryption?

Besides SAP, there should be no profile at the moment that requires an authenticated link key.

The support for Secure Connections is not wildly deployed at the moment, but what might arise is something like RequireFIPS or RequireSecureConnection where the security level is actually not even High, it is FIPS level strong keys (at least that is how we named it internally in the kernel) which is level 4.

Regards

Marcel

