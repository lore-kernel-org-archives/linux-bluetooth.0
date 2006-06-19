Return-Path: <bluez-users-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Mon, 19 Jun 2006 12:16:26 -0400
Message-ID: <70DCB28C5BB04A4BBB1C8512589BAC65E69930@MAIL006.mail.lan>
From: "Brand, Chris" <chris.brand@qwikker.com>
To: <bluez-users@lists.sourceforge.net>
Subject: [Bluez-users] Bccmd patch
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

I didn't see any response to this patch - resending to ensure that it
didn't get missed.

I discovered a couple of things :
1. bccmd has some nice features that aren't mentioned in its "usages".
2. bccmd psset didn't work for keys with a size > 32 bits (because the
OPT_PSKEY macro returned an error if you specified more than one value
for the key, but it expected a list of bytes if the length is more than
1 or 2).
 
Here's a patch (against bluez-utils version 2.25) :
--- bccmd.c.old 2006-04-08 00:01:10.000000000 +0000

+++ bccmd.c 2006-04-10 19:21:13.000000000 +0000

@@ -199,9 +209,9 @@

}

}

-#define OPT_RANGE(range) \

- if (argc < (range)) { errno = EINVAL; return -1; } \

- if (argc > (range)) { errno = E2BIG; return -1; }

+#define OPT_RANGE(min, max) \

+ if (argc < (min)) { errno = EINVAL; return -1; } \

+ if (argc > (max)) { errno = E2BIG; return -1; }

static struct option help_options[] = {

{ "help", 0, 0, 'h' },

@@ -227,7 +237,7 @@

#define OPT_HELP(range, help) \

opt_help(argc, argv, (help)); \

argc -= optind; argv += optind; optind = 0; \

- OPT_RANGE((range))

+ OPT_RANGE((range), (range))

static int cmd_builddef(int transport, int argc, char *argv[])

{

@@ -510,10 +520,10 @@

return optind;

}

-#define OPT_PSKEY(range, stores, reset, help) \

+#define OPT_PSKEY(min, max, stores, reset, help) \

opt_pskey(argc, argv, (stores), (reset), (help)); \

argc -= optind; argv += optind; optind = 0; \

- OPT_RANGE((range))

+ OPT_RANGE((min), (max))

static int cmd_psget(int transport, int argc, char *argv[])

{

@@ -524,7 +534,7 @@

memset(array, 0, sizeof(array));

- OPT_PSKEY(1, &stores, &reset, NULL);

+ OPT_PSKEY(1, 1, &stores, &reset, NULL);

if (strncasecmp(argv[0], "0x", 2)) {

pskey = atoi(argv[0]);

@@ -599,7 +609,7 @@

memset(array, 0, sizeof(array));

- OPT_PSKEY(2, &stores, &reset, NULL);

+ OPT_PSKEY(2, 81, &stores, &reset, NULL);

if (strncasecmp(argv[0], "0x", 2)) {

pskey = atoi(argv[0]);

@@ -702,7 +712,7 @@

uint16_t pskey, stores = CSR_STORES_PSRAM;

int i, err, reset = 0;

- OPT_PSKEY(1, &stores, &reset, NULL);

+ OPT_PSKEY(1, 1, &stores, &reset, NULL);

if (strncasecmp(argv[0], "0x", 2)) {

pskey = atoi(argv[0]);

@@ -739,7 +749,7 @@

uint16_t pskey = 0x0000, length, stores = CSR_STORES_DEFAULT;

int err, reset = 0;

- OPT_PSKEY(0, &stores, &reset, NULL);

+ OPT_PSKEY(0, 0, &stores, &reset, NULL);

while (1) {

memset(array, 0, sizeof(array));

@@ -785,7 +795,7 @@

char *str, val[7];

int i, err, reset = 0;

- OPT_PSKEY(0, &stores, &reset, NULL);

+ OPT_PSKEY(0, 0, &stores, &reset, NULL);

while (1) {

memset(array, 0, sizeof(array));

@@ -854,7 +864,7 @@

char *str, val[7];

int err, reset = 0;

- OPT_PSKEY(1, &stores, &reset, NULL);

+ OPT_PSKEY(1, 1, &stores, &reset, NULL);

psr_read(argv[0]);

@@ -933,13 +943,13 @@

{ "disabletx", cmd_disabletx, "", "Disable TX on the device" },

{ "enabletx", cmd_enabletx, "", "Enable TX on the device" },

{ "memtypes", cmd_memtypes, NULL, "Get memory types" },

- { "psget", cmd_psget, "<key>", "Get value for PS key" },

- { "psset", cmd_psset, "<key> <value>", "Set value for PS key" },

- { "psclr", cmd_psclr, "<key>", "Clear value for PS key" },

- { "pslist", cmd_pslist, NULL, "List all PS keys" },

- { "psread", cmd_psread, NULL, "Read all PS keys" },

- { "psload", cmd_psload, "<file>", "Load all PS keys from PSR file" },

- { "pscheck", cmd_pscheck, "<file>", "Check PSR file" },

+ { "psget", cmd_psget, "[-r] [-s <store>] <key>", "Get value for PS
key" },

+ { "psset", cmd_psset, "[-r] [-s <store>] <key> <value>", "Set value
for PS key" },

+ { "psclr", cmd_psclr, "[-r] [-s <store>] <key>", "Clear value for PS
key" },

+ { "pslist", cmd_pslist, "[-r] [-s <store>]", "List all PS keys" },

+ { "psread", cmd_psread, "[-r] [-s <store>]", "Read all PS keys" },

+ { "psload", cmd_psload, "[-r] [-s <store>] <file>", "Load all PS keys
from PSR file" },

+ { "pscheck", cmd_pscheck, "[-r] [-s <store>] <file>", "Check PSR file"
},

{ NULL }

};

@@ -977,6 +987,7 @@

}

}

printf("\n");

+ printf("\tor by hex value\n");

}

static struct option main_options[] = {


-- 
Chris Brand
Senior Software Engineer
WideRay
604-233-1105
 


_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
