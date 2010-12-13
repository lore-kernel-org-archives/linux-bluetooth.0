Return-Path: <cyrus@holtmann.org>
Message-ID: <4D069450.70502@codeaurora.org>
Date: Mon, 13 Dec 2010 13:46:56 -0800
From: Brian Gix <bgix@codeaurora.org>
MIME-Version: 1.0
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
CC: linux-bluetooth@vger.kernel.org
Subject: LE Compound Procedure strategy
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Hi Vinicius,

I am breaking this out into a new conversation.

How about we create a new parameter to g_attrib_send, which is a boolean 
that indicates wether or not the command being sent may be the start (or 
continuation) of a Compound GATT procedure?

If this flag is TRUE, then when gattrib.c creates the command record for 
it, it will see if it is continuing a prior procedure, and if so add it 
to the head of the queue. Perhaps even *replace* the current head, which 
would presumably be recognized as the original command.

This would allow it to reuse the Command ID (allowing the upper layers 
to cancel as needed) and ensure the single-threaded intent of compound 
GATT procedures.

An additional gattrib.c API could then be added which must be called at 
the conclusion of all compound GATT procedures. This new API would 
perform final clean-up on the procedure, including allowing the next 
(following) items in the command queue to be serviced.

Your Thoughts?


-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
