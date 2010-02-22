Return-Path: <cyrus@holtmann.org>
Message-ID: <4B82380A.6040204@nokia.com>
Date: Mon, 22 Feb 2010 09:53:46 +0200
From: Ville Tervo <ville.tervo@nokia.com>
MIME-Version: 1.0
To: ext Nick Pelly <npelly@google.com>
CC: Marcel Holtmann <marcel@holtmann.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] Bluetooth: Allow SCO/eSCO packet type selection for
 outgoing SCO connections.
References: <1265918068-14721-1-git-send-email-npelly@google.com> 	<35c90d961002111159h6727bc2cw28b55ce6e919fb4f@mail.gmail.com> 	<35c90d961002151315i5fc0f5b9y36aaba4415987a2f@mail.gmail.com> 	<4B7BB746.1040806@nokia.com> <35c90d961002170849m1d13743fg725a87594d63b80c@mail.gmail.com> 	<1266427894.8849.66.camel@localhost.localdomain> <35c90d961002181547x1ea26ba7je4eee29ef29e6fd2@mail.gmail.com> 	<4B7E46FC.5030408@nokia.com> <35c90d961002191323x50203ca1x8ed709b3f128e41d@mail.gmail.com>
In-Reply-To: <35c90d961002191323x50203ca1x8ed709b3f128e41d@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Nick Pelly wrote:
>>> Attached is a new patch with the consistent bit logic.
>>>
>>> Comments?
>> In order to keep backwards compatibility 1 should mean "don't allow this
>> packet type" for all packets. Other wise old application with new kernel
>> would not allow any packet types.
> 
> The current patch achieves this backwards compatibility by assuming
> that all packet types are allowed if the old sockaddr_sco struct is
> used (it checks the size), or if sco_pkt_type is 0.

OK. Then my concerns are gone.



-- 
Ville
