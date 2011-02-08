Return-Path: <cyrus@holtmann.org>
Message-ID: <4D51D70F.9050703@codeaurora.org>
Date: Tue, 08 Feb 2011 15:51:43 -0800
From: Brian Gix <bgix@codeaurora.org>
MIME-Version: 1.0
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: GATT Attribute Server changes coming.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Due to some observations at UPF, I have made some on the fly 
modifications to the attribute-server.c and example.c files.  The 
changes appear to work, but I am cleaning up the changes and will submit 
them as potential patches probably early next week.

Specifically, they pertain to how Primary Services are discovered by 
BR/EDR GATT Clients.  The relevant spec section is 4.4 of Part G (GATT), 
Volume 3, Core Revision 4.0.  It states that Primary Services SHALL be 
discovered on BR/EDR links via SDP.

So I have staged the following changes in my personal workspace:

1. Modified the ATT_UUID to be 0x0007 instead of 0x1801, which is the 
GATT UUID.  The ATT Protocol UUID is now publiched in BT Assigned Numbers.

2. I have added a new "end" parameter to attrib_db_add() to indicate the 
end of a Attribute Handle Range (which may be Zero if not appropriate) 
which when combined with a Primary Service Attribute, will register a 
correctly formatted SDP service Record for BR/EDR purposes. I will 
probably also add yet one more Parameter that will be a string value 
description for the SDP record.

3. I have tested against two other teams so far to shake out the bugs, 
and it looks promising.  There is one team that depends on these SDP 
records, and I will be testing against them again tomorrow.


-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
