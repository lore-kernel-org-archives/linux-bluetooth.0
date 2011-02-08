Return-Path: <cyrus@holtmann.org>
Message-ID: <4D51D1DE.7010309@codeaurora.org>
Date: Tue, 08 Feb 2011 15:29:34 -0800
From: Brian Gix <bgix@codeaurora.org>
MIME-Version: 1.0
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
CC: linux-bluetooth@vger.kernel.org
Subject: SM Key Distribution
References: <4D508DC2.60003@codeaurora.org> <4D509ABA.1010909@codeaurora.org> <20110208135849.GA31237@piper> <4D517EE1.8040408@codeaurora.org>
In-Reply-To: <4D517EE1.8040408@codeaurora.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

More on Key Distribution:


When we are an SM responder, we are suppose to AND the requested key 
distribution values with our values (what we expect, and what we 
generate).  So for instance, if we have 07 07 as our prefered key 
distribution values, and we receive 00 01, then we should mask 
everything out except for the Responder LTK distribution PRIOR to 
responding with the Pairing Response, and then of course only distribute 
that one LTK key after link encryption.


Currently, we are always responding with 07 07 regardless of what the 
Initiator requested, and then always distribute all possible keys.


Regards,


-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
