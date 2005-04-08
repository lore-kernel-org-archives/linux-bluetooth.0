Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4256B7BB.3090800@palmsource.com>
From: Frederic Danis <frederic.danis@palmsource.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-devel] Problem to really close RFComm socket
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 08 Apr 2005 18:56:27 +0200

Hello,

I am trying to use RFComm sockets, but I have a problem when I close the 
socket, it does not close RFComm or ACL connection.
So, if I try to reconnect I got an error 0x10. I used hcidump and 
nothing happens when close is called.
The only way to really close is to stop the app.

what I use is :
        laddr.rc_family = AF_BLUETOOTH;
        laddr.rc_bdaddr = *BDADDR_ANY;
        laddr.rc_channel = 0;
       
        if (bind(rfcSocket, (struct sockaddr *)&laddr, sizeof(laddr)) < 0)
            return -1;
      
        raddr.rc_family = AF_BLUETOOTH;
        raddr.rc_bdaddr = SESSION(btAddr);
        raddr.rc_channel = channel;
        if (connect(rfcSocket, (struct sockaddr *)&raddr, sizeof(raddr)) 
< 0)
            return -1;

       ........

       close(rfcSocket);

I think I have forgot something, but what ?

Regards
Fred


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
