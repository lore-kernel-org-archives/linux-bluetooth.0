Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Alexander Holler <holler@ahsoftware.de>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] hid2hci and Logitech Hub
Message-ID: <27150000.1072412780@[192.168.207.2]>
In-Reply-To: <1072406653.2876.98.camel@pegasus>
References: <8430000.1072356496@[192.168.207.2]>
 <1072363056.2876.75.camel@pegasus>  <30700000.1072366993@[192.168.207.2]>
 <1072369721.2876.90.camel@pegasus>  <19230000.1072404120@[192.168.207.2]>
 <1072406653.2876.98.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Fri, 26 Dec 2003 05:26:20 +0100

Hi Marcel,

--On Freitag, Dezember 26, 2003 03:44:13 +0100 Marcel Holtmann 
<marcel@holtmann.org> wrote:

>> As the report info for 0x10 shows 1 field and the maxusage from that
>> field  is 1, it seems there is no way sending 6 bytes (usages?) with one
>> report  0x10 using hiddev (if I have understood that part of hiddev
>> correct ;) ).
>
> I can't tell you how it is with hiddev, but the report ID 16 has six
> bytes and the report ID 17 has 19 bytes. Count for yourself.
>
> 	Usage Page (Undefined)
> 	Usage (0x01)
> 	Collection (Application)
> 	  Report ID (16)
> 	  Report Size (8)
> 	  Report Count (6)
> 	  Logical Minimum (0)
> 	  Logical Maximum (65535)
> 	  Usage (0x01)
> 	  Input (0x0000)
> 	  Usage (0x01)
> 	  Output (0x0000)
> 	End Collection
>
> 	Usage Page (Undefined)
> 	Usage (0x02)
> 	Collection (Application)
> 	  Report ID (17)
> 	  Report Size (8)
> 	  Report Count (19)
> 	  Logical Minimum (0)
> 	  Logical Maximum (65535)
> 	  Usage (0x02)
> 	  Input (0x0000)
> 	  Usage (0x02)
> 	  Output (0x0000)
> 	End Collection

Hmm, such an report I've searched. How to do you got this?

I've used the HIDIOCGREPORTINFO and HIDIOCGFIELDINFO ioctl from hiddev. 
There is an example ( 
http://www.frogmouth.net/hid-doco/examples/hiddev-misc/dump-events.c ) 
which output prints the same as my findings:

  Report id: 16 (1 fields)
  Field: 0: app: ff000001 phys 0000 flags 0 (1 usages) unit 0 exp 0
  Usage: ff000001 val 255 idx 0

>> I've tried sending 6 reports (0x10) with the values 0xff ... 0x00. That
>> hasn't worked (allways remember, I've just started collecting some
>> knowledge of usb, bluetooth and hid ;) ).
>
> With what kind of code?

Looking at hiddev.c and the documentation I've found, normally it should 
work with that code:

--------------------------
#include <fcntl.h>
#include <stdio.h>
#include <sys/ioctl.h>
#include <asm/types.h>
#include <linux/hiddev.h>

int main(void)
{
  char switch_sequence[] = {
    0xff, 0x81, 0x80, 0x00, 0x00, 0x00
  };
  struct hiddev_report_info rinfo;
  struct hiddev_usage_ref uref;
  struct hiddev_field_info finfo;
  int fd;
  if ((fd = open("/dev/usb/hid/hiddev0", O_RDONLY)) <= 0) { // I have only 
one hiddev
    printf("error opening device\n");
    return 1;
  }
  int rc=ioctl(fd, HIDIOCINITREPORT,0);
  printf("rc: %d\n", rc);
  if(rc)
    perror(NULL);
  memset( &rinfo, 0, sizeof(rinfo) );
  rinfo.report_type = HID_REPORT_TYPE_OUTPUT;
  rinfo.report_id = 0x10;
  rc=ioctl(fd, HIDIOCGREPORTINFO, &rinfo);
  printf("rc: %d\n", rc);
  if(rc)
    perror(NULL);
  printf("rinfo.num_fields: %u\n", rinfo.num_fields);
  memset( &finfo, 0, sizeof(finfo) );
  finfo.report_type=HID_REPORT_TYPE_OUTPUT;
  finfo.report_id=0x10;
  finfo.field_index=0;
  rc=ioctl(fd, HIDIOCGFIELDINFO, &finfo);
  printf("rc: %d\n", rc);
  if(rc)
    perror(NULL);
  printf("finfo.maxusage: %u\n", finfo.maxusage);
  int i;
  for(i=0; i< 6; ++i ) {
    memset( &uref, 0, sizeof(uref) );
    uref.report_type = HID_REPORT_TYPE_OUTPUT;
    uref.report_id = 0x10;
    uref.field_index = i;
    uref.usage_index = 0;
    uref.usage_code = 0 ;
    uref.value = switch_sequence[i];
    rc=ioctl(fd, HIDIOCSUSAGE, &uref);
    printf("rc: %d\n", rc);
    if(rc)
      perror(NULL);
  }
  memset( &rinfo, 0, sizeof(rinfo) );
  rinfo.report_type = HID_REPORT_TYPE_OUTPUT;
  rinfo.report_id = 0x10;
  rinfo.num_fields = 6;
  rc=ioctl(fd, HIDIOCSREPORT, &rinfo);
  printf("rc: %d\n", rc);
  if(rc)
    perror(NULL);
  close(fd);
  return 0;
}
--------------------------

The above doesn't work. I've also tried to increment usage_index, which 
doesn't work too (as the code in hiddev.c shows too).

But reading other messages on the usb-ml it seems I'm not the only one 
having problems sending multiples bytes with hiddev.

The next thing I will try, is using usbfs, but first I have to read how. ;)


>> Just remove or comment out the release of the isoc_iface. The release
>> isn't  needed and that avoids the oops. ;)
>
> Trust me that it is better to check it in detail. You always have to
> know why you are doing some things this way and I don't know it right
> now.

Surely, but the comment to usb_driver_release_interface clearly says the 
call of that function in hci_usb.c is not needed:

-------------
 * When the USB subsystem disconnect()s a driver from some interface,
 * it automatically invokes this method for that interface.  That
 * means that even drivers that used usb_driver_claim_interface()
 * usually won't need to call this.
-----------------

So removing it, isn't wrong and it avoids the oops. ;)

I think that maybe something is released twice. I've digged somewhat deeper 
into the usb code, but haven't find something. So I will this left 'as an 
excercise for the reader'. Choke, I will report it to the usb-ml. ;)

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
