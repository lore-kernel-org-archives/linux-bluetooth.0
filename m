Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <d5920d1e0707300303v10b288cenb541b18e69094b2b@mail.gmail.com>
Date: Mon, 30 Jul 2007 12:03:42 +0200
From: "Hamid MENOUAR" <menouar@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <46AA3BA3.2080102@gmail.com>
MIME-Version: 1.0
References: <d5920d1e0707270800g1ca7d171jae107615f0c19cd1@mail.gmail.com>
	<46AA3BA3.2080102@gmail.com>
Subject: Re: [Bluez-users] no bluetooth devices is detected
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

Thank you for your answer,
I just tried to make "hciconfig hci0 reset" as you said but it says
that "can't init device hci0. Connection timed out(110)"

in follow what I got on my teminal :


 >[root@localhost root]# hciconfig hci0 reset
 >Can't init device hci0. Connection timed out(110)
 >[root@localhost root]#
 >[root@localhost root]# hciconfig
 >hci0:   Type: USB
 >        BD Address: 00:16:38:CA:56:A8 ACL MTU: 1017:8  SCO MTU: 64:1
 >        DOWN
 >        RX bytes:111 acl:0 sco:0 events:15 errors:0
 >        TX bytes:318 acl:0 sco:0 commands:16 errors:0
 >[root@localhost root]#
 >[root@localhost root]# hciconfig hci0 up
 >Can't init device hci0. Connection timed out(110)
 >[root@localhost root]#



What can I do to fix the problem ?

Thanks in advance
Menouar




On 7/27/07, Xamindar <junkxamindar@gmail.com> wrote:
>
>  Try running "hciconfig hci0 reset" and see if you can scan after that.  My dell bluetooth started doing exactly what you describe when I upgraded my bluez to a more recent version.  Too bad, I have to have this workaround in my local startup script and also in my resume from hibernation script.  But lots of people are starting to have this problem so hopefully they will fix it soon.
>
>  Hamid MENOUAR wrote:
>
> Dear bluez users,
>
>  In order to make my laptop (OS: Fedora Core 2) communicate with some bluetooth device through an ANYCOM Bluetooth USB Adapter, I have installed the Bluez packages (bluez-libs bluez-libs bluez-utils bluez-hcidump bluez-utils-cups).
>
>  But, when trying to detect nearby active bluetooth devices, using "hcitool scan" non of the devices are detected, wheras the same configuration works very well with windows.
>
>  so, that's what I get on my terminal:
>
>
> >[root@localhost root]# hciconfig
>  >hci0:   Type: USB
>  >        BD Address: 00:16:38:CA:56:A8 ACL MTU: 1017:8  SCO MTU: 64:1
>  >        UP RUNNING
>  >        RX bytes:93 acl:0 sco:0 events:12 errors:0
>  >        TX bytes:296 acl:0 sco:0 commands:12 errors:0
>  >
>  >[root@localhost root]# hcitool scan
>  >Scanning ...
>  >Inquiry failed: Connection timed out
>
>  One more thing is that, when loading the bluez module it says that the module is not found
>
>
> >[root@localhost root]# modprobe bluez
>
> >FATAL: Module bluez not found.
>
>
>  It would be very much helpful if someone knows how to solve the problem.
>
>  Thanks so much in advance,
>  Menouar
>
>    ________________________________

> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc.
> Still grepping through log files to find problems?  Stop.
> Now Search log events and configuration files using AJAX and a browser.
> Download your FREE copy of Splunk now >>  http://get.splunk.com/
>    ________________________________

> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>
>
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc.
> Still grepping through log files to find problems?  Stop.
> Now Search log events and configuration files using AJAX and a browser.
> Download your FREE copy of Splunk now >>  http://get.splunk.com/
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>
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
