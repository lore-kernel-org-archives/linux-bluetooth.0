Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <20050517063124.90031.qmail@web8308.mail.in.yahoo.com>
From: Mayank Batra <mayankbatra@yahoo.co.in>
To: BLUEZ DEVELOPERS LIST <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Subject: [Bluez-devel] a2play timing is still whacky
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
Date: Tue, 17 May 2005 07:31:24 +0100 (BST)

Brad,

I tried the latest version of a2play with BlueSoleil.
The timing is still not upto the mark.
I mean, this time, the sound is breking, i.e I feel we
are putting a greater delay than what is needed.

len = sbc_encode(&sbc, buf2, size2);//do the encoding
	sleeptime = sbc.duration;
	sbc_info.blocks = sbc.blocks;
	sbc_info.subbands = sbc.subbands;

Here, why are we using the variable sleeptime if we
are not making use of it later on in the code?

// pause if the ring buffer is full
while((ring_out + 1) % FRAMEBUF == ring_in)
usleep(10);

Here, why did you choose usleep(10) only?

Mayank.
        

________________________________________________________________________
Yahoo! India Matrimony: Find your life partner online
Go to: http://yahoo.shaadi.com/india-matrimony


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
