Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <50142.195.22.30.15.1108037990.squirrel@195.22.30.15>
From: schnelte@uni-paderborn.de
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Subject: [Bluez-devel] Several bluetooth dongles at time
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
Date: Thu, 10 Feb 2005 13:19:50 +0100 (CET)

Hi there,

I am runnning a rfcomm server on a linux pc and want mobile phones to
connect to it.
I need some clearence about the following questions:

1) As the phone is connecting to the pc and not the other way around, the
pc is the slave at first. As far as I know a slave cannot connect to more
than one device at time. So I force a role switch to master after
connection. What happend when another phone will connect? The PC will be
master from the beginning and no role switch is needed? (I don't have a
second mobile to test, at the moment)

2) Can i have multiple connections on the same rfcomm channel? So more
than one mobile can connect to my server at time or only one device per
channel and i have to open more than one channel?

3) If I have more than one bluetooth dongle how can I say which dongle to
use for the connections? At the moment I am setting the field rc_bdaddr to
the address of the bluetooth dongle I am willing to use. Is that about
right? What happens if I am using BDADDR_ANY, BDADDR_ALL or BDADDR_LOCAL
instead? Is there any convinient way that bluez automatically chooses
another dongle if all connections on one dongle are full?

Tnx very much in advance for your answers.

Matthias

This is the code I am using:

  int sock, client, alen;
  int dev;

  struct sockaddr_rc addr;
  if( (sock = socket(AF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM)) < 0)
    {
      perror("socket");
      exit(1);
    }

  addr.rc_family = AF_BLUETOOTH;
  bdaddr_t local;
  str2ba("00:10:60:A4:03:01", &local);
  bacpy(&addr.rc_bdaddr, &local);
  addr.rc_channel = htobs(channel);
  alen = sizeof(addr);

  if(bind(sock, (struct sockaddr *)&addr, alen) < 0)
    {
      perror("bind");
      exit(1);
    }

  listen(sock,10);
  printf("%d Waiting for connections...\n\n",channel);

  if(client = accept(sock, (struct sockaddr *)&addr, &alen))
    {
      printf("%d Got a connection attempt!\n",channel);
    }

  dev=hci_open_dev(0);
  if (dev<0) {
    printf("Error opening hci dev");
    exit(1);

    }

  if (hci_switch_role(dev, &addr.rc_bdaddr, 0, 10000) <0) {
    printf("Role switch failed!");
    }
  close(dev);




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
