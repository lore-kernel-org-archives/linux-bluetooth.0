Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH] test: Python import cleanup
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20140118014507.85FAE10065C@puck.mtv.corp.google.com>
Date: Sat, 18 Jan 2014 00:39:43 -0800
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <F9F70436-F525-4903-B2F4-5B4164635C5E@holtmann.org>
References: <20140118014507.85FAE10065C@puck.mtv.corp.google.com>
To: Petri Gynther <pgynther@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Petri,

> Some test scripts use "from gi.repository import GObject" whereas others
> use "import gobject". gi.repository is not always available on embedded
> systems, so convert all instances to this format:
> 
> try:
>  from gi.repository import GObject
> except ImportError:
>  import gobject as GObject
> 
> Also, sort the imports in this order: system, dbus, gobject, bluezutils

I am not a Python expert, but the changes look all good to. So I went ahead and applied the patch.

Regards

Marcel

