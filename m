Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Alexander Holler <holler@ahsoftware.de>
To: bluez-devel@lists.sourceforge.net
Message-ID: <10480000.1073193805@[192.168.207.2]>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: [Bluez-devel] Switching the Logitech-Hub
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
Date: Sun, 04 Jan 2004 06:23:25 +0100

Hi,

I've now find a way to use hiddev for sending a report to the hub.

Using the patch from

http://sourceforge.net/mailarchive/forum.php?thread_id=3581364&forum_id=5398

the following works for sending reports:

----------------
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
  int i;
  for(i=0; i< 6; ++i ) {
    memset( &uref, 0, sizeof(uref) );
    uref.report_type = HID_REPORT_TYPE_OUTPUT;
    uref.report_id = 0x10;
    uref.field_index = 0;
    uref.usage_index = i ;
    uref.usage_code=0xff000001; // not used, just as beautifier
    uref.value = switch_sequence[i];
    rc=ioctl(fd, HIDIOCSUSAGE, &uref);
    printf("rc: %d\n", rc);
    if(rc)
      perror(NULL);
  }
  memset( &rinfo, 0, sizeof(rinfo) );
  rinfo.report_type = HID_REPORT_TYPE_OUTPUT;
  rinfo.report_id = 0x10;
  rinfo.num_fields = 1;
  rc=ioctl(fd, HIDIOCSREPORT, &rinfo);
  printf("rc: %d\n", rc);
  if(rc)
    perror(NULL);
  close(fd);
  return 0;
}
----------------

But the hub doesn't switch.

Using some debug-statements in hid-core.c, I see the following:

hid_submit_report
hid_submit_ctrl: 04 00 00 00 00 00 00
hid_submit_report
hid_submit_ctrl: 10 ffff ff81 ff80 00 00 00

This sequence will get send everytime I send one report using the above 
program. The first ctrl comes from HIDIOCINITREPORT. I don't now if calling 
the init is need, but I assume it doesn't break things.

Because the hub doesn't switch, it seems the report used (10 ff 81 80 00 00 
00) is wrong.

I will test some other reports (or sequences of them), I could find in my 
windows-log.

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
