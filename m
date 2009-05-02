Return-Path: <cyrus@holtmann.org>
Date: Sat, 2 May 2009 23:06:00 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: bluetoothd git version -> Segmentation fault
Message-ID: <20090502200600.GA775@jh-x301>
References: <49F8638C.5070205@pook.es> <20090429160430.GA25611@jh-x301> <49F87CFF.4090804@pook.es> <20090429163255.GA27251@jh-x301> <49F88DC2.60703@pook.es> <20090429174229.GA29760@jh-x301> <49F89C94.2070604@pook.es> <2d5a2c100904291237k5afa93fdo15ba4913f641f4d0@mail.gmail.com> <49FC94FD.1080808@pook.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <49FC94FD.1080808@pook.es>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Stuart,

On Sat, May 02, 2009, Stuart Pook wrote:
> bluetoothd seg faulted again. This time I didn't have to type control-C.
> I just ran it and it crashed. I last did a git pull a bit before
> 2009-04-29 20:17
<snip>
> bluetoothd[3300]: connect: Operation not permitted (1)
> ==3300== Invalid read of size 1
> ==3300==    at 0x4826728: strlen (mc_replace_strmem.c:242)
> ==3300==    by 0x498E677: vfprintf (in /lib/i686/cmov/libc-2.9.so)
> ==3300==    by 0x4A2A635: __vsyslog_chk (in /lib/i686/cmov/libc-2.9.so)
> ==3300==    by 0x4A2A706: vsyslog (in /lib/i686/cmov/libc-2.9.so)
> ==3300==    by 0x12D457: error (logging.c:58)
> ==3300==    by 0x4EEC176: get_record_cb (headset.c:1432)
> ==3300==    by 0x12D9DA: search_completed_cb (glib-helper.c:209)
> ==3300==    by 0x493F0B1: sdp_process (in /usr/local/stow/bluez-4.37/lib/libbluetooth.so.3.2.3)
> ==3300==    by 0x12DA46: search_process_cb (glib-helper.c:228)
> ==3300==    by 0x48B64AC: (within /usr/lib/libglib-2.0.so.0.2000.1)
> ==3300==    by 0x487F847: g_main_context_dispatch (in /usr/lib/libglib-2.0.so.0.2000.1)
> ==3300==    by 0x4882DAA: (within /usr/lib/libglib-2.0.so.0.2000.1)
> ==3300==  Address 0x5 is not stack'd, malloc'd or (recently) free'd
> ==3300== ==3300== Process terminating with default action of signal 11 
> (SIGSEGV)

Thanks a lot for this trace! It turned out to be a simple format string
bug which is now fixed in git:
http://git.kernel.org/?p=bluetooth/bluez.git;a=commitdiff;h=ca06dd9c4d4d4c055583dd4e2b4a823264c3b687

Johan
