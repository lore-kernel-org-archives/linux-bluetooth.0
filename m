Return-Path: <wim.delvaux@adaptiveplanet.com>
From: wim delvaux <wim.delvaux@adaptiveplanet.com>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [Bluez-users] link_key_request problems
Date: Wed, 25 Feb 2004 03:51:06 +0100
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
References: <200402250154.18963.wim.delvaux@adaptiveplanet.com> <1077672429.2919.67.camel@pegasus>
In-Reply-To: <1077672429.2919.67.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200402250351.06911.wim.delvaux@adaptiveplanet.com>
List-ID: <bluez-users.lists.sourceforge.net>

>
> what are your hcid.conf settings? Set the pairing mode to "multi".

	Pairing is in both MULTI

HCID.conf of IPAQ

# HCId options
options {
        # Automatically initialize new devices
        autoinit yes;

        # Security Manager mode
        #   none - Security manager disabled
        #   auto - Use local PIN for incoming connections
        #   user - Always ask user for a PIN
        #
        security user;

        # Pairing mode
        #   none  - Pairing disabled
        #   multi - Allow pairing with already paired devices
        #   once  - Pair once and deny successive attempts
        pairing multi;

        # PIN helper
        pin_helper /bin/bluepin;
        #dbus_pin_helper;
}device {
        # Local device name
        #   %d - device id
        #   %h - host name
        name "%h (%d)";

        # Local device class
        class 0x120112;

        # Default packet type
        #pkt_type DH1,DM1,HV1;

        # Inquiry and Page scan
        iscan enable; pscan enable;

        # Default link mode
        #   none   - no specific policy
        #   accept - always accept incoming connections
        #   master - become master on incoming connections,
        #            deny role switch on outgoing connections
        #
        #lm accept,master;
        #
        lm accept;

        # Default link policy
        #   none    - no specific policy
        #   rswitch - allow role switch
        #   hold    - allow hold mode
        #   sniff   - allow sniff mode
        #   park    - allow park mode
        #
        #lp hold,sniff;
        #
        lp hold,sniff,park;

        # Authentication and Encryption
        auth enable;
        #encrypt enable;
}

Hcid for the SERVER :

options {
        # Automatically initialize new devices
        autoinit yes;

        # Security Manager mode
        #   none - Security manager disabled
        #   auto - Use local PIN for incoming connections
        #   user - Always ask user for a PIN
        #
        # security auto;
        security user;

        # Pairing mode
        #   none  - Pairing disabled
        #   multi - Allow pairing with already paired devices
        #   once  - Pair once and deny successive attempts
        pairing multi;

        # PIN helper
        pin_helper /usr/bin/bluez-pin;
}

# Default settings for HCI devices
device {
        # Local device name
        #   %d - device id
        #   %h - host name
        name "%h-%d";

        # Local device class
        class 0x100;

        # Default packet type
        #pkt_type DH1,DM1,HV1;

        # Inquiry and Page scan
        iscan enable; pscan enable;

        # Default link mode
        #   none   - no specific policy
        #   accept - always accept incoming connections
        #   master - become master on incoming connections,
        #            deny role switch on outgoing connections
        #
        lm accept,master;
        #
        #lm accept;

        # Default link policy
        #   none    - no specific policy
        #   rswitch - allow role switch
        #   hold    - allow hold mode
        #   sniff   - allow sniff mode
        #   park    - allow park mode
        #
        #lp hold,sniff;
        #
        lp hold,sniff,park;

        # Authentication and Encryption
        auth enable;
        # encrypt enable;
}




>
> Regards
>
> Marcel
