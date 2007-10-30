Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Sumeet VERMA <sumeet.verma@st.com>
To: <bluez-users@lists.sf.net>
Date: Tue, 30 Oct 2007 11:00:46 +0530
Message-ID: <00bb01c81ab6$0651bfd0$832fc70a@dlh.st.com>
MIME-Version: 1.0
Subject: [Bluez-users] Problem while compiling bluez-utils-3.22
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi 
I am trying to enable to audio in bluez utils 3.22
$ ./configure --enable-audio

but I get the following error while compiling audio/pcm_bluetooth.c file

make[2]: Entering directory `/local_no_backup/projects/sharp/bluez-utils-3.21/audio'
/bin/sh ../libtool --tag=CC   --mode=compile gcc -DHAVE_CONFIG_H -I. -I.. -I../common   -I/usr/include/alsa   -I../sbc -Wall -O2 -D_FORTIFY_SOURCE=2 -MT libasound_module_pcm_bluetooth_la-pcm_bluetooth.lo -MD -MP -MF .deps/libasound_module_pcm_bluetooth_la-pcm_bluetooth.Tpo -c -o libasound_module_pcm_bluetooth_la-pcm_bluetooth.lo `test -f 'pcm_bluetooth.c' || echo './'`pcm_bluetooth.c
mkdir .libs
 gcc -DHAVE_CONFIG_H -I. -I.. -I../common -I/usr/include/alsa -I../sbc -Wall -O2 -D_FORTIFY_SOURCE=2 -MT libasound_module_pcm_bluetooth_la-pcm_bluetooth.lo -MD -MP -MF .deps/libasound_module_pcm_bluetooth_la-pcm_bluetooth.Tpo -c pcm_bluetooth.c  -fPIC -DPIC -o .libs/libasound_module_pcm_bluetooth_la-pcm_bluetooth.o
pcm_bluetooth.c:41:18: rtp.h: No such file or directory
pcm_bluetooth.c: In function `avdtp_write':
pcm_bluetooth.c:601: error: dereferencing pointer to incomplete type
pcm_bluetooth.c:603: error: dereferencing pointer to incomplete type
pcm_bluetooth.c:603: error: dereferencing pointer to incomplete type
pcm_bluetooth.c:605: error: dereferencing pointer to incomplete type
pcm_bluetooth.c:606: error: dereferencing pointer to incomplete type
pcm_bluetooth.c:607: error: dereferencing pointer to incomplete type
pcm_bluetooth.c:608: error: dereferencing pointer to incomplete type
pcm_bluetooth.c:609: error: dereferencing pointer to incomplete type
pcm_bluetooth.c:610: error: dereferencing pointer to incomplete type
pcm_bluetooth.c:617: error: invalid application of `sizeof' to incomplete type `rtp_header' 
pcm_bluetooth.c:617: error: invalid application of `sizeof' to incomplete type `rtp_payload' 
pcm_bluetooth.c: In function `bluetooth_a2dp_init':
pcm_bluetooth.c:968: error: invalid application of `sizeof' to incomplete type `rtp_header' 
pcm_bluetooth.c:968: error: invalid application of `sizeof' to incomplete type `rtp_payload' 
make[2]: *** [libasound_module_pcm_bluetooth_la-pcm_bluetooth.lo] Error 1
make[2]: Leaving directory `/local_no_backup/projects/sharp/bluez-utils-3.21/audio'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/local_no_backup/projects/sharp/bluez-utils-3.21'
make: *** [all] Error 2

Any help?

Regards,
Sumeet 


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
