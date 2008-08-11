Return-Path: <cyrus@holtmann.org>
Message-ID: <BLU117-W37725D654BF1EA3447895EDF710@phx.gbl>
From: thanit sara <sara200t@uregina.ca>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Date: Mon, 11 Aug 2008 16:24:17 -0500
In-Reply-To: <d89ddf300808110209k46949860n3c525a7dd7e7b341@mail.gmail.com>
References: <b7bab9650808101623h1b9ca61fhe4725368c4987e0d@mail.gmail.com>
	<d89ddf300808110209k46949860n3c525a7dd7e7b341@mail.gmail.com>
MIME-Version: 1.0
Subject: [Bluez-users] Inquiry result with RSSI (From Newbie)
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net


Dear all,

            Question from newbie. I am trying to send out the inquiry result format with RSSI.
This is what I have done. 
My steps are
1.)open the BT device (open socket)
2.)set up event filters
3.)set the inquiry mode to be result format with RSSI
"int set_Inquiring = hci_send_cmd(sock, OGF_HOST_CTL, OCF_WRITE_INQUIRY_MODE, WRITE_INQUIRY_MODE_RP_SIZE, &cpp);//set inquiry mode"
4.)send out an inquiry
"int Inquiring = hci_send_cmd(sock, OGF_LINK_CTL,OCF_INQUIRY , INQUIRY_CP_SIZE, &cp);//do inquiry"
5.)try to read the rssi from "inquiry_info_with_rssi read_rssi"
6.)close socket

Below is my code. Please advice me. Am I missing something here.
/**************************************************************************************************
 //Open BT device
	//to retrieve the BT id of the local BT adaptor
	local_BT_id = hci_get_route(NULL); //NULL option = get teh first available BT adaptor
	//check for error
	if (local_BT_id < 0)
	{
		//    	printf(stderr, "error code %d: %s\n",errno, strerror(errno));
		perror("Fail to get BT adaptor id");
		exit(1);
	}
	
	//to open the socket of the local BT device 
	sock = hci_open_dev( local_BT_id ); 
	// check for error
	if (local_BT_id < 0 || sock < 0) 
	{
		perror("Fail to open device socket");
		exit(1);
	}
	//*****************************************************    
	//Set up an event filter looking after the inquiry related events
	struct hci_filter InqFilter;
	hci_filter_clear(&InqFilter);
	hci_filter_set_ptype(HCI_EVENT_PKT,  &InqFilter);
	hci_filter_set_event(EVT_INQUIRY_RESULT, &InqFilter);
	hci_filter_set_event(EVT_INQUIRY_RESULT, &InqFilter);
	hci_filter_set_event(EVT_INQUIRY_RESULT_WITH_RSSI, &InqFilter);
	hci_filter_set_event(EVT_INQUIRY_RESULT_WITH_RSSI, &InqFilter);
	hci_filter_set_event(EVT_INQUIRY_COMPLETE, &InqFilter);
	if (setsockopt(sock, SOL_HCI, HCI_FILTER, &InqFilter, sizeof(InqFilter)) < 0)
	{
		perror("Fail to setup filter!");
		exit(1);
	}

	//*****************************************************    
	//inquiry with the RSSI result
	inquiry_info_with_rssi read_rssi;
        
	write_inquiry_mode_cp cpp;
	cpp.mode = 0x01;
	int set_Inquiring = hci_send_cmd(sock, OGF_HOST_CTL, OCF_WRITE_INQUIRY_MODE, WRITE_INQUIRY_MODE_RP_SIZE, &cpp);//set inquiry mode
	
	inquiry_cp cp;	
	cp.lap[0] =0x33;
	cp.lap[1] =0x8b;
	cp.lap[2] =0x9e;
	cp.length = 4; //=4*1.28second = 5seconds
	cp.num_rsp =0;
	
	int Inquiring = hci_send_cmd(sock, OGF_LINK_CTL,OCF_INQUIRY , INQUIRY_CP_SIZE, &cp);//do inquiry
	if (Inquiring < 0)
	{

		printf("starting to inquire: %d\n",Inquiring);
		exit(1);
	}
	else 
		printf ("Done inquiry with RSSI!\n");

    printf("rssi value = %d \n", read_rssi.rssi); //Try to print the RSSI value here.
	close( sock );//close socket
	return 0;
}
/***********************************************************************


Beside my hcidump shows no event result format with RSSI.

< HCI Command: Write Inquiry Mode (0x03|0x0045) plen 1
  01 
> HCI Event: Command Complete (0x0e) plen 4
  01 45 0C 00 
< HCI Command: Inquiry (0x01|0x0001) plen 5
  33 8B 9E 04 00 
> HCI Event: Command Status (0x0f) plen 4
  12 01 01 04 
/********************************************************************

Your kindness is greatly appreciated. I use Fedora9, with BlueZ version 3.32. (I tried command hciconfig hci0 inqmode 1 and it works fine, so I think the problem might not be from my usb dongle.)

Best regards,
Sara

_________________________________________________________________


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
