Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <7aa80ced0502212224cce2126@mail.gmail.com>
From: Mohan K <kmohangda@gmail.com>
To: bluez-users@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: [Bluez-users] trying to send data at HCI level
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
Date: Tue, 22 Feb 2005 11:54:45 +0530

Hi all,
       I am using two USB dongles on two different PCs. I want to send
and receive data on the either side at HCI level. I wrote one program
to send and receive the data, which is not working. I don't know how
to send and recevie the data at the HCI level. Previously I wrote
program for L2CAP level, which is working.
       Can any any one help me to do at HCI level. I am using blueZ
stack in linux platform
 The program is as follows:

/* program*/

	size_t datlen;
	int nb;
	bdaddr_t bdaddr;
	int opt, ptype, dd;
	uint16_t handle;
	uint8_t role;

	role = 0x01;
	ptype = HCI_DM1 | HCI_DM3 | HCI_DM5 | HCI_DH1 | HCI_DH3 | HCI_DH5;

	str2ba("00:0B:0D:33:DA:F9", &bdaddr);

	if (dev_id < 0) {
		dev_id = hci_get_route(&bdaddr);
		if (dev_id < 0) {
			fprintf(stderr, "Device is not available.\n");
			exit(1);
		}
	}

	dd = hci_open_dev(dev_id);
	if (dd < 0) {
		perror("HCI device open failed");
		exit(1);
	}

	if (hci_create_connection(dd, &bdaddr, htobs(ptype),
					0, role, &handle, 25000) < 0)
		perror("Can't create connection");

	datlen=formpacket(0x01,0x04);

	if ((nb=send(dd,&packet[0],(datlen+4),MSG_DONTWAIT))< 0)
	{
			perror("\nCan't send data.\n");
	}
	else
	{
			printf("\nNo. of bytes sent=%d\n",nb);
	}
	

	hci_close_dev(dd);


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
