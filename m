Return-Path: <cyrus@holtmann.org>
Message-ID: <4E6EB2DE.8090102@goop.org>
Date: Mon, 12 Sep 2011 18:33:18 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
MIME-Version: 1.0
To: padovan@profusion.mobi
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-bluetooth@vger.kernel.org, linux-wireless@vger.kernel.org,
	Keith Packard <keithp@keithp.com>
Subject: Bluetooth regression with headphones
Content-Type: text/plain; charset=UTF-8
Sender: linux-wireless-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

I reported a regression in connecting my Nokia BH-905i headphones in
June this year (https://lkml.org/lkml/2011/6/23/770), which was the same
problem Keith Packard reported in https://lkml.org/lkml/2011/6/9/63.  
It was briefly fixed in
git://git.kernel.org/pub/scm/linux/kernel/git/padovan/bluetooth-2.6.git.

Unfortunately it regressed again by the time of the linux-3.0 release,
to something with similar symptoms: the headphones won't reliably
connect to my laptop unless I freshly re-pair them.  However, unlike the
original bug, they will very occasionally connect normally, though I
don't know why.

This behaviour has been consistent since 3.0 up until the current
3.1-rc6 kernel.

What further information can I provide?  How can I help debug this?

Thanks,
    J
