Return-Path: <cyrus@holtmann.org>
Date: Fri, 9 Dec 2011 10:43:38 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>,
	Frederic Danis <frederic.danis@linux.intel.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH hciemu v2 1/2] Process Read Local AMP Info in hciemu
Message-ID: <20111209084338.GA24504@x220>
References: <1323334477-32179-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <20111208094032.GA28204@x220>
 <4EE0D0A0.2000401@linux.intel.com>
 <20111209081637.GB7256@aemeltch-MOBL1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20111209081637.GB7256@aemeltch-MOBL1>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Dec 09, 2011, Emeltchenko Andrei wrote:
> > This patch breaks the build on Ubuntu 10.10 32 bits with messages:
> > 
> > fdanis@fdanis-linux:bluez (master %)$ make
> > make --no-print-directory all-am
> >   CC     test/hciemu.o
> > cc1: warnings being treated as errors
> > test/hciemu.c: In function ‘hci_host_control’:
> > test/hciemu.c:431: error: dereferencing pointer ‘({anonymous})’ does
> > break strict-aliasing rules
> > test/hciemu.c:431: note: initialized from here
> > make[1]: *** [test/hciemu.o] Error 1
> > make: *** [all] Error 2
> 
> Cannot reproduce this problem on my Ubuntu 11.04. Are you sure the error is
> attributed to my patch?

In the latest git hciemu.c:431 is not inside the hci_host_control
function so it seems Frederic is using some older version of the code.
In any case I'd expect him to provide a patch for this if necessary
since it seems he is the only one who is able to reproduce the issue.

Johan
