Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <517CF7F08A05D4118C380000E869BFA4BDEDD1@emg_ntserv2>
From: R.Schade@tu-braunschweig.de
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Subject: [Bluez-users] =?utf-8?B?c2ltcGxlIHJmY29tbSBjb25uZWN0IT8=?=
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
Date: Fri, 22 Oct 2004 08:36:37 +0200

Hi,

I have two identical BT-Dongles and I want to make my first steps on
programming with bluez. For the first quick and dirty I tried to connect
these two dongles on different PCs over a RFCOMM channel. The server comes
up and is waiting, but the client breaks the connect with "Connection
refused". What can I do? How can I debug or find out more information about
whats going wrong? Can I switch to verbose output for the bluez-daemons?

Both PCs are on Debian Sarge 2.4.27 with whole bluez-stuff compiled in the
kernel and the additional bluez-packages. The "hcid.conf" and "pin" are
identical on both PCs, for testing the security is none. "l2ping" and the
other basic tests are working. "hciconfig -a" and "hcitool scan" looks good,
but sdptool browse xxxx shows only "L2CAP" on protocol-lists, no RFCOMM
(look at the end of email). All internet examples have the rfcomm on the
protocol list ??!

Thanks for your help,
Ralf

void BTserver(void)
{
	int len = 0;
	if ((ownsock = socket(PF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM)) <
0)
	{
		perror("socket!");
		exit(1);
	}
	printf("Server-Socket: %d\n", ownsock);
	if ( bind(ownsock, (struct sockaddr*)&ownaddr, sizeof(ownaddr)) < 0)
	{
		perror("bind!");
		exit(1);
	}
	if (listen(ownsock, 10) < 0)
	{
		perror("listen!");
		exit(1);
	}
	len = sizeof(remoteaddr);
	if ((remotesock = accept(ownsock, (struct sockaddr*)&remoteaddr,
&len)) < 0)
	{
		perror("accept!");
		exit(1);
	}
	printf("Server accept Socket: %d\n", remotesock);
}

void BTclient(void)
{
	int len = 0;
	
	if ((ownsock = socket(PF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM)) <
0)
	{
		perror("socket!");
		exit(1);
	}
	printf("Client-Socket: %d\n", ownsock);
	if ( bind(ownsock, (struct sockaddr*)&ownaddr, sizeof(ownaddr)) < 0)
	{
		perror("bind!");
		exit(1);
	}
	len = sizeof(remoteaddr);
	if ((remotesock = connect(ownsock, (struct sockaddr*)&remoteaddr,
len)) < 0)
	{
		perror("connect!");
		exit(1);
	}
	printf("Client connects: %d\n", remotesock);
}

emg-rs-debian-mobil:~# sdptool browse 00:04:61:81:20:5F
Browsing 00:04:61:81:20:5F ...
Service Name: SDP Server
Service Description: Bluetooth service discovery server
Service Provider: BlueZ
Service RecHandle: 0x0
Service Class ID List:
  "SDP Server" (0x1000)
Protocol Descriptor List:
  "L2CAP" (0x0100)
    PSM: 1
    Version: 0x0001
Language Base Attr List:
  code_ISO639: 0x656e
  encoding:    0x6a
  base_offset: 0x100

Service Name: Public Browse Group Root
Service Description: Root of public browse hierarchy
Service Provider: BlueZ
Service RecHandle: 0x804d050
Service Class ID List:
  "Browse Group Descriptor" (0x1001)
Language Base Attr List:
  code_ISO639: 0x656e
  encoding:    0x6a
  base_offset: 0x100



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
