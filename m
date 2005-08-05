Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Possible security vulnerability in hcid when
	calling pin helper
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20050805050932.3111586d.henryk@ploetzli.ch>
References: <20050805050932.3111586d.henryk@ploetzli.ch>
Content-Type: text/plain
Message-Id: <1123211794.8331.104.camel@pegasus>
Mime-Version: 1.0
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
Date: Fri, 05 Aug 2005 05:16:34 +0200

Hi Henryk,

> (I'm using a Gentoo Linux box with kernel 2.6.12.1, hcid 2.18 and
> kbluepin from kbluetoothd 0.99-beta1; although the problem seems 
> to still exist in current CVS hcid and should be independent of 
> the pin helper used.)
> 
> I just stumbled upon a bug in hcid that can possibly be used as a
> security vulnerability: In hcid/security.c (around line 335 in current
> CVS) the device name from the remote device is copied straight into the
> command line that is used to call the pin helper, only surrounded by a
> pair of single quotes with _no_ _escaping_ done:
> 
> | read_device_name(sba, &ci->bdaddr, name);
> | //hci_remote_name(dev, &ci->bdaddr, sizeof(name), name, 0);
> |
> | ba2str(&ci->bdaddr, addr);
> | snprintf(str, sizeof(str), "%s %s %s \'%s\'", hcid.pin_helper,
> |                                 ci->out ? "out" : "in", addr, name);
> 
> At the very least this leads to failures when the remote device uses
> single quotes in its name. E.g. something like "Henryk's Phone" (without 
> the double quotes) will give 
> 
> Aug  5 03:41:03 gleam hcid[24398]: PIN helper exited abnormally with code 512
> 
> in the syslog and 
> 
> sh: -c: line 0: unexpected EOF while looking for matching `''
> sh: -c: line 1: syntax error: unexpected end of file
> 
> at stderr when running hcid -n (this is how I originally found the 
> problem).
> 
> However, something more creative like "';touch '/tmp/foo23" (again 
> without the double quotes) will actually execute a program on the 
> attacked box (and create a file /tmp/foo23 in this case). For 
> reference: in strace this looks like this:
> 
> execve("/bin/sh", ["sh", "-c", "/usr/lib/kdebluetooth/kbluepin out 00:0E:ED:00:23:42 \'\';touch \'/tmp/foo23\'"], [/* 62 vars */]) = 0
> 
> (note that the conversion from ' to \' was done by strace)
> 
> Using this vulnerability one can also create pairings without approval
> of the user: Setting the bluetooth device name to something like
> "'>/dev/null&echo 'PIN:42" (without the double quotes) and then trying 
> to create a pairing with a bluez box will override the decision of the 
> pin helper and always set 42 as the PIN.
> 
> PS: Thanks to roh and Sascha from the CCC Berlin.

thanks for catching this problem. Do you have a fix for it?

Regards

Marcel




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
