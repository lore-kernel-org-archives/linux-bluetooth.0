Return-Path: <wim.delvaux@adaptiveplanet.com>
From: wim delvaux <wim.delvaux@adaptiveplanet.com>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [Bluez-users] killing a persisted pand session
Date: Sun, 7 Mar 2004 03:10:27 +0100
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
References: <200403070058.50508.wim.delvaux@adaptiveplanet.com> <200403070245.59604.wim.delvaux@adaptiveplanet.com> <1078624633.2807.20.camel@pegasus>
In-Reply-To: <1078624633.2807.20.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200403070310.27377.wim.delvaux@adaptiveplanet.com>
List-ID: <bluez-users.lists.sourceforge.net>

On Sunday 07 March 2004 02:57, Marcel Holtmann wrote:
> Hi Wim,
>
> > I also have a lot of 'dead' pand --listens haning around in the process
> > table (perhaps a pointer error caused the module to become dangling ???)
>
> when do you start your "pand --listen"? Don't start it from
> bluetooth.agent script.

	Ah that might be the problem. Indeed it is started from there.

	Why ? As said I have a dongle that gets inserted and removed frequently.
	Therefore I wanted the hcid/sdpd/pand thing to start when the dongle
	is inserted. so I added the start / stop of these apps to the bluetooth.agent	
	script.  


case $ACTION in
    add|register)
        # start bluetooth daemons
        sh -x /etc/init.d/bluez-utils start
        sleep 1
        sh -x /etc/init.d/bluez-sdp start
        sleep 1
        sh -x /etc/init.d/bluez-pan start

        # install remover
        #echo "set -x" > $REMOVER
        #echo 'exec 2> /tmp/HCI_REMOVE' >> $REMOVER
        #echo "/etc/init.d/bluez-pan stop" >> $REMOVER
        #echo "/etc/init.d/bluez-sdp stop" >> $REMOVER
        #echo "/etc/init.d/bluez-utils stop" >> $REMOVER
        #chmod 700 $REMOVER
     ;;
     unregister)
        /etc/init.d/bluez-pan stop
        /etc/init.d/bluez-sdp stop
        /etc/init.d/bluez-utils stop
     ;;
esac

>
> Regards
>
> Marcel
