Return-Path: <cyrus@holtmann.org>
Date: Wed, 16 Feb 2011 07:12:00 -0700
From: Jonathan Corbet <corbet@lwn.net>
To: Alan Ott <alan@signal11.us>
Cc: Randy Dunlap <rdunlap@xenotime.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, jkosina@suse.cz,
	ospite@studenti.unina.it, linux-input@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, bgood@velocity.net
Subject: Re: [PATCH v4 1/2] HID: Documentation for hidraw
Message-ID: <20110216071200.02ccdaa5@bike.lwn.net>
In-Reply-To: <1297829209-10511-2-git-send-email-alan@signal11.us>
References: <1297829209-10511-1-git-send-email-alan@signal11.us>
	<1297829209-10511-2-git-send-email-alan@signal11.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 15 Feb 2011 23:06:48 -0500
Alan Ott <alan@signal11.us> wrote:

>  Documentation/hid/Makefile      |    8 ++
>  Documentation/hid/hid-example.c |  167 +++++++++++++++++++++++++++++++++++++++

I believe we're trying to get code - especially runnable code - out of the
Documentation tree.  Should this go under samples/ or, if it's useful
enough, under tools/?

Thanks,

jon
