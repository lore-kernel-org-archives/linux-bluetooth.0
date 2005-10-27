Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <43604483.7070109@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] fixed-point sbc decoder
References: <C70061B183DE09419568AB2060C52A950104B2D3@arion.intra.local>
In-Reply-To: <C70061B183DE09419568AB2060C52A950104B2D3@arion.intra.local>
Content-Type: text/plain; charset=ISO-8859-1
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
Date: Wed, 26 Oct 2005 21:07:47 -0600

Victor,

> I'll take a look in coming days.

thanks... for now I'm running floating and fixed point side-by-side and
watching for sign errors to find overflow. I was putting too many
precision bits in the fixed point synmatrix and it was overflowing and
coming out with the wrong sign in the product...

hey I noticed something that doesn't look right:

#define SP8(val) (val >> SCALE_PROTO8_TBL)

this is used in the tables for the 32-bit encoder. but this is not right
for negative values. Their sign will flip because it's a logical (not
arithmetic) shift. it's safer to do something like:

#define SP8(val) (val/(1<<SCALE_PROTO8_TBL))

don't you think? the divide will be done at compile time and it will
preserve the sign bit.

Brad


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
