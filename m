Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <43CFC015.80005@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] libsbc refactoring
References: <C70061B183DE09419568AB2060C52A95017EAF33@arion.intra.local>
In-Reply-To: <C70061B183DE09419568AB2060C52A95017EAF33@arion.intra.local>
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
Date: Thu, 19 Jan 2006 09:36:37 -0700

Victor

> I think there were macros relying on the copiler to handle 64-bit math
> and, as I remember, it was 2 times slower than arm specific code. But
> I'll check anyway. Altough 32-bit math should be enough, but it probably
> needs some good thinking and smart tricks (or may be not).

I want to have a look at unifying on 32-bit but I was hoping this would
be ok to clean things up a bit.

I can see why assembly would be better than working with two 32-bit
values. You don't have a way to get at the add-with-carry assembly
instruction for example. But the compiler has got to be doing something
wrong if basic math ops on a native c type (int64_t) are only half as
fast as hand-coded assembly. :(

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
