Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <e85851c20606072213o130384b3u38242e415dc6271b@mail.gmail.com>
References: <e85851c20606072213o130384b3u38242e415dc6271b@mail.gmail.com>
Date: Thu, 08 Jun 2006 09:21:08 +0200
Message-Id: <1149751268.27331.9.camel@localhost>
Mime-Version: 1.0
Cc: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] [Bluez-devel] How to send file using File
	Transfer Protocol
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
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
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Gloria,

> I want to ask you about the way to send file using File
> Transfer Protocol.
> Here my code :
> 
> int main(){
> 	bdaddr_t src,dest;
> 	uint8_t channel = 0;
> 	int mode,od;
> 	unsigned char *buf;
> 	size_t len;
> 
> 
> 	bacpy(&src,BDADDR_ANY);
> 	str2ba("xx:xx:xx:xx:xx:xx",&dest); //xx is my bluetooth address
> 
> 	if((!channel)&&(!sdp_get_ftp_channel(&src,&dest,&channel))){
> 		printf("Can't retrieve RFCOMM OBEX channel\n");
> 		exit(1);
> 	}
> 
> 	if((od=obex_open(&src,&dest,channel))<0){
> 		perror("Can't establish OBEX connection\n");
> 		exit(1);
> 	}
> 
> 	mode = OBEX_FILE_TRANSFER;
> 	obex_connect(od,mode);
> 	printf("connected\n");
> 
>         obex_setpath(od, "C:/", 0x03);

using the FTP profile you are not using Windows alike paths. This is not
how it works and all paths are mapped under a root directory. So leave
this command out and try again.

> NB : The function used in main function has declared.

And your code has do be licensed under GPL.

Regards

Marcel




_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
