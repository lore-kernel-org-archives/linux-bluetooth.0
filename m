Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTik6UtLziw2ZjNu+BU0k_8GYNW8Zduq8gouLifUG@mail.gmail.com>
References: <AANLkTi=1qnQh+vpcWgBQKAO5bTfANJQ-x0WFd5gg0DYS@mail.gmail.com>
	<AANLkTik6UtLziw2ZjNu+BU0k_8GYNW8Zduq8gouLifUG@mail.gmail.com>
Date: Wed, 2 Mar 2011 20:45:15 -0800
Message-ID: <AANLkTikfJsFWODrhBrYJJyF=PtAtu1P8ioMFx7-u0-Md@mail.gmail.com>
Subject: Re: cannot setup multiple connection using RFCOMM
From: Han <keepsimple@gmail.com>
To: Brad Midgley <bmidgley@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Mar 2, 2011 at 6:31 PM, Brad Midgley <bmidgley@gmail.com> wrote:
> Han
>
>> I have a client / server application running over bluetooth using
>> RFCOMM as transport.  I am using socket API in C with AF_BLUETOOTH,
>> SOCK_STREAM and BTPROTO_RFCOMM.
>
> rfcomm is the wrong protocol if you want to have multiple connections
> to one server.

Thanks Brad. What should be the right protocol to use?

>
> In case you have no choice, I've appended a very old howto suggesting
> a way to multiplex rfcomm for gps, but it's generally unreliable
> because clients cache sdp records unpredictably.

thanks for the detailed info.  It seems that rfcomm.conf has to
include one entry for each connection with different channel? In my
case, I really don't know how many (parallel)  client connections in
advance. It's all dynamic.

Han

>
> ================================
>
> Bluetooth & GPS
> I would like to have a multifunction GPS unit... logging, repeating
> gps location data over bluetooth for two clients. gpsd is running and
> receiving from the local gps.
>
> Next, to make it repeat the gps stream, I started by installing gpspipe.
>
> start with two rfcomm listeners in /etc/bluetooth/rfcomm.conf:
>
> #
> # cat /etc/bluetooth/rfcomm.conf
> #
> # RFCOMM configuration file.
> #
>
> rfcomm0 {
>        listen yes;
>
>        # Bluetooth address of the device
>        device hci0;
>
>        # RFCOMM channel for the connection
>        channel 1;
>
>        # Description of the connection
>        comment "gps repeater channel 1";
> }
>
> rfcomm1 {
>        listen yes;
>
>        # Bluetooth address of the device
>        device hci0;
>
>        # RFCOMM channel for the connection
>        channel 2;
>
>        # Description of the connection
>        comment "gps repeater channel 2";
> }
>
> next, in /etc/bluetooth/rfcomm/rfcomm-gps-repeater:
>
> #!/bin/sh
> # use: rfcomm-gps-repeater rfcommx next-port-number
> # eg: rfcomm-gps-repeater rfcomm0 2 & rfcomm-gps-repeater rfcomm1 1 &
> while true;
>        do
>        rfcomm show | grep $1 > /dev/null 2> /dev/null
>        if [ "$?" != "1" ] ; then
>                /usr/bin/sdptool add --channel=$2 SP
>                /usr/bin/gpspipe -r >/dev/$1;
>        fi
>        sleep 1;
> done
>
> I run two of these in parallel, pointing each one to the *next* rfcomm
> channel it should advertise via sdp. This is so the next bluetooth
> client to scan sdp will find the available repeater.
>
> It seems the rfcomm listener is not prepared to serve two ports. The
> new /etc/bluetooth/rfcomm/rfcomm-listen:
>
> #!/bin/sh
> while $1 -r -f $2 listen $3;do continue;done
>
> Finally, execute everything properly in /etc/init.d/S30bluetooth:
>
> ...
> RFCOMM_GPS_REPEATER=/etc/bluetooth/rfcomm/rfcomm-gps-repeater
> ...
>                #$RFCOMM_LISTEN $RFCOMM_EXEC $RFCOMM_CONFIG > /dev/null 2>&1 &
>                $RFCOMM_LISTEN $RFCOMM_EXEC $RFCOMM_CONFIG rfcomm0 > /dev/null 2>&1 &
>                $RFCOMM_LISTEN $RFCOMM_EXEC $RFCOMM_CONFIG rfcomm1 >
> /dev/null 2>&1 &
>                #$RFCOMM_GETTY > /dev/null 2>&1 &
>                $RFCOMM_GPS_REPEATER rfcomm0 2 > /dev/null 2>&1 &
>                $RFCOMM_GPS_REPEATER rfcomm1 1 > /dev/null 2>&1 &
> ...
>
> You may have to change hcid.conf to contain "lm accept,master" so the
> board insists on being the bluetooth master device. I was getting i/o
> errors before I did that.
>
> --
> Brad Midgley
>
