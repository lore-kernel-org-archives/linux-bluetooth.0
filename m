Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Sumeet VERMA <sumeet.verma@st.com>
To: "'BlueZ users'" <bluez-users@lists.sourceforge.net>
Date: Tue, 30 Oct 2007 15:53:51 +0530
Message-ID: <00c801c81ade$f8b766d0$832fc70a@dlh.st.com>
MIME-Version: 1.0
In-Reply-To: <472705E8.8050408@hccnet.nl>
Subject: Re: [Bluez-users] Audio gaps with bcm2035 and Hama receiver
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

Yeah I did that. Thanks :)


Sumeet 
-----Original Message-----
From: bluez-users-bounces@lists.sourceforge.net
[mailto:bluez-users-bounces@lists.sourceforge.net] On Behalf Of Remy Bosch
Sent: Tuesday, October 30, 2007 3:53 PM
To: BlueZ users
Subject: Re: [Bluez-users] Audio gaps with bcm2035 and Hama receiver

Sumeet VERMA wrote:
> Hi Remy
> I am also facing the same compilation problem. I saw in the mailing 
> list you were able to resolve it. How did you do it?
>
>
> Thanks,
> Sumeet
> -----Original Message-----
> From: bluez-users-bounces@lists.sourceforge.net
> [mailto:bluez-users-bounces@lists.sourceforge.net] On Behalf Of Remy 
> Bosch
> Sent: Friday, October 26, 2007 9:50 PM
> To: BlueZ users
> Subject: Re: [Bluez-users] Audio gaps with bcm2035 and Hama receiver
>
> For some reason "rtp.h" can't be found (included in
audio/pcm_bluetooth.c).
> This blocks my attempt to build it on gentoo without the use of eglib.
> The build goes as follows. In the source directory:
>
> The rm -r eglib/{*.c,*.h} # make sure eglib is ignored
> autoreconf -fis                  # Reconfigure
> ./configure --enable-inotify --enable-hal --enable-usb --enable-alsa 
> --enable-glib --disable-obex --enable-network --enable-serial 
> --enable-input --enable-audio --enable-sync --enable-hcid 
> --enable-configfiles --disable-initscripts --disable-pcmciarules 
> --enable-bccmd --enable-avctrl --enable-hid2hci --enable-dfutool
--localstatedir=/var
> make       # And then make
>
> This creates the error:
>  gcc -DHAVE_CONFIG_H -I. -I.. -I../common -I/usr/include/alsa -I../sbc 
> -Wall
> -O2 -D_FORTIFY_SOURCE=2 -MT
> libasound_module_pcm_bluetooth_la-pcm_bluetooth.lo -MD -MP -MF 
> .deps/libasound_module_pcm_bluetooth_la-pcm_bluetooth.Tpo -c 
> pcm_bluetooth.c -fPIC -DPIC -o 
> .libs/libasound_module_pcm_bluetooth_la-pcm_bluetooth.o
> pcm_bluetooth.c:41:17: error: rtp.h: No such file or directory
> pcm_bluetooth.c: In function 'avdtp_write':
> pcm_bluetooth.c:601: error: dereferencing pointer to incomplete type
> pcm_bluetooth.c:603: error: dereferencing pointer to incomplete type
> pcm_bluetooth.c:603: error: dereferencing pointer to incomplete type
> pcm_bluetooth.c:603: error: dereferencing pointer to incomplete type
> pcm_bluetooth.c:603: error: dereferencing pointer to incomplete type
> pcm_bluetooth.c:603: error: dereferencing pointer to incomplete type
> pcm_bluetooth.c:603: error: dereferencing pointer to incomplete type
> pcm_bluetooth.c:603: warning: left-hand operand of comma expression 
> has no effect
> pcm_bluetooth.c:603: error: dereferencing pointer to incomplete type
> pcm_bluetooth.c:603: error: dereferencing pointer to incomplete type
> pcm_bluetooth.c:603: error: dereferencing pointer to incomplete type
> pcm_bluetooth.c:603: error: dereferencing pointer to incomplete type
> pcm_bluetooth.c:605: error: dereferencing pointer to incomplete type
> pcm_bluetooth.c:606: error: dereferencing pointer to incomplete type
> pcm_bluetooth.c:607: error: dereferencing pointer to incomplete type
> pcm_bluetooth.c:608: error: dereferencing pointer to incomplete type
> pcm_bluetooth.c:609: error: dereferencing pointer to incomplete type
> pcm_bluetooth.c:610: error: dereferencing pointer to incomplete type
> pcm_bluetooth.c:617: error: invalid application of 'sizeof' to 
> incomplete type 'struct rtp_header'
> pcm_bluetooth.c:617: error: invalid application of 'sizeof' to 
> incomplete type 'struct rtp_payload'
> pcm_bluetooth.c: In function 'bluetooth_a2dp_init':
> pcm_bluetooth.c:968: error: invalid application of 'sizeof' to 
> incomplete type 'struct rtp_header'
> pcm_bluetooth.c:968: error: invalid application of 'sizeof' to 
> incomplete type 'struct rtp_payload'
> make[2]: *** [libasound_module_pcm_bluetooth_la-pcm_bluetooth.lo] 
> Error 1
> make[2]: Leaving directory `/root/bluez-utils-3.21/audio'
> make[1]: *** [all-recursive] Error 1
> make[1]: Leaving directory `/root/bluez-utils-3.21'
> make: *** [all] Error 2
>
>
> Any idea how to fix it?
>
>   

Update to 3.22


Remy


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
