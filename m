Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTi=3QDhRvEn74radQJXWnN8Sn3KUDDBTHQk6A-Zw@mail.gmail.com>
References: <1294960264-7622-1-git-send-email-epx@signove.com>
 <33e10449eddb45a9d7de33c23d05e14f@libresoft.es> <AANLkTi=3QDhRvEn74radQJXWnN8Sn3KUDDBTHQk6A-Zw@mail.gmail.com>
From: Jose Antonio Santos Cadenas <jcaden@libresoft.es>
Date: Fri, 14 Jan 2011 12:15:15 +0100
Message-ID: <AANLkTikjeQ1Yemc8w1hqemk6NUdGmUr5sSBg1e9KZQR6@mail.gmail.com>
Subject: Re: [PATCH] [RFC] HDP: reject MDL reconnection with different MTU
To: =?ISO-8859-1?Q?Elvis_Pf=FCtzenreuter?= <epx@signove.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

2011/1/14 Jose Antonio Santos Cadenas <jcaden@libresoft.es>:
> 2011/1/14 José Antonio Santos Cadenas <jcaden@libresoft.es>
>>
>> Hi Elvis,
>>
>> On Thu, 13 Jan 2011 21:11:04 -0200, Elvis PfÃ¼tzenreuter wrote:
>>>
>>> From: Elvis Pfutzenreuter <epx@signove.com>
>>>
>>> This patch implements refusal of a MDL reconnection if the new L2CAP
>>> connection presents a different MTU. Accordingly to HDP spec. item 3.5.
>>>
>>> It aims to pass the TC_SNK_HCT_BV_07_C PTS test. (It does not pass yet
>>> because PTS itself seems to have issues. See ticket 7121 for details.)
>

I finish the tests I'd like to do. Just I'm concerned about why you
are using just OMTU value instead of both values IMTU and OMTU. Will
not be better to store and check both of them?

Let's see if the PTS issue gets fixed soon :).

Regards.

Jose.
