Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <20040605142720.89620.qmail@web50902.mail.yahoo.com>
From: ionut dediu <dyonutz@yahoo.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-devel] L2Cap Connection problem : PC - Nokia 6600
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sat, 5 Jun 2004 07:27:20 -0700 (PDT)

Hy everybody.
I'm a newbie (big surprise :). I'm trying to make a
simple chat application between a Nokia 6600 phone
(using j2me ) and my PC (using BlueZ) over L2CAP. The
problem is that I can't get the connection to start.
I'm guessing it's from connection parameters
negotiation (probably imtu and omtu). First I didn't
supply any of the mtus, neither on pc nor phone, then
I used the same values (512). On both situations I get
the following error message from connect : Can't
connect. Connection refused(111). The phone is the
server, and the PC is the client. I don't specify a
psm on the connection string url on the phone because
I get an exception. Instead I let the BCC of the phone
supply me one. Then using the sdptool I find the psm
(which is allways 4097 <-> 0x1001) and use it in the
client application on the PC to connect. The code is
very simple. Here it is :

PHONE :

	public void registerSimpleL2CAPService()
	{
		try
		{
			String serverConnString =
			
"btl2cap://localhost:ABCD;ReceiveMTU=512;TransmitMTU=512;name=Simple";
			server =
				(L2CAPConnectionNotifier)
Connector.open(serverConnString);
			L2CAPConnection clientConn =
(L2CAPConnection)server.acceptAndOpen();
			((TextBox)mainScreen).setString("Connected");
		}
		catch(Exception e)
		{
			((TextBox)mainScreen).setString("BT Exception");
		}
	}

PC :

#define BT_LOCAL_ADDR "00:0C:76:D3:4C:D3"
#define BT_REM_NOKIA_ADDR "00:60:57:D2:27:66"

int do_connect(char * remAddr)
{
	struct sockaddr_l2 rem_addr, loc_addr;
	struct l2cap_options opts;
	int s, opt;

	if ((s = socket(PF_BLUETOOTH, SOCK_SEQPACKET,
BTPROTO_L2CAP)) < 0) {
		syslog(LOG_ERR, "Can't create socket. %s(%d)",
strerror(errno), errno);
		return -1;
	}

	memset(&loc_addr, 0, sizeof(loc_addr));
	loc_addr.l2_family = AF_BLUETOOTH;
	str2ba(BT_LOCAL_ADDR, &loc_addr.l2_bdaddr);
	if (bind(s, (struct sockaddr *) &loc_addr,
sizeof(loc_addr)) < 0) {
		printf("Can't bind socket. %s(%d)", strerror(errno),
errno);
		exit(1);
	}

	// Get default options 
	opt = sizeof(opts);
	if (getsockopt(s, SOL_L2CAP, L2CAP_OPTIONS, &opts,
&opt) < 0) {
		printf("Can't get default L2CAP options. %s(%d)",
strerror(errno), errno);
		return -1;	
	}

	// Set new options
	opts.omtu = 512;
	opts.imtu = 512;
	if (setsockopt(s, SOL_L2CAP, L2CAP_OPTIONS, &opts,
opt) < 0) {
		printf("Can't set L2CAP options. %s(%d)",
strerror(errno), errno);
		return -1;
	}

	memset(&rem_addr, 0, sizeof(rem_addr));
	rem_addr.l2_family = AF_BLUETOOTH;
	baswap(&rem_addr.l2_bdaddr, strtoba(remAddr));
	rem_addr.l2_psm = htobs(4097);
	if (connect(s, (struct sockaddr *)&rem_addr,
sizeof(rem_addr)) < 0 ) {
		printf("Can't connect. %s(%d)\n", strerror(errno),
errno);
		close(s);
		return -1;
	}

	printf("Connected\n");

	return s;

}

int main(int argc, char** argv)
{
	do_connect(BT_REM_NOKIA_ADDR);
	return 0;
}


The hcidump is :

HCIDump - HCI packet analyzer ver 1.8
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection(0x01|0x0005) plen 13
> HCI Event: Command Status(0x0f) plen 4
> HCI Event: Connect Complete(0x03) plen 11
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 4097 scid 0x0040
> HCI Event: Number of Completed Packets(0x13) plen 5
> HCI Event: Max Slots Change(0x1b) plen 3
> ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0056 scid 0x0040
result 1 status 2
> HCI Event: QoS Setup Complete(0x0d) plen 21
> ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0056 scid 0x0040
result 3 status 0
< HCI Command: Disconnect(0x01|0x0006) plen 3
> HCI Event: Command Status(0x0f) plen 4
> HCI Event: Disconn Complete(0x05) plen 4

What means result 3 status 0, from hcidump ? Sorry I'm
not familiar with hcidump. Thanks a lot in advance.



	
		
__________________________________
Do you Yahoo!?
Friends.  Fun.  Try the all-new Yahoo! Messenger.
http://messenger.yahoo.com/ 


-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
