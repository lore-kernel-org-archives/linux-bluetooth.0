Return-Path: <cyrus@holtmann.org>
Message-ID: <cc1649d10806071840q63bc169alf7d2073ffd29b339@mail.gmail.com>
Date: Sat, 7 Jun 2008 21:40:38 -0400
From: "Vlad Skarzhevskyy" <skarzhevskyy@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <fdd96f380805310924l7aca51b2t489a25307aaba5b2@mail.gmail.com>
MIME-Version: 1.0
References: <fdd96f380805310924l7aca51b2t489a25307aaba5b2@mail.gmail.com>
Subject: Re: [Bluez-devel] RFCOMM Security
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Marcel,
 I would like to rephrase this question. This is again all about
BlueCove JSR-82.

 When we open socket for client connection there is an options for
setsockopt  RFCOMM_LM_AUTH and RFCOMM_LM_ENCRYPT as far as I can see
they don't change the connection settings.  The same for L2CAP
connections: only we tried L2CAP_LM_AUTH

 I do calls in this sequence: socket, bind, setsockopt, connect
 But the connection does not get authenticated. (pairing procedure not started)

 The problem does not apply for RFCOMM/L2CAP service when service
created and I want only authenticated connections to be accepted we
use socket(),bind(), setsockopt(RFCOMM_LM_AUTH), listen().  Then when
client connects.  The system will initiate pairing procedure.

 Is this unimplemented feature of BlueZ for client connections of we
are not using it right?

 Our code is here:
http://code.google.com/p/bluecove/source/browse/bluecove-gpl/trunk/src/main/c/

Regards,
Vlad Skarzhevskyy
http://bluecove.org

On 5/31/08, Mina Shokry <minashokry@gmail.com> wrote:
> Hello all
> I have a question regarding BlueZ
> does bluez support rfcomm connection security (eg. authenticate and
> encrypt)?
> if yes, please can anyone give an example (C code)?
> thanks in advance
>
> -------------------------------------------------------------------------
>  This SF.net email is sponsored by: Microsoft
>  Defy all challenges. Microsoft(R) Visual Studio 2008.
>  http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
> _______________________________________________
>  Bluez-devel mailing list
>  Bluez-devel@lists.sourceforge.net
>  https://lists.sourceforge.net/lists/listinfo/bluez-devel
>
>

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
