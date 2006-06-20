Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Sumeet VERMA <sumeet.verma@st.com>
To: "'BlueZ users'" <bluez-users@lists.sourceforge.net>
Date: Tue, 20 Jun 2006 13:16:10 +0530
Message-ID: <003c01c6943d$9932ff90$7f0cc70a@dlh.st.com>
MIME-Version: 1.0
In-Reply-To: <1150787594.10957.5.camel@localhost>
Subject: Re: [Bluez-users] dbus-glib problem
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

Hi Marcel

I think the problem is with the kernel version. I am using 2.4 while the
package bluez-utils-3.1 seems to work with 2.6. Is this true?

If yes.. then is there any way I can make bluez latest package work with
Linux kernelversion 2.4.

Best Regards,

Sumeet



-----Original Message-----
From: bluez-users-bounces@lists.sourceforge.net
[mailto:bluez-users-bounces@lists.sourceforge.net] On Behalf Of Marcel
Holtmann
Sent: Tuesday, June 20, 2006 12:43 PM
To: BlueZ users
Subject: Re: [Bluez-users] dbus-glib problem


Hi Sumeet,

> I have downloaded bluez-utils-3.1 and bluez-libs-3.1 and I am trying 
> to build them.
> 
> I get the following error when I run ./configure for bluez-utils -
> 
> [I have no name!@del32tpt  bluez-utils-3.1]$ ./configure checking for 
> a BSD-compatible install... /usr/bin/install -c checking whether build 
> environment is sane... yes checking for gawk... gawk
> ..
> .
> .
> .
> .
> .
> .
> checking for BLUEZ... yes
> checking for DBUS... Package dbus-glib-1 was not found in the pkg-config
search path.
> Perhaps you should add the directory containing `dbus-glib-1.pc'
> to the PKG_CONFIG_PATH environment variable
> No package 'dbus-glib-1' found
> configure: error: dbus-glib > 0.35 is required
> 
> There seem to be some dependencies. I have tried installing dbus-0.61 
> and glib-2.8.6 but it does not work. Please tell me what packages to 
> install to remove these dependencies and send me a link also if 
> possible.

we don't require the dbus-glib bindings. No idea why it is looking for them.
This seems like a bug in D-Bus package. What kind distribution is this?

Regards

Marcel




_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users



_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
