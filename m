Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20041018192925.18589.qmail@web60410.mail.yahoo.com>
From: Murat Bog <murat_bog@yahoo.com>
Reply-To: murat_bog@yahoo.com
Subject: Re: [Bluez-users] Packages to Use For Zaurus SL-6000L
To: Stephen Crane <steve.crane@rococosoft.com>
Cc: bluez-users@lists.sourceforge.net
In-Reply-To: <1098091301.20331.84.camel@baroque.rococosoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 18 Oct 2004 12:29:25 -0700 (PDT)

Thanks for the reply.

Before I sent my query, I had tried using the 
following combination of packages specified in your
readme file:

bluez-kernel-2.4.18-mh14_arm.ipk
bluez-libs-2.8_arm.ipk
bluez-utils-2.8_arm.ipk

They had installed without errors.  I initially got
the following message when I started the bluetooth
services

Starting Bluetooth subsystem: hcid sdpdCan't open
RFCOMM control socket: No such file or directory
 rfcomm.

It looked like the rfcomm bluez modules were not
installed by the kernel, so I did

insmod l2cap
insmod rfcomm
depmod -a

and restarted bluetooth successfully.

Next, I ran

hciattach /dev/ttyS3 bt2000c

which also  executed successfully and returned the
following response

CSR build ID 0x02-0x0D

The problem is when I tried running hciconfig after
this, I got

hci0:   Type: UART
        BD Address: 00:00:00:00:00:00 ACL MTU: 0:0 
SCO MTU: 0:0
        DOWN INIT RUNNING
        RX bytes:0 acl:0 sco:0 events:0 errors:0
        TX bytes:4 acl:0 sco:0 commands:1 errors:0

but after a short while the status changed to just
"DOWN".

If I tried to reset or bring up hci0 at this point, I
got the following error.

Can't init device hci0. Connection timed out(110)

I don't know if I'm missing something basic but I had
thought that perhaps there was a driver issue which
may have been fixed in the later versions of the bluez
packages under the zaurus download directory.
 
Regards,
Murat


--- Stephen Crane <steve.crane@rococosoft.com> wrote:

> Hi,
> 
> On Sat, 2004-10-16 at 07:50, Murat Bog wrote:
> > Hello,
> > 
> > I am wondering which combination of Bluez packages
> I
> > should be installing on a Zaurus 6000L with
> factory
> > configuration(2.4.18-rml7-pxa3-embedix with ROM
> > version 1.12) to work with an AmbiCom BT2000CF
> card.
> > 
> > The latest set of packages do not seem to be
> working
> > together.  When I install
> bluez-utils-2.10_arm.ipk, it
> > reports a dependency error when used with
> > bluez-kernel-2.4.18-mh15_arm.ipk and
> > bluez-libs-2.10_arm.ipk.
> > 
> > I also see that when I run
> "/etc/rc.d/init.d/bluetooth
> > start" command, I get the following message:
> > 
> > "Starting Bluetooth subsystem:/usr/sbin/hcid:
> error
> > while loading shared libraries: libsdp.so.2:
> cannot
> > load shared object file: No such file or
> directory"
> 
> Pretty much all you need to know is described here:
>
http://bluez.sourceforge.net/download/zaurus/README.txt
> 
> Regards,
> Steve
> -- 
> Stephen Crane, Rococo Software Ltd.
> http://www.rococosoft.com
> steve.crane@rococosoft.com +353-1-6601315 (ext 209)
> 
> 



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
