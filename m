Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <43CD92AE.20006@fillibach.de>
From: Kosta Welke <kosta@fillibach.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
References: <43C29249.3020008@fillibach.de> <1136909256.7200.6.camel@localhost.localdomain>
In-Reply-To: <1136909256.7200.6.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-devel] patch: custom devup script
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
Date: Wed, 18 Jan 2006 01:58:22 +0100

I changed the subject from "pan link quality" because it didnt really 
apply anymore.

Marcel Holtmann wrote:

>> PS: Are you interesed in a "zeroconf ip" patch for pand?
> Go ahead and post the patch to the mailing list. We will review it.

As my zeroconf implementation is incomplete (only generates an IP 
address, but does not check for conflicts), I instead added an option to 
run a custom devup script instead of /etc/bluetooth/pan/dev-up.

Why? Because the mobile phone running embedded linux has a read-only 
/etc. This way, I can move my devup-script anywhere I want, without 
needing to recompile if its location changes.

(In the unlikely case that anyone is interested in my zeroconf,
here's the uri: http://lastpageofthe.net/zeroconf.test.c )

Here's the unified diff:
--- ../bluez-utils-2.24-original/pand/pand.h2005-10-29 
23:04:28.000000000 +0000
+++ pand/pand.h2006-01-18 00:49:23.000000000 +0000
@@ -23,8 +23,7 @@
   */

  /* PAN scripts & commands */
-#define PAND_CONFIG_DIR  "/etc/bluetooth/pan"
-#define PAND_DEVUP_CMD   "dev-up"
+#define PAND_DEVUP_CMD  "/etc/bluetooth/pan/dev-up"

  /* BNEP functions */
  int bnep_init(void);
--- ../bluez-utils-2.20-original/pand/main.c2005-08-27 
13:37:16.000000000 +0000
+++ pand/main.c2006-01-17 19:49:17.000000000 +0000
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
-char *argv[4], prog[40];
+char *argv[4], *prog;
  struct sigaction sa;

-sprintf(prog, "%s/%s", PAND_CONFIG_DIR, PAND_DEVUP_CMD);
+if (devup_path)
+prog = devup_path;
+else
+prog = PAND_DEVUP_CMD;

  if (access(prog, R_OK | X_OK))
  return;
@@ -510,10 +514,11 @@
  { "cache",    0, 0, 'C' },
  { "pidfile",  1, 0, 'P' },
  { "autozap",  0, 0, 'z' },
+{ "devup",    1, 0, 'u' },
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
-"\t--pidfile -P <pidfile>    Create PID file\n";
+"\t--pidfile -P <pidfile>    Create PID file\n"
+"\t--devup <script>          run script instead of usual dev-up\n";

  int main(int argc, char **argv)
  {
@@ -642,7 +648,9 @@
  case 'z':
  cleanup = 1;
  break;
-
+case 'u':
+devup_path = optarg;
+break;
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
