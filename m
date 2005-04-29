Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Microsoft Intellimouse Explorer
From: "mlists@tdbnetworks.org" <mlists@tdbnetworks.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1114792820.8836.102.camel@pegasus>
References: <1114275541.6610.5.camel@hellontoast>
	 <1114276885.10706.31.camel@pegasus>  <1114579747.5602.5.camel@hellontoast>
	 <1114598379.10706.394.camel@pegasus>
	 <50183.213.86.139.177.1114605149.squirrel@sockthing.tdbnetworks.org>
	 <1114790433.7736.16.camel@hellontoast>  <1114792820.8836.102.camel@pegasus>
Content-Type: text/plain
Message-Id: <1114793313.6049.4.camel@hellontoast>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 29 Apr 2005 17:48:33 +0100

Marcel,
Forgive my ignorance by what is security mode 3, and how do I change
this if required?

I've pasted in my hcid.conf file below in the hope that you can help me
get this working as the only config I've done using bluetooth is through
the rfcomm.conf to setup dial up networking.

Thanks in advance

Richard


options {
        # Automatically initialize new devices
        autoinit yes;

        # Security Manager mode
        #   none - Security manager disabled
        #   auto - Use local PIN for incoming connections
        #   user - Always ask user for a PIN
        security user;

        # Pairing mode
        #   none  - Pairing disabled
        #   multi - Allow pairing with already paired devices
        #   once  - Pair once and deny successive attempts
        pairing multi;

        # PIN helper
        pin_helper /usr/bin/bluepin
#       pin_helper /etc/bluetooth/bluepin;
}

# Default settings for HCI devices
device {
        # Local device name
        #   %d - device id
        #   %h - host name
        name "%h-%d";

        # Local device class
        class 0x120104;

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
        encrypt enable;
}



On Fri, 2005-04-29 at 18:40 +0200, Marcel Holtmann wrote:
> Hi Richard,
> 
> > Right, I've been doing some more digging and it looks like the issue is
> > because the mouse doesn't want to have a pin but I also need to use
> > bluetooth for dial up networking to my phone which does need one.
> > 
> > Is there any way in the hcid.conf to setup another profile so I can set
> > specific settings for this device?
> 
> if you set yourself to security mode 3 then you have to deal with it. It
> is not recommended by me and it is also not the default setting.
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: NEC IT Guy Games.
> Get your fingers limbered up and give it your best shot. 4 great events, 4
> opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
> win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
