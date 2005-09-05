Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Peter Wippich <pewi@gw-instruments.de>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] sbc synthesis inconsistencies
In-Reply-To: <431A810B.2060705@xmission.com>
Message-ID: <Pine.LNX.4.33.0509051123130.25062-100000@redbean.intranet.gw-instruments.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Mon, 5 Sep 2005 11:24:07 +0200 (CEST)


Hi,

outer loop goes from i=0 up to i=4 -> 5 times * 8 * 2 = 80

Ciao,

Peter

On Sat, 3 Sep 2005, Brad Midgley wrote:

> Guys,
>
> Have any of you looked closely at this? It comes straight from the spec
> for a2dp on page 66:
>
>
> 	/* Build a 80 values vector U */
> 	for (i = 0; i <= 4; i++) {
> 		for (j = 0; j < 8; j++) {
> 			state->U[ch][i * 16 + j] = state->V[ch][i * 32 + j];
> 			state->U[ch][i * 16 + j + 8] = state->V[ch][i * 32 + j + 24];
> 		}
> 	}
>
> But isn't this code only populating u[ch][0..63] and not through 79 like
> the comment suggests? So the u[ch][64..79] terms are always 0 right?
>
> This isn't the only thing that looks wrong in the spec. We also have a
> sliding window of v[] values that moves 16 values in each pass. The
> vector is 160 elements long even though the code above never accesses
> anything beyond the 128th value!
>
> It's amazing this stuff even works as poorly specified as it is :(
>
> BTW, in our code it looks like sbc_synthesize_eight was multiplying
> sbc_proto_8_80 by -4 where it should be -8. I changed that in cvs.
>
> Brad
>
>
> -------------------------------------------------------
> SF.Net email is Sponsored by the Better Software Conference & EXPO
> September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
> Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
> Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>

|	Peter Wippich 			Voice: +49 30 46776411		|
|	G&W Instruments GmbH		fax:   +49 30 46776419		|
|	Gustav-Meyer-Allee 25, Geb. 12	Email: pewi@gw-instruments.de	|
|	D-13355 Berlin  / Germany					|




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
