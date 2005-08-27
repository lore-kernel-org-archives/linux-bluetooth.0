Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <430FD78A.6070507@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] sbc and fixed-point progress
References: <C70061B183DE09419568AB2060C52A95B73437@arion.intra.local>
In-Reply-To: <C70061B183DE09419568AB2060C52A95B73437@arion.intra.local>
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
Date: Fri, 26 Aug 2005 21:01:30 -0600

Victor

> The _anamatrix8[] and _sbc_proto_8[] are  extracted from anamatrix8[][]
> and sbc_proto_8_80[]. 
> Basically what I did is, made loop unrolling, then the rearanged
> resulting code minimizing the number of multiplies

wow. you the man as they say.

FYI I stubbed in the fixed-point 4 subband stuff for now but I'd 
eventually like to see it in there. Curently it may not behave right 
when you build with USE_FIXED and then encode with 4 subbands (it tries 
to use floating point)

I don't know if you've used 4 subbands much, but it sounds quite 
respectable and it would allow us to scale down to some of the 
smallest/slowest embedded processors out there (memory permitting).

> P.S. There is a bug in general code of SUB64 (not much  influencing the
> final result). I'll check in fix this weeken and also I did some
> cleaning up of my code and added arm assembly for ADD64, SUB64. I still
> plan to modify joint stereo code in sbc_pack_frame()  (as there are some
> floating point ops still remain there) sbc_init() (and a2play) to accept
> encoder parameters like nr. of subbands, bit pool and so on.

you probably saw that a2play has some rough options for encoder params, 
jut the -t (thrifty) flag.

> P.P.S. I'm also thinking to merge floating point and fixed point filter
> code, so USE_FIXED will decide which macro to use floating or fixed
> (general|arm). Btw, I also think it is quite easy to implement 32 bit
> version this way.

nice

Brad


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
