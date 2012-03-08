Return-Path: <cyrus@holtmann.org>
Date: Thu, 8 Mar 2012 09:58:52 +0200
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC 1/2] Bluetooth: General HCI callback implementation
Message-ID: <20120308075849.GA26562@aemeltch-MOBL1>
References: <1331039789-31519-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <20120308055306.GF3998@joana>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120308055306.GF3998@joana>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Thu, Mar 08, 2012 at 02:53:06AM -0300, Gustavo Padovan wrote:
> Hi Andrei,
> 
> * Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com> [2012-03-06 15:16:28 +0200]:
> 
> > From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > 
> > Add general HCI callback implementation. Can be used for executing
> > HCI commands from A2MP protocol.
> 
> I'm not sure why we need this, can you add a better explanation here?

We need callbacks from HCI events for A2MP protocol.

Best regards 
Andrei Emeltchenko 

