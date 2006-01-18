Return-Path: <bluez-devel-admin@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] patch: custom devup script
References: <43C29249.3020008@fillibach.de> <1136909256.7200.6.camel@localhost.localdomain> <43CD92AE.20006@fillibach.de> <1137590415.27515.17.camel@localhost> <e1effdeb0601180937q11f65498r18ea21be597fb587@mail.gmail.com>
Message-ID: <op.s3lhk3t7e8fkrv@auth.smtp.kundenserver.de>
From: "Konstantin 'Kosta' Welke" <kosta@fillibach.de>
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-1
MIME-Version: 1.0
In-Reply-To: <e1effdeb0601180937q11f65498r18ea21be597fb587@mail.gmail.com>
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
Date: Wed, 18 Jan 2006 23:18:29 +0100

On Wed, 18 Jan 2006 18:37:35 +0100, Claudio Takahasi  
<cktakahasi@gmail.com> wrote:

> If you want add support to a seamless local IP link address assigment
> to pand daemon. IMHO, it's better use a stable daemon like:
> - HOWL (autoipd)
> - UDHCP + zeroconf patch

I tried to do that, but they didn't work out-of-the-box on my
mobile device. Also, due to my network layout, collision detection
would not really have worked, so that I had to code a plugin
for olsr. None of this matters anymore, because network layout
has changed and I can use dhcp. But thanks for the input!

I still need to call a custom devup script, thou (dhcp, this time),
so I hope this patch doesnt get corrupted this time.

--- bluez-utils-2.20-original/pand/pand.h	2005-08-27 13:37:16.000000000  
+0000
+++ bluez-utils-2.20/pand/pand.h	2006-01-18 00:46:10.000000000 +0000
@@ -28,8 +28,7 @@
   */

  /* PAN scripts & commands */
-#define PAND_CONFIG_DIR  "/etc/bluetooth/pan"
-#define PAND_DEVUP_CMD   "dev-up"
+#define PAND_DEVUP_CMD  "/etc/bluetooth/pan/dev-up"

  /* BNEP functions */
  int bnep_init(void);
--- bluez-utils-2.20-original/pand/main.c	2005-08-27 13:37:16.000000000  
+0000
+++ bluez-utils-2.20/pand/main.c	2006-01-17 19:49:17.000000000 +0000
@@ -67,6 +67,7 @@
  static int  master;
  static int  cleanup;
  static int  search_duration = 10;
+static char* devup_path = 0;

  static struct {
  	int      valid;
@@ -93,10 +94,13 @@

  static void run_devup(char *dev, char *dst, int sk, int nsk)
  {
-	char *argv[4], prog[40];
+	char *argv[4], *prog;
  	struct sigaction sa;

-	sprintf(prog, "%s/%s", PAND_CONFIG_DIR, PAND_DEVUP_CMD);
+	if (devup_path)
+		prog = devup_path;
+	else
+		prog = PAND_DEVUP_CMD;

  	if (access(prog, R_OK | X_OK))
  		return;
@@ -510,10 +514,11 @@
  	{ "cache",    0, 0, 'C' },
  	{ "pidfile",  1, 0, 'P' },
  	{ "autozap",  0, 0, 'z' },
+	{ "devup",    1, 0, 'u' },
  	{ 0, 0, 0, 0 }
  };

-static char main_sopts[] = "hsc:k:Kr:d:e:i:lnp::DQ::AESMC::P:z";
+static char main_sopts[] = "hsc:k:Kr:d:e:i:lnp::DQ::AESMC::P:z:u";

  static char main_help[] =
  	"Bluetooth PAN daemon version " VERSION " \n"
@@ -539,7 +544,8 @@
  	"\t--nodetach -n             Do not become a daemon\n"
  	"\t--persist -p[interval]    Persist mode\n"
  	"\t--cache -C[valid]         Cache addresses\n"
-	"\t--pidfile -P <pidfile>    Create PID file\n";
+	"\t--pidfile -P <pidfile>    Create PID file\n"
+	"\t--devup <script>          run script instead of usual dev-up\n";

  int main(int argc, char **argv)
  {
@@ -642,7 +648,9 @@
  		case 'z':
  			cleanup = 1;
  			break;
-
+		case 'u':
+			devup_path = optarg;
+			break;
  		case 'h':
  		default:
  			printf(main_help);


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
