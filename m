Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20111202112649.GB17203@x220.ger.corp.intel.com>
References: <1321973388-16300-1-git-send-email-sancane@gmail.com>
	<1321973388-16300-2-git-send-email-sancane@gmail.com>
	<1321973388-16300-3-git-send-email-sancane@gmail.com>
	<20111202112649.GB17203@x220.ger.corp.intel.com>
Date: Fri, 2 Dec 2011 12:52:00 +0100
Message-ID: <CACLukz+aP0O_SXLpmA+EadYTFPHEHg6krjj4aqSkpu55ifdFHg@mail.gmail.com>
Subject: Re: [PATCH 2/6] Confiure C.C.C descriptor during the thermometer configuration
From: Santiago Carot <sancane@gmail.com>
To: Santiago Carot-Nemesio <sancane@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

2011/12/2 Johan Hedberg <johan.hedberg@gmail.com>:
> Hi Santiago,
>
> On Tue, Nov 22, 2011, Santiago Carot-Nemesio wrote:
>> +                     atval[0] = 0x02;
>> +                     atval[1] = 0x00;
>
> What are these magic values? Could we have some defines for them or
> something else more readable?

These are GATT flags to enable/disable indications/notifications in
client characteristic configuration descriptor, I thought about this
issue, I haven't seen any macros mapping those values in GATT though.
I was thinking in sending a separate patch to deal with this issue but
I saw some Claudio's commits to deal with notification/indications so
I guess he is already working on it, so I decided no to  interfere and
wait to see how he is thinking to deal with this stuff.

Regards.
