Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Philip Barnes <phil@trig222.f9.co.uk>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Content-Type: text/plain
Message-Id: <1105899721.5669.12.camel@localhost.localdomain>
Mime-Version: 1.0
Subject: [Bluez-users] Securing my bluetooth connection
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
Date: Sun, 16 Jan 2005 18:22:01 +0000

Hi
I have set up my bluetooth connection on Fedora core 3 so that I can
connect my Palm Pilot. I just needed to add the sdpd line to rc.local
after moving from core 2.

My configuration is below.

A couple of questions
How do I configure it so that only my palm pilot can connect, I have
tried putting my mac address into rfcomm.conf, but I can still connect
when I set it wrong.

How do I make the PC not discoverable, I know the chances of being
scanned by someone standing on the pavement outside is not as likely as
being bluejacked in Tescos or the pub, but it could happen.

Thanks Phil


rc.local --
#
# Start configuration of Bluetooth network
/usr/sbin/hciconfig hci0 up
/usr/sbin/hcid
/usr/sbin/sdpd
/sbin/modprobe rfcomm
dund --listen --msdun 10.2.0.1:10.2.0.10
echo '1' > /proc/sys/net/ipv4/ip_forward
/sbin/iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
/sbin/iptables -A FORWARD -i ppp0 -j ACCEPT
/sbin/iptables -A FORWARD -m state --state ESTABLISHED,RELATED -j ACCEPT

rfcomm.conf --
rfcomm0 {
        # Automatically bind the device at startup
        bind no;

        # Bluetooth address of the device
        device 00:07:E0:xx:xx:xx;

        # RFCOMM channel for the connection
        channel 1;

        # Description of the connection
        comment "Slartibartfast";
}
hcid.conf --
# Default settings for HCI devices
device {
        # Local device name
        #   %d - device id
        #   %h - host name
        name "fordprefect";

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
        lp rswitch,hold,sniff,park;

        # Authentication and Encryption
        #auth enable;
        #encrypt enable;
}






-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
