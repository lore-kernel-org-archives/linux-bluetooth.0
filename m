Return-Path: <cyrus@holtmann.org>
Message-ID: <4DA81E10.60109@Atheros.com>
Date: Fri, 15 Apr 2011 15:59:36 +0530
From: Suraj Sumangala <suraj@Atheros.com>
MIME-Version: 1.0
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: optional support for ERTM mode for certain PSM
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

I am working on the L2CAP BQB test cases for ERTM mode and came across 
test cases for PSMs which optionally and mandatorily support ERTM.

As part of BQB qualification, I see two test cases

1. Mandatory support:
	When tester sends a Config respose with "Un-acceptable parameter" for 
EFC parameter, the IUT is supposed to disconnect the link.

2. Optional support

	When tester sends a Config respose with "Un-acceptable parameter" for 
EFC parameter, the IUT is supposed re-negotiate the connection with the 
EFC parameter provided by Tester.

Any idea how both cases can be executed successfully?

Regards
Suraj
