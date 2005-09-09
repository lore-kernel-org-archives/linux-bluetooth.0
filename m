Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <43219928.5050507@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] sbc decoder unrolled
References: <43211F8F.5030607@xmission.com> <43217888.9030902@csr.com>
In-Reply-To: <43217888.9030902@csr.com>
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
Date: Fri, 09 Sep 2005 08:16:08 -0600

Steven,

> threshold. (For qualification, they talk about the decoder having a K
> value which needs to be greater than 14).

I had given up on regression tests for accuracy and performance because 
I didn't know about K values and I figured x86 performance might 
actually go down for fixed point (Victor confirmed this)

Google isn't helping me find much about K value this morning but I would 
like to put a regression test in the build if we find something...

> As well as measuring K, you should also listen to the outputs -
> otherwise you may have a bug that sounds bad but somehow manages to
> pass the K test.

Yes... the only thing worse than listening to the reference streams for 
the thousandth time is listening to the reference streams again with 
some new distortion introduced. I ended up encoding some music snipets 
for testing that I (used to) like to listen to :)

thanks for the input

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
