Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <495ce9180602150202m3fcf8e93v@mail.gmail.com>
From: Mario <mario.temporary@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Re: Developing Broadcom driver support
In-Reply-To: <43F0C174.2060909@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <e44ae5e0602111105n6bacb4e8i@mail.gmail.com>
	 <43F0C174.2060909@xmission.com>
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
Date: Wed, 15 Feb 2006 11:02:04 +0100

I have to say that usually fix "hciconfig hci0 scomtu 64:8" usually
works but sometime it stops to work. It is not so stable and I have to
use the command every time.


2006/2/13, Brad Midgley <bmidgley@xmission.com>:
>  http://bluetooth-alsa.sourceforge.net/sco-mtu.patch

This kind of patch (I've tried to use the constants 64 & 8) seems to
work not good as the command-line fix.

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
