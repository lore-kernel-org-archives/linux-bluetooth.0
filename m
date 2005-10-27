Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <436066BC.4060501@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] fixed-point sbc decoder
References: <C70061B183DE09419568AB2060C52A950104B2D3@arion.intra.local> <43604483.7070109@xmission.com>
In-Reply-To: <43604483.7070109@xmission.com>
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
Date: Wed, 26 Oct 2005 23:33:48 -0600

Victor,

>>I'll take a look in coming days.

fwiw, I committed fixed point decoding such as it is to cvs after
finding and eliminating some overflow problems. it's noisy but at least
functional. so you can just check it out of cvs (I didn't want to commit
what I had before that was nonfunctional but at least this is borderline)

> #define SP8(val) (val/(1<<SCALE_PROTO8_TBL))

actually, I found this needs to look like

#define SP8(val) (((int32_t)val)/(1<<SCALE_PROTO8_TBL))

I guess because all the literals in the array init look like they're
unsigned. This kind of fix may need to be applied in a few other places.

I am very proud of the latest optimization. I eliminated the shift/copy
of the main array by reordering it. The result is going to benefit from
unrolling since I was also able to make the array access into sbc_proto
always the same in every pass.

brad


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
