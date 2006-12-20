Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <4588F340.3000003@idlum.be>
Date: Wed, 20 Dec 2006 09:24:32 +0100
From: Pierre-Yves Paulus <py@idlum.be>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] Switch virtual TTY (/dev/rfcomm0) to RAW mode
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

Hello,

I'm writing a simple Java application which performs an OBEX push, using 
a Java OBEX implementation, and not OpenOBEX "as usual".

All my application is making use of the DBus API to find the device, and 
to get a virtual TTY (/dev/rfcommX) connected to the remote devices's 
OPP channel. It is working very well.

However, before I can start the OBEX session over /dev/rfcommX, I've to 
switch it into RAW mode, as I learnt it on this list previously. I think 
I've got a problem at this step. I'm using the following piece of C code 
to put /dev/rfcomm0 into RAW mode (from a JNI call):

// Open the file (representing the virtual TTY)
FILE *stream  = NULL;
stream = fopen(filename, "r");

if (!stream) {
   printf("Unable to open file!\n");
   exit(-1);
}

// Get its identifier
int fid = fileno(stream);

struct termio old_term;
struct termio new_term;

// Get the current config of the TTY
if (ioctl(fid, TCGETA, &old_term) == -1) {
   printf("ioctl get failed.\n");
   exit(-2);
}

// Change what has to be.
new_term = old_term;
new_term.c_lflag &= ~ICANON;
new_term.c_cc[VMIN] = 0;
new_term.c_cc[VTIME] = 0;

// Apply
if (ioctl(fid, TCSETA, &new_term) == -1) {
  printf("ioctl set failed.\n");
  exit(-3);
}

// Close the file
fclose(stream);

Is it the right way to perform this, or am I doing something wrong 
there? Needless to say I'm very new to this tty stuff, and may have done 
something really stupid, in which case I would like to know it.

Thanks in advance,
Best Regards,
Pierre-Yves

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
