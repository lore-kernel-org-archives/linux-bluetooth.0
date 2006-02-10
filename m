Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <43ECB0D4.0@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Re: btsco with an HP embedded bluetooth adapter
References: <495ce9180602080745y146974c4t@mail.gmail.com>	 <495ce9180602080858i118c037ap@mail.gmail.com>	 <43EB9B59.1010107@xmission.com> <495ce9180602100543q4f65bef3p@mail.gmail.com>
In-Reply-To: <495ce9180602100543q4f65bef3p@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
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
Date: Fri, 10 Feb 2006 08:27:16 -0700

Mario

>>Did you try this patch?
>>
>>http://sourceforge.net/mailarchive/message.php?msg_id=14450798
> 
> 
> I've tried it (but I've to say that I forgot to recompile the
> snd-bt-sco module; is it important?) without success.  Should I see a
> different output of 'hciconfig hci0 revision' with this patch?

the patch only modifies the low-level bluetooth module (offhand not sure
which). but it will require you to make modules_install to overwrite the
old modules

> 
> root@legolas:~# hciconfig hci0 revision
> hci0:   Type: USB
>         BD Address: 00:10:C6:59:7A:FC ACL MTU: 377:10 SCO MTU: 16:0
>         Firmware 2.105 / 97

this won't change. (I updated the bluetooth-alsa.sf.net page to link to
the patch by the way)

> 
> Is my Broadcom chipset supported or not? :|
> 
> If you say that this patch could work, I can try a second time.

it might work with this fix, but I've only heard one success story so
far (from the patch author)

Brad


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
