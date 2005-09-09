Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4321D8A0.6030103@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] sbc decoder unrolled
References: <C70061B183DE09419568AB2060C52A950E449C@arion.intra.local>
In-Reply-To: <C70061B183DE09419568AB2060C52A950E449C@arion.intra.local>
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
Date: Fri, 09 Sep 2005 12:46:56 -0600

Victor,

I was hoping to have regression tests as a regular makefile target... 
it's just more of a pain when it requires shipping stuff around.

However, if we are willing to assume that our floating point 
implementations are correct enough to be our own golden standard, then 
it is pretty straightforward to make a special target that builds both 
and compares them.

Brad

Victor Shcherbatyuk wrote:
> Brad,
> 
> But why is it a problem? The result of encoding/decoding is save to a file - we compare files... So we run reference encoder under windows (or using wine under linux) and then run our stuff under linux, and compare the results obtained using windows reference ebcoder/decoder?
> 
> Regards,
>      Victor.
> 
> 
> -----Original Message-----
> From: bluez-devel-admin@lists.sourceforge.net on behalf of Brad Midgley
> Sent: Fri 9/9/2005 7:59 PM
> To: bluez-devel@lists.sourceforge.net
> Subject: Re: [Bluez-devel] sbc decoder unrolled
>  
> Steven
> 
> 
>>  output of reference encoder + your decoder (spec requires K > 14)
>>  output of your encoder + reference decoder
>>  output of your encoder + your decoder
> 
> 
> There is a little gotcha here in that we only have a windows binary for 
> a reference encoder/decoder. I haven't tried to build our stuff in 
> cygwin or windows dev tools and there are probably things to fix...
> 
> Brad
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
> 


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
