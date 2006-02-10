Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <495ce9180602100543q4f65bef3p@mail.gmail.com>
From: Mario <mario.temporary@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Re: btsco with an HP embedded bluetooth adapter
In-Reply-To: <43EB9B59.1010107@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <495ce9180602080745y146974c4t@mail.gmail.com>
	 <495ce9180602080858i118c037ap@mail.gmail.com>
	 <43EB9B59.1010107@xmission.com>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 10 Feb 2006 14:43:54 +0100

2006/2/9, Brad Midgley <bmidgley@xmission.com>:
> Maybe the mtu is only messed up for adapter->headset traffic.
>
> Did you try this patch?
>
> http://sourceforge.net/mailarchive/message.php?msg_id=3D14450798

I've tried it (but I've to say that I forgot to recompile the
snd-bt-sco module; is it important?) without success.  Should I see a
different output of 'hciconfig hci0 revision' with this patch?

root@legolas:~# hciconfig hci0 revision
hci0:   Type: USB
        BD Address: 00:10:C6:59:7A:FC ACL MTU: 377:10 SCO MTU: 16:0
        Firmware 2.105 / 97

Is my Broadcom chipset supported or not? :|

If you say that this patch could work, I can try a second time.

Thanks for your reply.
Mario


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
