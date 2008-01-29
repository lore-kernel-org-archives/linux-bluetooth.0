Return-Path: <cyrus@holtmann.org>
Message-ID: <d89ddf300801291107y15ba6888n65c6841f8c95088f@mail.gmail.com>
Date: Tue, 29 Jan 2008 12:07:03 -0700
From: "Brad Midgley" <bmidgley@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <50282bd30801290946l359dc7a6j29bb3b891ab35f9a@mail.gmail.com>
MIME-Version: 1.0
References: <50282bd30801290946l359dc7a6j29bb3b891ab35f9a@mail.gmail.com>
Subject: Re: [Bluez-devel] ARM optimization
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

Hey

The only thing I'd add here is the ugliness in putting the function
declaration inside the ifdef is mitigated a bit by taking advantage
instead of the ugliness of making the function non-static for all
platforms.

The thing to note here is the optimization will not take if gcc sees
the function is static *or* inline.

It isn't perfect, but replacing the whole function with assembly will
be even harder to maintain. We're really hurting on omap so we need to
take some steps to get performance up.

diff -u -r1.56 sbc.c
--- sbc/sbc.c   29 Jan 2008 18:56:13 -0000      1.56
+++ sbc/sbc.c   29 Jan 2008 19:03:06 -0000
@@ -709,9 +709,13 @@
 }


-static inline void _sbc_analyze_four(const int32_t *in, int32_t *out)
+void _sbc_analyze_four(const int32_t *in, int32_t *out)
 {
+#ifdef __arm__
+       sbc_extended_t register res asm("r4");
+#else
        sbc_extended_t res;
+#endif
        sbc_fixed_t t[8];
        sbc_extended_t s[5];

@@ -794,9 +798,13 @@
                state->position[ch] = 36;
 }

-static inline void _sbc_analyze_eight(const int32_t *in, int32_t *out)
+void _sbc_analyze_eight(const int32_t *in, int32_t *out)
 {
+#ifdef __arm__
+       sbc_extended_t register res asm("r4");
+#else
        sbc_extended_t res;
+#endif
        sbc_fixed_t t[8];
        sbc_extended_t s[8];


-- 
Brad

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
