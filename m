Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=US-ASCII
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Subject: Re: [PATCH v4 00/26] Bluetooth: Management interface fixes
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAHZ1yCkPqiDoJCJ8_5-aReT2UDLYm6-yS=8P7Nwt3UM8WeifHA@mail.gmail.com>
Date: Fri, 15 Mar 2013 16:14:09 -0700
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <1AB5D8F3-C990-4324-80D3-4223357991BB@holtmann.org>
References: <1363198337-3896-1-git-send-email-johan.hedberg@gmail.com> <CAHZ1yCkPqiDoJCJ8_5-aReT2UDLYm6-yS=8P7Nwt3UM8WeifHA@mail.gmail.com>
To: Scott James Remnant <keybuk@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Scott,

>> I'm sending all 26 patches I had pending in my local tree, as requested
>> by Marcel. The first six in this set are identical to my patch set
>> titled "[PATCH v3 0/6] Bluetooth: HCI command synchronisation fixes".
>> 
> 
> Which version of BlueZ are these intended to be used with?

these are for bluetooth-next. They are ensuring that we do not reply to userspace too early. Internal usage for controller specific setup and AMP are possible as well.

Main driving factor is of course the LE extensions we are planning. The capability to execute command sequences is really important there. 

Regards

Marcel

