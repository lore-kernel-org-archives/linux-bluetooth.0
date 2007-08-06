Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Mon, 6 Aug 2007 13:33:51 -0700 (PDT)
From: hong zhang <henryzhang62@yahoo.com>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <mailman.151917.1186390010.21973.bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Message-ID: <547249.8186.qm@web58008.mail.re3.yahoo.com>
Subject: [Bluez-devel] cross compile problem on bluez
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

List,

I apply bluez to embedded linux system. ARM processor
is used and arm compiler from montavista. Based on
README of bluez-libs-3.11. I run

configure
--host=/opt/montavista/mobilinux/devkit/arm/v6_vfp_le/bin/arm_v6_vfp_le-
 --prefix=/root/Desktop/bluez-libs-3.11

returns error as following, any help would be
appreciated.

configure: WARNING: If you wanted to set the --build
type, don't use --host.
    If a cross compiler is detected then cross compile
mode will be used.
checking for a BSD-compatible install...
/usr/bin/install -c
checking whether build environment is sane... yes
checking for gawk... gawk
checking whether make sets $(MAKE)... yes
checking for
/opt/montavista/mobilinux/devkit/arm/v6_vfp_le/bin/arm_v6_vfp_le--strip...
no
checking for strip... strip
checking whether to enable maintainer-specific
portions of Makefiles... no
checking for
/opt/montavista/mobilinux/devkit/arm/v6_vfp_le/bin/arm_v6_vfp_le--gcc...
no
checking for gcc... gcc
checking for C compiler default output file name...
a.out
checking whether the C compiler works... yes
checking whether we are cross compiling... no
checking for suffix of executables...
checking for suffix of object files... o
checking whether we are using the GNU C compiler...
yes
checking whether gcc accepts -g... yes
checking for gcc option to accept ANSI C... none
needed
checking for style of include used by make... GNU
checking dependency style of gcc... gcc3
checking for a BSD-compatible install...
/usr/bin/install -c
checking build system type... i686-redhat-linux-gnu
checking host system type... Invalid configuration
`/opt/montavista/mobilinux/devkit/arm/v6_vfp_le/bin/arm_v6_vfp_le-':
machine
`/opt/montavista/mobilinux/devkit/arm/v6_vfp_le/bin/arm_v6_vfp_le'
not recognized
configure: error: /bin/sh ./config.sub
/opt/montavista/mobilinux/devkit/arm/v6_vfp_le/bin/arm_v6_vfp_le-
failed



----henry


       
____________________________________________________________________________________
Boardwalk for $500? In 2007? Ha! Play Monopoly Here and Now (it's updated for today's economy) at Yahoo! Games.
http://get.games.yahoo.com/proddesc?gamekey=monopolyherenow  

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
