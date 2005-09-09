Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <43211F8F.5030607@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: [Bluez-devel] sbc decoder unrolled
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
Date: Thu, 08 Sep 2005 23:37:19 -0600

Hey

woohoo... I worked over the decoder a lot more and finally unrolled & 
committed it. It still uses floating point for now.

I was very proud of the fact that I found a way to rotate which 
sbc_proto_x_x0 value we choose rather than shifting matrixed values 
around in every loop. It's even more clear that the implementation they 
illustrate in the spec is meant to make the algorithm clear but not be 
an efficient way to do it.

I don't know how the instruction cache size in arm compares to x86. I 
haven't checked to see yet if unrolling is as big a win on xscale. fwiw, 
it cut x86 cpu use by about 50% over the looped code.

I'll look at fixed point next.

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
