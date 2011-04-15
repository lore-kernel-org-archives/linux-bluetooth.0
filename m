Return-Path: <cyrus@holtmann.org>
Date: Fri, 15 Apr 2011 08:14:49 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Suraj Sumangala <suraj@Atheros.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: optional support for ERTM mode for certain PSM
Message-ID: <20110415111309.GA3103@joana>
References: <4DA81E10.60109@Atheros.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4DA81E10.60109@Atheros.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Suraj,

* Suraj Sumangala <suraj@Atheros.com> [2011-04-15 15:59:36 +0530]:

> Hi Gustavo,
> 
> I am working on the L2CAP BQB test cases for ERTM mode and came across 
> test cases for PSMs which optionally and mandatorily support ERTM.
> 
> As part of BQB qualification, I see two test cases
> 
> 1. Mandatory support:
> 	When tester sends a Config respose with "Un-acceptable parameter" for 
> EFC parameter, the IUT is supposed to disconnect the link.
> 
> 2. Optional support
> 
> 	When tester sends a Config respose with "Un-acceptable parameter" for 
> EFC parameter, the IUT is supposed re-negotiate the connection with the 
> EFC parameter provided by Tester.

For mandatory support you have to SOCK_STREAM, in l2test this is the -U
options. Optional support is the default configuration for l2test.

-- 
Gustavo F. Padovan
http://profusion.mobi
