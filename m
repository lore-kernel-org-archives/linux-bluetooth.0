Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <3F9EBF48.2070401@prim-time.fr>
From: Aurelien Minet <a.minet@prim-time.fr>
MIME-Version: 1.0
Cc: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Wrong errno
References: <200310281437.01092.xavier@xgarreau.org>
In-Reply-To: <200310281437.01092.xavier@xgarreau.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 28 Oct 2003 20:11:04 +0100

Xavier Garreau wrote:

> Hi,
> 
> I'm currently developping an application with bluez. I wrote a little code to 
> test the alarm behaviour with bluez sockets code.
> 
> The connect and read (or recv) get interrupted but errno is set to ESPIPE (29) 
> instead of EINTR (4). Does any one of you guys know why i'm getting this 
> illegal seek operation errno ?
> 
> Regards,
> 
> my sample code is below :
> 
> #include <signal.h>
> #include <unistd.h>
> #include <stdio.h>
> #include <sys/socket.h>
> #include <netinet/in.h>
> #include <bluetooth/bluetooth.h>
> #include <bluetooth/hci.h>
> #include <bluetooth/hci_lib.h>
> #include <bluetooth/l2cap.h>
> #include <sys/ioctl.h>
> #include <errno.h>
> 
> extern int errno;
> 
> void alarm_handler(int sig) {
> 	printf ("IN alarm_handler\n");
> }
> 
> int get_socket(char* watch_addr) {
> 	int s;
> 	struct sockaddr_l2 addr;
> 	bdaddr_t bdaddr;
> 
> 
> 	if ((s = socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP)) < 0) {
> 		perror("Can't create socket ");
> 		return 0;
> 	}
> 
> 	bacpy(&bdaddr, BDADDR_ANY);
> 	memset(&addr, 0, sizeof(addr));
> 	addr.l2_family = AF_BLUETOOTH;
> 	addr.l2_bdaddr = bdaddr;
> 	addr.l2_psm = htobs(0XCC33);
> 
>         if (bind(s, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
> 		perror("Can't bind socket ");
> 		return 0;
>         }
> 
> 	baswap(&addr.l2_bdaddr, strtoba(watch_addr));
>         if (connect(s, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
> 		perror("Can't connect ");
> 		printf ("errno : %d\n", errno);
> 		return 0;
>         }
> 	return s;
> }
> 
> char* attends_data(int s) {
> 	int i;
> 	int encore = 0;
> 	char buff[256];
> 
> 	encore = read(s, buff, 256);
> 	if (encore == -1 || errno) {
> 		perror("Echec lors de la lecture");
> 		return NULL;
> 	}
> 	return NULL;
> }
> 
> 
> int main (void) {
> 	int aSocket;
> 
> 	signal (SIGALRM, alarm_handler);
> 	siginterrupt (SIGALRM, 1);
> 
> 	alarm(20);
> 	printf ("Connexion ! \n");
> 	aSocket = get_socket ("00:04:76:f1:6c:f9");
> 
> 	if (aSocket) {
> 		printf ("Connecté ! \n");
> 		alarm(5);
> 		printf ("Lecture ! \n");
> 		if (!attends_data (aSocket)) {
> 			printf ("errno : %d\n", errno);
> 		} else {
> 			printf ("OK !\n");
> 			alarm(0);
> 		}
> 		shutdown (aSocket, 2);
> 	}
> 	close (aSocket);
> }
> 

Hi Xavier,

I don't know why ESPIPE error.
But after a connect I negociate the MTU and MRU and I haven'y noticed 
any error with a recv() :

(g_error()/g_message are GTK+ functions)

struct l2cap_options opts;
int  opt;
.......
opt = sizeof(opts);
if( getsockopt(montre->sk_bluez, SOL_L2CAP, L2CAP_OPTIONS, &opts, &opt) 
< 0 )
	g_error("Can't get L2CAP options. %s(%d)", strerror(errno), errno);
else
	g_message("Actual MTU is %d & MRU is %d ",opts.omtu,opts.imtu);

opts.imtu = MY_IMTU ;
opts.omtu = MY_OMTU ;

if (setsockopt(montre->sk_bluez, SOL_L2CAP, L2CAP_OPTIONS, &opts, opt) < 0)
	g_error("Can't set L2CAP options. %s(%d)", strerror(errno), errno);
else
	g_message("Setting MTU to %d & MRU to %d ",opts.omtu,opts.imtu);
.......
r=recv(s,&buff,sizeof(buff),0))


regards

	Aurelien







-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
