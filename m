Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <47320355.7020600@gmail.com>
Date: Wed, 07 Nov 2007 15:26:29 -0300
From: Manuel Naranjo <naranjo.manuel@gmail.com>
MIME-Version: 1.0
To: Olivier Le Pogam <olepogam@free.fr>,
        BlueZ development <bluez-devel@lists.sourceforge.net>
References: <000001c8212f$58c2cc80$0a486580$@savary@kerlink.fr>
	<00ef01c8214f$1f9cc580$0200a8c0@jester>
In-Reply-To: <00ef01c8214f$1f9cc580$0200a8c0@jester>
Subject: Re: [Bluez-devel] Bluez libs 3.22 & hci_read_remote_name
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

I had seen the same problem, but by doing "hcitool scan". I have a piece
of code in C that does scanning (based on the web site example) and it
doesn't seem to be having the same problem.

Maybe hci_* functions had started failing? And it's time to move to D-BUS?

D-BUS is a great solution, I really like it, I had my first experience
with it during the weekend, and it's much better than calling libbluez
directly, but AFAIK there's no way to open an rfcomm channel and wait
for connections. So moving to D-BUS is not 100% applicable yet.

Thanks
Manuel
> I have big problems making "hci_read_remote_name" work using libs 3.22, it 
> is very long or blocking.
> I had to roll back to 3.20 which is working fine.
> I have 4 dongles on my computer, maybe has there been a change on 
> multi-devices in 3.22 ?
> If you need me to investigate further just ask me what to do and I'll 
> provide you with more details.
>   


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
