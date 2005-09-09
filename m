Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <43217888.9030902@csr.com>
From: Steven Singer <steven.singer@csr.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] sbc decoder unrolled
References: <43211F8F.5030607@xmission.com>
In-Reply-To: <43211F8F.5030607@xmission.com>
Content-Type: text/plain; charset="us-ascii"
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
Date: Fri, 09 Sep 2005 12:56:56 +0100

Brad Midgley wrote:
>                       It's even more clear that the implementation they 
> illustrate in the spec is meant to make the algorithm clear but not be 
> an efficient way to do it.

This is definitely true.

The spec allows you complete flexibility on your implementation. You're
not even obliged to use the algorithm in the spec. You need make sure
only that the errors between the outputs of your encoder and decoder and
the outputs of the reference encoder and decoder are less than a
threshold. (For qualification, they talk about the decoder having a K
value which needs to be greater than 14).

If you have a program that can calculate K, then I suggest that a
suitable regression test is to measure the K values of the reference
test inputs between:

  output of reference encoder + reference decoder

and each of:

  output of reference encoder + your decoder (spec requires K > 14)
  output of your encoder + reference decoder
  output of your encoder + your decoder

This gives you much more optimisation flexibility than requiring an
identical output bit stream.

As well as measuring K, you should also listen to the outputs -
otherwise you may have a bug that sounds bad but somehow manages to
pass the K test.

Remember SBC is a lossy codec, it'd be pointless to try too hard to
precisely reproduce the losses of the reference codec.

	- Steven
-- 


**********************************************************************
This email and any files transmitted with it are confidential and
intended solely for the use of the individual or entity to whom they
are addressed. If you have received this email in error please notify
the system manager.

**********************************************************************



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
