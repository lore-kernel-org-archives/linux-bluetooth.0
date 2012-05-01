Return-Path: <cyrus@holtmann.org>
Date: Tue, 1 May 2012 12:01:45 -0600
From: Jonathan Corbet <corbet@lwn.net>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [now bisected] Weird bluetooth keyboard regression - just me?
Message-ID: <20120501120145.21f65ae2@lwn.net>
In-Reply-To: <20120501171901.GA26006@srcf.ucam.org>
References: <20120501073711.028d31d6@lwn.net>
	<20120501110156.2b6e0561@lwn.net>
	<20120501171901.GA26006@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 1 May 2012 18:19:01 +0100
Matthew Garrett <mjg59@srcf.ucam.org> wrote:

> On its own, this should do precisely nothing.

Nonetheless, at the previous patch
(0846e7e9856c0928223447d9349a877202a63f24, usb: Add support for indicating
whether a port is removable) things work.  With this one, they don't.  

> What userspace are you 
> running, and what does the removable node in the sysfs entry for the 
> dongle's USB device say?

It's Rawhide, updated yesterday.  "Removable" says "fixed".

FWIW, power/runtime_status reads "suspended" most of the time.  By banging
on the keyboard I can get it to "active", but it goes back to "suspended"
even with continuous activity.  Weirdly, the keyboard continues to work if
I keep hitting keys.

Thanks,

jon
