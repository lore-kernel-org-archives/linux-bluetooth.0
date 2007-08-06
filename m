Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <d5920d1e0708060931p3f4a6a81n7e4f359754e57df9@mail.gmail.com>
Date: Mon, 6 Aug 2007 18:31:54 +0200
From: "Hamid MENOUAR" <menouar@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <d5920d1e0708030011sf85f0cbrbeff1a7f3836f32d@mail.gmail.com>
MIME-Version: 1.0
References: <d5920d1e0708010151h1610b190vb7618b71686cba05@mail.gmail.com>
	<57c68ddc0708010345u73c7482esff100f76b20646fc@mail.gmail.com>
	<d5920d1e0708022327v665d3c02gc8799485d896d459@mail.gmail.com>
	<57c68ddc0708022330obca2bdds2d21bdda830db6b4@mail.gmail.com>
	<d5920d1e0708030011sf85f0cbrbeff1a7f3836f32d@mail.gmail.com>
Subject: Re: [Bluez-users] Module bluez not found
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

I tried with FC4 and with Debian as well and I got the same thing,

> [hmeno@dhcp28 hmeno]$ hcitool scan
> Scanning ...
> Inquiry failed: Connection timed out

I think some thing is missing in my installation way or my USB adaptor
which is not working well, but I have already tried id with Windows
and it worked very well !!

So, can somebody help me and explain me, step by step, how to make
bluez (or how to make my bluetooth USB adaptor) works  ?

Thank you very much for your help,
Menouar

On 8/3/07, Hamid MENOUAR <menouar@gmail.com> wrote:
> Here is the output
>
> [root@localhost root]# modprobe hci_usb
> [root@localhost root]# modprobe rfcomm
> [root@localhost root]# hciconfig hci0 up
> [root@localhost root]# hciconfig
> hci0:   Type: USB
>         BD Address: 00:16:38:CA:56:A8 ACL MTU: 1017:8  SCO MTU: 64:1
>         UP RUNNING
>         RX bytes:195 acl:0 sco:0 events:29 errors:0
>         TX bytes:886 acl:0 sco:0 commands:29 errors:0
>
> [root@localhost root]# hcitool scan
> Scanning ...
> Inquiry failed: Connection timed out
> [root@localhost root]#
>
>
>
> On 8/3/07, siddhant tewari <siddhant.tewari@gmail.com> wrote:
> > what is the output of hciconfig
> >
> >
> > On 8/3/07, Hamid MENOUAR <menouar@gmail.com> wrote:
> > >
> > > Thank you for your answer.
> > >
> > > Even when doing that, still no devices is detected when scanning
> > > (hcitool scan) !!
> > >
> > > Regards,
> > > Menouar
> > >
> > > On 8/1/07, siddhant tewari < siddhant.tewari@gmail.com> wrote:
> > > > u should try
> > > > modprobe hci_usb
> > > > modprobe rfcomm
> > > >
> > > > then run
> > > > hciconfig hci0 up (only one dongle attached)
> > > >
> > > > then
> > > > hcitool scan (if near by devices are scanned succesfully then part of
> > > > bluetooth system is working fine)
> > > >
> > > > now for sending and recieving files you should try searching in mail
> > > > archive.....
> > > >
> > > > regards
> > > > siddhant
> > > >
> > > >
> > > >
> > > > On 8/1/07, Hamid MENOUAR < menouar@gmail.com> wrote:
> > > > >
> > > > > Dear all,
> > > > >
> > > > > In order to use Bluez to connect some bluetooth device on my computer,
> > > > > I have installed on my Linux FC2 the four following packages
> > > > > (bluez-libs, bluez-utils, bluez-firmware, bluez-hcidump).
> > > > >
> > > > > And, when trying to load the Bluez module manually by doing "modprobe
> > > > > bluez" it says "FATAL: Module bluez not found."
> > > > >
> > > > > Could anyone help me to explain and solve this?
> > > > >
> > > > > Thank you in advance,
> > > > > Menouar
> > > > >
> > > > >
> > > >
> > -------------------------------------------------------------------------
> > > > > This SF.net email is sponsored by: Splunk Inc.
> > > > > Still grepping through log files to find problems?  Stop.
> > > > > Now Search log events and configuration files using AJAX and a
> > browser.
> > > > > Download your FREE copy of Splunk now >>   http://get.splunk.com/
> > > > > _______________________________________________
> > > > > Bluez-users mailing list
> > > > > Bluez-users@lists.sourceforge.net
> > > > >
> > https://lists.sourceforge.net/lists/listinfo/bluez-users
> > > > >
> > > >
> > > >
> > > >
> > -------------------------------------------------------------------------
> > > > This SF.net email is sponsored by: Splunk Inc.
> > > > Still grepping through log files to find problems?  Stop.
> > > > Now Search log events and configuration files using AJAX and a browser.
> > > > Download your FREE copy of Splunk now >>   http://get.splunk.com/
> > > > _______________________________________________
> > > > Bluez-users mailing list
> > > > Bluez-users@lists.sourceforge.net
> > > >
> > https://lists.sourceforge.net/lists/listinfo/bluez-users
> > > >
> > > >
> > >
> > >
> > -------------------------------------------------------------------------
> > > This SF.net email is sponsored by: Splunk Inc.
> > > Still grepping through log files to find problems?  Stop.
> > > Now Search log events and configuration files using AJAX and a browser.
> > > Download your FREE copy of Splunk now >>   http://get.splunk.com/
> > > _______________________________________________
> > > Bluez-users mailing list
> > > Bluez-users@lists.sourceforge.net
> > > https://lists.sourceforge.net/lists/listinfo/bluez-users
> > >
> >
> >
> > -------------------------------------------------------------------------
> > This SF.net email is sponsored by: Splunk Inc.
> > Still grepping through log files to find problems?  Stop.
> > Now Search log events and configuration files using AJAX and a browser.
> > Download your FREE copy of Splunk now >>  http://get.splunk.com/
> > _______________________________________________
> > Bluez-users mailing list
> > Bluez-users@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/bluez-users
> >
> >
>

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
