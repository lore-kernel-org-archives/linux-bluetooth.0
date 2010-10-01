Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <99B09243E1A5DA4898CDD8B700111448097CF4A9D9@EXMB04.eu.tieto.com>
References: <AANLkTimDw_obL=cV-CjU5OPCH+PiTqSyQ+0JTy1o+=3Q@mail.gmail.com>
	<99B09243E1A5DA4898CDD8B700111448097CF4A9D9@EXMB04.eu.tieto.com>
Date: Fri, 1 Oct 2010 16:29:56 +0530
Message-ID: <AANLkTincT1K8tHBox0+JYi+Hhj65RSBdtYcaZNU+RfOW@mail.gmail.com>
Subject: Re: How to ensure pairing is done
From: "Yedire, Sandeep" <syedire@gmail.com>
To: Waldemar.Rymarkiewicz@tieto.com
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Thanks for help. I could not make out "Connection Refused - security block"

Please find my hcidump log message below. I have taken this during
./agent 0000 <bdaddr> and  executing ex_3_5.c application to test my
L2CAP connection. Please find source ex_3_5.c file below this email.

hcidump during agent 0000 <bdaddr>
_________________________________
#
# lockd: cannot monitor 136.170.194.184
lockd: failed to monitor 136.170.194.184
lockd: cannot monitor 136.170.194.184
lockd: failed to monitor 136.170.194.184
lockd: cannot monitor 136.170.194.184
lockd: failed to monitor 136.170.194.184
< HCI Command: Create Connection (0x01|0x0005) plen 13
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Connect Complete (0x03) plen 11
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
> HCI Event: Command Status (0x0f) plen 4
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
> HCI Event: Read Remote Supported
Features (0x0b) plen 11
> HCI Event: Command Complete (0x0e) plen 6
< HCI Command: Authentication Requested (0x01|0x0011) plen 2
> HCI Event: Command Status (0x0f) plen 4
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
> HCI Event: Link Key Request (0x17) plen 6
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
< HCI Command: Link Key Request Negative Reply (0x01|0x000c) plen 6
> HCI Event: Max Slots Change (0x1b) plen 3
> HCI Event: Command Complete (0x0e) plen 10
> HCI Event: PIN Code Request (0x16) plen 6
< HCI Command: PIN Code Request Reply (0x01|0x000d) plen 23
> HCI Event: Command Complete (0x0e) plen 10
> HCI Event: Remote Name Req Complete (0x07) plen 3
< HCI Command: Read Remote Version Information (0x01|0x001d) plen 2
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Read Remote Ver Info Complete (0x0c) plen 8
> HCI Event: Link Key Notification (0x18) plen 23
> HCI Event: Auth Complete (0x06) plen 3
< HCI Command: Disconnect (0x01|0x0006) plen 3
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Disconn Complete (0x05) plen 4

--------------------------------------------------------------------------------
hcidump during ex_3 application.
< HCI Command: Create Connection (0x01|0x0005) plen 13
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Connect Complete (0x03) plen 11
< ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 25 scid 0x0040
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
> HCI Event: Command Status (0x0f) plen 4
< HCI Command: Write Link
Policy Settings (0x02|0x000d) plen 4
> HCI Event: Read Remote Supported Feature
s (0x0b) plen 11
> HCI Event: Command Complete (0x0e) plen 6
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
> HCI Event: Max Slots Change (0x1b) plen 3
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
> ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0040 result 1 status 2
      Connection pending - Authorization pending
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Remote Name Req Complete (0x07) plen 255
< HCI Command: Read Remote Version Information (0x01|0x001d) plen 2
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Read Remote Ver Info Complete (0x0c) plen 8
> HCI Event: Link Key Request (0x17) plen 6
lockd: failed to monitor 136.170.194.184
> HCI Event: Number of Completed Packets (0x13) plen 5
< HCI Command: Link Key Request Negative Reply (0x01|0x000c) plen 6
> HCI Event: Command Complete (0x0e) plen 10
> ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0000 scid 0x0040 result 3 status 0
      Connection refused - security block
> HCI Event: Disconn Complete (0x05) plen 4
-----------------------------------------------------------------------------------------
#include<stdio.h>
#include<unistd.h>
#include<sys/socket.h>
#include<bluetooth/bluetooth.h>
#include<bluetooth/l2cap.h>
#include<errno.h>
int main(int argc,char **argv)
{
	struct sockaddr_l2 addr = { 0 } ;
	int s , status;
	short i = 0;
	char dest[18] = "00:1E:7C:00:B7:AD" ;
	/*if(argc < 2){
		fprintf(stderr , "usage: %s <bt_addr>\n" , argv [0]) ;
		return 1;
	}*/
	//strncpy(dest , argv[1] , 18);
	//allocate a socket
	s = socket(AF_BLUETOOTH , SOCK_SEQPACKET , BTPROTO_L2CAP ) ;
	//set the connection parameters (who to connect to)
	addr.l2_family = AF_BLUETOOTH;
	addr.l2_psm = htobs(25);
	str2ba (dest,&addr.l2_bdaddr);
	//connect to server
	if(status = connect (s, (struct sockaddr *)&addr, sizeof(addr))<0){
		fprintf(stderr,"Connection error errno-%s(%d\n",strerror(errno),errno);
		perror(errno);
		exit(-1);
	}
	else
		printf("Connected-Status =%d\n",status);
		 ;
	//send a message
	for(i=0 ; i< 10; i++){
	//if(0 == status){
		status = send(s,"hello!", 6, 0);
		printf("send return-%d\n",status);
	}
	//}
	if(status <0) perror("uh oh") ;
	close (s ) ;
	return 0;
}
----------------------------------------------------------------------------------------------
Regards,
Sandeep.Yedire

----------------------------------------------------------
T.Jefferson, 'Victory and defeat are each of the same price"



On 1 October 2010 12:21,  <Waldemar.Rymarkiewicz@tieto.com> wrote:
> Hi
>
>>I get below error message
>>l2test[476]: Can't connect: Connection refused (146)
>>
>
> I suggest to analyse hcidump first.
>
> Regards,
> /Waldek
>
