Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <42372E0A.80002@futurlink.com>
From: Pedro Monjo Florit <pedro.monjo@futurlink.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-users] Multiple Bluetooth connections
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
Date: Tue, 15 Mar 2005 19:48:42 +0100

Hi,

In the application that I am developing, I want to send simultaneous 
OBEX messages to different OBEX servers over Bluetooth. I am using 
OpenOBEX for this purpose. There are two problems I am facing.

On the one hand, it seems that there is only room to establish one 
Bluetooth connection at a time. If I start many OBEX pushes 
simultaneously, only the first one succeeds. The others fail usually 
with error "Device or resource busy" (errno=16); sometimes even with 
"Software caused connection abort" (errno=103). Once the first 
connection is established and while sending OBEX data, I can establish 
another connection.

I just want to make clear that the problem is with the establishment of 
the connection. I am fully aware that it is possible to handle various 
on-going connections with no problems and I have succeeded with that. Is 
there a limitation with Bluetooth or BlueZ that allows only one RFCOMM, 
L2CAP or HCI connection establishment?

On the other hand, some connections die before sending the data, but it 
seems that the file descriptor of this connection does not receive any 
notification (I use select() on all file descriptors, with the file 
descriptor in the read mask). I know that this could be due to a problem 
with my program, a problem with OpenOBEX or the BlueZ version I am using 
(it is not the latest). In any case, to track down the cause, I would 
like to know how can I monitor the Bluetooth connections (at any level, 
but preferably RFCOMM) that a process (or the whole system) has. What I 
am looking for is a tool like netstat.

Thanks & regards,

Pedro Monjo


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
