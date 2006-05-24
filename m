Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e85851c20605240107q9529208w39a5fafaef48fe0b@mail.gmail.com>
From: "Gloria Saripah Patara" <glowz.saripah@gmail.com>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <e85851c20605232344p52bf1210y36273bef4ff02ce6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_94979_27332005.1148458058845"
References: <e85851c20605232344p52bf1210y36273bef4ff02ce6@mail.gmail.com>
Subject: [Bluez-devel] Found errors
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 24 May 2006 15:07:38 +0700

------=_Part_94979_27332005.1148458058845
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello, Mr. Marcell Holtmann. I am Gloria. I want ask you, about error messa=
ges.
Did you find this kind of message?
-------- Can't establish OBEX connection : Host is down -----------
I use perror to print the message. And function that raises the
message is BtOBEX_TransportConnect(...., ...., ....., ....)

inside this message i attached my code.

---------------------
Thanks in advance

------=_Part_94979_27332005.1148458058845
Content-Type: application/octet-stream; name=main.c
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_enlb4jwo
Content-Disposition: attachment; filename="main.c"

#include <stdio.h>
#include <errno.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdlib.h>
#include <getopt.h>
#include <signal.h>
#include <libgen.h>
#include <sys/ioctl.h>
#include <sys/socket.h>
#include <sys/mman.h>
#include <sys/stat.h>

#include <bluetooth/bluetooth.h>
#include <bluetooth/hci.h>
#include <bluetooth/hci_lib.h>

#include <readline/readline.h>
#include <readline/history.h>

#include "goep.h"
#include "ftp.h"

void send_file(int od, char *fileName)
{
	struct stat st;
	unsigned char *data;
	int fd;

	fd = open(argv[0], O_RDONLY);
	if (fd < 0) {
		printf("Can't open file %s\n", fileName);
		return;
	}

	if (fstat(fd, &st) < 0) {
		printf("Can't get size of file %s\n", fileName);
		close(fd);
		return;
	}

	data = mmap(NULL, st.st_size, PROT_READ, MAP_SHARED, fd, 0);
	if (!data) {
		printf("Can't mmap file %s\n", fileName);
		close(fd);
		return;
	}

	if (obex_put(od, NULL, basename(fileName), data, st.st_size) == 0) {
		printf("%lu bytes sent\n", st.st_size);
	}

	munmap(data, st.st_size);
	close(fd);
}

bdaddr_t get_client(){
	inquiry_info *ii = NULL;
	int max_rsp;

	max_rsp = 255;
	ii = (inquiry_info*)malloc(max_rsp * sizeof(inquiry_info));
	free(ii);

    	return (ii->bdaddr);
}

int main(){
	bdaddr_t src, dest;
	int mode, od;
	char *fileName = "bt.sol";
	
	bacpy(&src, BDADDR_ANY);

	if ((od = obex_open(&src, &get_client(), channel)) < 0) {
		perror("Can't establish OBEX connection");
		exit(1);
	}

	mode = OBEX_FILE_TRANSFER;
	obex_connect(od, mode);
	printf("Connected\n");

	//transferring file
	send_file();

	obex_disconnect(od);
	printf("Disconnected.\n");
	obex_close(od);

	return 0;
}
------=_Part_94979_27332005.1148458058845--


-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
