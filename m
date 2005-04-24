Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <20050424121342.69329.qmail@web8301.mail.in.yahoo.com>
From: Mayank Batra <mayankbatra@yahoo.co.in>
Subject: Re: [Bluez-devel] a2play code not according to the specifications
To: bluez-devel@lists.sourceforge.net
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
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
Date: Sun, 24 Apr 2005 13:13:42 +0100 (BST)

Brad,

> it was written as a proof of concept. it actually
> doesn't work well at 
> all if you give it a raw sbc file because it's not
> paced correctly. it 
> works most consistently if it's used like
> 
> mpg123 --au - file.mp3 | sbc/sbcenc - | ./a2play
> bdaddr

The current code has good timing just because of the
fact that the delay due to encoding during streaming
is good for us.
 
> we count on mpg123 to enforce timing correctly, but
> even then, a2play 
> can block the pipeline and mess up the timing, for
> example if the link 
> is lossy.

We no more need mpg123 if we have ecasound.
Use:
ecasound -i file.mp3 -o file.snd

Now use ./a2play <bdaddr> <.snd filename>

And enjoy the music on ur A2DP headset !


> to maintain license compatibility, we want
> (especially avdtp) code 
> contributions to be GPL so they could go into the
> kernel if appropriate. 
> is that license ok with you?

Fine

> 
> > Also, I am ready to put up the A2DP sink code on
> the
> > CVS.
> > 
> > Please tell if you would like to put it on the CVS
> as
> > well.
> 
> very good! yes.

Just wait for some more time.
I am now correcting the things that u mentioned in the
earlier mail.


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
