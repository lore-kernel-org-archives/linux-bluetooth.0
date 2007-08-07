Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Mon, 6 Aug 2007 18:20:16 -0700 (PDT)
From: hong zhang <henryzhang62@yahoo.com>
To: bluez-users@lists.sourceforge.net, sumeet.verma@st.com, leiyu@kcoe.cn
In-Reply-To: <mailman.168957.1185041390.29475.bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Message-ID: <193755.30655.qm@web58015.mail.re3.yahoo.com>
Subject: Re: [Bluez-users] Bluez-users Digest, Vol 15, Issue 15
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

Sumeet, leiyu,

Thanks for your information on bluez cross compile.

I did configure and make successfully for bluez-libs.
And follows what you said. BUT not install bluex-libs
because I do not where it should go. But they stay in
/root/Desktop/blue/buez-libs-3.11/include/bluetooth.

I can configure bluez-utils using following command
line with no error. 

configure --host=arm-linux
--prefix=/root/Desktop/bluez/bluez-libs-3.11
--with-bluez-libs=/root/Desktop/bluez/bluez-libs-3.11/lib
--includedir=/root/Desktop/bluez/bluez-libs-3.11/include
--libdir=/root/Desktop/bluez/bluez-libs-3.11/lib
--with-kernel=/root/Desktop/src/mxc/l26_21/ltib/rpm/BUILD/linux-2.6.10
CC=/opt/montavista/mobilinux/devkit/arm/v6_vfp_le/bin/arm_v6_vfp_le-gcc
AR=/opt/montavista/mobilinux/devkit/arm/v6_vfp_le/bin/arm_v6_vfp_le-ar
STRIP=/opt/montavista/mobilinux/devkit/arm/v6_vfp_le/bin/arm_v6_vfp_le-strip
RANLIB=/opt/montavista/mobilinux/devkit/arm/v6_vfp_le/bin/arm_v6_vfp_le-ranlib
LD=/opt/montavista/mobilinux/devkit/arm/v6_vfp_le/bin/arm_v6_vfp_le-ld
configure: WARNING: If you wanted to set the --build
type, don't use --host.
    If a cross compiler is detected then cross compile
mode will be used.


But get errors when make. 

1. it cannot find sdp.h in
/root/Desktop/bluez/bluez-utils-3.11/include/bluetooth.

2. try to link /usr/include/dbus-1.0 not surppose.

make[2]: Entering directory
`/root/Desktop/bluez/bluez-utils-3.11/common'
if
/opt/montavista/mobilinux/devkit/arm/v6_vfp_le/bin/arm_v6_vfp_le-gcc
-DHAVE_CONFIG_H -I. -I. -I..   
-I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include  
-DDBUS_API_SUBJECT_TO_CHANGE -I../eglib -Wall -O2
-D_FORTIFY_SOURCE=2 -MT oui.o -MD -MP -MF
".deps/oui.Tpo" -c -o oui.o oui.c; \
then mv -f ".deps/oui.Tpo" ".deps/oui.Po"; else rm -f
".deps/oui.Tpo"; exit 1; fi
cc1: warning: include location "/usr/include/dbus-1.0"
is unsafe for cross-compilation




Thanks.

----henry

--- bluez-users-request@lists.sourceforge.net wrote:

> Send Bluez-users mailing list submissions to
> 	bluez-users@lists.sourceforge.net
> 
> To subscribe or unsubscribe via the World Wide Web,
> visit
> 
>
https://lists.sourceforge.net/lists/listinfo/bluez-users
> or, via email, send a message with subject or body
> 'help' to
> 	bluez-users-request@lists.sourceforge.net
> 
> You can reach the person managing the list at
> 	bluez-users-owner@lists.sourceforge.net
> 
> When replying, please edit your Subject line so it
> is more specific
> than "Re: Contents of Bluez-users digest..."
> 
> 
> Today's Topics:
> 
>    1. Fail in cross-compile bluez-utils-3.9 (leiyu)
>    2. Re: Trouble with basic a2dp setup (Frederic
> Dalleau)
>    3. Re: Fail in cross-compile bluez-utils-3.9
> (Sumeet VERMA)
>    4. Re: Computer not visible to other devices.
> (Mats Erik Andersson)
>    5. Re: Plantronics Explorer 350 and
> bluetooth-alsa (Crni Gorac)
>    6. Re: Trouble with basic a2dp setup (Jesse
> Barnes)
>    7. Re: Why do I have to pair my headset each
> time? (David Abrahams)
> 
> 
>
----------------------------------------------------------------------
> 
> Message: 1
> Date: Fri, 20 Jul 2007 15:56:06 +0800
> From: "leiyu" <leiyu@kcoe.cn>
> Subject: [Bluez-users] Fail in cross-compile
> bluez-utils-3.9
> To: "Bluez-Users"
> <bluez-users@lists.sourceforge.net>
> Message-ID:
> <EJENLMBEOLKAMCJFBFMDOEDDCAAA.leiyu@kcoe.cn>
> Content-Type: text/plain;	charset="gb2312"
> 
> Dear All,
> 
> I use arm-linux-gcc-3.4.1 to cross-compile
> bluez-libs-3.9 and bluez-utils-3.9
> I success in cross-compile bluez-libs-3.9 ,but fail
> in bluez-utils-3.9 ,
> 
> /usr/bluez/bluezlibs is the directory I install
> bluez-libs-3.9    
> /usr/local/arm/linux-2.6.14.1 is the kernel diretory
> 
> [root@localhost bluez-utils-3.9]# ./configure
> --prefix=/bluez/bluezutils
> --includedir=/bluez/bluezlibs/include
> --libdir=/bluez/bluezlibs/lib  --host=arm-linux
> CC=/usr/local/arm/3.4.1/bin/arm-linux-gcc
> CPP=/usr/local/arm/3.4.1/bin/arm-linux-cpp
> AR=/usr/local/arm/3.4.1/bin/arm-linux-ar
> STRIP=/usr/local/arm/3.4.1/bin/arm-linux-strip
> RANLIB=/usr/local/arm/3.4.1/bin/arm-linux-ranlib
> LD=/usr/local/arm/3.4.1/bin/arm-linux-ld
> --with-bluez-libs=/bluez/bluezlibs
> --with-kernel=/usr/local/arm/linux-2.6.14.1
> .......
> checking if libtool supports shared libraries... yes
> checking whether to build shared libraries... yes
> checking whether to build static libraries... no
> configure: creating libtool
> checking for ppoll... no
> checking for arm-linux-pkg-config... no
> checking for pkg-config... /usr/bin/pkg-config
> checking pkg-config is at least version 0.9.0... yes
> checking for BLUEZ... no
> configure: error: Bluetooth library is required
> 
> Is my gcc version  not suit for it ? or Is my
> configure parameter not right ? I appreciate for
> your comment, thanks 
>  
> Best regards,
> Leiyu
> 
> 
> ------------------------------
> 
> Message: 2
> Date: Fri, 20 Jul 2007 10:13:27 +0200
> From: Frederic Dalleau
> <frederic.dalleau@access-company.com>
> Subject: Re: [Bluez-users] Trouble with basic a2dp
> setup
> To: BlueZ users <bluez-users@lists.sourceforge.net>
> Message-ID:
>
<1184919207.880.5.camel@ubuntu.mpl.access-company.com>
> Content-Type: text/plain
> 
> Are you paired?
> Put your headset discoverable and retry.
> The pincode dialog should appear, if not, make sure
> you have
> bluez-gnome.
> 
> Frederic
> 
> 
> On Thu, 2007-07-19 at 16:54 -0700, Jesse Barnes
> wrote:
> > I recently picked up a Jabra BT620s headset for
> use with my Treo, and it
> > works great.  So I figured it would be nice if it
> worked with my
> > bluetooth capable Linux laptops as well. 
> Unfortunately, configuring it
> > to actually play audio on demand hasn't been as
> easy as I'd expected.
> > 
> > I followed the instructions at the bluetooth-alsa
> site, .a2dprc
> > attached, and .asoundrc looks like this:
> > 	pcm.a2dpd {
> > 	        type a2dpd
> > 	}
> > 
> > hcitool scan shows my device address if its in
> associate mode, and I can
> > ping it with l2ping, but when I play audio after
> starting the a2dpd
> > daemon, I get a lot of debug output, some of which
> look like error
> > messages:
> > 
> > ...
> > A2DPD[16:42:59.501]: init_ipc: Selected IPC: unix,
> addr=127.0.0.1, 
> > bcst=127.0.0.255, port=21453
> > A2DPD[16:42:59.501]: make_daemon_process: a2dpd
> [Jul 19 2007 14:19:57] 
> > starting ...
> > A2DPD[16:42:59.502]: main: (errno=13:Permission
> denied)a2dpd 
> > addr=00:13:17:71:44:AA timer=0 us [Jul 19 2007
> 14:37:05]
> > A2DPD[16:42:59.503]: a2dpd_signal_init: Getting on
> DBUS
> > A2DPD[16:42:59.509]: a2dpd_signal_init: Installing
> watch
> > A2DPD[16:42:59.510]: add_dbus_watch: Added watch 0
> 0x859b838 disabled
> > A2DPD[16:42:59.510]: add_dbus_watch: Added watch 1
> 0x859b860 enabled
> > A2DPD[16:42:59.511]: a2dpd_signal_init:
> Registering object 
> > path: /com/access/a2dpd
> > A2DPD[16:42:59.511]: a2dpd_signal_init: Acquiring
> service: 
> > com.access.a2dpd
> > A2DPD[16:42:59.513]: a2dpd_signal_init: OK
> > A2DPD[16:42:59.513]: a2dpd_register_sdp: Start
> > A2DPD[16:42:59.514]: add_avrtg:
> > A2DPD[16:42:59.516]: add_a2source:
> > A2DPD[16:42:59.516]: a2dpd_register_sdp: OK
> > A2DPD[16:42:59.517]: main_loop:
> > A2DPD[16:42:59.517]: make_server_socket:
> > A2DPD[16:42:59.518]: a2dp_make_listen_socket:
> (errno=13:Permission 
> > denied)Cannot bind socket 6 for psm 25
> > A2DPD[16:42:59.518]: main_loop: *** Cannot get
> AVDTP socket, incoming 
> > AVDTP connections are impossible ***
> > A2DPD[16:42:59.519]: a2dpd_signal_state: Started
> 00:13:17:71:44:AA
> > A2DPD[16:42:59.520]: bta2dpdevicenew:
> > A2DPD[16:42:59.520]: a2dpd_signal_address_changed:
> 00:13:17:71:44:AA
> > A2DPD[16:42:59.521]: a2dpd_signal_set_socket:
> Signal socket set to 6
> > A2DPD[16:42:59.524]: a2dpd_signal_state:
> Disconnected
> > A2DPD[16:42:59.525]: a2dp_alloc:
> > A2DPD[16:42:59.525]: a2dp_alloc: (a2dp =
> 0x859ef88)
> > ...
> > A2DPD[16:43:08.561]: get_avdtp_psm: Record
> > A2DPD[16:43:08.561]: get_avdtp_psm: Service Search
> OK
> > A2DPD[16:43:08.593]: get_avdtp_psm: Checking non
> spec audio
> > A2DPD[16:43:08.593]: a2dp_state_machine: Found psm
> 25
> > A2DPD[16:43:08.593]: a2dp_state_machine: State 
> > AVDTP_STATEX_CTL_CONNECTING
> > A2DPD[16:43:08.593]: a2dp_state_machine: Socket is
> 9
> 
=== message truncated ===



       
____________________________________________________________________________________
Boardwalk for $500? In 2007? Ha! Play Monopoly Here and Now (it's updated for today's economy) at Yahoo! Games.
http://get.games.yahoo.com/proddesc?gamekey=monopolyherenow  

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
