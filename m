Return-Path: <cyrus@holtmann.org>
Date: Tue, 31 Aug 2010 03:04:29 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Jonathan Haug <jonathanhaug@wolke7.net>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Check for connections and disable bluetooth in shell
Message-ID: <20100831060429.GA15844@vigoh>
References: <1283234299.1702.12.camel@josua>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1283234299.1702.12.camel@josua>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jonathan,

* Jonathan Haug <jonathanhaug@wolke7.net> [2010-08-31 07:58:19 +0200]:

> 
> Dear bluetooth-experts,
> 
> I want to disable bluetooth on my system (via commandline), if there is
> no active bluetooth connection -- without being root.
> 
> Therefor I need a way to
> 
> 1.  check if there is an active bluetooth connection

'hcitool conn' can show that to you.

-- 
Gustavo F. Padovan
ProFUSION embedded systems - http://profusion.mobi
