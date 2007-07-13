Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <5dcacb1f0707131405l41a8b8b3l7bc14bc519b447cb@mail.gmail.com>
Date: Fri, 13 Jul 2007 14:05:18 -0700
From: "Chulwoong Jeon" <chulwoongjeon@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-devel] Float point SBC codec
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

I have been looking for the float point version sbc codec 'btsco' and
trying to cvs under bluetooth-alsa web page but couldn't download it.

Would you let me know where I can find the float point sbc codec source code?

Chulwoong

> Chulwoong
>
> I'm responsible for any breakage in the decoder. I took the working
> floating point and converted it to fixed point and also reworked the
> algorithm.
>
> If you want to compare the last floating point version to see if it's
> less noisy, check out the cvs project "btsco" from bluetooth-alsa and
> ./configure and build it. You'll get the app sbcdec that can decode a
> stream and play it.
>
> I'll check on the change you recommended.
>
> The mailing list bluez-devel is a better place to ask than in private
> email since there are likely to be others on the list who have tried the
> decoder.
>
> Brad
>
> > I have several questions about your SBC codec. Currently, I am
> > evaluating your SBC codec and able to decode SBC streams.
> >
> > In order to evaluate your SBC codec, I downloaded a test package from
> > https://www.bluetooth.org/foundry/adopters/document/AV_101_sbc_bitstreams_test/en/1/AV_101_sbc_bitstreams_test.zip
> >
> > . I compared your decoder outputs with the reference decoder outputs
> > in the link, but the outputs from your decoder are nosier. I wonder
> > whether if my build of your codec is wrong or not. When I downloaded
> > the original project from http://sourceforge.net/projects/sbc/ , I
> > couldn't make your decoder work so that I made a small change. Please,
> > see below.
> >
> > In ' sbc_math_.h '
> >
> > Original:
> > #define SCALE4_STAGED2_BITS 23
> > #define SCALE8_STAGED2_BITS 23
> >
> > Modification:
> > #define SCALE4_STAGED2_BITS 30
> > #define SCALE8_STAGED2_BITS 30
> >
> > I wonder if you are able to give me any your decoder outputs using the
> > reference files in the link above.
> >
> > I am looking forward to have any answers from you.
> >
> > Best regards,
> >
> > Chulwoong
>

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
