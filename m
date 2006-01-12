Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <43C69F77.8050701@pagestation.com>
From: Jerry Geis <geisj@pagestation.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: [Bluez-users] btsco.41 not compiling
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 12 Jan 2006 13:27:03 -0500

I downloaded btsc.41 today. did the ./bootsrap; .configure; make ; make install
all that was good.
cd kernel; make and I get the following errors from this section of code.


static int index[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS - 1)] = -2}; /*
Exclude the first card */

module_param_array(index, int, NULL, 0444);
MODULE_PARM_DESC(index, "Index value for Bluetooth SCO Headset
Soundcard.");




[root@geisjdell kernel]#
[root@geisjdell kernel]# make
make[1]: Entering directory `/usr/src/kernels/2.6.9-22.0.1.EL-i686'
  CC [M]  /usr/src/btsco-0.41/kernel/btsco.o
/usr/src/btsco-0.41/kernel/btsco.c:88: error: invalid lvalue in unary
`&'
/usr/src/btsco-0.41/kernel/btsco.c:88: error: initializer element is not
constant
/usr/src/btsco-0.41/kernel/btsco.c:88: error: (near initialization for
`__param_arr_index.num')
make[2]: *** [/usr/src/btsco-0.41/kernel/btsco.o] Error 1
make[1]: *** [_module_/usr/src/btsco-0.41/kernel] Error 2
make[1]: Leaving directory `/usr/src/kernels/2.6.9-22.0.1.EL-i686'
make: *** [default] Error 2
[root@geisjdell kernel]#

-----------------

What  do I do?

I am running centos 4.2, with kernel 2.6.9-22.0.1-EL.
alsa 1.0.11rc2

Thanks,

Jerry





-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
