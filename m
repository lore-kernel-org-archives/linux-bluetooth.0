Return-Path: <bluez@thomae-privat.de>
Message-ID: <40F11592.8090704@thomae-privat.de>
Date: Sun, 11 Jul 2004 12:25:22 +0200
From: Matthias Thomae <bluez@thomae-privat.de>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Edd Dumbill <edd@usefulinc.com>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] starting order in debian init script for bluez
References: <40F03526.3000900@thomae-privat.de> <1089485717.13519.75.camel@pegasus>
In-Reply-To: <1089485717.13519.75.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Marcel, Edd,

Marcel Holtmann wrote:
>>Wouldn't it be better to start it before rfcomm/sdpd/pand/hidd, to allow 
>>these services to use the dongle immediately?
> 
> no, because the hcid/sdpd/rfcomm/pand/hidd etc. can be started without
> any real device attached. And when you run hid2hci to switch into HCI
> mode, the hidd must already running to accept the reconnect from your
> HID devices.

Ok, I see.

>>I had a problem connection a Logitech-Hub-dongled PC to a NAP, and 
>>changing the order (and adding 'sleep 2' before start_pan, but that's a 
>>different story I guess) helped here.
> 
> 
> If you start a client connection then this is really a different story.

So it would still make sense to call hci2hid before rfcomm/dund/pand, 
wouldn't it?

BTW, this is exactly the case in the init script contained in 
bluez-utils 2.8:

   start)
         echo -n "Starting $DESC:"
         if $HCID_ENABLE && [ -x "$HCID_EXEC" -a -f "$HCID_CONFIG" ] ; then
                 $HCID_EXEC -f $HCID_CONFIG
                 echo -n " $HCID_NAME"
         fi
         if $SDPD_ENABLE && [ -x "$SDPD_EXEC" ] ; then
                 $SDPD_EXEC
                 echo -n " $SDPD_NAME"
         fi
         if $HIDD_ENABLE && [ -x "$HIDD_EXEC" ] ; then
                 $HIDD_EXEC $HIDD_OPTIONS --server || true
                 echo -n " $HIDD_NAME"
         fi
         if $HID2HCI_ENABLE && [ -x "$HID2HCI_EXEC" ] ; then
                 $HID2HCI_EXEC --tohci > /dev/null 2>&1 || true
                 echo -n " $HID2HCI_NAME"
         fi
         if $RFCOMM_ENABLE && [ -x "$RFCOMM_EXEC" -a -f "$RFCOMM_CONFIG" 
] ; then
                 $RFCOMM_EXEC -f $RFCOMM_CONFIG bind all || true
                 echo -n " $RFCOMM_NAME"
         fi
         if $DUND_ENABLE && [ -x "$DUND_EXEC" -a -n "$DUND_OPTIONS" ] ; then
                 $DUND_EXEC $DUND_OPTIONS
                 echo -n " $DUND_NAME"
         fi
         if $PAND_ENABLE && [ -x "$PAND_EXEC" -a -n "$PAND_OPTIONS" ] ; then
                 $PAND_EXEC $PAND_OPTIONS
                 echo -n " $PAND_NAME"
         fi
         echo "."
         ;;


Regards.
Matthias
