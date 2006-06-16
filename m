Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Fri, 16 Jun 2006 16:02:25 +0200
From: =?windows-1252?Q?G=F6tz_Issel?= <g.issel@fh-wolfenbuettel.de>
To: bluez-devel@lists.sourceforge.net
Message-id: <167599168834.168834167599@fh-wolfenbuettel.de>
MIME-version: 1.0
Subject: [Bluez-devel] sending SAP messages on rfcomm?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi,
I am still trying to get the remote SimAccessProfile SAP to work. I habe
a BT scanner too now, showing me all in detail down to single bits and I
saw that my sent messages are not being sent.

This is what I have done:

--> search for devices that offer SAP service (standard sdp search and
filter out "the good ones")

--> pairing with the SIM-Server mobile phone using 16 digits pin as
required, works fine 

--> connect to the phone via rfcomm on the channel given by sdp search
before (i.e. nokia 6810 needs #4, siemens s65 wants #6 etc) and here the
phone asks again for allowance to access the SIM. Good sign so far.
     ...
    // allocate a socket
    rfcomm_sock = socket(AF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM);

    // set the connection parameters (who to connect to)
    addr.rc_family = AF_BLUETOOTH;
    addr.rc_channel = (uint8_t) dest_channel;  // dest_channel depends
on mobile phone
    
    str2ba( dest, &addr.rc_bdaddr );  // dest is the string of the
bdaddr of mobile phone

	printf("\r\nrfcomm connect to %s on channel %i",dest,dest_channel);
	fflush(stdout);

    // connect to server
    status = connect(rfcomm_sock, (struct sockaddr *)&addr, sizeof(addr));
    ...

--> now sending the 1st sap message "CONNECT_REQ" like this (bad style,
i know, only testing)

int send_connect_req(int sock)
{
    int status;
    unsigned char message[12] = {};

    message [0]  = 0x00; // message ID, here connection req
    message [1]  = 0x01; // number of parameters
    message [2]  = 0x00; // reserved
    message [3]  = 0x00; // reserved
    message [4]  = 0x00; // parameter ID, here MaxMsgSize
    message [5]  = 0x00; // reserved 
    message [6]  = 0x00; // parameter length high byte
    message [7]  = 0x02; // parameter length low byte
    message [8]  = 0x01; // parameter value high byte
    message [9]  = 0x18; // parameter value low byte
    message [10] = 0x00; // padding byte
    message [11] = 0x00; // padding byte
    
    status = write(sock, &message, sizeof(message));
    return status;
}
 

--> using hcidump shows, that the essage is sent in some way,look at end
of  http://sap.goetzi.de/hci_dump_sap_1st_msg.txt 

I have the feeling i am missing something. Any suggestions? Is "write()"
the correct way? Do I have to define a new type of packet somewhere
first? I amlost and my deadline for handing in my project at uni is
coming closer. Any help appreciated, please.

Thanks,
Goetz



_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
