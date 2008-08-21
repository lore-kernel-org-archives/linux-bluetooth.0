Return-Path: <cyrus@holtmann.org>
Message-ID: <BLU117-W323C2D9620C852EC69619ADF6B0@phx.gbl>
From: thanit sara <sara200t@uregina.ca>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Date: Thu, 21 Aug 2008 17:03:38 -0500
In-Reply-To: <3e9cdced0808200740p335fd2acq6c2e2aef891293f0@mail.gmail.com>
References: <3e9cdced0808200615v203df9e1pd88e9fd8ac98d7ff@mail.gmail.com>
	<3e9cdced0808200740p335fd2acq6c2e2aef891293f0@mail.gmail.com>
MIME-Version: 1.0
Subject: [Bluez-users] How to access the RSSI value from the
 "inquiry_result_format_with_RSSI" (from newbie)
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


Dear all,         I am trying to implement the code to get rssi values from near by devices. I have successfully changed the inquiry mode to be 0x01 and sent out the inquiry. I can see from the "Hci dump" that it is working, I can see the inquiry result with RSSI values. However, My problem is how can I get(/keep) those rssi values so that I can use them later on.I know there is a struct "inquiry_info_with_rssi", but what should I assign to this to get the response value.Please give me some hint so that I could move on. Your kindness is greatly appreciated.Below is my code.//Set up an event filter looking after the inquiry related events    struct hci_filter InqFilter;    hci_filter_clear(&InqFilter);    hci_filter_set_ptype(HCI_EVENT_PKT,  &InqFilter);    hci_filter_set_event(EVT_INQUIRY_RESULT, &InqFilter);    hci_filter_set_event(EVT_INQUIRY_RESULT_WITH_RSSI, &InqFilter);    hci_filter_set_event(EVT_INQUIRY_COMPLETE, &InqFilter);    if (setsockopt(sock, SOL_HCI, HCI_FILTER
 , &InqFilter, sizeof(InqFilter)) < 0)    {        perror("Fail to setup filter!");        exit(1);    }    //*****************************************************        //inquiry with the RSSI result    inquiry_info_with_rssi read_rssi;  //Note **I try to define this struct variable here, but not sure what to assign to it.            write_inquiry_mode_cp cpp;    cpp.mode = 0x01;        //set inquiry mode    int set_Inquiring = hci_send_cmd(sock, OGF_HOST_CTL, OCF_WRITE_INQUIRY_MODE, WRITE_INQUIRY_MODE_RP_SIZE, &cpp);        inquiry_cp cp;        cp.lap[0] =0x33;    cp.lap[1] =0x8b;    cp.lap[2] =0x9e;    cp.length = 4; //=4*1.28second = 5seconds    cp.num_rsp =0;    //do inquiry        int Inquiring = hci_send_cmd(sock, OGF_LINK_CTL,OCF_INQUIRY , INQUIRY_CP_SIZE, &cp);    if (Inquiring < 0)    {        printf("starting to inquire: %d\n",Inquiring);        exit(1);    }    else         printf ("Done inquiry with RSSI!\n");    printf("rssi value = %d \n", read_rssi.rssi);   
  close( sock );//close socket//***************************************************** Best regards,Newbie  


_________________________________________________________________
If you like crossword puzzles, then you'll love Flexicon, a game which combines four overlapping crossword puzzles into one!
http://g.msn.ca/ca55/208
-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
