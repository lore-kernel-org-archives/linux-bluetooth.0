Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <448430E9.8080108@auroramsx.nl>
Date: Mon, 05 Jun 2006 15:26:01 +0200
From: Eric Boon <eric@auroramsx.nl>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <768ccca40606041514m77eea4cer437d3ea227d3eec8@mail.gmail.com>	<4483B5E4.7000305@xmission.com>	<44840D5E.5060800@auroramsx.nl>
	<44841B29.7020904@auroramsx.nl>
In-Reply-To: <44841B29.7020904@auroramsx.nl>
Subject: Re: [Bluez-devel] Belkin
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

And another hello :-)

I applied the patch as described in
http://www.ussg.iu.edu/hypermail/linux/kernel/0601.1/1679.html
and the device is now working, although I get numerous buffer
under-runs when the CPU has a noticeable load...
(E.g. upon opening an application.)
I'd still rather work with a non-patched kernel, so other options
are welcome!

Greetz,
    Eric




_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
