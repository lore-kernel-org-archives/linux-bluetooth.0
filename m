Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <42BB637B.1010804@e28.com.hk>
From: Jacky Cheung <jackycheung@e28.com.hk>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] how to scan for other bluetooth device
References: <Pine.LNX.4.44.0506231858020.7539-100000@zeskia.int.eridani.co.uk>
In-Reply-To: <Pine.LNX.4.44.0506231858020.7539-100000@zeskia.int.eridani.co.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Date: Fri, 24 Jun 2005 09:35:55 +0800

Hi all,

My mobile device is MOTO A760. And set it is "Find Me"

in the PC, here are my steps:

# hciconfig hci0 up
# hcitool scan

Sometimes I saw it scanning from few seconds, sometimes it returns quickly


Thanks a lot

Jacky Cheung
cat /etc/bluetooth/hcid.conf
#
# HCI daemon configuration file.
#
# $Id: hcid.conf,v 1.7 2004/12/13 14:16:03 holtmann Exp $
#

# HCId options
options {
        # Automatically initialize new devices
        autoinit yes;

        # Security Manager mode
        #   none - Security manager disabled
        #   auto - Use local PIN for incoming connections
        #   user - Always ask user for a PIN
        #
        security auto;

        # Pairing mode
        #   none  - Pairing disabled
        #   multi - Allow pairing with already paired devices
        #   once  - Pair once and deny successive attempts
        pairing multi;

        # PIN helper
        pin_helper /usr/bin/bluepin;

        # D-Bus PIN helper
        #dbus_pin_helper;
}

# Default settings for HCI devices
device {
        # Local device name
        #   %d - device id
        #   %h - host name
        name "BlueZ (%d)";

        # Local device class
        class 0x3e0100;

        # Default packet type
        #pkt_type DH1,DM1,HV1;

        # Inquiry and Page scan
        iscan enable; pscan enable;

        # Default link mode
        #   none   - no specific policy
        #   accept - always accept incoming connections
        #   master - become master on incoming connections,
        #            deny role switch on outgoing connections
        lm accept;

        # Default link policy
        #   none    - no specific policy
        #   rswitch - allow role switch
        #   hold    - allow hold mode
        #   sniff   - allow sniff mode
        #   park    - allow park mode
        lp rswitch,hold,sniff,park;

        # Authentication and Encryption (Security Mode 3)
        #auth enable;
        #encrypt enable;
}
cat /etc/bluetooth/rfcomm.conf
#
# RFCOMM configuration file.
#
# $Id: rfcomm.conf,v 1.1 2002/10/07 05:58:18 maxk Exp $
#

rfcomm0 {
        # Automatically bind the device at startup
        bind no;

        # Bluetooth address of the device
        device 11:22:33:44:55:66;

        # RFCOMM channel for the connection
        channel 1;

        # Description of the connection
        comment "Example Bluetooth device";
}


Jacky Cheung <jackycheung@e28.com.hk> <mailto:jackycheung@e28.com.hk>
Software Engineer
E28 Hong Kong Limited
Tel: 3105 0493 Fax: 3105 0495
Unit 1003, Millennium City 3,
370 Kwun Tong Road,
Hong Kong



Michael McConnell wrote:

>On Thu, 23 Jun 2005, Jacky Cheung wrote:
>
>  
>
>>my mobile device is on.. and had tried hcitool scan., but no device found
>>    
>>
>
>With most mobile phones, you can have Bluetooth enabled with it set "hidden", 
>that is, it won't respond to scans.
>
>Depending on the phone, you may have an option to toggle it visible or hidden 
>(like the Nokia 6310i), or a "Find Me" option (like most Motorolas) that 
>makes the phone respond to scans for the next 60 seconds, after which it will 
>revert to being hidden.
>
>  
>
>>Joel - JFX wrote:
>>
>>    
>>
>>>the bluetooth option like "visible" on your mobile are ON??
>>>
>>>you can scan using "hcitool scan"
>>>
>>>2005/6/23, Jacky Cheung <jackycheung@e28.com.hk>:
>>> 
>>>
>>>      
>>>
>>>>Hi all,
>>>>
>>>>I am new to linux Bluetooth. I've got a question in paging other
>>>>bluetooth device, says Bluetooth support phone.
>>>>
>>>>My PC is running in Redhat9.0, and I got a USB Bluetooth device. When I
>>>>plugin the Bluetooth device, I've got the following message from
>>>>/var/log/message
>>>>
>>>>Jun 23 18:03:48 localhost kernel: hub.c: new USB device 00:1d.2-1,
>>>>assigned address 5
>>>>Jun 23 18:03:49 localhost hcid[2611]: HCI dev 0 registered
>>>>Jun 23 18:03:49 localhost hcid[2579]: HCI dev 0 registered
>>>>Jun 23 18:03:49 localhost hcid[2611]: HCI dev 0 up
>>>>Jun 23 18:03:49 localhost hcid[2579]: HCI dev 0 up
>>>>Jun 23 18:03:49 localhost hcid[2579]: Starting security manager 0
>>>>Jun 23 18:03:49 localhost hcid[2611]: Starting security manager 0
>>>>Jun 23 18:03:49 localhost /sbin/hotplug: no runnable
>>>>/etc/hotplug/bluetooth.agent is installed
>>>>Jun 23 18:03:52 localhost /etc/hotplug/usb.agent: Setup hci_usb for USB
>>>>product a12/1/1120
>>>>
>>>>Actually, I can see the Bluetooth device from hciconfig, and the phone
>>>>can scan the USB BT. However, I fail to scan the phone device in PC. Is
>>>>that I have missed some settings?
>>>>
>>>>Thanks
>>>>
>>>>Regards,
>>>>Jacky Cheung
>>>>
>>>>-------------------------------------------------------
>>>>SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
>>>>        
>>>>
>>>>from IBM. Find simple to follow Roadmaps, straightforward articles,
>>>      
>>>
>>>>informative Webcasts and more! Get everything you need to get up to
>>>>speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
>>>>_______________________________________________
>>>>Bluez-users mailing list
>>>>Bluez-users@lists.sourceforge.net
>>>>https://lists.sourceforge.net/lists/listinfo/bluez-users
>>>>
>>>>   
>>>>
>>>>        
>>>>
>>>-------------------------------------------------------
>>>SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
>>>      
>>>
>>>from IBM. Find simple to follow Roadmaps, straightforward articles,
>>    
>>
>>>informative Webcasts and more! Get everything you need to get up to
>>>speed, fast. http://ads.osdn.com/?ad_idt77&alloc_id492&op=click
>>>_______________________________________________
>>>Bluez-users mailing list
>>>Bluez-users@lists.sourceforge.net
>>>https://lists.sourceforge.net/lists/listinfo/bluez-users
>>>
>>> 
>>>
>>>      
>>>
>>
>>-------------------------------------------------------
>>SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
>>from IBM. Find simple to follow Roadmaps, straightforward articles,
>>informative Webcasts and more! Get everything you need to get up to
>>speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
>>_______________________________________________
>>Bluez-users mailing list
>>Bluez-users@lists.sourceforge.net
>>https://lists.sourceforge.net/lists/listinfo/bluez-users
>>
>>    
>>
>
>-- Michael "Soruk" McConnell
>   Eridani Star System
>
>   MailStripper - "The easy spam filter."
>   http://mailstripper.eridani.co.uk/
>
>
>
>-------------------------------------------------------
>SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
>from IBM. Find simple to follow Roadmaps, straightforward articles,
>informative Webcasts and more! Get everything you need to get up to
>speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
>_______________________________________________
>Bluez-users mailing list
>Bluez-users@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/bluez-users
>
>  
>


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
