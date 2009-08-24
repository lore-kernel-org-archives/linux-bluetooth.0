Return-Path: <cyrus@holtmann.org>
Date: Mon, 24 Aug 2009 16:42:34 +0200
From: Stefan Seyfried <stefan.seyfried@googlemail.com>
To: BlueZ devel list <linux-bluetooth@vger.kernel.org>
Subject: Re: bluez-4.49 does not build for me.
Message-ID: <20090824164234.0adf696e@stoetzler>
In-Reply-To: <20090824151514.6eb4f1f6@stoetzler>
References: <20090824151514.6eb4f1f6@stoetzler>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, 24 Aug 2009 15:15:14 +0200
Stefan Seyfried <stefan.seyfried@googlemail.com> wrote:

> I'll start looking into it.

"ln -s lib bluetooth" seems to partially fix it. However, a bit later:

seife@stoetzler:~/tmp/bluez-4.49> make all
make --no-print-directory all-am
make[1]: *** No rule to make target `tools/bccmd.8', needed by `all-am'.  Stop.
make: *** [all] Error 2

tools/bccmd.8 is missing from the tarball, as is tools/hid2hci.8,
tools/dfutool.1, test/rctest.1, test/hciemu.1, compat/pand.1 and compat/dund.1


BTW: "make distcheck" would have already complained about that ;)

Best regards,

	Stefan

-- 
Stefan Seyfried
R&D Preload Department             |              "Any ideas, John?"
SUSE LINUX Products GmbH, Nürnberg | "Well, surrounding them's out."

This footer brought to you by insane German lawmakers:
SUSE Linux Products GmbH, GF: Markus Rex, HRB 16746 (AG Nürnberg)
