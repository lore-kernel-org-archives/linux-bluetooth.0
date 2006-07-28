Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <44C89EEF.3060003@student.uib.no>
References: <44C89EEF.3060003@student.uib.no>
Date: Fri, 28 Jul 2006 21:25:05 +0200
Message-Id: <1154114705.2298.46.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Enabling authentication and encryption in C
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Stale,

> I'm working on my master thesis about Bluetooth security, and are going 
> to test the security and possibly implement some improvements. I program 
> in C, and am currently trying to enable authentication and encryption 
> through some function calls in hci_lib.h, namly hci_authenticate_link 
> and hci_encrypt_link respectively. Below is a part of my code.
> 
> int main(void) {
>     struct hci_conn_info_req *cr;
>     struct sockaddr_rc resciever = { 0 };
>     struct sockaddr_rc local = { 0 };
>     uint16_t handle;
>     int s, status, dd;
> 
>     char destination[17] = "00:09:DD:60:02:45";
> 
>     resciever.rc_family = AF_BLUETOOTH;
>     resciever.rc_channel = (uint8_t) 1;
>     str2ba( destination, &resciever.rc_bdaddr );
> 
>     local.rc_family = AF_BLUETOOTH;
>     local.rc_channel = (uint8_t) 1;
>     //lokal_addr.rc_bdaddr = *BDADDR_ANY;
>     str2ba("00:14:A4:D4:0F:A1", &local.rc_bdaddr);
>    
>     dd = hci_open_dev(hci_get_route(&local.rc_bdaddr));
>     cr = (struct hci_conn_info_req*) malloc(sizeof(struct 
> hci_conn_info_req));
>     ioctl(dd, HCIGETCONNINFO, (unsigned long) cr);
>     handle = cr->conn_info->handle;
> 
>     status = hci_authenticate_link(dd, handle, 0);
>     printf("status: %d\n", status);
>     status = hci_encrypt_link(dd, handle, (uint8_t)1, 0);
>     printf("status: %d\n", status);
>     ....
>     .... }
> 
> Both calls always return -1, and things obviously aren't going as 
> expected. I've managed to digg down through several function calls:
> hci_authenticate_link -> hci_send_req -> hci_send_cmd -> writev.
> writev returns -1 as well and sets the error code variable 'errno' to 77 
> (EBADFD, defined in asm/errno.h and means 'File descriptor in bad state').
> I'm not sure what this means.

run "hcidump -X -V" and see if they really got sent. And take a look at
hidd, because this daemon already implements this.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
