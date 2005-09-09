Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <43218AF9.1030005@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] sbc decoder unrolled
References: <C70061B183DE09419568AB2060C52A95C7C4B7@arion.intra.local>
In-Reply-To: <C70061B183DE09419568AB2060C52A95C7C4B7@arion.intra.local>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Fri, 09 Sep 2005 07:15:37 -0600

Victor,

Yeah, the only thing I didn't like about it is adding a bunch of 
computed array index and index modulo operations... I think we end up 
coming out ahead but I didn't test it specifically.

I could also double the size of sbc_proto_x_x0 and then I wouldn't have 
to worry about the modulo ops wrapping around our indexing into it. That 
will hurt any kind of caching of the array however.

Brad

Victor Shcherbatyuk wrote:
> Brad,
> 
> I'll check if I can do the same for the encoder, getting rid of that
> array shifting might speed up the stuff (well, it will probably add some
> array index operations which might make things worse, but we will see).
> 
> Regards,
>     Victor.
> 
> -----Original Message-----
> From: bluez-devel-admin@lists.sourceforge.net
> [mailto:bluez-devel-admin@lists.sourceforge.net] On Behalf Of Brad
> Midgley
> Sent: Friday, September 09, 2005 7:37 AM
> To: BlueZ Mailing List
> Subject: [Bluez-devel] sbc decoder unrolled
> 
> Hey
> 
> woohoo... I worked over the decoder a lot more and finally unrolled &
> committed it. It still uses floating point for now.
> 
> I was very proud of the fact that I found a way to rotate which
> sbc_proto_x_x0 value we choose rather than shifting matrixed values
> around in every loop. It's even more clear that the implementation they
> illustrate in the spec is meant to make the algorithm clear but not be
> an efficient way to do it.
> 
> I don't know how the instruction cache size in arm compares to x86. I
> haven't checked to see yet if unrolling is as big a win on xscale. fwiw,
> it cut x86 cpu use by about 50% over the looped code.
> 
> I'll look at fixed point next.
> 
> Brad
> 
> 
> -------------------------------------------------------
> SF.Net email is Sponsored by the Better Software Conference & EXPO
> September 19-22, 2005 * San Francisco, CA * Development Lifecycle
> Practices Agile & Plan-Driven Development * Managing Projects & Teams *
> Testing & QA Security * Process Improvement & Measurement *
> http://www.sqe.com/bsce5sf
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
> 
> 
> This e-mail message contains information which is confidential and may be privileged. It is intended for use by the addressee only. If you are not the intended addressee, we request that you notify the sender immediately and delete or destroy this e-mail message and any attachment(s), without copying, saving, forwarding, disclosing or using its contents in any other way. TomTom N.V., TomTom International BV or any other company belonging to the TomTom group of companies will not be liable for damage relating to the communication by e-mail of data, documents or any other information.
> 
> 
> -------------------------------------------------------
> SF.Net email is Sponsored by the Better Software Conference & EXPO
> September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
> Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
> Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
