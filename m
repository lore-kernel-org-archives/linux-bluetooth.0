Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-Id: <5.1.0.14.2.20030612101029.0789e508@unixmail.qualcomm.com>
To: "Daryl Van Vorst" <daryl@wideray.com>, "BlueZ Mailing List" <bluez-devel@lists.sourceforge.net>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: [Bluez-devel] SO_ERROR, LM_RELIABLE
In-Reply-To: <001001c3248f$838dfdf0$1a01010a@baked>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 12 Jun 2003 10:13:33 -0700

At 01:35 PM 5/27/2003, Daryl Van Vorst wrote:
>Max,
>
>I'm working on LM_RELIABLE support in l2test. I'm using aclsession to send
>both valid and invalid l2cap packets.
>
>I'm sending an invalid (wrong length) packet followed by a valid packet. I
>get the ECOMM error and clear it with getsockopt(SO_ERROR), and then I can
>receive the next packet. That works fine for both long and short packets.
>But when I disconnect, I get the following in syslog (for either the too
>long or the too short case):
>
>l2test[583]: Disconnect. Communication error on send
>
>Normally that would say "Disconnect. Success".
>
>But I'm not sending. (At least not that I know of) Any ideas about what
>would cause that?
That what you'd get if you do strerror(ECOMM) :(. So the error message is ok.
The question is why do you get error after you cleared it with getsockopt(SO_ERROR).
I'll take a look at it.

Max





-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
