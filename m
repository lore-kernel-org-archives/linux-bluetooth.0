Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <457F0368.6050007@sbox.tugraz.at>
Date: Tue, 12 Dec 2006 20:30:48 +0100
From: Hans Juergen Gamauf <gamauf@sbox.tugraz.at>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] Problem with RFCOMM/Socket and security
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hello to all!

I'm working with an Embedded System (Arm 9, Linux 2.6.17.3, Uart 
Bluetooth Module from Bluegiga WT11) with Bluez, but without using 
/etc/bluetooth/hcid.conf
I'm starting it with

/usr/sbin/hciattach /dev/ttyS1 csr 115200
/usr/sbin/hciconfig hci0 up

and can set it up using hciconfig (currently I only set the name)

Now I want to establish a simple RFCOMM-Socket-Connection between two of 
these systems through

////// Server
_sock = socket(AF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM);
loc_addr.rc_family = AF_BLUETOOTH;
loc_addr.rc_bdaddr = *BDADDR_ANY;
loc_addr.rc_channel = (uint8_t) 1;
bind(_sock, (struct sockaddr *)&loc_addr, sizeof(loc_addr));
listen(_sock, 1);
_clientSock = accept(_sock, (struct sockaddr *)&rem_addr, (socklen_t*)&opt);


Everything works fine!


But now I want to Authenticate and Encrypt this Connection, so I inserted

opt = RFCOMM_LM_AUTH|RFCOMM_LM_ENCRYPT;
setsockopt(_sock, SOL_RFCOMM, RFCOMM_LM, &opt, sizeof(opt));

after creating the socket, both on the server and the client, but now 
the connection cannot be established, of course, the pin is missing
but where can I introduce it? I have no hcid.conf, so no pin_helper and 
so on, is it possible to tell bluez the pin through this programm?





One little other problem:
I have many clients, and I want that only one connection at a time can 
be established, but when one client is talking to the server, the next 
client can establish it (connect returns 0) and can send the data, but I 
don't know who receives the data
Is it possible to reject the connection from the server if he is dealing 
already a client?




Thank you in advance!

regards,

Hans Juergen


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
