Return-Path: <cyrus@holtmann.org>
From: Arnd Bergmann <arnd@arndb.de>
To: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH v2 2/2] mach-ux500: Add CG2900 devices
Date: Mon, 28 Mar 2011 16:59:45 +0200
Cc: "Par-Gunnar HJALMDAHL" <par-gunnar.p.hjalmdahl@stericsson.com>,
 "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
 Pavan Savoy <pavan_savoy@sify.com>,
 Vitaly Wool <vitalywool@gmail.com>,
 Alan Cox <alan@lxorguk.ukuu.org.uk>,
 Marcel Holtmann <marcel@holtmann.org>,
 Lukasz Rymanowski <Lukasz.Rymanowski@tieto.com>,
 Linus WALLEIJ <linus.walleij@stericsson.com>,
 "Par-Gunnar Hjalmdahl" <pghatwork@gmail.com>,
 Lee Jones <lee.jones@linaro.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>
References: <1301302992-10671-1-git-send-email-par-gunnar.p.hjalmdahl@stericsson.com> <AFCDDB4A3EA003429EEF1E7B211FDBBA3377B51A1F@EXDCVYMBSTM005.EQ1STM.local> <20110328143955.GB23892@suse.de>
In-Reply-To: <20110328143955.GB23892@suse.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201103281659.45929.arnd@arndb.de>
List-ID: <linux-bluetooth.vger.kernel.org>

On Monday 28 March 2011, Greg KH wrote:
> > 
> > But how should I then do this? As I understood it I was told that I should
> > call an init function, but I was not allowed to add any staging folder
> > inclusion in the board config makefile. And now I can't do any extern
> > declaration either. I don't really see how I could do it then.
> 
> Why can't you add a staging folder inclusion?  You could do that, and
> properly set up your .h file so that if the driver is not built, your
> code still properly builds and runs.

That would work as well, along with the two solutions I suggested.

I believe Pär-Gunnar was trying to avoid #ifdefs, and the patch actually
contains alternative files implementing cg2900_init_board as a stub
when CONFIG_CG2900 is set, so the intent was clearly there:

@@ -0,0 +1,18 @@
+#
+# Makefile for ST-Ericsson CG2900 connectivity combo controller
+#
+
+ccflags-y :=                                   \
+       -Idrivers/staging/cg2900/include \
+       -Iarch/arm/mach-ux500
+
+ifeq ($(CONFIG_CG2900),n)
+obj-y  += board-mop500-nocg2900.o
+export-objs                    := board-mop500-nocg2900.o
+else
+obj-$(CONFIG_CG2900)   += board-mop500-cg2900.o devices-cg2900.o
+export-objs                    := board-mop500-cg2900.o
+endif
+

I don't think that this works though, because the directory
is ignored when CONFIG_CG2900 is not set, and if it did work,
it would cause an empty function to be included in every
single kernel, not even limited to the ARM architecture.

	Arnd
