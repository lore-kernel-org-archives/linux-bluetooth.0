Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <4159C272.1080601@3wt.com.br>
From: Rafael Vidal Aroca <rafael@3wt.com.br>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-users] Initialization script
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 28 Sep 2004 16:58:42 -0300


    Hello people,

    i'm very happy using bluez tools as a wireless internet gateway to 
my ipaq via my linux box.

    I'll report the way i did it in case anyone is interested:

    added the lines to /etc/modules.conf:
   
    alias net-pf-31 bluez
    alias bt-proto-0 l2cap
    alias bt-proto-2 sco
    alias bt-proto-3 rfcomm
    alias bt-proto-4 bnep
    alias tty-ldisc-15 hci_uart
    alias char-major-10-250 hci_vhci

    Run the following commands:
    ---------------------------------------
    hciconfig hci0 up
    hcid
    sdpd
    /opt/kde/bin/kbluetoothd
    pand --listen --role NAP
    dund --listen
    dund --listen --msdun call dun
    echo 1 > /proc/sys/net/ipv4/ip_forward                        
    iptables -t nat -A POSTROUTING -j MASQUERADE -o eth0

    And set a peer called dund in /etc/ppp/peers.

    All worker nicely!  


    The only problem i have is that i have to issue these commands every 
time i turn the computer on.

    I tried to edit hotplug's bluefw script so that after inserting my 
usb bluetooth dongle, and loading the firmware, i get all user space 
apps running.

    But it does not work!
    Yes, if i issue a ps, i see that all needed daemons are running, but 
when my ipaq searches for services, if fails....

    any hint to this strange behavior?

thanks
[]s Rafael.




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
