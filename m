Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <43D0066A.6030803@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] libsbc refactoring
References: <C70061B183DE09419568AB2060C52A95017EAF33@arion.intra.local>	 <43CFC015.80005@xmission.com> <1137705822.393.4.camel@localhost.localdomain>
In-Reply-To: <1137705822.393.4.camel@localhost.localdomain>
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
Date: Thu, 19 Jan 2006 14:36:42 -0700

Victor

I will roll it back if we know that is happening with gcc.

If it isn't too hard to modify the arm assembly for doing the basic ops
using an int64_t instead of the int32_t/uint32_t I'd like to see that.

Where should I pick up with the 32-bit code? I think I saw this in a header

#define SP4(val) (val >> SCALE_PROTO4_TBL)

and I was thinking it should look more like

#define SP4(val) (((int32_t)val)/(1<<SCALE_PROTO4_TBL))

To preserve negative values. Does that seem reasonable? I didn't do
anything with this idea yet.

I think the (int32_t) cast was necessary because the tables use a
positive-looking hex constant for negative values.

Brad

> I think (may be mistakenly) gcc does not use all the optimizations, only
> generic ones and, probably, the 32x32 -> 64 register multiplication is
> not among them. It might be that the arm compiler does this kind of
> optimizations, but it needs licensing I guess.
> 
> Regards,
>     Victor.


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
