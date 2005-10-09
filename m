Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <43493BFD.1060300@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Nokia 770 and bluetooth audio
References: <4346F84D.8050004@xmission.com> <1128774836.5212.4.camel@blade>	 <4348AF2B.4030301@xmission.com>  <1128849280.15821.7.camel@blade> <1128860708.8700.12.camel@localhost.localdomain>
In-Reply-To: <1128860708.8700.12.camel@localhost.localdomain>
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
Date: Sun, 09 Oct 2005 09:49:17 -0600

Victor

> It would be nice to have at least a piece of advise from those
> mysterious people who tell all those things about the optimization :)

as far as the algorithm goes, I decided for the decoder that there were 
basically two paths you could go down for optimizing:

  - keep the shifting of values around in each pass and unroll the loops 
(in this case referencing the tables is optimized by the compiler to 
literal values so unrolling eliminates an array access)

  - eliminate the shifting of values and don't unroll the loop, just 
simplify the array index computations (the table access is different in 
each pass depending on where the data would have been shifted around to 
so unrolling is no win)

I ended up moving 8-subbands to the latter and I will move 4 too.

For the decoder it's moot since anyone serious about decoding will be 
doing it in CSR silicon, but there may be a parallel in the encoder.

Brad


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
