Return-Path: <bluez-devel-admin@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] patch: custom devup script
References: <43C29249.3020008@fillibach.de> <1136909256.7200.6.camel@localhost.localdomain> <43CD92AE.20006@fillibach.de> <1137590415.27515.17.camel@localhost> <e1effdeb0601180937q11f65498r18ea21be597fb587@mail.gmail.com> <op.s3lhk3t7e8fkrv@auth.smtp.kundenserver.de> <1137631888.14557.23.camel@localhost>
Message-ID: <op.s3lrneii2fbw7g@no-home>
From: "Kosta Welk" <kosta@fillibach.de>
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-15
MIME-Version: 1.0
In-Reply-To: <1137631888.14557.23.camel@localhost>
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
Date: Thu, 19 Jan 2006 02:55:52 +0100

On Thu, 19 Jan 2006 01:51:28 +0100, Marcel Holtmann <marcel@holtmann.org>  
wrote:

> I like the idea. However I prefer to remove any default devup script at
> all and only call it when specified on the command line. Can you provide
> me with a patch for that?

Sure :)

> And this must be ...zu: and not ...z:u

Yes, you are right. Funny thing is, if you omit the final : it will work
with --devup but not with -u

--- ../../bluez-utils-2.24-original/pand/pand.h	2005-10-29  
23:04:28.000000000 +0000
+++ pand.h	2006-01-19 01:58:30.000000000 +0000
@@ -22,10 +22,6 @@
   *
   */

-/* PAN scripts & commands */
-#define PAND_CONFIG_DIR  "/etc/bluetooth/pan"
-#define PAND_DEVUP_CMD   "dev-up"
-
  /* BNEP functions */
  int bnep_init(void);
  int bnep_cleanup(void);
--- ../../bluez-utils-2.24-original/pand/main.c	2005-10-29  
23:04:28.000000000 +0000
+++ main.c	2006-01-19 02:51:29.000000000 +0000
@@ -61,6 +61,7 @@
  static int  master;
  static int  cleanup;
  static int  search_duration = 10;
+static char* devup_path = 0;

  static struct {
  	int      valid;
@@ -87,13 +88,13 @@

  static void run_devup(char *dev, char *dst, int sk, int nsk)
  {
-	char *argv[4], prog[40];
+	char *argv[4];
  	struct sigaction sa;

-	sprintf(prog, "%s/%s", PAND_CONFIG_DIR, PAND_DEVUP_CMD);
-
-	if (access(prog, R_OK | X_OK))
+	if (devup_path && access(devup_path, R_OK | X_OK)) {
+		syslog(LOG_ERR, "could not rx open %s", devup_path);
  		return;
+	}

  	if (fork())
  		return;
@@ -103,17 +104,20 @@

  	if (nsk >= 0)
  		close(nsk);
-	
+
+	if (!devup_path)
+		exit(0);
+
  	memset(&sa, 0, sizeof(sa));
  	sa.sa_handler = SIG_DFL;
  	sigaction(SIGCHLD, &sa, NULL);
  	sigaction(SIGPIPE, &sa, NULL);

-	argv[0] = prog;
+	argv[0] = devup_path;
  	argv[1] = dev;
  	argv[2] = dst;
  	argv[3] = NULL;
-	execv(prog, argv);
+	execv(devup_path, argv);
  	exit(1);
  }

@@ -478,8 +482,6 @@
  	fclose(f);
  	return 0;
  }
-		
-

  static struct option main_lopts[] = {
  	{ "help",     0, 0, 'h' },
@@ -504,10 +506,11 @@
  	{ "cache",    0, 0, 'C' },
  	{ "pidfile",  1, 0, 'P' },
  	{ "autozap",  0, 0, 'z' },
+	{ "devup",    1, 0, 'u' },
  	{ 0, 0, 0, 0 }
  };

-static char main_sopts[] = "hsc:k:Kr:d:e:i:lnp::DQ::AESMC::P:z";
+static char main_sopts[] = "hsc:k:Kr:d:e:i:lnp::DQ::AESMC::P:zu:";

  static char main_help[] =
  	"Bluetooth PAN daemon version " VERSION " \n"
@@ -533,7 +536,8 @@
  	"\t--nodetach -n             Do not become a daemon\n"
  	"\t--persist -p[interval]    Persist mode\n"
  	"\t--cache -C[valid]         Cache addresses\n"
-	"\t--pidfile -P <pidfile>    Create PID file\n";
+	"\t--pidfile -P <pidfile>    Create PID file\n"
+	"\t--devup -u <script>       run script when the interface comes up\n";

  int main(int argc, char **argv)
  {
@@ -636,7 +640,9 @@
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
