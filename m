Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <20050508125039.1494.qmail@web8305.mail.in.yahoo.com>
From: Mayank Batra <mayankbatra@yahoo.co.in>
Subject: Re: [Bluez-devel] Regarding a2recv
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20050506060525.32b209ca.henryk@ploetzli.ch>
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
Date: Sun, 8 May 2005 13:50:39 +0100 (BST)

Henryk,

> Ah no, but luckily Brad did. However, that wasn't
> the problem. The
> problem was that a2recv didn't correctly fill out
> the transaction
> label. When responding to a request one must use the
> same transaction
> label that the other side used.

I believe that should have been a problem because
interchanding packet_type and message_type does make a
lot of difference to the avdtp packet.

Also, I agree that the init_request() function was not
much thought after while it was being written.
 
> I don't fully understand the logic behind what
> init_request() in
> a2recv.c does to the transaction_label, but it's
> most likely wrong.

Yes, we can simply copy the transation label given by
the source in the response.

> I therefore introduced a function init_response()
> that takes the header
> of the command that was received and creates a
> positive response header.
> init_request() is then used nowhere anymore, so I
> #if 0'd it. I also
> went through a hcidump of the (now working) stream
> setup phase and
> compared it to the AVDTP spec. Most of it looks
> correct now, except for
> Open Stream Response and Start Stream Response,
> which are too long (I'm
> not sure what to do about that as the additional
> byte(s) are reserved in
> the struct open_stream_rsp and struct
> start_stream_rsp for the case of
> an error).
 
> So now I made it to "Sent start stream confirm" but
> not further as the
> audio dongle doesn't seem to start streaming. The
> last three packets I
> see in an hcidump are

Why doesn't the streaming start?
 
> Anyways: I have committed the changed
> transaction_label handling to 
> CVS, so please check that it doesn't break your
> already working 
> devices.

I'll do that.


Mayank

________________________________________________________________________
Yahoo! India Matrimony: Find your life partner online
Go to: http://yahoo.shaadi.com/india-matrimony


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
