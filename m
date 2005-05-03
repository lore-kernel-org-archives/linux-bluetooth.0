Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: Phil Stopford <philstopford@hotmail.com>
Message-ID: <loom.20050504T013955-956@post.gmane.org>
References: <loom.20050427T005347-298@post.gmane.org> <1114606563.8836.1.camel@pegasus> <loom.20050427T153844-482@post.gmane.org> <200504271607.30208.cijoml@volny.cz> <loom.20050427T165103-193@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] Re: Belkin F8T002 PCMCIA - how to get working?
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
Date: Tue, 3 May 2005 23:44:17 +0000 (UTC)

Phil Stopford <philstopford <at> hotmail.com> writes:

> 
> Michal Semler <cijoml <at> volny.cz> writes:
> 
 <snip to satisfy gmane.org>
> 
> > >   Serial controller: Oxford Semiconductor Ltd OXCB950 Cardbus 16950 UART
> > 
> > ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > It is UART - hciattach with proper parameters should work for you
> > 
> > List back the conference to find them
> > 
> > Michal
> 

Having gone through the documentation for SuSE, I came across a suggestion to
add a section to /etc/pcmcia/config that defines the card and attempts to load
the module. I added the following based on cardctl ident output :

card "Oxford Semiconductor Ltd OXCB950 Cardbus 16950 UART"
  manfid 0x0279, 0x0001
  version "OXSEMI", "OXCB950", "Rev A"
  bind "serial_cs"

>From /var/log/messages, I get the following error and am somewhat puzzled about
how to fix the problem :

May  3 15:46:35 alfred kernel: PCI: Enabling device 0000:02:00.0 (0000 -> 0003)
$ Cardbus 16950 UART (not in the WHITELIST)

Any ideas or pointers would be welcome, as ever. Meanwhile, I'll see what google
can turn up.

Thanks,

Philip



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
