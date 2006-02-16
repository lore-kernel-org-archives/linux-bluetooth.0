Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <43F4BED6.5010802@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] snd-bt-sco and internal broadcom adapter
References: <1140016859.5595.25.camel@localhost.localdomain>
In-Reply-To: <1140016859.5595.25.camel@localhost.localdomain>
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
Date: Thu, 16 Feb 2006 11:05:10 -0700

Erik

Thanks for the response. The patch is a proof of concept... I believe
Marcel is cooking up a way for it to fit in more cleanly. Hopefully
broadcom will work out of the box soon :)

Brad

> I have a Lenovo x41 laptop with an internal bluetooth-adapter from
> broadcom. Applying "patch to force sco mtu values" from the
> bluetooth-alsa project page enabled me to use my Jabra BT205-headset.
> Before applying the patch recording from the headset worked, but i could
> not send any sound to it (hciconfig reported TX sco: 0).
> 
> Kernel used: 2.6.15.3
> 
> //Erik


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
