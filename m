Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <20050422050216.50183.qmail@web8303.mail.in.yahoo.com>
From: Mayank Batra <mayankbatra@yahoo.co.in>
To: BLUEZ DEVELOPERS LIST <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Subject: [Bluez-devel] a2play code not according to the specifications
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
Date: Fri, 22 Apr 2005 06:02:16 +0100 (BST)

Hi Brad,

Your a2play code on the CVS is not 'exactly' according
to the specifications.

The specifications demand that the source encodes the
media payload into an appropriate format (SBC in this
case) and then stream the packet to the sink. The sink
then decodes the packet and plays the stream.

But in your code, you are sending an already encoded
file instead of streaming a simple PCM file by
encoding the file into SBC frames in a real time
manner.

Infact there is no use of storing SBC files at the
source. The source should read the PCM file (for
example a .wav or .snd file), encode the data into SBC
and then form the A2DP packet. 

And who the hell has .sbc files on his system ??

I improved your code to fulfill the above
requirements. My code does exactly what a2play code
does. The only difference is that my code reads a pcm
format file(.snd file which is Sun/NeXT format), it
converts the file to SBC packets during the streaming
process.

So the source need not keep .sbc file on his system. 

A .snd file can be listened to using the Linux
application called 'play'.

I am using the SBC codec library from the CVS.

I have tested my code with the help of Dongles with
various stacks:

1)   BlueZ stacks on both source and sink.
2)   BlueZ stack on source and IVT Corporation's
BlueSoleil on the sink side (Windows)

My code is working fine in all cases.

Please tell me if you would like to update the CVS
with my code.

Also, I am ready to put up the A2DP sink code on the
CVS.

Please tell if you would like to put it on the CVS as
well.

And please, I intended no offence to anyone. I was
just waiting to get over with certain formalities.

Thanks and Regards,

Mayank

________________________________________________________________________
Yahoo! India Matrimony: Find your life partner online
Go to: http://yahoo.shaadi.com/india-matrimony


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
