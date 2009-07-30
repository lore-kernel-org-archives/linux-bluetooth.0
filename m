Return-Path: <cyrus@holtmann.org>
Date: Thu, 30 Jul 2009 23:24:39 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-acpi@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	bugzilla-daemon@bugzilla.kernel.org,
	bugme-daemon@bugzilla.kernel.org, pi3mm3@gmail.com,
	"John W. Linville" <linville@tuxdriver.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [Bugme-new] [Bug 13879] New: Bluetooth stops working after s3
	suspend/resume
Message-ID: <20090730222439.GA25462@srcf.ucam.org>
References: <bug-13879-10286@http.bugzilla.kernel.org/> <20090730142733.b05a95ed.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090730142733.b05a95ed.akpm@linux-foundation.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Jul 30, 2009 at 02:27:33PM -0700, Andrew Morton wrote:

> hm, what's all that stuff in
> http://memebeam.org/free-software/toshiba_acpi/ and who wrote it and
> should we be merging it into mainline?

Still waiting for someone to just do the right thing and add rfkill 
support to the Toshiba driver. I'm actually considering a complete 
rewrite - the existing code's grown kind of organically, and support for 
modern kernel features has been rather bolted onto the side.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
