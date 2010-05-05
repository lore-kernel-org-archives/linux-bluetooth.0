Return-Path: <cyrus@holtmann.org>
From: =?iso-8859-1?q?Jos=E9_Antonio_Santos_Cadenas?=
	<jcaden@libresoft.es>
Reply-To: jcaden@libresoft.es
To: Elvis =?iso-8859-1?q?Pf=FCtzenreuter?= <epx@signove.com>
Subject: Re: HDP proposed API
Date: Wed, 5 May 2010 15:18:45 +0200
Cc: "Santiago Carot-Nemesio" <scarot@libresoft.es>,
	linux-bluetooth@vger.kernel.org
References: <1272959741.2182.123.camel@mosquito> <F4813D96-A6B5-4755-ABB8-4C7D880B05D8@signove.com> <483C27C6-11BB-459F-AD43-F0734EE0F3A9@signove.com>
In-Reply-To: <483C27C6-11BB-459F-AD43-F0734EE0F3A9@signove.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201005051518.45474.jcaden@libresoft.es>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello, 


El Wednesday 05 May 2010 15:10:56 Elvis Pfützenreuter escribió:
> 
> >> 
> >> The d-bus writing option: we thing that is too much load for the dbus and that will be very
> >> slow too. Because the change to xml formtat could be very expensive, and the amount of data
> >> could be very big. Note tha 11073-20601 defines apdus of 65Kb (we think that this is too much for d-bus)
> > 
> > That's a good question for us to make in #dbus channel :) 
> 
> Ok, indeed D-BUS guys said that a fd (e.g. a pipe) is better, and suggested using pipes + http://en.wikipedia.org/wiki/Splice_(system_call)

So you mean do fd-passing with the pipe file descriptor to the client and then HDP will write the data in the L2CAP socket using splice, am I right?

Regards.

> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
