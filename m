Return-Path: <cyrus@holtmann.org>
Date: Tue, 24 Jan 2012 10:27:42 +0200
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Greg Hazel <ghazel@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: BT_AMP_POLICY and RFCOMM
Message-ID: <20120124082739.GA19238@aemeltch-MOBL1>
References: <D0339DC2-78B0-427D-9FC3-704725A88020@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <D0339DC2-78B0-427D-9FC3-704725A88020@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Jan 23, 2012 at 08:15:16PM -0800, Greg Hazel wrote:
> Hi,
> 
> I'm trying to set BT_AMP_POLICY on an RFCOMM socket to
> BT_AMP_POLICY_PREFER_AMP. In return I'm getting "Operation not supported

BTW: Why would you need to set this? Functionality is not supported yet so
nothing will change.

Best regards 
Andrei Emeltchenko 

> on transport endpoint" (errno 95). Glancing at the code, it looks like
> RFCOMM sockets do not handle BT_AMP_POLICY, and the default policy for
> the underlying L2CAP socket is BT_AMP_POLICY_REQUIRE_BR_EDR. However,
> the L2CAP socket is L2CAP_MODE_ERTM, so my expectation is that it would
> work to use AMP.
> 
> So, why was BT_AMP_POLICY left out for RFCOMM sockets? Was it simply an
> oversight?

