Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 20 Mar 2014 11:50:53 -0700
Message-ID: <CAHZ1yCmtYxwiQ0_dPJut83vFaOEQEBm2u6CvE0UGVd_u36qzkw@mail.gmail.com>
Subject: RequireAuthentication doesn't require authentication
From: Scott James Remnant <keybuk@chromium.org>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The org.bluez.ProfileManager1 API permits a RequireAuthentication
option to be specified when registering a profile implementation. This
is defined in the API documentation as:

    boolean RequireAuthentication

            Pairing is required before connections
            will be established. No devices will
            be connected if not paired.

This is a little bit hand-wavy, since devices can be paired with an
authenticated link key or with an unauthenticated link key, depending
on whether Just Works pairing was used or not.

Looking at the implementation this option adjusts the security level
of the socket, when false BT_IO_SEC_LOW is used and when true
BT_IO_SEC_MEDIUM is used:

    } else if (strcasecmp(key, "RequireAuthentication") == 0) {
            if (type != DBUS_TYPE_BOOLEAN)
                    return -EINVAL;

            dbus_message_iter_get_basic(value, &b);
            if (b)
                    ext->sec_level = BT_IO_SEC_MEDIUM;
            else
                    ext->sec_level = BT_IO_SEC_LOW;

When medium security is selected, an unauthenticated link key is
permitted to establish the connection:

    /* An unauthenticated combination key has sufficient security for
       security level 1 and 2. */
    if (conn->key_type == HCI_LK_UNAUTH_COMBINATION &&
        (sec_level == BT_SECURITY_MEDIUM || sec_level == BT_SECURITY_LOW))
            goto encrypt;


So RequireAuthentication doesn't require authentication at all, at
least not in the BT 2.1+ world of authenticated and unauthenticated
link keys.

The option really means "Require Encryption".


A few questions:

 1) Is this as intended? I realize that this probably predates the
    2.1 security model in its intent, but the Profile API is newer.

 2) Would fixing this to use BT_IO_SEC_HIGH be a bad thing? Then the
    option would actually do what it says.

 2a) If no, would there be also scope for allowing a profile to select
     "require encryption" (unauthenticated link key okay)?

 2b) If yes, would there be scope for allowing a profile to require
     an authenticated link key in addition to encryption?

Scott
