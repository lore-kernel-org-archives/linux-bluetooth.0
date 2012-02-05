Return-Path: <cyrus@holtmann.org>
Message-ID: <1328441601.321.1.camel@pohly-mobl1.fritz.box>
Subject: Re: [PATCH] bluetooth.h: fix compile issue in C++ with ifdef
From: Patrick Ohly <patrick.ohly@intel.com>
To: Rohan Garg <rohangarg@ubuntu.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	linux-bluetooth@vger.kernel.org, Milan Crha <mcrha@redhat.com>,
	ying.an.deng@intel.com, ulf.hofemeier@intel.com,
	ning.w.wang@intel.com,
	Tino Keitel <tino.keitel+syncevolution@tikei.de>
Date: Sun, 05 Feb 2012 12:33:21 +0100
In-Reply-To: <CAEb1ZdjO3W5xUkU3t+CSpVn1u=OCGwBLLeUyvfG-_WMR5AXWxQ@mail.gmail.com>
References: <1326702341.3360.107.camel@pohly-mobl1.fritz.box>
	 <1326705845.6454.274.camel@aeonflux>
	 <1326708597.3360.133.camel@pohly-mobl1.fritz.box>
	 <1328439363.32199.20.camel@pohly-mobl1.fritz.box>
	 <1328439464.32199.22.camel@pohly-mobl1.fritz.box>
	 <CAEb1ZdjO3W5xUkU3t+CSpVn1u=OCGwBLLeUyvfG-_WMR5AXWxQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Sun, 2012-02-05 at 16:37 +0530, Rohan Garg wrote:
> I've not gone through the entire patch, but if the problem is merely
> the fact that one cannot convert a void* to anything in C++, why not
> use a static_cast in syncevolution wherever the struct is used?

The problem is not in the way how SyncEvolution uses the structs. The
problem is in the header files; it also occurs in any other C++ app
including the bluetooth.h file.

-- 
Best Regards, Patrick Ohly

The content of this message is my personal opinion only and although
I am an employee of Intel, the statements I make here in no way
represent Intel's position on the issue, nor am I authorized to speak
on behalf of Intel on this matter.


