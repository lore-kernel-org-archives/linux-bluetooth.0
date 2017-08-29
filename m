Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH BlueZ] build: use abspath for lib/bluetooth
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20170823225839.461-1-yunhanw@google.com>
Date: Tue, 29 Aug 2017 07:08:26 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <D2A056DB-B533-4CAC-BCB8-19C39760E05F@holtmann.org>
References: <20170823225839.461-1-yunhanw@google.com>
To: Yunhan Wang <yunhanw@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Yunhan,

> When building from out of tree, and the top build dir was specified as
> an absolute path, the linked headers in ${builddir}/lib/bluetooth were
> broken.  This patch fixes it by relying on make's abspath macro as
> opposed to the path concatenation.
> ---
> Makefile.am | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Makefile.am b/Makefile.am
> index eaed632e8..ad638cbb2 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -499,7 +499,7 @@ $(lib_libbluetooth_la_OBJECTS): $(local_headers)
> 
> lib/bluetooth/%.h: lib/%.h
> 	$(AM_V_at)$(MKDIR_P) lib/bluetooth
> -	$(AM_V_GEN)$(LN_S) -f "$(abs_top_builddir)"/$< $@
> +	$(AM_V_GEN)$(LN_S) -f $(abspath $<) $@

does “fakeroot make distcheck” still works when doing this change?

Regards

Marcel

