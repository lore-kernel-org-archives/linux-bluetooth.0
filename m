Return-Path: <cyrus@holtmann.org>
Date: Wed, 2 May 2012 22:50:34 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [now bisected] Weird bluetooth keyboard regression - just me?
Message-ID: <20120502215034.GA622@srcf.ucam.org>
References: <20120501073711.028d31d6@lwn.net>
 <20120501110156.2b6e0561@lwn.net>
 <20120501171901.GA26006@srcf.ucam.org>
 <20120501120145.21f65ae2@lwn.net>
 <20120501183149.GA28536@srcf.ucam.org>
 <20120501123923.01ac1138@lwn.net>
 <20120501185455.GA29060@srcf.ucam.org>
 <20120501192736.GA29770@srcf.ucam.org>
 <20120501172454.0e811379@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120501172454.0e811379@lwn.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, May 01, 2012 at 05:24:54PM -0600, Jonathan Corbet wrote:
> > In either case, does the 
> > attached file help if dropped into /lib/udev/rules.d ?
> 
> Nope, no joy there.  

You tested after rebooting?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
