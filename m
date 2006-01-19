Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] libsbc refactoring
From: Victor Shchebatyuk <victor@win.tue.nl>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <43CFC015.80005@xmission.com>
References: <C70061B183DE09419568AB2060C52A95017EAF33@arion.intra.local>
	 <43CFC015.80005@xmission.com>
Content-Type: text/plain
Message-Id: <1137705822.393.4.camel@localhost.localdomain>
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
Date: Thu, 19 Jan 2006 22:23:42 +0100

Brad

I think (may be mistakenly) gcc does not use all the optimizations, only
generic ones and, probably, the 32x32 -> 64 register multiplication is
not among them. It might be that the arm compiler does this kind of
optimizations, but it needs licensing I guess.

Regards,
    Victor.

On Thu, 2006-01-19 at 09:36 -0700, Brad Midgley wrote:
> Victor
> 
> > I think there were macros relying on the copiler to handle 64-bit math
> > and, as I remember, it was 2 times slower than arm specific code. But
> > I'll check anyway. Altough 32-bit math should be enough, but it probably
> > needs some good thinking and smart tricks (or may be not).
> 
> I want to have a look at unifying on 32-bit but I was hoping this would
> be ok to clean things up a bit.
> 
> I can see why assembly would be better than working with two 32-bit
> values. You don't have a way to get at the add-with-carry assembly
> instruction for example. But the compiler has got to be doing something
> wrong if basic math ops on a native c type (int64_t) are only half as
> fast as hand-coded assembly. :(
> 
> Brad
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
> for problems?  Stop!  Download the new AJAX search engine that makes
> searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
