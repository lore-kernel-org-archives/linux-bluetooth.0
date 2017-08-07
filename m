Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Mon, 7 Aug 2017 21:46:13 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Karunakar Reddy <karan.tillu@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: Re: Support for SPP 1.2 Specification in Bluez
Message-ID: <20170807184613.GA20236@x1c.home>
References: <CAGfak60obAiVJToyRbPvVmsjO3phw4SpL8Wn_mgucNeSUFOG-g@mail.gmail.com>
 <CABBYNZKPf1JOr4BiDEsRibUd37pWC=Y8uVe2Gv_Op5S0qB41XQ@mail.gmail.com>
 <CAMQUNB8KQZY9E1idg1sFx2JynaTDeaDKO+SrnZ8mQAcvRaO7XQ@mail.gmail.com>
 <CAGfak62kHdrq=aAPxP4MczMj+PrgMbqraoTaCjqqZdg40zeXeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAGfak62kHdrq=aAPxP4MczMj+PrgMbqraoTaCjqqZdg40zeXeA@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Karan,

On Mon, Aug 07, 2017, Karunakar Reddy wrote:
> Thanks for the update. As you said, SDP specific enhancements seem to
> present. Also there are L2CAP feature additions like flow and error control
> and flush timeout using the ENHANCED RETRANSMISSION MODE(ERTM).
> 
> We would like to know if current Bluez stack is fully compliant with SPP
> 1.2 specification. Thanks in advance

I think you'll need to determine that yourself by running the respective
qualification (PTS) tests. All I can say is that I'm at least not aware
of any gaps in the implementation.

Johan
