Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <42B31512.8060301@sdgsystems.com>
From: Todd Blumer <todd@sdgsystems.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: multipart/mixed;
 boundary="------------020009090504060504060903"
Subject: [Bluez-devel] [PATCH] TI BTS for hciattach
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
Date: Fri, 17 Jun 2005 14:23:14 -0400

This is a multi-part message in MIME format.
--------------020009090504060504060903
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

This proposed patch implements the TI BTS (Bluetooth script) mechanism.
I have attached the diff and new files to be built along with hciattach.
I have also attached a sample BTS file (the one that goes along with the
BRF6150 plus firmware, as found in the iPAQ hx4700). The code is a bit
chatty (prints BTS comment lines), but provides feedback as to what is
being done with the chip. Comments / Suggestions welcome. Example usage:

hciattach -S /etc/bluetooth/TIInit_3.2.26.bts ttyS1 texas

Sample output (comments come from bts file):

TI module LMP version : 0x02
TI module LMP sub-version : 0x0d1a
Loading BTS script version 1
#--------------------------------------------------------------------------------
# Description : Initilization for BRF6150 2.11 ROM Device
#
#               The following software update is required to be
#               executed after power up or reset of the BRF6150 v2.11 device
#               for optimal performance and enhancement of the RF.
#
#
# Script Ver  : 2.26c
#
# Compatablity: BRF6150 2.11 ROM Device
#
# Last Updated: 25.3.2004
#
# Notes       : For usage on BRF6150 v2.11 ROM device only (FW version
2.0.26)!
#
#--------------------------------------------------------------------------------
#LC Pole trim bits [9:7=011]
# DETECTOR Update
# Set MLSE THRESHOLD to -68 dBm
#MLSE Match filter coef
# MLSE Ideal values
#AFC T2 Coefficients
#ANRITSU Power Control
BTS changing baud rate to 921600, flow control to 1
Bluetooth: HCI UART driver ver 2.1
Bluetooth: HCI H4 protocol initialized
Bluetooth: HCI BCSP protocol initialized

--
Todd Blumer
SDG Systems, LLC


--------------020009090504060504060903
Content-Type: application/octet-stream;
 name="TIInit_3.2.26.bts"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="TIInit_3.2.26.bts"

QlRTQgEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAGAFIAIy0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tAAYAOgAjIERlc2NyaXB0aW9uIDogSW5pdGlsaXphdGlvbiBmb3IgQlJGNjE1
MCAyLjExIFJPTSBEZXZpY2UABgACACMABgBBACMgICAgICAgICAgICAgICBUaGUgZm9sbG93
aW5nIHNvZnR3YXJlIHVwZGF0ZSBpcyByZXF1aXJlZCB0byBiZSAABgBOACMgICAgICAgICAg
ICAgICBleGVjdXRlZCBhZnRlciBwb3dlciB1cCBvciByZXNldCBvZiB0aGUgQlJGNjE1MCB2
Mi4xMSBkZXZpY2UgAAYAQwAjICAgICAgICAgICAgICAgZm9yIG9wdGltYWwgcGVyZm9ybWFu
Y2UgYW5kIGVuaGFuY2VtZW50IG9mIHRoZSBSRi4ABgAEACMJCQAGAAIAIwAGABYAIyBTY3Jp
cHQgVmVyICA6IDIuMjZjAAYAAgAjAAYAKAAjIENvbXBhdGFibGl0eTogQlJGNjE1MCAyLjEx
IFJPTSBEZXZpY2UABgACACMABgAaACMgTGFzdCBVcGRhdGVkOiAyNS4zLjIwMDQABgACACMA
BgBQACMgTm90ZXMgICAgICAgOiBGb3IgdXNhZ2Ugb24gQlJGNjE1MCB2Mi4xMSBST00gZGV2
aWNlIG9ubHkgKEZXIHZlcnNpb24gMi4wLjI2KSEABgARACMgICAgICAgICAgICAgICAABgBS
ACMtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQAGAAEAAAEADgABiP8K/wFAQEBAQEBAFQIA
DwCIEwAABwAAAAQOBACI/wAGAAEAAAEABwABkP8DAP//AgAPAIgTAAAHAAAABA4EAJD/AAYA
AQAABgAdACNMQyBQb2xlIHRyaW0gYml0cyBbOTo3PTAxMV0AAQAJAAFh/wVtzx0AAAIADwCI
EwAABwAAAAQOBABh/wAGAAEAAAYAEwAjIERFVEVDVE9SIFVwZGF0ZSAAAQAJAAFh/wWFhoYA
AAIADwCIEwAABwAAAAQOBABh/wAGAAEAAAEACQABYf8FhoaGAAACAA8AiBMAAAcAAAAEDgQA
Yf8ABgABAAAGACAAIyBTZXQgTUxTRSBUSFJFU0hPTEQgdG8gLTY4IGRCbQABAAYAARv+ArwB
AgAPAIgTAAAHAAAABA4EABv+AAYAAQAABgAgACNNTFNFIE1hdGNoIGZpbHRlciBjb2VmICAg
ICAgICAABgABAAABAAoAAQH/Bqyk//8+AAIADwCIEwAABwAAAAQOBAAB/wAGAAEAAAEACgAB
Af8GrqT//ywAAgAPAIgTAAAHAAAABA4EAAH/AAYAAQAAAQAKAAEB/wawpP//AAACAA8AiBMA
AAcAAAAEDgQAAf8ABgABAAAGAAEAAAYAFAAjIE1MU0UgSWRlYWwgdmFsdWVzAAYAAQAAAQAK
AAEB/waypP//UPYCAA8AiBMAAAcAAAAEDgQAAf8ABgABAAABAAoAAQH/BrSk//+Q+AIADwCI
EwAABwAAAAQOBAAB/wAGAAEAAAEACgABAf8GtqT//zAFAgAPAIgTAAAHAAAABA4EAAH/AAYA
AQAAAQAKAAEB/wa4pP//cAcCAA8AiBMAAAcAAAAEDgQAAf8ABgABAAABAAoAAQH/Brqk//+Q
+AIADwCIEwAABwAAAAQOBAAB/wAGAAEAAAEACgABAf8GvKT//9D6AgAPAIgTAAAHAAAABA4E
AAH/AAYAAQAAAQAKAAEB/wa+pP//cAcCAA8AiBMAAAcAAAAEDgQAAf8ABgABAAABAAoAAQH/
BsCk//+wCQIADwCIEwAABwAAAAQOBAAB/wAGAAEAAAYAFwAjQUZDIFQyIENvZWZmaWNpZW50
cyAgAAYAAQAAAQAJAAFh/wWphIcAAAIADwCIEwAABwAAAAQOBABh/wAGAAEAAAEACQABYf8F
qoSHAAACAA8AiBMAAAcAAAAEDgQAYf8ABgABAAAGABcAI0FOUklUU1UgUG93ZXIgQ29udHJv
bAABAAUAAQX+AQECAA8AiBMAAAcAAAAEDgQABf4ABgABAAABAAgAATb/BAAQDgACAA8AiBMA
AAcAAAAEDgQANv8AAwAIAAAQDgABAAAABgABAAA=
--------------020009090504060504060903
Content-Type: text/plain;
 name="hciattach-patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hciattach-patch"

Index: Makefile.am
===================================================================
RCS file: /cvsroot/bluez/utils/tools/Makefile.am,v
retrieving revision 1.29
diff -u -r1.29 Makefile.am
--- Makefile.am	16 May 2005 11:51:27 -0000	1.29
+++ Makefile.am	17 Jun 2005 18:08:42 -0000
@@ -24,6 +24,9 @@
 
 noinst_PROGRAMS = hcisecfilter ppporc pskey bccmd
 
+hciattach_SOURCES = hciattach.c ti_bts.h ti_bts.c
+hciattach_LDADD = @BLUEZ_LIBS@
+ 
 hciconfig_SOURCES = hciconfig.c csr.h csr.c
 hciconfig_LDADD = @BLUEZ_LIBS@ $(top_builddir)/common/libtextfile.a
 
Index: hciattach.c
===================================================================
RCS file: /cvsroot/bluez/utils/tools/hciattach.c,v
retrieving revision 1.29
diff -u -r1.29 hciattach.c
--- hciattach.c	30 Jan 2005 20:38:04 -0000	1.29
+++ hciattach.c	17 Jun 2005 18:08:42 -0000
@@ -51,6 +51,8 @@
 #include <bluetooth/hci_lib.h>
 #include <bluetooth/hci_uart.h>
 
+#include "ti_bts.h"
+
 struct uart_t {
 	char *type;
 	int  m_id;
@@ -60,6 +62,7 @@
 	int  speed;
 	int  flags;
 	int  (*init) (int fd, struct uart_t *u, struct termios *ti);
+	char *bts;	/* bluetooth script */
 };
 
 #define FLOW_CTL	0x0001
@@ -235,6 +238,114 @@
 	return 0;
 }
 
+static int brf6150(int fd, struct uart_t *u, struct termios *ti)
+{
+	bts_t *bfp;
+	int i;
+	unsigned long vers;
+	unsigned char actionbuf[256];
+	unsigned char resp[128];		/* Response */
+	unsigned long count;
+	unsigned short atype;
+
+	if (u->bts == NULL)	/* no script, ignore */
+		return 0;
+
+	bfp = bts_load_script( u->bts, &vers );
+	if (bfp == NULL)
+		return -1;
+
+	fprintf( stderr, "Loading BTS script version %lu\n", vers );
+
+	while ((count = bts_next_action( bfp, actionbuf,
+			sizeof actionbuf - 1, &atype )) != 0) {
+		if (atype == ACTION_REMARKS) {
+			if (actionbuf[0] != 0)
+				fprintf( stderr, "%s\n", actionbuf );
+		}
+		else if (atype == ACTION_SEND_COMMAND) {
+#if 0
+			fprintf( stderr, "ACTION_SEND_COMMAND: ", (int)atype );
+			for (i=0; i<count; i++) {
+				fprintf( stderr, "0x%02x ", actionbuf[i] );
+			}
+			fprintf( stderr, "\n" );
+#endif
+			int n;
+			n = write(fd, actionbuf, count);
+			if (n < 0 || n < count) {
+				perror("Failed to write TI action command");
+				return -1;
+			}
+		}
+		else if (atype == ACTION_WAIT_EVENT) {
+			action_wait_t *wait = (action_wait_t *)actionbuf;
+#if 0
+			fprintf( stderr, "ACTION_WAIT_EVENT: %u msec, %u size, data = ", wait->msec, wait->size );
+			for (i=0; i<wait->size; i++) {
+				fprintf( stderr, "0x%02x ", wait->data[i] );
+			}
+			fprintf( stderr, "\n" );
+#endif
+			usleep(wait->msec);	/* seems they give usec, not msec */
+			/* Read reply. */
+			if ((count = read_hci_event(fd, resp, sizeof resp)) < 0) {
+				perror("Failed to read TI command response");
+				return -1;
+			}
+			if (count < wait->size) {
+				fprintf( stderr, "TI command response is short.");
+			}
+			for (i=0; i<wait->size; i++) {
+				if (i == 3) continue;	/* ignore */
+				if (resp[i] != wait->data[i]) {
+					fprintf( stderr, "TI command response does not match expected result.\n" );
+				}
+			}
+		}
+		else if (atype == ACTION_SERIAL_PORT_PARAMETERS) {
+			action_serial_t *sercmd = (action_serial_t *)actionbuf;
+
+			/* Set actual baudrate */
+			fprintf( stderr,
+				"BTS changing baud rate to %u, flow control to %u\n",
+				sercmd->baud, sercmd->flow_control );
+
+			tcflush(fd, TCIOFLUSH);
+
+			if (sercmd->flow_control)
+				ti->c_cflag |= CRTSCTS;
+			else
+				ti->c_cflag &= ~CRTSCTS;
+			if (tcsetattr(fd, TCSANOW, ti) < 0) {
+				perror("Can't set port settings");
+				return -1;
+			}
+
+			u->speed = sercmd->baud;
+
+			tcflush(fd, TCIOFLUSH);
+			if (set_speed(fd, ti, sercmd->baud) < 0) {
+				perror("Can't set baud rate");
+				return -1;
+			}
+		}
+		else if (atype == ACTION_DELAY) {
+			action_delay_t *delay = (action_delay_t *)actionbuf;
+			usleep(delay->msec);	/* seems they give usec, not msec */
+		}
+		else {
+			fprintf( stderr, "BTS action type = %d: ", (int)atype );
+			for (i=0; i<count; i++) {
+				fprintf( stderr, "0x%02x ", actionbuf[i] );
+			}
+			fprintf( stderr, "\n" );
+		}
+	}
+	bts_unload_script( bfp );
+	return 0;
+}
+
 static int texas(int fd, struct uart_t *u, struct termios *ti)
 {
 	struct timespec tm = {0, 50000};
@@ -275,14 +386,25 @@
 	} while (resp[4] != cmd[1] && resp[5] != cmd[2]);
 
 	/* Verify manufacturer */
-	if ((resp[11] & 0xFF) != 0x0d)
+	if (resp[11] != 0x0d)
 		fprintf(stderr,"WARNING : module's manufacturer is not Texas Instrument\n");
 
 	/* Print LMP version */
-	fprintf(stderr, "Texas module LMP version : 0x%02x\n", resp[10] & 0xFF);
+	fprintf(stderr, "TI module LMP version : 0x%02x\n", resp[10]);
 
 	/* Print LMP subversion */
-	fprintf(stderr, "Texas module LMP sub-version : 0x%02x%02x\n", resp[14] & 0xFF, resp[13] & 0xFF);
+	fprintf(stderr, "TI module LMP sub-version : 0x%02x%02x\n", resp[14], resp[13]);
+	if ((resp[14] >> 2) == 3) {
+		int err;
+		nanosleep(&tm, NULL);
+
+		/* BRF6150 */
+		if ((err=brf6150( fd, u, ti )) != 0) {
+			fprintf( stderr, "TI script failed (err=%d)\n",
+				err );
+			return -1;
+		}
+	}
 	
 	nanosleep(&tm, NULL);
 	return 0;
@@ -946,7 +1068,7 @@
 {
 	printf("hciattach - HCI UART driver initialization utility\n");
 	printf("Usage:\n");
-	printf("\thciattach [-n] [-p] [-b] [-t timeout] [-s initial_speed] <tty> <type | id> [speed] [flow|noflow]\n");
+	printf("\thciattach [-n] [-p] [-b] [-t timeout] [-s initial_speed] [-S bts-script] <tty> <type | id> [speed] [flow|noflow]\n");
 	printf("\thciattach -l\n");
 }
 
@@ -963,11 +1085,12 @@
 	pid_t pid;
 	struct sigaction sa;
 	char dev[20];
+	char *bts = NULL;
 
 	detach = 1;
 	printpid = 0;
 	
-	while ((opt=getopt(argc, argv, "bnpt:s:l")) != EOF) {
+	while ((opt=getopt(argc, argv, "bnpt:s:S:l")) != EOF) {
 		switch(opt) {
 		case 'b':
 			send_break = 1;
@@ -989,6 +1112,10 @@
 			init_speed = atoi(optarg);
 			break;
 
+		case 'S':
+			bts = optarg;
+			break;
+
 		case 'l':
 			for (i = 0; uart[i].type; i++) {
 				printf("%-10s0x%04x,0x%04x\n", uart[i].type,
@@ -1060,6 +1187,8 @@
 	if (init_speed)
 		u->init_speed = init_speed;
 
+	u->bts = bts;
+
 	memset(&sa, 0, sizeof(sa));
 	sa.sa_flags = SA_NOCLDSTOP;
 	sa.sa_handler = sig_alarm;

--------------020009090504060504060903
Content-Type: text/x-csrc;
 name="ti_bts.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ti_bts.c"

/*
 * Copyright (c) 2005 Texas Instruments, Inc.
 *    Ported by SDG Systems, LLC
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License version 2 as
 *  published by the Free Software Foundation;
 *
 *  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
 *  OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY RIGHTS.
 *  IN NO EVENT SHALL THE COPYRIGHT HOLDER(S) AND AUTHOR(S) BE LIABLE FOR ANY
 *  CLAIM, OR ANY SPECIAL INDIRECT OR CONSEQUENTIAL DAMAGES, OR ANY DAMAGES 
 *  WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN 
 *  ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF 
 *  OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 *
 *  ALL LIABILITY, INCLUDING LIABILITY FOR INFRINGEMENT OF ANY PATENTS, 
 *  COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS, RELATING TO USE OF THIS 
 *  SOFTWARE IS DISCLAIMED.
 *
 */


#include <stdio.h>
#include <stdlib.h>
#include "ti_bts.h"

#ifndef MAKEWORD
#define MAKEWORD(a, b)      ((unsigned short)(((unsigned char)(a)) | ((unsigned short)((unsigned char)(b))) << 8))
#endif

#define TI_MANUFACTURER_ID  13

/*
 * Common Init Script specific
 */
const char *
cis_create_filename(const unsigned char* cmdparms)
{
    static char bts_file[50];

    /* Check for TI's id */
    unsigned short manfid = MAKEWORD(cmdparms[8], cmdparms[9]);

    if (TI_MANUFACTURER_ID == manfid) {
        unsigned short version = MAKEWORD(cmdparms[10], cmdparms[11]);
        
        unsigned short chip =  (version & 0x7C00) >> 10;
        unsigned short min_ver = (version & 0x007F);
        unsigned short maj_ver = (version & 0x0380) >> 7;

        if (0 != (version & 0x8000)) {
            maj_ver |= 0x0008;
        }
        
        sprintf( bts_file, "TIInit_%d.%d.%d.bts", 
            (int)chip, (int)maj_ver, (int)min_ver);

        return &bts_file[0];
    }
    return NULL;
}

typedef struct tagCHeader 
{
    unsigned long magic;
    unsigned long version;
    unsigned char future[24];
} cheader_t;


/* The value 0x42535442 stands for (in ASCII) BTSB */
/* which is Bluetooth Script Binary */
#define FILE_HEADER_MAGIC   0x42535442


bts_t *
bts_load_script(const char* fname, unsigned long* version)
{
    bts_t* bts = NULL;
    FILE* fp = fopen(fname, "rb");

    if (NULL != fp) {
        /* Read header */
        cheader_t header;

        /* Read header */
        if (1 == fread(&header, sizeof(header), 1, fp)) {
            /* Check magic number for correctness */
            if (header.magic == FILE_HEADER_MAGIC) {
                /* If user wants the version number */
                if (NULL != version) {
                    *version = header.version;
                }
                bts = (bts_t*)fp;
            }
        }
        /* If failed reading the file, close it */
        if (NULL == bts) {
            fclose(fp);
        }
    }
    return bts;
}

unsigned long
bts_next_action(const bts_t* bts_fp, unsigned char* action_buf,
    unsigned long nMaxSize, unsigned short* ptype)
{
    unsigned long bytes = 0;
    FILE* fp = (FILE*)bts_fp;
    unsigned char action_hdr[4];

    if (bts_fp == NULL)
        return 0;

    /* Each Action has the following: */
    /* UINT16 type of this action */
    /* UINT16 size of rest */
    /* BYTE[] action buffer (for HCI, includes the type byte e.g. 1 for hci command) */

    if (1 == fread(&action_hdr[0], sizeof(action_hdr), 1, fp)) {
        unsigned short type = *(unsigned short*)&action_hdr[0];
        unsigned short size = *(unsigned short*)&action_hdr[2];

        if (size <= nMaxSize) {
            int nread = fread(action_buf, sizeof(action_buf[0]), size, fp);

            if (nread == size) {
                *ptype = type;
                bytes = (unsigned long)size;
            }
        }
    }

    return bytes;
}

void
bts_unload_script(bts_t* bts_fp)
{
    FILE* fp = (FILE*)bts_fp;

    if (NULL != fp) {
        fclose(fp);
    }
}


--------------020009090504060504060903
Content-Type: text/x-chdr;
 name="ti_bts.h"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ti_bts.h"

/*
 * Copyright (c) 2005 Texas Instruments, Inc.
 *    Ported by SDG Systems, LLC
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License version 2 as
 *  published by the Free Software Foundation;
 *
 *  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
 *  OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY RIGHTS.
 *  IN NO EVENT SHALL THE COPYRIGHT HOLDER(S) AND AUTHOR(S) BE LIABLE FOR ANY
 *  CLAIM, OR ANY SPECIAL INDIRECT OR CONSEQUENTIAL DAMAGES, OR ANY DAMAGES 
 *  WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN 
 *  ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF 
 *  OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 *
 *  ALL LIABILITY, INCLUDING LIABILITY FOR INFRINGEMENT OF ANY PATENTS, 
 *  COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS, RELATING TO USE OF THIS 
 *  SOFTWARE IS DISCLAIMED.
 *
 */

#ifndef BT_SCRIPT_H
#define BT_SCRIPT_H

#ifdef __cplusplus
extern "C" {
#endif

/*
 * Define the interface of Bluetooth Script
 */

typedef void bts_t;


#define ACTION_SEND_COMMAND             1   /* Send out raw data (as is) */
#define ACTION_WAIT_EVENT               2   /* Wait for data */
#define ACTION_SERIAL_PORT_PARAMETERS   3   
#define ACTION_DELAY                    4   
#define ACTION_RUN_SCRIPT               5   
#define ACTION_REMARKS                  6

/*
 * Structure for ACTION_SEND_COMMAND
 */
typedef struct tagCActionCommand
{
    unsigned char data[1]; /* Data to send */
} action_command_t;

/*
 * Structure for ACTION_WAIT_EVENT
 */
typedef struct tagCActionWaitEvent
{
    unsigned long msec; /* in milliseconds */
    unsigned long size;
    unsigned char data[1]; /* Data to wait for */
} action_wait_t;


/*
 * Structure for ACTION_SERIAL_PORT_PARAMETERS
 */
typedef struct tagCActionSerialPortParameters
{
    unsigned long baud;
    unsigned long flow_control;
} action_serial_t;

/* Flow Control Type */
#define FCT_NONE        0
#define FCT_HARDWARE    1

#define DONT_CHANGE     0xFFFFFFFF  /* For both baud rate and flow control */


/*
 * Structure for ACTION_DELAY
 */
typedef struct tagCActionDelay
{
    unsigned long msec; /* in milliseconds */
} action_delay_t;

/*
 * Structure for ACTION_RUN_SCRIPT
 */
typedef struct tagCActionRunScript
{
    char filename[1];
} action_run_t;

/*
 * Structure for ACTION_REMARKS
 */
typedef struct tagCActionRemarks
{
    char m_szRemarks[1];
} action_remarks_t;


const char *cis_create_filename(const unsigned char* cmdparms);
bts_t * bts_load_script(const char* fname, unsigned long* version);
unsigned long bts_next_action(const bts_t* bts_fp, unsigned char* action_buf,
	unsigned long nMaxSize, unsigned short* ptype);
void bts_unload_script(bts_t* bts_fp);

#ifdef __cplusplus
};
#endif

#endif /* BT_SCRIPT_H */


--------------020009090504060504060903--


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
