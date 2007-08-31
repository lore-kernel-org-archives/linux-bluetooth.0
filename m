Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <46D867CF.4020607@gmail.com>
Date: Fri, 31 Aug 2007 16:11:11 -0300
From: Manuel Naranjo <naranjo.manuel@gmail.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <46D84FBD.60203@gmail.com> <1188585920.13373.105.camel@violet>
In-Reply-To: <1188585920.13373.105.camel@violet>
Content-Type: multipart/mixed; boundary="------------040304050504090702010406"
Subject: Re: [Bluez-devel] [PATCH] SDP lib memory leak
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------040304050504090702010406
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Marcel Holtmann escribió:
> Hi Manuel,
>
>   
>> I have made an application that makes use of the sdp lib. By 
>> running the app with valgrind [1] I found a memory leak.
>> There's an static variable called bluetooth_base_uuid that's being 
>> initializated once but then never freed.
>> I had added a method that should be called, only when the thread is 
>> about to end that frees that variable.
>> Attached you can see the patch.
>>     
>
> thanks for the patch, but I put a different patch in the CVS that avoids
> any memory allocation at all.
>
> Can you extract me a test program from your application, so I can double
> check that it is doing the right thing on little and big endian systems
> and we don't have any memory leaks at all anymore.
>
> Regards
>
> Marcel
>
>   
Great. I'm attaching you the source, you can find it online at: 
http://aircable.googlecode.com/svn/lcd_temp/AIRcableSPP2/
Regards,
Manuel


--------------040304050504090702010406
Content-Type: text/plain;
 name="errorcodes.h"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="errorcodes.h"

#ifndef SPP_ERR_CODES
#define SPP_ERR_CODES

//no problems
#define OK					0
#define CONNECTION_CLOSE 	1

//errors
//TODO: Extend errors list
#define ERROR				-1


#endif

--------------040304050504090702010406
Content-Type: text/plain;
 name="sppclient.h"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sppclient.h"

/*
 *
 *  SPPclient, little spp client.
 *
 *  Copyright (C) 2007 Naranjo,manuel <manuel@aircable.net>
 *  Copyright (C) 2007 Wireless Cables Inc  <aircable.net>
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 * 
 */

#ifndef SPPCLIENT_H_
#define SPPCLIENT_H_

#include <stdio.h>
#include <ctype.h>
#include <errno.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdlib.h>
#include <malloc.h>
#include <string.h>
#include <time.h>
#include <poll.h>

#include <sys/ioctl.h>
#include <sys/socket.h>

#include <fcntl.h>

#include <bluetooth/bluetooth.h>
#include <bluetooth/hci.h>
#include <bluetooth/hci_lib.h>
#include <bluetooth/rfcomm.h>
#include <bluetooth/sdp.h>
#include <bluetooth/sdp_lib.h>

#include "errorcodes.h"

//Public functions
/** Register SPP service **/
int sppRegister(int channel);
/** Unregister SPP service **/
int sppUnregister();
/** Read a line from the spp socket **/
int sppReadLine(char * buf, int MAXLEN);
/** Write a line to the spp socket **/
int sppWriteLine(const char * buf);
/** Register socket for listening **/
int sppListen();
/** Wait for connections, this method will block **/
int sppWaitConnection();
/** Disconnect SPP socket **/
int sppDisconnect();

#endif /*SPPCLIENT_H_*/

--------------040304050504090702010406
Content-Type: text/x-csrc;
 name="sspclient.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sspclient.c"

/*
 *  SPPclient, little spp client.
 *
 *  Copyright (C) 2007 Naranjo,manuel <manuel@aircable.net>
 *  Copyright (C) 2007 Wireless Cables Inc  <aircable.net>
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 * 
 */

#include "sppclient.h"

static int channelNumber;

/* RFcomm socket */
static int SPPsocket;
/* Listening socket, opened once we get connected. */
static int SPPclient;
/* Bluetooth address of our peer */
static bdaddr_t SPPpeer;

/* Bluetooth interface used to register the SDP record */
static bdaddr_t interface;

/* SPP record handle number*/
static uint32_t recHandle;

/** Constants	**/
//times
#define TIMEOUT 			120

#define SPP_DEBUG

int sppRegister(int channelN){
	sdp_list_t *svclass_id, *apseq, *proto[2], *profiles, *root, *aproto;
	uuid_t root_uuid, sp_uuid, l2cap, rfcomm;
	sdp_profile_desc_t profile;
	uint8_t u8 = channelN ? channelN : 1;
	sdp_record_t  *record;
	sdp_session_t *session;	
	sdp_data_t *channel;
	
	int ret;
	
	session = sdp_connect(BDADDR_ANY, BDADDR_LOCAL, 0);
	if (!session) {
		perror("Failed to connect to the local SDP server");
		return ERROR;
	}

	record = sdp_record_alloc();
	if (!record) {
		perror("Failed to allocate service record");
		sdp_close(session);
		return ERROR;
	}

	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
	root = sdp_list_append(0, &root_uuid);
	sdp_set_browse_groups(record, root);
	sdp_list_free(root, 0);

	sdp_uuid16_create(&sp_uuid, SERIAL_PORT_SVCLASS_ID);
	svclass_id = sdp_list_append(0, &sp_uuid);
	sdp_set_service_classes(record, svclass_id);
	sdp_list_free(svclass_id, 0);

	sdp_uuid16_create(&profile.uuid, SERIAL_PORT_PROFILE_ID);
	profile.version = 0x0100;
	profiles = sdp_list_append(0, &profile);
	sdp_set_profile_descs(record, profiles);
	sdp_list_free(profiles, 0);

	sdp_uuid16_create(&l2cap, L2CAP_UUID);
	proto[0] = sdp_list_append(0, &l2cap);
	apseq = sdp_list_append(0, proto[0]);

	sdp_uuid16_create(&rfcomm, RFCOMM_UUID);
	proto[1] = sdp_list_append(0, &rfcomm);
	channel = sdp_data_alloc(SDP_UINT8, &u8);
	proto[1] = sdp_list_append(proto[1], channel);
	apseq = sdp_list_append(apseq, proto[1]);

	aproto = sdp_list_append(0, apseq);
	sdp_set_access_protos(record, aproto);

	bacpy(&interface, BDADDR_ANY);

	sdp_set_info_attr(record, "Serial Port", 0, "AIRcableSPP server");

	if (sdp_device_record_register(session, &interface, record, 0) < 0) {
		perror("Service Record registration failed\n");
		ret = ERROR;
		goto end;
	}

	printf("Serial Port service registered\n");
	
	recHandle = record->handle;
	
	ret = OK;
	channelNumber = u8;

end:
	sdp_data_free(channel);
	sdp_list_free(proto[0], 0);
	sdp_list_free(proto[1], 0);
	sdp_list_free(apseq, 0);
	sdp_list_free(aproto, 0);
	sdp_close(session);
	sdp_record_free(record);

	return ret;

}

int sppUnregister(){
	if (!recHandle){
		fprintf(stderr, "Not registered, nothing to do\n");
		return ERROR;
	}
	
	uint32_t range = 0x0000ffff;
	sdp_list_t *attr;
	sdp_session_t *sess;
	sdp_record_t *rec;

	sess = sdp_connect(&interface, BDADDR_LOCAL, SDP_RETRY_IF_BUSY);
	if (!sess) {
		printf("No local SDP server!\n");
		return ERROR;
	}

	attr = sdp_list_append(0, &range);
	rec = sdp_service_attr_req(sess, recHandle, SDP_ATTR_REQ_RANGE, attr);
	sdp_list_free(attr, 0);

	if (!rec) {
		printf("Service Record not found.\n");
		sdp_close(sess);
		return ERROR;
	}

	if (sdp_device_record_unregister(sess, &interface, rec)) {
		printf("Failed to unregister service record: %s\n", strerror(errno));
		sdp_close(sess);
		return ERROR;
	}

	printf("Service Record deleted.\n");	
	sdp_close(sess);	
	return OK;
}

int sppListen(){
	struct sockaddr_rc loc_addr = { 0 };
	
	if (channelNumber < 1){
		fprintf(stderr, "Channel Number can't be 0 or negative\n");
		fprintf(stderr, "You need to call sppRegister() first\n");
		return ERROR;
	}
		
	
    // allocate socket
	SPPsocket = socket(AF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM);
    if (SPPsocket < 0) {
		perror("Can't create RFCOMM socket");
		SPPsocket = 0;
		return ERROR;
	}

    // bind socket to port 1 of the first available 
    // local bluetooth adapter
    loc_addr.rc_family = AF_BLUETOOTH;
    loc_addr.rc_bdaddr = *BDADDR_ANY;
    loc_addr.rc_channel = (uint8_t) (channelNumber);
    if (bind(SPPsocket, (struct sockaddr *)&loc_addr, sizeof(loc_addr)) < 0) {
		perror("Can't bind RFCOMM socket");
		close(SPPsocket);
		SPPsocket = 0;
		return ERROR;
	}    

    // put socket into listening mode
    listen(SPPsocket, 1);
    
    return OK;
}
    
int sppWaitConnection(){
	struct sockaddr_rc peer_addr = { 0 };
    char addr[17] = { 0 };
    int unsigned opt = sizeof(peer_addr);
    struct timeval t;
	int result; 
	int unsigned ol = sizeof(struct timeval);
    
	if (!SPPsocket){
		fprintf(stderr, "You need to call sspListen first\n");
		return ERROR;
	}
	
    // accept one connection
    SPPclient = accept(SPPsocket, (struct sockaddr *)&peer_addr, &opt);

    ba2str( &peer_addr.rc_bdaddr, addr );
    bacpy( &SPPpeer, &peer_addr.rc_bdaddr);
    printf("accepted connection from %s\n", addr);
        
    result = getsockopt(SPPclient, SOL_SOCKET, SO_RCVTIMEO, &t, &ol); 
	
	if (result < 0)
		perror("timeout");

	t.tv_sec = TIMEOUT;
	t.tv_usec = 0;
	result = setsockopt(SPPclient, SOL_SOCKET, SO_RCVTIMEO,  &t, ol);	
	if (result < 0)
		perror("timeout");

	result = getsockopt(SPPclient, SOL_SOCKET, SO_RCVTIMEO, &t, &ol); 
	if (result < 0)
		perror("timeout");
      
    return OK;
}

int sppDisconnect(){
	struct hci_conn_info_req *cr;
	int dd;
	int ret = OK;
	
	if (SPPclient < 1 || SPPsocket < 1){
		perror("Not Connected, can't disconnect\n");
		return ERROR;
	}
	// close connection
	if (SPPclient)
    	close(SPPclient);
    	
    if (SPPsocket)
    	close(SPPsocket);
	
	dd = hci_open_dev(hci_get_route(NULL));
	if (dd < 0) {
		perror("HCI device open failed");
		return ERROR;
	}

	cr = malloc(sizeof(*cr) + sizeof(struct hci_conn_info));
	if (!cr) {
		perror("Can't allocate memory to disconnect");
		return ERROR;
	}

	bacpy(&cr->bdaddr, &SPPpeer);
	cr->type = ACL_LINK;
	if (ioctl(dd, HCIGETCONNINFO, (unsigned long) cr) < 0) {
		perror("Get connection info failed");
		return ERROR;
	}

	if (hci_disconnect(dd, htobs(cr->conn_info->handle),
				HCI_OE_USER_ENDED_CONNECTION, 10000) < 0){
		perror("Disconnect failed");
		ret = ERROR;
	}

	if (cr)
		free(cr);

	if (dd)
		hci_close_dev(dd);
	
	return ret;
}


int sppReadLine(char * out, int MAXLEN){
	struct pollfd fds;
	int ret, len=0;
	char c;	

	fds.fd = SPPclient;
	fds.events = POLLIN;

	while(1) {
		ret = poll(&fds, 1, -1); //wait forever, there's no chance poll will return = 0
		if (ret < 0){
			perror("Error while reading from Rfcomm Socket (poll)");
			return ERROR;
		}
			
		ret = read(SPPclient, &c, 1);
		if ( ret < 0 ) {
			perror("Error while reading from Rfcomm Socket (read)");
			return ERROR;
		}
			
		*out++=c;
		len++;
				
		#ifdef SPP_DEBUG
			if ( len > 0 && len % 70 ==0 )
				fprintf(stdout, "\n<< ");
			else if (len == 1)
				fprintf(stdout, "<< ");
				
			if ( isprint( c ) && c!='\n' && c!='\r')
				fprintf(stdout, "%c", c);
			else if (c != '\n')
				fprintf(stdout, "\\x%02X", c);
		#endif
						
		if (c == '\n' || c == '\x03' || c == '\r')
			break;
					
		if (len==MAXLEN -1 ){
			break;
		}			
	} 

	#ifdef SPP_DEBUG
		fprintf(stdout, "\n");
	#endif

		
	*out++=0; //null ending string.
	    
	return len;
	
}

int sppWriteLine(const char * buf){
	int ret = 0, len;
	struct pollfd fds;
	char * out = NULL;
	
	if (!SPPclient){
			fprintf(stderr, "SPP socket is not opened, can't write\n");
			return ERROR;
	}
	len = strlen(buf);
	out = calloc(len+5, sizeof(char));
	
	if (!out) {
		fprintf(stderr, "Couldn't allocate buffer\n");
		return ERROR;
	}
		
		
	fds.fd = SPPclient;
	fds.events = POLLOUT;
		
	ret = poll(&fds, 1, -1); //wait forever, there's no chance poll will return = 0
	if (ret < 0){
		perror("Error while writting to RFcomm Socket (poll)");
		free(out);
		return ERROR;
	}
	
	sprintf(out, "%s\n", buf);
	ret = write(SPPclient,out,strlen(out));
			
	if (ret < 0) {
		perror("Error while writting to RFcomm Socket (write)");
		free(out);
		return ERROR;
	}
		
	#ifdef SPP_DEBUG
		fprintf(stdout, ">> %s\n", buf);
	#endif
		
	free(out);
	return ret;
}

int main(void) {
	int r = sppRegister(1);
	if (r != OK)
		return -1;
	
	sppListen();
	sppWaitConnection();
	
	char * line;
	line = calloc(1024, sizeof(char));
	
	sppReadLine(line, 1024);
	sppWriteLine(line);
	
	free(line);
	sppUnregister();
	
	sdp_cleanup();
	return 0;
}

--------------040304050504090702010406
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--------------040304050504090702010406
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------040304050504090702010406--
