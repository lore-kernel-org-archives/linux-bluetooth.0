Return-Path: <cyrus@holtmann.org>
Subject: Re: Check for connections and disable bluetooth in shell
From: Jonathan Haug <jonathanhaug@wolke7.net>
To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20100831060429.GA15844@vigoh>
References: <1283234299.1702.12.camel@josua>  <20100831060429.GA15844@vigoh>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 07 Oct 2010 07:01:00 +0200
Message-ID: <1286427660.2181.5.camel@josua>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Am Dienstag, den 31.08.2010, 03:04 -0300 schrieb Gustavo F. Padovan:
> > 
> > I want to disable bluetooth on my system (via commandline), if there is
> > no active bluetooth connection -- without being root.
> > 
> > Therefor I need a way to
> > 
> > 1.  check if there is an active bluetooth connection
> 
> 'hcitool conn' can show that to you.
> 

Just to complete this thread:

Thanks Gustavo! I'm now using the following script:

		if grep -q off-line /proc/acpi/ac_adapter/ACAD/state; then
			if !(hcitool con | grep -q "state"); then
				rfkill block bluetooth
			fi
		fi

May it be helpful for someone.

Greetings

Jonathan

