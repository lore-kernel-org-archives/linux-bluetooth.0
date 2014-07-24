Return-Path: <cyrus@holtmann.org>
Date: Thu, 24 Jul 2014 13:08:20 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Murat Kilivan <Murat.Kilivan@csr.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Bluetooth Low Energy service crash report - when trying read a
 HID feature report
Message-ID: <20140724100820.GA13332@t440s.lan>
References: <45F17F5803927D43967AFEED068E781E0879A30E@CAMEUREXM02.EUROPE.ROOT.PRI>
 <20140724083116.GB9891@t440s.lan>
 <45F17F5803927D43967AFEED068E781E0879ACDB@CAMEUREXM02.EUROPE.ROOT.PRI>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <45F17F5803927D43967AFEED068E781E0879ACDB@CAMEUREXM02.EUROPE.ROOT.PRI>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Murat,

On Thu, Jul 24, 2014, Murat Kilivan wrote:
> ==10991== Process terminating with default action of signal 5 (SIGTRAP)
> ==10991==    at 0x40A340A: g_logv (in /lib/i386-linux-gnu/libglib-2.0.so.0.4000.0)
> ==10991==    by 0x40A3522: g_log (in /lib/i386-linux-gnu/libglib-2.0.so.0.4000.0)
> ==10991==    by 0x40A1C1D: g_malloc (in /lib/i386-linux-gnu/libglib-2.0.so.0.4000.0)
> ==10991==    by 0x40B9E75: g_memdup (in /lib/i386-linux-gnu/libglib-2.0.so.0.4000.0)
> ==10991==    by 0x80781C5: gatt_write_char (gatt.c:900)
> ==10991==    by 0x8072A7B: forward_report (hog.c:368)
> ==10991==    by 0x80A5B0D: queue_foreach (queue.c:206)
> ==10991==    by 0x807208E: uhid_read_handler (uhid.c:98)
> ==10991==    by 0x80A53F2: read_callback (io-glib.c:168)
> ==10991==    by 0x40E1E04: ??? (in /lib/i386-linux-gnu/libglib-2.0.so.0.4000.0)
> ==10991==    by 0x409C0A6: g_main_context_dispatch (in /lib/i386-linux-gnu/libglib-2.0.so.0.4000.0)
> ==10991==    by 0x409C467: ??? (in /lib/i386-linux-gnu/libglib-2.0.so.0.4000.0)
> ==10991== Invalid free() / delete / delete[] / realloc()
> ==10991==    at 0x402B3D8: free (in /usr/lib/valgrind/vgpreload_memcheck-x86-linux.so)
> ==10991==    by 0x4304F54: __libc_freeres (in /lib/i386-linux-gnu/libc-2.19.so)
> ==10991==    by 0x4024526: _vgnU_freeres (in /usr/lib/valgrind/vgpreload_core-x86-linux.so)
> ==10991==    by 0x40E4F6D: ??? (in /lib/i386-linux-gnu/libglib-2.0.so.0.4000.0)
> ==10991==  Address 0xffffffff is not stack'd, malloc'd or (recently) free'd

This helps a lot. Thanks. I'd bet the following code from forward_report() is
responsible:

        if (hogdev->has_report_id) {
                data = ev->u.output.data + 1;
                size = ev->u.output.size - 1;
        } else {
                data = ev->u.output.data;
                size = ev->u.output.size;
        }

You could add some debug logs there to be completely certain, but I have
a feeling the first branch is taken and ev->u.output.size is 0, giving
us the "0 - 1" value which you see in the failed memory allocation.

Now the question is what the right fix is. Should the if-statement
instead be as follows:

	if (hogdev->has_report_id && ev->u.output.size > 0)
		...

Could you try modifying your code base to verify that this is indeed the
cause of the crash? Thanks.

Johan
