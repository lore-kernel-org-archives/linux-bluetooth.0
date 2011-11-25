Return-Path: <cyrus@holtmann.org>
Message-ID: <4ECF9B0F.7040907@bmw-carit.de>
Date: Fri, 25 Nov 2011 14:41:35 +0100
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
MIME-Version: 1.0
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [RFC obexd 05/10] client-doc: replace parameter dict with conventional
 ones
References: <1322143742-31182-1-git-send-email-mikel.astiz@bmw-carit.de> <1322143742-31182-6-git-send-email-mikel.astiz@bmw-carit.de> <20111124182457.GB20733@samus> <CABBYNZ+T_j_4340NXefxH833tr-zdiy446yJnFDp58SoqDLnZw@mail.gmail.com>
In-Reply-To: <CABBYNZ+T_j_4340NXefxH833tr-zdiy446yJnFDp58SoqDLnZw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz, Vinicius,

> IMO it is better to leave as it is because then some parameters can be 
> omitted such as adapter and target, and it also easier to extend if we 
> need other parameters e.g. WHO header without breaking the signature. 

This might be a matter of personal preference, but IMO using a 
dictionary to make an API more flexible is just hiding the problem. I 
don't see why this method has more reasons than any other method to use 
a dictionary instead of well-defined formal parameters.

If the point is that some of the input parameters are optional, I would 
rather propose using empty strings. Again, it's a matter of personal taste.

Besides, I don't understand how the target could be omitted. Could you 
further elaborate on this?

Cheers,
Mikel

