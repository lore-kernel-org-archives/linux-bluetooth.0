Return-Path: <rene@soft.uni-linz.ac.at>
Message-ID: <3F950E33.3070303@soft.uni-linz.ac.at>
Date: Tue, 21 Oct 2003 12:45:07 +0200
From: Rene Mayrhofer <rene@soft.uni-linz.ac.at>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
Cc: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Re: command tx timeout and continuous inquiry.
References: <3F86784F.9050608@soft.uni-linz.ac.at>	<1065778372.14923.336.camel@baroque.r		ococosoft.com>		<3F86A88E.4090106@soft.uni-linz.ac.at>	<1065790691.14513.173.camel@pegasus>	  <3F86AF96.7000904@soft.uni-linz.ac.at>	<1065791594.14514.179.camel@pegasus>  <3F8FB6D9.8030000@soft.uni-linz.ac.at> <1066636708.902.5.camel@pegasus>
In-Reply-To: <1066636708.902.5.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Marcel,

Sorry to bother you again, but it still doesn't work as expected....

Marcel Holtmann wrote:
>>>all CSR firmwares with HCI 16.x and greater are fine.
>>
>>I will try a few devices at the hardware store to be sure to get a good 
>>firmware revision if I know what to look for. I'll look for CSR chipsets 
>>(easy to check), but which HCI Rev. and Subver. should I look for ? 
>>Which is the mimimum set of features that is needed ?
> 
> 
> You can take a look at my web pages
> 
> 	http://www.holtmann.org/linux/bluetooth/csr.html

I think I now have an adapter with correct firmware:

[rene@wall2 /tmp]$ sudo hciconfig -a
hci0:   Type: USB
         BD Address: 00:04:61:80:C3:DC ACL MTU: 192:8  SCO MTU: 64:8
         UP RUNNING PSCAN ISCAN
         RX bytes:99 acl:0 sco:0 events:13 errors:0
         TX bytes:296 acl:0 sco:0 commands:12 errors:0
         Features: 0xff 0xff 0x0b 0x00
         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
         Link policy: HOLD SNIFF PARK
         Link mode: MASTER
         Name: 'Wally (0)'
         Class: 0x000100
         Service Classes: Unspecified
         Device Class: Computer, Uncategorized
         HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP 
Subver: 0x20d
         Manufacturer: Cambridge Silicon Radio (10)

[rene@wall2 /tmp]$ sudo hciconfig hci0 revision
hci0:   Type: USB
         BD Address: 00:04:61:80:C3:DC ACL MTU: 192:8  SCO MTU: 64:8
         HCI 16.4 (bc02x)

[rene@wall2 /tmp]$ cat /proc/version
Linux version 2.4.22 (root@wally) (gcc version 3.2.3 (Debian)) #1 Fri 
Sep 5 16:10:27 CEST 2003


However, I am still unable to create a second L2 connection (with BSD 
sockets) from two independent threads. A test run with my custom code 
shows the following (I've commented it a bit and the respective code is 
at the end of this mail):

Creating new L2Connection object for MAC 00:E0:00:C7:33:5E, starting 
ping thread now
<comment> This means that the MAC address 00:E0:00:C7:33:5E has been 
found during an inquiry (in a background inquiry thread) and that 
another thread was started specifically for this MAC. No connection has 
been made until now, only the inquiry. </comment>

BluetoothLinuxFeatureProvider::L2Connection::run (00:E0:00:C7:33:5E): 
opened socket 8
<comment> This means that the newly started thread has created a socket 
for Bluetooth and got socket descriptor 8 back from the socket call. 
</comment>

Creating new L2Connection object for MAC 00:02:C7:08:77:11, starting 
ping thread now
Creating new L2Connection object for MAC 00:01:E3:10:44:ED, starting 
ping thread now
<comment> Two more MAC addresses were found during the inquiry, so two 
additional threads are started. </comment>

BluetoothLinuxFeatureProvider::L2Connection::run (00:02:C7:08:77:11): 
opened socket 9
<comment> The socket was opened successfully. </comment>

BluetoothLinuxFeatureProvider::L2Connection::run: Can't connect: Device 
or resource busy (16)
<comment> But the connect() call returned an error (16). </comment>

Deleting L2Connection object for MAC 00:02:C7:08:77:11, ping thread stopped
<comment> Since connect is not possible, the new thread immediately 
stops again. </comment>

BluetoothLinuxFeatureProvider::L2Connection::run (00:01:E3:10:44:ED): 
opened socket 9
BluetoothLinuxFeatureProvider::L2Connection::run: Can't connect: Device 
or resource busy (16)
Deleting L2Connection object for MAC 00:01:E3:10:44:ED, ping thread stopped
<comment> The same problem for the third MAC address. </comment>

BluetoothLinuxFeatureProvider::L2Connection::run (00:E0:00:C7:33:5E): 
opened socket 6
<comment> The first "ping" thread is running in the background and 
sending L2 echo packets. </comment>

Creating new L2Connection object for MAC 00:02:C7:08:77:11, starting 
ping thread now
BluetoothLinuxFeatureProvider::L2Connection::run (00:02:C7:08:77:11): 
opened socket 8
Creating new L2Connection object for MAC 00:01:E3:10:44:ED, starting 
ping thread now
BluetoothLinuxFeatureProvider::L2Connection::run: Can't connect: Device 
or resource busy (16)
Deleting L2Connection object for MAC 00:02:C7:08:77:11, ping thread stopped
BluetoothLinuxFeatureProvider::L2Connection::run (00:01:E3:10:44:ED): 
opened socket 8
BluetoothLinuxFeatureProvider::L2Connection::run: Can't connect: Device 
or resource busy (16)
Deleting L2Connection object for MAC 00:01:E3:10:44:ED, ping thread stopped
<comment> Another try at the two MAC addresses because they were again 
found in the inquiry. </comment>

BluetoothLinuxFeatureProvider::L2Connection::run (00:E0:00:C7:33:5E): 
opened socket 6
BluetoothLinuxFeatureProvider::L2Connection::run (00:E0:00:C7:33:5E): 
opened socket 6
BluetoothLinuxFeatureProvider::L2Connection::run (00:E0:00:C7:33:5E): 
opened socket 6
BluetoothLinuxFeatureProvider::L2Connection::run (00:E0:00:C7:33:5E): 
opened socket 6
BluetoothLinuxFeatureProvider::L2Connection::run (00:E0:00:C7:33:5E): 
opened socket 6
BluetoothLinuxFeatureProvider::L2Connection::run (00:E0:00:C7:33:5E): 
opened socket 6
BluetoothLinuxFeatureProvider::L2Connection::run (00:E0:00:C7:33:5E): 
opened socket 6
BluetoothLinuxFeatureProvider::L2Connection::run (00:E0:00:C7:33:5E): 
opened socket 6
BluetoothLinuxFeatureProvider::L2Connection::run (00:E0:00:C7:33:5E): 
opened socket 6
BluetoothLinuxFeatureProvider::L2Connection::run (00:E0:00:C7:33:5E): 
opened socket 6
BluetoothLinuxFeatureProvider::L2Connection::run (00:E0:00:C7:33:5E): 
opened socket 6
<comment> This took nearly a minute (there is a 5 seconds delays between 
ping packets), during which no MAC addresses were found in the 
inquiries. Inquiries run constantly in the background with 3 seconds 
delay between inquiry attempts and about 6 seconds inquiry time. As soon 
as a stable "ping" connection is created, the inquiry call no longer 
returns any addresses. </comment>

no response from 00:E0:00:C7:33:5E: id 212
Deleting L2Connection object for MAC 00:E0:00:C7:33:5E, ping thread stopped
<comment> This was simply a timeout in this thread, although the devices 
were not moved. But in my experience, this just happens sometimes. 
</comment>

Creating new L2Connection object for MAC 00:01:E3:10:44:ED, starting 
ping thread now
Creating new L2Connection object for MAC 00:02:C7:08:77:11, starting 
ping thread now
<comment> As soon as the L2 connection is down, the inquiry works again 
and returns MAC addresses. </comment>

BluetoothLinuxFeatureProvider::L2Connection::run (00:01:E3:10:44:ED): 
opened socket 8
BluetoothLinuxFeatureProvider::L2Connection::run (00:02:C7:08:77:11): 
opened socket 9
BluetoothLinuxFeatureProvider::L2Connection::run: Can't connect: Device 
or resource busy (16)
Deleting L2Connection object for MAC 00:02:C7:08:77:11, ping thread stopped
<comment> Same story again. The first socket creation call succeeds, the 
second doesn't. </comment>

.....


This is the code responsible for the background inquiry thread:
void BluetoothLinuxFeatureProvider::run() throw()
{
	int dev_id = -1, length = 5, flags = 0 /*IREQ_CACHE_FLUSH*/,
		num_rsp;
	inquiry_info *info = NULL;
	bdaddr_t bdaddr;

	while (!this->isCancelled()) {
		/* hci_inquiry will malloc() the info structure for the found number
		   of devices */
		num_rsp = hci_inquiry(dev_id, length, 0, NULL, &info, flags);
		if (num_rsp >= 0) {
			for (int i = 0; i < num_rsp; i++) {
				char* macStr = NULL;
				baswap(&bdaddr, &(info+i)->bdaddr);
				macStr = batostr(&bdaddr);
				if (macStr != NULL) {
					// skipped a few checks here, this is only done if a thread is not 
already running for this MAC
					new L2Connection(this, macStr);
				}
			}
			if (info != NULL)
				free(info);
			// we have to set it to 0 so that hci_inquire will again malloc !
			info = NULL;
		}

		this->sleep(3000);
	}
}

And this is the "ping" code for the threads:

void BluetoothLinuxFeatureProvider::L2Connection::run() throw() {
	bool running = true, started = false;
	bdaddr_t bdaddr;
	int id;
	struct sockaddr_l2 addr;
	char buf[128];
	struct hci_conn_info_req *cr;
	struct hci_request rq;
	get_link_quality_rp rp;

	baswap(&bdaddr, strtoba(mac.c_str()));

	// intialize ping packet buffer
	for(unsigned int i = L2CAP_CMD_HDR_SIZE; i < sizeof(buf); i++)
		buf[i]=(i%40)+'A';

	memset(&addr, 0, sizeof(addr));
	addr.l2_family = AF_BLUETOOTH;

	id = ident;
	while (running) {
		struct timeval tv_send, tv_recv, tv_diff;
		l2cap_cmd_hdr *cmd = (l2cap_cmd_hdr *) buf;
		int s, dd, dev_id;

		// first we need to create a Bluetooth socket
		if ((s = socket(PF_BLUETOOTH, SOCK_RAW, BTPROTO_L2CAP)) < 0) {
			plog("BluetoothLinuxFeatureProvider::L2Connection::run: Can't create 
socket: %s\n", strerror(errno));
			running = false;
			break;
		}
		plog("BluetoothLinuxFeatureProvider::L2Connection::run (%s): opened 
socket %d\n", mac.c_str(), s);

		bacpy(&(addr.l2_bdaddr), BDADDR_ANY);
         	if (bind(s, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
			plog("BluetoothLinuxFeatureProvider::L2Connection::run: Can't bind 
socket.\n");
			running = false;
			close(s);
			break;
         	}

		// connect to the remote host
		bacpy(&addr.l2_bdaddr, &bdaddr);
// here the problem starts
		if (connect(s, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
			plog("BluetoothLinuxFeatureProvider::L2Connection::run: Can't 
connect: %s (%d)\n", strerror(errno), errno);
			running = false;
			close(s);
			break;
		}

		/* Build command header */
<snip>

	plog("Deleting L2Connection object for MAC %s, ping thread stopped\n", 
mac.c_str());

}

Most of the code has been taken from hcitool and simply has been adapted 
to the framework. What is not shown here (the <skip> block) is that, 
after a successfully received reply packet, I also open a HCI socket 
with hci_open_dev to get the L2 link quality (code taken from hcitool 
con). Both sockets are closed immediately afterwards in the ping loop. 
Then there is a delay of 5 seconds and it starts again to open the L2 
socket.

Do you have any other pointers on what might go wrong here ? I am 
grateful for any hint. We don't have very much money to spend on 
hardware here at the university, but another Bluetooth adapter should be 
doable :)

best regards,
Rene
