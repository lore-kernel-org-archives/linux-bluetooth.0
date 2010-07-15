Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTinYIezHD8y4D4s9_awxjdqVV2NSp0f6Tmq1FEpa@mail.gmail.com>
References: <AANLkTinYIezHD8y4D4s9_awxjdqVV2NSp0f6Tmq1FEpa@mail.gmail.com>
Date: Thu, 15 Jul 2010 10:25:53 +0530
Message-ID: <AANLkTimpe_b4IpgRnTHWctF9XcYnb8vVmUCKGdn0_dKO@mail.gmail.com>
Subject: SSP Link key storing issue
From: Prabhakaran Chandrasekara M <prvb86@motorola.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello All,

 I am facing some problem with SSP pairing.
Sometimes Bluez does not store the Authenticated Combination link key
generated during pairing process And found the below code in
dbus-hci.c
hci_dbus_link_key_notify

/* Only store the link key if one of the following is true:
     * 1. this is a legacy link key
     * 2. this is a changed combination key and there was a previously
     *    stored one
     * 3. neither local nor remote side had no-bonding as a requirement
     * 4. the local side had dedicated bonding as a requirement
     * 5. the remote side is using dedicated bonding since in that case
     *    also the local requirements are set to dedicated bonding
     */

And from the logs found that, Bluez sets the Auth requirement as "no
bonding" and remote device sets the auth requirement as "General
Bonding", as a result of this pairing process "Authenticated
combination key" has been generated but not stored because of the
above mentioned check. Hence for the reconnection or other profile
connections, Bluez would re initiate the pairing process which User
would not like.

Usecase:
Remote device was not paired, I initiated a2dp connection through dbus
commands to remote device, hence the l2cap security level is low and
auth requirement is set as "No Bonding" at kernel.


I could not find Specification points for this behavior.

Can some body explain why Bluez has this check (based on some
specification?) while storing link key.

Thanks,
Prabhakaran.
