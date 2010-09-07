Return-Path: <cyrus@holtmann.org>
Message-ID: <4C8635FA.5010108@Atheros.com>
Date: Tue, 7 Sep 2010 18:24:18 +0530
From: Suraj Sumangala <suraj@Atheros.com>
MIME-Version: 1.0
To: <linux-bluetooth@vger.kernel.org>,
	<Jothikumar.Mothilal@Atheros.com>,
	<joakim.xj.ceder@stericsson.com>, <claudio.takahasi@gmail.com>,
	<Waldemar.Rymarkiewicz@tieto.com>, <Arkadiusz.Lichwa@tieto.com>
Subject: Re: [RFC] Sim Access Profile API doc
References: <1283839375-20033-1-git-send-email-suraj@atheros.com> <20100907092927.GA28640@jh-x301> <4C860CBE.8060808@Atheros.com> <20100907101230.GA6309@jh-x301>
In-Reply-To: <20100907101230.GA6309@jh-x301>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On 9/7/2010 3:42 PM, Johan Hedberg wrote:
> We're defining an API here, not implementation specific details, so I
> don't quite understand your concern. What's the point of defining an
> agent object if it will not receive any method calls? The RegisterAgent
> might as well be called EnableServer in that case and not contain any
> object path parameter at all.
>
> Having a proper agent interface and methods in it corresponding to SAP
> commands makes much more sense imho than emiting signals for SAP
> commands and receiving method calls for the SAP replies. It also doesn't
> in any way restrict the agent side implementation details. A D-Bus
> method call-method reply pair is a more intuitive mapping to a
> SAP-command-SAP-response pair compared to a D-Bus signal + method call
> which don't have any tight API level association (anybody can catch the
> signal and anybody can send the method call).
>

Got your point, Thanks.
Also, do let me know if you have any other suggestion regarding the 
interface.

Regards
Suraj

