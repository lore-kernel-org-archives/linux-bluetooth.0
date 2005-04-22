Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <42688D3A.5010808@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] a2play code not according to the specifications
References: <20050422050216.50183.qmail@web8303.mail.in.yahoo.com>
In-Reply-To: <20050422050216.50183.qmail@web8303.mail.in.yahoo.com>
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
Date: Thu, 21 Apr 2005 23:35:54 -0600

Mayank

> Your a2play code on the CVS is not 'exactly' according
> to the specifications.
> 
> But in your code, you are sending an already encoded
> file instead of streaming a simple PCM file by
> encoding the file into SBC frames in a real time
> manner.

it was written as a proof of concept. it actually doesn't work well at 
all if you give it a raw sbc file because it's not paced correctly. it 
works most consistently if it's used like

mpg123 --au - file.mp3 | sbc/sbcenc - | ./a2play bdaddr

we count on mpg123 to enforce timing correctly, but even then, a2play 
can block the pipeline and mess up the timing, for example if the link 
is lossy.

> Infact there is no use of storing SBC files at the
> source. The source should read the PCM file (for
> example a .wav or .snd file), encode the data into SBC
> and then form the A2DP packet. 

agreed

> I improved your code to fulfill the above
> requirements. My code does exactly what a2play code
> does. The only difference is that my code reads a pcm
> format file(.snd file which is Sun/NeXT format), it
> converts the file to SBC packets during the streaming
> process.
> 
> Please tell me if you would like to update the CVS
> with my code.

yes, definitely. if it's very big, email it to me directly.

to maintain license compatibility, we want (especially avdtp) code 
contributions to be GPL so they could go into the kernel if appropriate. 
is that license ok with you?

> Also, I am ready to put up the A2DP sink code on the
> CVS.
> 
> Please tell if you would like to put it on the CVS as
> well.

very good! yes.

> And please, I intended no offence to anyone. I was
> just waiting to get over with certain formalities.

understood. i don't think anyone took offense. i mainly wanted you to 
feel that we are interested in helping you and working together. you 
shouldn't feel like you've reached a dead end.

very cool.

Brad


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
