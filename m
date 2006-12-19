Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <45883E80.50703@gmail.com>
Date: Tue, 19 Dec 2006 16:33:20 -0300
From: Manuel Naranjo <naranjo.manuel@gmail.com>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <be976db60612191123s62dfa67egc3c937e63ae2031@mail.gmail.com>
In-Reply-To: <be976db60612191123s62dfa67egc3c937e63ae2031@mail.gmail.com>
Content-Type: multipart/mixed; boundary="------------090503020705080809060006"
Subject: Re: [Bluez-users] minicom over /dev/rfcomm0
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------090503020705080809060006
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Mark,
Here is a library I made on C++ based on the code from hcitool and some 
other code I found on the web, that let's you use the RFcomm layer as a 
serial port. It might need a lot of changes, it is just what I needed.
Thanks
Manuel
>
> Hi:
>
> In many examples that I found online where people are trying to make 
> their cellphone surf web or somehow talk to their cellphone from 
> Bluez, I notice that they can often do minicom over /dev/rfcomm0 in 
> the setup.
>
> If I want to access the serial port service like that, but from my C 
> program, do I just treat /dev/rfcomm0 as a serial device and use 
> standard Unix serial programming libraries from my C program to do so?
> Just curious.  Thanks in advanced for any tip.
>
>
> Mark
> ------------------------------------------------------------------------
>
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys - and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> ------------------------------------------------------------------------
>
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>   


--------------090503020705080809060006
Content-Type: text/plain;
 name="rfcomm.cpp"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rfcomm.cpp"

/***************************************************************************
 *   Copyright (C) 2006 by Manuel Naranjo   *
 *   manuel@aircable.net   *
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU Library General Public License as       *
 *   published by the Free Software Foundation; either version 2 of the    *
 *   License, or (at your option) any later version.                       *
 *                                                                         *
 *   This program is distributed in the hope that it will be useful,       *
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of        *
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         *
 *   GNU General Public License for more details.                          *
 *                                                                         *
 *   You should have received a copy of the GNU Library General Public     *
 *   License along with this program; if not, write to the                 *
 *   Free Software Foundation, Inc.,                                       *
 *   59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.             *
 *																		   *
 *																		   *
 *   This class	is a C++ warper of a Bluetooth RFcomm Socket			   *
 ***************************************************************************/

#include "rfcomm.h"

#include <string>
#include <iostream>
#include <sys/param.h>
#include <sys/socket.h>
#include <sys/ioctl.h>

#include <bluetooth/bluetooth.h>
#include <bluetooth/rfcomm.h>
#include <bluetooth/hci.h>
#include <bluetooth/hci_lib.h>

RfComm::RfComm(void){
	rfcommSocket = -1;
	bt_addr = "00:00:00:00:00:00";
}

RfComm::RfComm(string addr){
	rfcommSocket = -1;
	bt_addr = addr;
}

RfComm::~RfComm(void){
	Close();
}

void RfComm::Close(void){
	if (rfcommSocket != -1)
		close(rfcommSocket);

}

void RfComm::Open(void){
	bdaddr_t t_bdaddr;
	str2ba(bt_addr.c_str(), &t_bdaddr);

	struct sockaddr_rc sockaddr;
	sockaddr.rc_family = AF_BLUETOOTH;
	sockaddr.rc_bdaddr = t_bdaddr;
	sockaddr.rc_channel = (uint8_t) 1;

	rfcommSocket = socket(AF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM);

	if (connect(rfcommSocket, (struct sockaddr *) &sockaddr, sizeof(sockaddr)) < 0) {
		std::cerr << "Error While Openning RFComm Connection" <<endl;
    	rfcommSocket = -1;
  	}
}

void RfComm::setAddress(string new_addr){
	Close();
	bt_addr = new_addr;
}

int RfComm::Write(string message){
	int result = -1;
	if (rfcommSocket==-1){
		std::cerr << "Not a valid socket, aborting"<<endl;
		return result;
	}

	result = send(rfcommSocket, (void *)message.c_str(), message.size(), 0);

	if (result < 0)
		std::cerr << "There was an error when trying to write"<<endl;	

	return result;
}

string RfComm::Read(void){
	char response[64];
	string out = "";
	if (recv(rfcommSocket, response, 64, 0) < 0) {
		std::cerr << "There was an error while trying to read"<<endl;
		return NULL;
  	}
	
	out+=response;
	return out;
}

int RfComm::getLinkQuality(uint8_t * lq){
	struct hci_conn_info_req *cr;
	bdaddr_t bdaddr;

	int dd;
	int dev_id;

	str2ba(bt_addr.c_str(), &bdaddr);
	
	dev_id = hci_for_each_dev(HCI_UP, find_conn, (long) &bdaddr);
	if (dev_id < 0) {
		std::cerr <<"Not connected, can't read Link Quality" << endl;
		return -1;
	}	

	dd = hci_open_dev(dev_id);
	if (dd < 0) {
		std::cerr << "HCI device open failed";
		return -1;
	}

	cr = (hci_conn_info_req*)malloc(sizeof(*cr) + sizeof(struct hci_conn_info));
	if (!cr) {
		std::cerr << "Can't allocate memory";
		return -1;
	}

	bacpy(&cr->bdaddr, &bdaddr);
	cr->type = ACL_LINK;
	if (ioctl(dd, HCIGETCONNINFO, (unsigned long) cr) < 0) {
		std::cerr << "Get connection info failed";
		return -1;
	}

	if (hci_read_link_quality(dd, htobs(cr->conn_info->handle), lq, 1000) < 0) {
		std::cerr << "HCI read_link_quality request failed";
		return -1;
	}

	close(dd);
	free(cr);
	return 0;
}

int RfComm::getRSSI(int8_t * rssi){
	struct hci_conn_info_req *cr;
	bdaddr_t bdaddr;	
	int dd, dev_id;
	int8_t temp;
	str2ba(bt_addr.c_str(), &bdaddr);

	if (dev_id < 0) {
		dev_id = hci_for_each_dev(HCI_UP, find_conn, (long) &bdaddr);
		if (dev_id < 0) {
			std::cerr << "Not connected, can't read RSSI." << endl;
			return -1;
		}
	}

	dd = hci_open_dev(dev_id);
	if (dd < 0) {
		std::cerr << "HCI device open failed" << endl;
		return -1;
	}

	cr = (hci_conn_info_req*)malloc(sizeof(*cr) + sizeof(struct hci_conn_info));
	if (!cr) {
		std::cerr << "Can't allocate memory" << endl;
		return -1;
	}

	bacpy(&cr->bdaddr, &bdaddr);
	cr->type = ACL_LINK;
	if (ioctl(dd, HCIGETCONNINFO, (unsigned long) cr) < 0) {
		std::cerr << "Get connection info failed" << endl;
		return -1;
	}

	if (hci_read_rssi(dd, htobs(cr->conn_info->handle), &temp, 1000) < 0) {
		std::cerr << "Read RSSI failed" << endl;
		return -1;
	}

	*rssi = temp;
	
	close(dd);
	free(cr);
	return 0;
}

int RfComm::getTransmitPowerLevel(int8_t * level, uint8_t * type){
	struct hci_conn_info_req *cr;
	bdaddr_t bdaddr;
	uint8_t temp;
	int dd, dev_id;
	
	str2ba(bt_addr.c_str(), &bdaddr);
	
	if (dev_id < 0) {
		dev_id = hci_for_each_dev(HCI_UP, find_conn, (long) &bdaddr);
		if (dev_id < 0) {
			std::cerr << "Not connected. Can't read Transmit Power Level." << endl;
			return -1;
		}
	}

	dd = hci_open_dev(dev_id);
	if (dd < 0) {
		std::cerr << "HCI device open failed" << endl;
		return -1;
	}

	cr = (hci_conn_info_req*)malloc(sizeof(*cr) + sizeof(struct hci_conn_info));
	if (!cr) {
		std::cerr << "Can't allocate memory" << endl;
		return -1;
	}

	bacpy(&cr->bdaddr, &bdaddr);
	cr->type = ACL_LINK;
	if (ioctl(dd, HCIGETCONNINFO, (unsigned long) cr) < 0) {
		std::cerr << "Get connection info failed" << endl;
		return -1;
	}

	if (hci_read_transmit_power_level(dd, htobs(cr->conn_info->handle), temp, level, 1000) < 0) {
		std::cerr << "HCI read transmit power level request failed" << endl;
		return -1;
	}

	*type =temp;

	close(dd);
	free(cr);
	
	return 0;
}

static int find_conn(int s, int dev_id, long arg)
{
	struct hci_conn_list_req *cl;
	struct hci_conn_info *ci;
	int i;

	if (!(cl = (hci_conn_list_req*)malloc(10 * sizeof(*ci) + sizeof(*cl)))) {
		std::cerr << "Can't allocate memory";
		exit(1);
	}
	cl->dev_id = dev_id;
	cl->conn_num = 10;
	ci = cl->conn_info;

	if (ioctl(s, HCIGETCONNLIST, (void *) cl)) {
		std::cerr <<"Can't get connection list";
		exit(1);
	}

	for (i = 0; i < cl->conn_num; i++, ci++)
		if (!bacmp((bdaddr_t *) arg, &ci->bdaddr))
			return 1;

	return 0;
}




--------------090503020705080809060006
Content-Type: text/plain;
 name="rfcomm.h"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rfcomm.h"

/***************************************************************************
 *   Copyright (C) 2006 by Manuel Naranjo   *
 *   manuel@aircable.net   *
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU Library General Public License as       *
 *   published by the Free Software Foundation; either version 2 of the    *
 *   License, or (at your option) any later version.                       *
 *                                                                         *
 *   This program is distributed in the hope that it will be useful,       *
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of        *
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         *
 *   GNU General Public License for more details.                          *
 *                                                                         *
 *   You should have received a copy of the GNU Library General Public     *
 *   License along with this program; if not, write to the                 *
 *   Free Software Foundation, Inc.,                                       *
 *   59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.             *
 ***************************************************************************/

#ifndef __AIRcableRFCOMM_h__
#define __AIRcableRFCOMM_h__
#include <string>

#define ERROR 0xFFFF

using namespace std;

extern "C++"{	
	class RfComm{
		
		private:
			int		rfcommSocket;
			string	bt_addr;

		public:
			//constructor
			RfComm(void);

			RfComm(string bt_addr);

			~RfComm(void);

			void Open(void);

			void Close(void);

			int Write(string in);

			string Read(void);

			void setAddress(string new_addr);

			int getLinkQuality(uint8_t * lq);

			int getRSSI(int8_t * rssi);

			int getTransmitPowerLevel(int8_t * level, uint8_t * type);
	};
}; //C++

static int find_conn(int s, int dev_id, long arg);

#endif //__AIRcableRFCOMM_h__

--------------090503020705080809060006
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--------------090503020705080809060006
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--------------090503020705080809060006--
