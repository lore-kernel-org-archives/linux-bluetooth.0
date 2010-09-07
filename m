Return-Path: <cyrus@holtmann.org>
Date: Tue, 7 Sep 2010 13:12:30 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Suraj Sumangala <suraj@Atheros.com>
Cc: linux-bluetooth@vger.kernel.org, Jothikumar.Mothilal@Atheros.com,
	joakim.xj.ceder@stericsson.com, claudio.takahasi@gmail.com,
	Waldemar.Rymarkiewicz@tieto.com, Arkadiusz.Lichwa@tieto.com
Subject: Re: [RFC] Sim Access Profile API doc
Message-ID: <20100907101230.GA6309@jh-x301>
References: <1283839375-20033-1-git-send-email-suraj@atheros.com>
 <20100907092927.GA28640@jh-x301>
 <4C860CBE.8060808@Atheros.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4C860CBE.8060808@Atheros.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Sep 07, 2010, Suraj Sumangala wrote:
> The idea was to let the agent implementation be written depending on
> the actual SIM card reader implementation used in the back end. The
> agent can then map its signal/methods to the corresponding SAP
> server calls.

We're defining an API here, not implementation specific details, so I
don't quite understand your concern. What's the point of defining an
agent object if it will not receive any method calls? The RegisterAgent
might as well be called EnableServer in that case and not contain any
object path parameter at all.

Having a proper agent interface and methods in it corresponding to SAP
commands makes much more sense imho than emiting signals for SAP
commands and receiving method calls for the SAP replies. It also doesn't
in any way restrict the agent side implementation details. A D-Bus
method call-method reply pair is a more intuitive mapping to a
SAP-command-SAP-response pair compared to a D-Bus signal + method call
which don't have any tight API level association (anybody can catch the
signal and anybody can send the method call).

Johan
