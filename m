Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <430351BD.7090100@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] SBC Fixed Point for A2Dp
References: <013e01c5a30a$b9329eb0$050aa8c0@gateway>
In-Reply-To: <013e01c5a30a$b9329eb0$050aa8c0@gateway>
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
Date: Wed, 17 Aug 2005 09:03:25 -0600

Roberto

> I have read some transcoding to SBC fixed point somewhere , do you know 
> where become available ? We are working on a mobile version of A2DP with 
> headphones for Symbian and we would like to port this part of code 
> to mobile and deliver the library under LGPL

I hope you are able to help us with this. We currently have no 
implementation. Victor Shcherbatyuk has been tinkering with fixed point 
but was getting noisy audio last I heard and has not contributed 
anything yet.

If you look in sbc/sbc.h, you'll see some fixed point functions like 
fxmult and conversion functions. Currently, the precision is set to 20 
bits. This is probably not enough, but after you change it to get more 
precision, the fixed point tables in sbc_tables_f.h need to be 
regenerated; build gen_fixed.c by hand and run

./gen_fixed > sbc_tables_f.h

to do that.

Can I help in any other way?

thanks!
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
