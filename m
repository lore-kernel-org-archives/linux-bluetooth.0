Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Mon, 29 Jan 2007 09:44:06 -0800
Message-ID: <D8CE9CFA707C894180BAC8CDD154F8460B248D91@msiexch01.marvell.com>
From: "Quinton Yuan" <qyuan@marvell.com>
To: <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Bluez-devel Digest, Vol 9, Issue 99
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Marcel, Mayank

Sorry for the confusion, I would like to confirm that

1. First display is right from hcidump, 
	HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
	handle 1 ptype 0x2000
	Packet type: 3-DH5

	However, the problem for this is we just disabled the 3-DH5
packet type, instead of enabling it, whose function is reversed among
BDR and EDR

2. Second display is wrong which is caused firmware

Regards/Quinton

-----Original Message-----
From: bluez-devel-bounces@lists.sourceforge.net
[mailto:bluez-devel-bounces@lists.sourceforge.net] On Behalf Of
bluez-devel-request@lists.sourceforge.net
Sent: Monday, January 29, 2007 4:07 AM
To: bluez-devel@lists.sourceforge.net
Subject: Bluez-devel Digest, Vol 9, Issue 99

Send Bluez-devel mailing list submissions to
	bluez-devel@lists.sourceforge.net

To subscribe or unsubscribe via the World Wide Web, visit
	https://lists.sourceforge.net/lists/listinfo/bluez-devel
or, via email, send a message with subject or body 'help' to
	bluez-devel-request@lists.sourceforge.net

You can reach the person managing the list at
	bluez-devel-owner@lists.sourceforge.net

When replying, please edit your Subject line so it is more specific
than "Re: Contents of Bluez-devel digest..."


Today's Topics:

   1. Re: loading of hci_uart.ko (Choi Sonim)
   2. Re: loading of hci_uart.ko (Marcel Holtmann)
   3. Re: hcidump EDR packet type (Mayank BATRA)
   4. Re: loading of hci_uart.ko (Choi Sonim)
   5. Re: hcidump EDR packet type (Marcel Holtmann)
   6. Re: hcidump EDR packet type (Mayank BATRA)
   7. Rocket Stock Report (that. soloist)
   8. Traders Daily Report (Idaho Illinois)


----------------------------------------------------------------------

Message: 1
Date: Mon, 29 Jan 2007 11:57:00 +0200
From: "Choi Sonim" <choisonim@gmail.com>
Subject: Re: [Bluez-devel] loading of hci_uart.ko
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>, 	"Marcel
	Holtmann" <marcel@holtmann.org>
Message-ID:
	<4f436aae0701290157h3ac80220t801fffccdc2b8a8c@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed

Hi Marcel,

On 1/19/07, Marcel Holtmann <marcel@holtmann.org> wrote:
> > when I do "hciattach /dev/ttyS0 any", somehow the needed module
> > hci_uart.ko is loaded.
> > I looked in hciattach.c but I do not see how is it done ?
>
> # modinfo hci_uart
> alias:          tty-ldisc-15
>
> It tells the kernel to load this module if any application request the
> line discipline 15.

can you please elaborate on this ? when the app request the HCI line
discipline, how does the kernel knows it need to look for alias
tty-ldisc-15 ?
does it then run modprobe ?
what code is responsible for that ?

thank you very much for the help
choi
>
> Regards
>
> Marcel
>
>
>
>
------------------------------------------------------------------------
-
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to
share your
> opinions on IT & business topics through brief surveys - and earn cash
>
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDE
V
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>



------------------------------

Message: 2
Date: Mon, 29 Jan 2007 11:05:45 +0100
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [Bluez-devel] loading of hci_uart.ko
To: Choi Sonim <choisonim@gmail.com>
Cc: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <1170065145.15389.117.camel@violet>
Content-Type: text/plain

Hi Choi,

> > > when I do "hciattach /dev/ttyS0 any", somehow the needed module
> > > hci_uart.ko is loaded.
> > > I looked in hciattach.c but I do not see how is it done ?
> >
> > # modinfo hci_uart
> > alias:          tty-ldisc-15
> >
> > It tells the kernel to load this module if any application request
the
> > line discipline 15.
> 
> can you please elaborate on this ? when the app request the HCI line
> discipline, how does the kernel knows it need to look for alias
tty-ldisc-15 ?
> does it then run modprobe ?
> what code is responsible for that ?

the kernel actually doesn't care what's the module name of module
providing the line discipline 15. It simply requests the loading of the
module and the userspace (insmod/modprobe) has to resolve this.

Regards

Marcel





------------------------------

Message: 3
Date: Mon, 29 Jan 2007 16:08:08 +0530
From: Mayank BATRA <mayank.batra@st.com>
Subject: Re: [Bluez-devel] hcidump EDR packet type
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <45BDCE90.5070906@st.com>
Content-Type: text/plain; charset=ISO-8859-1

Hi Marcel,

> actually it is totally wrong. Sending the 3-DH5 bit only means that
you
> wanna enable DM1 and all EDR packets except 3-DH5, because setting
that
> bit means you disable that packet type. The corresponding response
> should be DM1 + 3-DH5 bit set.
> 
> Since this is custom firmware, it is interpreting the bitmask of the
> change connection packet type in the wrong way.
> 
> And to be clear on this, I don't care about the packet mask at all and
> nobody should mess with it (except for testing). Let the link manager
> decide which packet type to use. BlueZ can't make any intelligent
> decision on which is the best packet type. It doesn't know anything
> about the piconet it is using besides its handle.

OK. But my question is why display different packet lists in the command
and event?
< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
    handle 1 ptype 0x2000
    Packet type: 3-DH5

...

> HCI Event: Connection Packet Type Changed (0x1d) plen 5
    status 0x00 handle 1 ptype 0x1306
    Packet type: 2-DH1 2-DH3 2-DH5 3-DH1 3-DH3

Both of them should show the same packet list. Isn't it?

Best Regards,

Mayank



------------------------------

Message: 4
Date: Mon, 29 Jan 2007 12:42:09 +0200
From: "Choi Sonim" <choisonim@gmail.com>
Subject: Re: [Bluez-devel] loading of hci_uart.ko
To: "Marcel Holtmann" <marcel@holtmann.org>
Cc: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID:
	<4f436aae0701290242u18e4c35bocac8a8e9afeaa7b0@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed

On 1/29/07, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Choi,
>
> > > > when I do "hciattach /dev/ttyS0 any", somehow the needed module
> > > > hci_uart.ko is loaded.
> > > > I looked in hciattach.c but I do not see how is it done ?
> > >
> > > # modinfo hci_uart
> > > alias:          tty-ldisc-15
> > >
> > > It tells the kernel to load this module if any application request
the
> > > line discipline 15.
> >
> > can you please elaborate on this ? when the app request the HCI line
> > discipline, how does the kernel knows it need to look for alias
tty-ldisc-15 ?
> > does it then run modprobe ?
> > what code is responsible for that ?
>
> the kernel actually doesn't care what's the module name of module
> providing the line discipline 15. It simply requests the loading of
the
> module and the userspace (insmod/modprobe) has to resolve this.

thank you very much
choi

>
> Regards
>
> Marcel
>
>
>



------------------------------

Message: 5
Date: Mon, 29 Jan 2007 11:55:29 +0100
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [Bluez-devel] hcidump EDR packet type
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <1170068129.15389.122.camel@violet>
Content-Type: text/plain

Hi Mayank,

> > actually it is totally wrong. Sending the 3-DH5 bit only means that
you
> > wanna enable DM1 and all EDR packets except 3-DH5, because setting
that
> > bit means you disable that packet type. The corresponding response
> > should be DM1 + 3-DH5 bit set.
> > 
> > Since this is custom firmware, it is interpreting the bitmask of the
> > change connection packet type in the wrong way.
> > 
> > And to be clear on this, I don't care about the packet mask at all
and
> > nobody should mess with it (except for testing). Let the link
manager
> > decide which packet type to use. BlueZ can't make any intelligent
> > decision on which is the best packet type. It doesn't know anything
> > about the piconet it is using besides its handle.
> 
> OK. But my question is why display different packet lists in the
command
> and event?
> < HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
>     handle 1 ptype 0x2000
>     Packet type: 3-DH5
> 
> ...
> 
> > HCI Event: Connection Packet Type Changed (0x1d) plen 5
>     status 0x00 handle 1 ptype 0x1306
>     Packet type: 2-DH1 2-DH3 2-DH5 3-DH1 3-DH3
> 
> Both of them should show the same packet list. Isn't it?

that must be a bug in their firmware. They should be the same with the
only exception of DM1.

My assumption is that change connection packet type is treating this
command as enable 3-DH5 only. However that is not what that command
means. It means enable DM1 and all 2-* and 3-* packets except 3-DH5.

Regards

Marcel





------------------------------

Message: 6
Date: Mon, 29 Jan 2007 16:38:04 +0530
From: Mayank BATRA <mayank.batra@st.com>
Subject: Re: [Bluez-devel] hcidump EDR packet type
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <45BDD594.9040000@st.com>
Content-Type: text/plain; charset=ISO-8859-1

Hi Marcel,

> that must be a bug in their firmware. They should be the same with the
> only exception of DM1.
> 
> My assumption is that change connection packet type is treating this
> command as enable 3-DH5 only. However that is not what that command
> means. It means enable DM1 and all 2-* and 3-* packets except 3-DH5.

You are right. Its the job of the firmware and not the host to toggle
the EDR packet type bits (in contrast to what I said in a previous
post).

Best Regards,

Mayank



------------------------------

Message: 7
Date: Mon, 29 Jan 2007 12:07:09 +0000
From: "that. soloist" <iiwynsl@boydenchi.com>
Subject: [Bluez-devel] Rocket Stock Report
To: bluez-devel@lists.sourceforge.net
Message-ID: <EB9E16C91E85D07.3AC59A1260@boydenchi.com>
Content-Type: text/plain; charset="us-ascii"

An HTML attachment was scrubbed...
URL:
http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel/attachmen
ts/20070129/5ad84797/attachment.html 

------------------------------

Message: 8
Date: Mon, 29 Jan 2007 12:07:09 +0000
From: "Idaho Illinois" <mnwdrfhha@conecte.net>
Subject: [Bluez-devel] Traders Daily Report
To: bluez-devel@lists.sf.net
Message-ID: <4E3ED2D04317CD2.771D1C8382@conecte.net>
Content-Type: text/plain; charset="us-ascii"

An HTML attachment was scrubbed...
URL:
http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel/attachmen
ts/20070129/cfb749d1/attachment.html 

------------------------------

------------------------------------------------------------------------
-
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share
your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDE
V

------------------------------

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel


End of Bluez-devel Digest, Vol 9, Issue 99
******************************************

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
