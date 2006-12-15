Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Fri, 15 Dec 2006 15:07:44 +0800
From: amateur <ztl.post@gmail.com>
To: bluez-users@lists.sourceforge.net
Message-ID: <20061215070744.GA3309@163.com>
References: <457F104A.3020508@sbox.tugraz.at>
MIME-Version: 1.0
In-Reply-To: <457F104A.3020508@sbox.tugraz.at>
Subject: Re: [Bluez-users] Problem with RFCOMM/Socket and security
Reply-To: amateur <ztl.post@gmail.com>,
        BlueZ users <bluez-users@lists.sourceforge.net>
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

On Tue, Dec 12, 2006 at 09:25:46PM +0100, Hans Juergen Gamauf wrote:
> Hello to all!
> 
> I'm working with an Embedded System (Arm 9, Linux 2.6.17.3, Uart
> Bluetooth Module from Bluegiga WT11) with Bluez, but without using
> /etc/bluetooth/hcid.conf
> I'm starting it with
> 
> /usr/sbin/hciattach /dev/ttyS1 csr 115200
> /usr/sbin/hciconfig hci0 up
> 
> and can set it up using hciconfig (currently I only set the name)
> 
> Now I want to establish a simple RFCOMM-Socket-Connection between two of
> these systems through
> 
> ////// Server
> _sock = socket(AF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM);
> loc_addr.rc_family = AF_BLUETOOTH;
> loc_addr.rc_bdaddr = *BDADDR_ANY;
> loc_addr.rc_channel = (uint8_t) 1;
> bind(_sock, (struct sockaddr *)&loc_addr, sizeof(loc_addr));
> listen(_sock, 1);
> _clientSock = accept(_sock, (struct sockaddr *)&rem_addr, (socklen_t*)&opt);
> 
> 
> Everything works fine!
> 
> 
> But now I want to Authenticate and Encrypt this Connection, so I inserted
> 
> opt = RFCOMM_LM_AUTH|RFCOMM_LM_ENCRYPT;
> setsockopt(_sock, SOL_RFCOMM, RFCOMM_LM, &opt, sizeof(opt));
> 
> after creating the socket, both on the server and the client, but now
> the connection cannot be established, of course, the pin is missing
> but where can I introduce it? I have no hcid.conf, so no pin_helper and
> so on, is it possible to tell bluez the pin through this programm?
You can handle pin code request in your own code following the way
that hcid uses. BTW, what brand of Embedded Arm Chip support 2.6.17-3?
I have never seen such a embedded arm vendor.
> 
> 
> One little other problem:
> I have many clients, and I want that only one connection at a time can
> be established, but when one client is talking to the server, the next
> client can establish it (connect returns 0) and can send the data, but I
> don't know who receives the data
> Is it possible to reject the connection from the server if he is dealing
> already a client?
What if you close the main socket(the listening one) after accpting
one client? 

-- 
You will pioneer the first Martian colony.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
