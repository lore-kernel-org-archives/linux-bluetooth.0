Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Alexander Holler <holler@ahsoftware.de>
To: bluez-devel@lists.sourceforge.net
Message-ID: <9810000.1073197538@[192.168.207.2]>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: [Bluez-devel] Success: switching the Logitech-Hub
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sun, 04 Jan 2004 07:25:38 +0100

Hi,

lsusb:

Bus 001 Device 004: ID 046d:c707 Logitech, Inc.
Bus 001 Device 003: ID 046d:c704 Logitech, Inc.
Bus 001 Device 002: ID 0451:2036 Texas Instruments, Inc. TUSB2036 Hub
Bus 001 Device 001: ID 0000:0000

Just be sure you have sshd up and running before switching the hub when 
using the diNovo Keyboard. ;)
This is also the reason for putting one of those stupid disclaimers into 
the source.

-------------------- logi2hci.cpp --------------------
/*
 logi2hci

 Small utility for switching the Logitech Bluetooth-Hub from USB-HID-mode
 into bluetooth-operation.

 (c) 2003 Alexander Holler

  This program is free software; you can redistribute it and/or modify
  it under the terms of the GNU General Public License version 2 as
  published by the Free Software Foundation;

  Legal stuff:

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
  OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY 
RIGHTS.
  IN NO EVENT SHALL THE COPYRIGHT HOLDER(S) AND AUTHOR(S) BE LIABLE FOR ANY 
CLAIM,
  OR ANY SPECIAL INDIRECT OR CONSEQUENTIAL DAMAGES, OR ANY DAMAGES 
WHATSOEVER
  RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF 
CONTRACT,
  NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH 
THE
  USE OR PERFORMANCE OF THIS SOFTWARE.

  ALL LIABILITY, INCLUDING LIABILITY FOR INFRINGEMENT OF ANY PATENTS, 
COPYRIGHTS,
  TRADEMARKS OR OTHER RIGHTS, RELATING TO USE OF THIS SOFTWARE IS 
DISCLAIMED.

 Kernel-patch for 2.6.0 needed:
 http://sourceforge.net/mailarchive/forum.php?thread_id=3581364&forum_id=53
98
*/

#include <fcntl.h>
#include <stdio.h>
#include <sys/ioctl.h>
#include <asm/types.h>
#include <linux/hiddev.h>
#include <string.h>
#include <unistd.h>

static int send_report(int fd, const char *values)
{
  struct hiddev_report_info rinfo;
  struct hiddev_usage_ref uref;

  for(int i=0; i<6; ++i ) {
    memset( &uref, 0, sizeof(uref) );
    uref.report_type = HID_REPORT_TYPE_OUTPUT;
    uref.report_id = 0x10;
    uref.field_index = 0;
    uref.usage_index = i ;
    uref.usage_code=0xff000001; // not needed just as beautifier
    uref.value = values[i];
    int rc=ioctl(fd, HIDIOCSUSAGE, &uref);
    if(rc)
      return rc;
  }
  memset( &rinfo, 0, sizeof(rinfo) );
  rinfo.report_type = HID_REPORT_TYPE_OUTPUT;
  rinfo.report_id = 0x10;
  rinfo.num_fields = 1;
  return ioctl(fd, HIDIOCSREPORT, &rinfo);
}

int main(void)
{
  int fd, rc;
  if ((fd = open("/dev/usb/hid/hiddev0", O_RDONLY)) <= 0) { // I have only 
one hiddev
    printf("error opening device\n");
    return 1;
  }
/*
  rc=ioctl(fd, HIDIOCINITREPORT,0);
  if(rc) {
    perror(NULL);
    return 2;
  }
*/
  char report1[] = {
    0xff, 0x80, 0x80, 0x01, 0x00, 0x00
  };
  rc=send_report(fd, report1);
  if(rc) {
    perror(NULL);
    return 3;
  }
  char report2[] = {
    0xff, 0x80, 0x00, 0x00, 0x30, 0x00
  };
  rc=send_report(fd, report2);
  if(rc) {
    perror(NULL);
    return 4;
  }
  char report3[] = {
    0xff, 0x81, 0x80, 0x00, 0x00, 0x00
  };
  rc=send_report(fd, report3);
  if(rc) {
    perror(NULL);
    return 5;
  }

  close(fd);
  return 0;
}
-------------------- logi2hci.cpp --------------------

Now, a hid-howto is needed. ;)

Regards,

Alexander



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
