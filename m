Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <43EB9B59.1010107@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Re: btsco with an HP embedded bluetooth adapter
References: <495ce9180602080745y146974c4t@mail.gmail.com> <495ce9180602080858i118c037ap@mail.gmail.com>
In-Reply-To: <495ce9180602080858i118c037ap@mail.gmail.com>
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
Date: Thu, 09 Feb 2006 12:43:21 -0700

Mario

> I've just read that the Broadcom chipsets are unsupported by the SCO
> linux driver. This is a real mess. I have another question: why I'm
> able to use it as microphone without any problem (I can record my
> voice!), but I'm not able to hear anything through the BT headphone?

Maybe the mtu is only messed up for adapter->headset traffic.

Did you try this patch?

http://sourceforge.net/mailarchive/message.php?msg_id=14450798

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
