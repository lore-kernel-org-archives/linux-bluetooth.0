Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <00cd01c5dfc0$eecfae30$f3a265c3@Silicium>
From: "Dan ABITBOL" <d.abitbol@bloophone.com>
To: <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=response
Subject: [Bluez-users] QOS issues
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
Date: Wed, 2 Nov 2005 16:20:08 +0100

we are facing some issues concerning QOS requirements on a l2cap connection.

 Does Bluez fully support QOS  because in the setsockopt method or 
getsockopt
 method, there's no QOS values to fill or retrieve ..

 When the connection has been completed ,  we use the
 hci_send_request(..OGF_LINK_POLICY, OCF_QOS_SETUP....) primitives but we 
get
 "protocol not available 92" error    with CSR class 1 and Broadcom class 1 
USB dongles ?


 Here is the code in our L2CAP  listening method  once the connection has
 occured  and the socket already created

WORD handle = 0;
struct l2cap_conninfo info;
int infoSize = sizeof(info);
if( getsockopt(my_connect_socket, SOL_L2CAP, L2CAP_CONNINFO, &info,
(socklen_t*)&infoSize) < 0 ) {
printf("Can't get L2CAP options. %s(%d)", strerror(errno), errno); return
false;
}
 handle = info.hci_handle;
 qos_setup_cp qosSetupParams;
 qosSetupParams.handle = handle;
 qosSetupParams.flags = 0;                          /* Reserved */
 qosSetupParams.qos.service_type = 0x02;            /* Guaranteed */
 qosSetupParams.qos.token_rate = 0x00004250;        /* 32kbps + overhead */
 qosSetupParams.qos.peak_bandwidth = 0xFFFFFFFF;    /* Unspecified bwdth */
 qosSetupParams.qos.latency = 4000;                 /* In microseconds */
 qosSetupParams.qos.delay_variation = 0xFFFFFFFF;   /* Do not care */

 struct hci_request request;
 request.ogf = OGF_LINK_POLICY;
 request.ocf = OCF_QOS_SETUP;
 request.cparam = &qosSetupParams;
 request.clen = QOS_SETUP_CP_SIZE;
 if (hci_send_reqmy_connect_socket, &request, 1000) < 0) {
  printf("Can't set QoS on connection. %s(%d)\n", strerror(errno), errno);
 }

 printf("CBluetooth_Socket: connect() succeeded\n");
 return true;




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
