Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <e85851c20606072213o130384b3u38242e415dc6271b@mail.gmail.com>
Date: Thu, 8 Jun 2006 12:13:46 +0700
From: "Gloria Saripah Patara" <glowz.saripah@gmail.com>
To: bluez-users@lists.sourceforge.net, bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-devel] How to send file using File Transfer Protocol
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

Hello, guys. I want to ask you about the way to send file using File
Transfer Protocol.
Here my code :

int main(){
	bdaddr_t src,dest;
	uint8_t channel = 0;
	int mode,od;
	unsigned char *buf;
	size_t len;


	bacpy(&src,BDADDR_ANY);
	str2ba("xx:xx:xx:xx:xx:xx",&dest); //xx is my bluetooth address

	if((!channel)&&(!sdp_get_ftp_channel(&src,&dest,&channel))){
		printf("Can't retrieve RFCOMM OBEX channel\n");
		exit(1);
	}

	if((od=obex_open(&src,&dest,channel))<0){
		perror("Can't establish OBEX connection\n");
		exit(1);
	}

	mode = OBEX_FILE_TRANSFER;
	obex_connect(od,mode);
	printf("connected\n");

        obex_setpath(od, "C:/", 0x03);
	cmd_put(od,"gongli.jpeg");

	obex_disconnect(od);
	printf("disconnected\n");
	obex_close(od);

	return 0;

}

i have compiled this source code and success. no error. to compile it,
i using : gcc -o main main.c -lopenobex -lbluetooth.
And then, i want test it by running it using : run-standalone.sh ./main
But, the file didn't reach the phone's memory. i mean, there's a
confirmation that a message is coming but the confirmation will
disappear immediately. i have checked the inbox or file manager
(phone's memory), but there's none. There something error on my code?.

NB : The function used in main function has declared.

-------------------------------------------
Thanks in advance


_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
